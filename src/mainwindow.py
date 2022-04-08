from PySide6.QtWidgets import QApplication
from PySide6.QtQml import QQmlApplicationEngine
from PySide6.QtCore import QObject, Signal, Slot
#import gspread

from database import Sheet

import os
import sys
import datetime

# EXPERIMENTAL
    
class Backend(QObject):
    def __init__(self):
        QObject.__init__(self)
        self.super = ""
        self.superlog = ""
        self.admin = ""
        self.adminlog = ""
        self.student = ""
        self.studentlog = ""
        self.availbal = 0
        self.activity = ""
        self.recipient = ""
        self.recipientlog = ""
        self.accname = ""
        self.amount = 0

    googlesheet = None
    report = []
    pageindex = {
        1: "P1Form.ui.qml", 2: "P2Form.ui.qml", 3: "P3Form.ui.qml",
        'supersetting': 'Superview.ui.qml', 'adminsetting': 'Adminview.ui.qml',
        'Purchase': 'Purchasemulti2.ui.qml', 'Transfer': 'Transfermulti2.ui.qml',
        'Deposit': 'Deposit.ui.qml', 'Register': 'Register.ui.qml'
        }

    """
    Signals used for communicating with QML from Python
    1. Incorrect: For login and transfer activities. Check 'Invalid Signal' in No. 2
    2. Invalid: For register and remove user/admins activities. Check 'Incorrect Signal' in No. 1
    3. Finishedprocess: Used when changing page to close the loading page and open the next page
    4. Loggeduser: Emitted when user changes mode from purchase to transfer and vice versa. Transfers login detail across modes
    5. Accbalance: Communicates user's account balance when mode changes and displays it. Emitted with 'Loggeduser Signal' in No. 4
    6. Featuremode: Displays the current activity window. Emitted with 'Loggeduser Signal' in No. 4
    7. Proceed: Gives go ahead to continue transaction
    8. Totalexp: Used in purchase page to sum up total expense
    9. Accountname: Used in feature pages (purchases & transfer) to identify customer and beneficiary's of transfers
    """
    incorrect = Signal(int)
    invalid = Signal(int) 
    finishedprocess = Signal(str)
    loggeduser = Signal(str) 
    accbalance = Signal(float)
    featuremode = Signal(str)
    proceed = Signal(int)
    totalexp = Signal(float)
    accountname = Signal(list)

    """
    Slots are used to communicate with Python from QML
    1. Superuser: Runs during a Super Admin log in. It passes the information entered and, at the end, emits appropriate Signal(s) based on the outcome of the login attempt
    2. Superadminlogout: Called when a Super Admin is logged out.
    3. Adminuser: Runs during an Admin log in. See Description of 'Superuser Slot' in No. 2 for extra detail
    4. Adminlogout: Called when an Admin is logged out.
    5. Checksuper: Used when Removing/Registering to certify they exist/don't exist respectively
    6. Registersuper: Called when Registering a Super Admin or Admin
    7. Removesuper: Called when Removing a Super Admin or Admin
    8. Studentuser: Runs during a User/Student log in. See Description of 'Superuser Slot' in No. 2 for extra detail
    9. Userlogout: Called when a User/Student is logged out.
    10. Feature: Called to assign the variable which tells the program what activity was chosen. Helps to Display and Load the correct page
    11. Menubranch: Tells the code what page the menu branched out from
    12. Switchfeature: Called to emit Signals which display Activity window, Logged user's name, and Account balance. See 'Loggeduser Signal' in No. 4 of Signal List
    13. Purchaseamounts: Used to sum the multiple purchase values. Calls totalexp Signal
    14. Purchasefeature: Called to assign the variable which tells the program what amount was spent
    15. Transferrecipient: Checks if the beneficiary of a transaction exists
    16. Transferfeature: Called to assign the variables which tell the program what amount was transferred, the Recipient, and Recipient's means of identification
    17. Deposit: Called when making a deposit to confirm admin to verify the deposit and update the database
    18. Checkuser: Called when registering a new user to be sure reg no doesn't already exist
    19. Registeruser: Called to assign the variables which tell the program Reg No., Password, and Fingerprint of New User
    20. Transactiondone: Called after a Purchase or Transfer was attempted regardless if it was successful or not
    """

    @Slot(list)
    def superuser(self, s_user):
        #self.userdetails(s_user, 0) #ANSWER
        self.super = s_user[0]
        s_password = s_user[1]
        self.superlog = s_user[2] # Remove this line when fingerprint if-block is done
        # Write an if block for when fingerprint is used
        
        if self.supersheet['Name'].get(self.super) == None: self.loaded(self.pageindex[1]); self.incorrect.emit(1); self.log("1001", self.super)
        else:
            data = self.supersheet.loc[self.supersheet['Name'].get(self.super)]
            if s_password == data.Pin:
                self.loaded(self.pageindex[2]) if s_user[3] == 0 else self.loaded(self.pageindex['supersetting']); self.accountname.emit([data['Account Name'], data.Station])
                self.log("1101", self.super) if self.superlog == 'Pin' else self.log("1111", self.super)
            else: self.loaded(self.pageindex[1]); self.incorrect.emit(1); self.log("1001", self.super)

    @Slot(int)
    def superadminlogout(self, code):
        self.log("51-1", self.super)
        self.super, self.superlog = "", ""
        if code == 1: self.adminlogout()

    @Slot(list)
    def adminuser(self, a_user):
        # self.userdetails(a_user, 1) #ANSWER
        self.admin = a_user[0]
        a_password = a_user[1] # Calls pi to capture finger for processing
        self.adminlog = a_user[2]
        
        if self.adminsheet['Name'].get(self.admin) == None: self.loaded(self.pageindex[2]); self.incorrect.emit(1); self.log("1000", self.admin)
        else:
            data = self.adminsheet.loc[self.adminsheet['Name'].get(self.admin)]
            if a_password == data.Pin:
                self.loaded(self.pageindex[3]) if a_user[3] == 0 else self.loaded(self.pageindex['adminsetting']); self.accountname.emit([data['Account Name'], data.Station])
                self.log("1100", self.admin) if self.adminlog == 'Pin' else self.log("1110", self.admin)
            else: self.loaded(self.pageindex[2]); self.incorrect.emit(1); self.log("1000", self.admin)

    @Slot()
    def adminlogout(self):
        self.log("51-0", self.admin)
        self.admin, self.adminlog = "", ""

    @Slot(list)
    def checksuper(self, details):
        entry = details[0]
        auth = details[1]
        # Condition fails if name is found in corresponding adminlist
        if ((auth == 'Super Admin') & (self.supersheet['Name'].get(entry) != None)) | ((auth == 'Admin') & (self.adminsheet['Name'].get(entry) != None)):
            self.invalid.emit(1); self.log("40-1", entry) if auth == 'Super Admin' else self.log("40-0", entry)
        else: self.proceed.emit(2)
        
    @Slot(list)
    def registersuper(self, details):
        import csv
        # self.userdetails(details, 3) # ANSWER
        information = details[:6]
        entry = details[0]
        accname = details[1]
        auth = details[2]
        station = details[3]
        password = details[4]
        fingerprint = details[5]
        if details[-1] != "Verified": # Super Admin has not been verified already
            supername = details[6]
            superpin = details[7]
            superlog = details[8]
            #Super verify
            if self.supersheet['Name'].get(supername) == None:
                self.log('40-1', f"{entry} Unfound {supername}") if auth == 'Super Admin' else self.log('40-0', f"{entry} Unfound {supername}")
                self.incorrect.emit(3); return
            else:
                data = self.supersheet.loc[self.supersheet['Name'].get(supername)]
                if superpin != data.Pin:
                    self.log('40-1', f"{entry} Unverified {supername}") if auth == 'Super Admin' else self.log('40-0', f"{entry} Unverified {supername}")
                    self.incorrect.emit(3); return
        
        information.append(datetime.datetime.now().__str__()[:19])

        if auth == 'Super Admin': self.supersheet.loc[entry] = information
        else: self.adminsheet.loc[entry] = information

        if details[-1] != "Verified": self.proceed.emit(1) # Run if super is not verified already
        with open ('admindummy.csv', 'a') as file:
            csv_writer = csv.writer(file)
            csv_writer.writerow(information)
        self.log("41-1", entry) if auth == 'Super Admin' else self.log("41-0", entry)
        # Regular Admin registering as Super Admin
        if (auth == 'Super Admin') & (self.adminsheet['Name'].get(entry) != None):
            if details[-1] != "Verified": self.log("41-1", f"{entry} by Super: {supername} - {superlog}")
            else: self.log("41-1", f"{entry} by Super: {self.super} - {self.superlog}")
    
    @Slot(list)
    def removesuper(self, details):
        import csv
        #self.userdetails(details, 4) # ANSWER

        removename = details[0] # Remove rank has been removed from details[1]
        supername = details[1]
        auth = details[2]
        superlog = details[3]

        #Super verify # biometric not included in this code
        if self.supersheet['Name'].get(supername) == None: self.log(['6','0','Unfound', 'Unfound', auth], removename); self.incorrect.emit(3); return
        else:
            data = self.supersheet.loc[self.supersheet['Name'].get(supername)]
            if superlog != data.Pin:
                self.log(['6','0','Unfound', f"Unverified {supername}", auth], removename)
                self.incorrect.emit(3); return
        
        #Removee verify
        if (self.supersheet['Name'].get(removename) != None) | (self.adminsheet['Name'].get(removename) != None): # if a super admin and an admin, it'll remove admin profile
            if (self.supersheet['Name'].get(removename) != None) & (self.adminsheet['Name'].get(removename) != None): # user in both lists
                data = list(self.adminsheet.loc[removename])
                self.adminsheet.drop(removename, inplace = True)
            elif self.supersheet['Name'].get(removename) != None: # user a superadmin
                data = list(self.supersheet.loc[removename])
                self.supersheet.drop(removename, inplace = True)
            elif self.adminsheet['Name'].get(removename) != None: # user an admin
                data = list(self.adminsheet.loc[removename])
                self.adminsheet.drop(removename, inplace = True)
            data.append(datetime.datetime.now().__str__()[:19])
            with open('deletedadmins.csv', 'a') as dfile:
                csv_writer = csv.writer(dfile)
                csv_writer.writerow(data)
                
            self.proceed.emit(1)
            formatted_list = self.pdtolist('Admins')
            removerank = data[2]
            
            with open ('admindummy.csv', 'w') as file:
                csv_writer = csv.writer(file)
                csv_writer.writerows(formatted_list)
            self.log(['6','1',removerank,supername,auth], removename)
        else:
            self.invalid.emit(1); self.log(['6','0','Undefined',supername,auth], removename)
    
    @Slot(list)
    def studentuser(self, user): #user = [name, pin, "Fingerprint/Pin"]
        #self.userdetails(user, 2) # ANSWER
        self.student = user[0]
        u_password = user[1]
        self.studentlog = user[2]

        if self.customersheet['Name'].get(self.student) == None: self.loaded('close'); self.incorrect.emit(1); self.log("1002", self.student)
        else:
            data = self.customersheet.loc[self.customersheet['Name'].get(self.student)]
            self.availbal = data.Amount
            self.accname = data[1]
            if u_password == data.Pin:
                self.loaded(self.pageindex[self.activity]); self.switchfeature()
                self.log("1102", self.student) if self.studentlog == 'Pin' else self.log("1112", self.student)
            else: self.loaded('close'); self.incorrect.emit(1); self.log("1002", self.student)

    @Slot()
    def userlogout(self):
        self.log("51-2", self.student)
        self.student, self.studentlog, self.activity = "", "", ""

    @Slot(str)
    def feature(self, activity):
        self.activity = activity
        if activity == "Register": self.featuremode.emit("Registration")

    @Slot(int)
    def menubranch(self, stem):
        if stem == 4: self.loaded(self.pageindex['supersetting']) ; return
        elif stem == 5: self.loaded(self.pageindex['adminsetting']) ; return
        self.loaded(self.pageindex[stem])

    @Slot()
    def switchfeature(self):
        self.loggeduser.emit(self.accname)
        self.featuremode.emit(self.activity)
        self.accbalance.emit(self.availbal)
        
    @Slot(list)
    def purchaseamounts(self, amounts):
        total = 0
        for amount in amounts:
            tempnum = 0
            if (amount.strip()).isnumeric():
                tempnum = int(amount.strip())
                if 0 < tempnum < 50: self.incorrect.emit(1) ; return
                total += tempnum
        else:
            self.incorrect.emit(1) if round(total, 2) == 0 else self.totalexp.emit(round(total, 2))

    @Slot(float)
    def purchasefeature(self, amount):
        self.amount = amount

    @Slot(list)
    def transferrecipient(self, info): # info = [fingerpicture/username, code]
        if self.customersheet['Name'].get(info[0]) == None: self.incorrect.emit(2)
        else:
            recipient = self.customersheet.loc[info[0]]['Account Name']            
            self.accountname.emit([recipient, info[1]])  # ; self.displayuser.emit(username)

    @Slot(list)
    def transferfeature(self, details): # details = [amount, fingerpicture/ username, "Fingerprint/ Typed"]
        self.amount = 0.0 if details[0] == '' else float(details[0])
        self.recipient = details[1]        
        self.recipientlog = details[2]
        
        # if self.customersheet['Name'].get(self.recipient) == None: self.loaded('close'); self.incorrect.emit(2)
        # ANSWER BELOW
        """self.amount = 0.0 if details[0] == '' else float(details[0])
        if self.recipientlog == "Fingerprint":
            if self.recipient in self.googlesheet('users')[fingerprint]:
                self.recipient = self.googlesheet('users')[fingerprint][self.recipient] # return a name
            else: self.loaded('close'); self.incorrect.emit(2)
        elif self.recipientlog == "Typed":
            if self.recipient not in self.customersheet: self.loaded('close'); self.incorrect.emit(2)"""

    @Slot(list)
    def deposit(self, details):
        import csv
        # Super/Admin verify
        amount = float(details[0])
        supername = details[1]
        superpin = details[2]
        superlog = details[3]
        #Super verify
        if self.supersheet['Name'].get(supername) != None: # Super Verified
            data = self.supersheet.loc[self.supersheet['Name'].get(supername)]
            auth = '1'
            if superpin != data.Pin:
                self.log(['7','0',auth,supername,f"Unverified {superlog}"], amount)
                self.incorrect.emit(3); return
        elif self.adminsheet['Name'].get(supername) != None: # Admin Verified
            data = self.adminsheet.loc[self.adminsheet['Name'].get(supername)]
            auth = '0'
            if superpin != data.Pin:
                self.log(['7','0',auth,supername,f"Unverified {superlog}"], amount)
                self.incorrect.emit(3); return
        else:
            self.log(['7','0','3',supername,f"Unverified {superlog}"], amount)
            self.incorrect.emit(3); return

        self.availbal += round(amount, 2)
        self.customersheet.at[self.student, 'Amount'] = self.availbal
        self.proceed.emit(1)
        formatted_list = self.pdtolist('Users')

        with open ('userdummy.csv', 'w') as file:
            csv_writer = csv.writer(file)
            csv_writer.writerows(formatted_list)
        self.log(['7','1',auth,supername,superlog], amount)
        # Inserts code to add amount

    @Slot(str)
    def checkuser(self, name):
        if self.customersheet['Name'].get(name) != None:
            self.invalid.emit(1); self.log("40-2", name)
        else: self.proceed.emit(1)
            
    @Slot(list)
    def registeruser(self, details): # details = [reg no, acc name, password, fingerpicture]
        import csv
        # self.userdetails(details, 32) # ANSWER
        self.student = details[0]
        details.insert(2, 'User')
        details.insert(3, 0)
        details.append(datetime.datetime.now().__str__()[:19])

        self.customersheet.loc[self.student] = details
        with open ('userdummy.csv', 'a+') as file:
            csv_writer = csv.writer(file)
            csv_writer.writerow(details)
        self.log("41-2", self.student)

    @Slot(int)
    def transactiondone(self, code):
        import csv
        self.availbal = self.customersheet.loc[self.student]['Amount']
        self.availbal -= round(self.amount, 2)
        self.customersheet.at[self.student, 'Amount'] = self.availbal

        if code == 0: # Purchase
            self.log("2112", self.student) if self.studentlog == "Fingerprint" else self.log("2102", self.student)
        elif code == 1: # Transfer
            self.log("3112", self.student) if self.studentlog == "Fingerprint" else self.log("3102", self.student)
            recipientbal = self.customersheet.loc[self.recipient]['Amount']
            recipientbal += round(self.amount, 2)
            self.customersheet.at[self.recipient, 'Amount'] = recipientbal

        # self.googlesheet('users')[self.student].writedata['amount'] = self.availbal - self.amount #For deducting from account
        formatted_list = self.pdtolist('Users')

        with open ('userdummy.csv', 'w') as file:
            csv_writer = csv.writer(file)
            csv_writer.writerows(formatted_list)
   
    """
    Script Functions
    1. Test_gspread: Retrieves Googlesheet from cloud and loads information into physical memory
    2. Pdtolist: After removing a (super) admin Or after a transaction, the function converts the dataframe to a list for writing to csv file
    3. Loaded: Called to close Loading page after a process has completed
    4. Writeout: Executed activity is written to external log file. 'Log Function' calls 'Writout'
    5. Log: Called after an activity has been executed successfully or failingly
    6. Closeapp: Runs when close button is clicked. It prints the activity log for that current session and closes the application
    """
    
    def test_gspread(self):
        """
        tosin needs to define a function for removing a user
        a function for loading the sheet to a panda file, it's in gspread documentation
        """
        from pandas import read_csv 
        '''self.googlesheet = Sheet()
        if self.googlesheet: print(f'Loaded: {len(self.googlesheet.table)-1} entries')
        #print(self.googlesheet.get_entireTableUser())'''
        self.finishedprocess.emit(self.pageindex[1])

        # Experimental
        spreadsheet = read_csv('admindummy.csv', dtype = str)
        spreadsheet.set_index(spreadsheet['Name'], inplace = True)
        self.supersheet = spreadsheet.loc[spreadsheet['Rank']=='Super Admin']
        self.adminsheet = spreadsheet.loc[spreadsheet['Rank']=='Admin']
        self.customersheet = read_csv('userdummy.csv', dtype = str)
        self.customersheet.set_index(self.customersheet['Name'], inplace = True)
        self.customersheet = self.customersheet.astype({'Amount': float})
        print(f"Admins: {len(spreadsheet)} Entries\nUsers: {len(self.customersheet)} Entries")
        """
        When working
            df.set_index(df['Name'], inplace = True)
        For finding column
            if y['Name'].get(username) == None: self.incorrect.emit(1)
            else: data = y.loc[y['Name'].get(username)]
        when writing to csv
            df.sort_values('Name')
            df.to_csv('path', index = False)
        To Add
            df.loc[name] = [name,rank,pin,fingerprint]
        To Remove
            data = df.loc[index]
            deleteddf.loc[index] = [data.Name, data.Rank, data.Pin, data.Fingerprint]
            df.drop(index, inplace = True)
        """
    def pdtolist(self, instruction):
        if instruction == 'Admins':
            superlist = [list(self.supersheet.iloc[i]) for i in range(len(self.supersheet))]
            adminlist = [list(self.adminsheet.iloc[i]) for i in range(len(self.adminsheet))]
            superlist.insert(0, list(self.supersheet.columns))
            finallist = superlist + adminlist
            return finallist
        elif instruction == 'Users':
            userlist = [list(self.customersheet.iloc[i]) for i in range(len(self.customersheet))]
            userlist.insert(0, list(self.customersheet.columns))
            return userlist

        
    def loaded(self, code):
        ''' Called after process has finished'''
        self.finishedprocess.emit(code)

    def writeout(self, message):
        with open('cupaylog.txt', 'a') as file:
            file.write(message)
        print('event logged')

    def log(self, code, name):
        passkey = {'1': 'Success', '0': 'Fail'}
        biokey = {'1': 'Biometric', '0': 'Pin'}
        userkey = {'1': 'Super Admin', '0': 'Admin', '2': 'User', '3': 'Unfound'}
        if code[0] == '1':
            message = f"Login {passkey[code[1]]}: {userkey[code[3]]} {name} used {biokey[code[2]]} by {datetime.datetime.now().__str__()[:19]}\n"
        elif code[0] == '2':
            message = f"Purchase {passkey[code[1]]}: {userkey[code[3]]} {name} used {biokey[code[2]]} for {self.amount:.2f} by {datetime.datetime.now().__str__()[:19]}\n"
        elif code[0] == '3':
            message = f"Transfer {passkey[code[1]]}: {userkey[code[3]]} {name} used {biokey[code[2]]} for {self.amount:.2f} to {self.recipientlog} {self.recipient} by {datetime.datetime.now().__str__()[:19]}\n"
        elif code[0] == '4':
            message = f"Register {passkey[code[1]]}: {userkey[code[3]]} {name} by {datetime.datetime.now().__str__()[:19]}\n"
        elif code[0] == '5':
            message = f"Logout {passkey[code[1]]}: {userkey[code[3]]} {name} by {datetime.datetime.now().__str__()[:19]}\n"
        elif code[0] == '6':
            message = f"Removal {passkey[code[1]]}: {code[2]} {name} removed by Super Admin {code[3]} with {code[4]} at {datetime.datetime.now().__str__()[:19]}\n"
        elif code[0] == '7':
            message = f"Deposit {passkey[code[1]]}: {self.student} deposited {name} confirmed by {userkey[code[2]]} {code[3]} with {code[4]} at {datetime.datetime.now().__str__()[:19]}\n"
        self.writeout(message)
        self.report.append(message)

    def closeapp(self):
        if self.report: print("The following transactions occurred in this session")
        for items in self.report: print(items)
        
    def reset_variables(self):
        ''' Called after a log has been printed'''
        self.student = ""
        self.studentlog = ""
        self.activity = ""
        self.recepient = ""
        self.recepientlog = ""
        self.amount = None
        
if __name__ == "__main__":
    app = QApplication(sys.argv)
    engine = QQmlApplicationEngine()    
    back = Backend()
    engine.rootContext().setContextProperty("backend", back)
    print('> ', end= '')
    #engine.load('UI/Deposit.ui.qml')
    engine.load('UI/Home.ui.qml')
    print("loaded")
    back.test_gspread()
    engine.quit.connect(app.quit)
    #engine.load('UI/P3Form.ui.qml')
    result = app.exec()
    back.closeapp()
    sys.exit(result)


