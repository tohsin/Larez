import os
import sys
#import gspread
import datetime
from database import Sheet
from PySide6.QtWidgets import QApplication
from PySide6.QtQml import QQmlApplicationEngine
from PySide6.QtCore import QObject, Signal, Slot
 
    
class Backend(QObject):
    def __init__(self):
        QObject.__init__(self)
        self.super = ""
        self.superlog = ""
        self.admin = ""
        self.adminlog = ""
        self.student = ""
        self.studentlog = ""
        self.availbal = 6000
        self.activity = ""
        self.recipient = ""
        self.recipientlog = ""
        self.amount = None

    googlesheet = None
    report = []
    #supersheet = {'100': '0000'}
    supersheet = {'': ''}
    #adminsheet = {'200': '0000'}
    adminsheet = {'': '0000'}
    #customersheet = {'': '0000'}
    customersheet = {'3': '0000'}
    pageindex = {
        1: "P1Form.ui.qml", 2: "P2Form.ui.qml", 3: "P3Form.ui.qml",
        'Purchase': 'Purchase.ui.qml', 'Transfer': 'Transfer.ui.qml',
        'Register': 'Register.ui.qml'
        }

    """
    Signals used for communicating with QML from Python
    1. Incorrect: For login and transfer activities. Check 'Invalid Signal' in No. 2
    2. Invalid: For register and remove user/admins activities. Check 'Incorrect Signal' in No. 1
    3. Finishedprocess: Used when changing page to close the loading page and open the next page
    4. Loggeduser: Emitted when user changes mode from purchase to transfer and vice versa. Transfers login detail across modes
    5. Accbalance: Communicates user's account balance when mode changes and displays it. Emitted with 'Loggeduser Signal' in No. 4
    6. Featuremode: Displays the current activity window. Emitted with 'Loggeduser Signal' in No. 4
    """
    incorrect = Signal(int)
    invalid = Signal(int) 
    finishedprocess = Signal(str) 
    loggeduser = Signal(str) 
    accbalance = Signal(float)
    featuremode = Signal(str)

    """
    Slots are used to communicate with Python from QML
    1. Closeapp: Runs when close button is clicked. It prints the activity log for that current session and closes the application
    2. Superuser: Runs during a Super Admin log in. It passes the information entered and, at the end, emits appropriate Signal(s) based on the outcome of the login attempt
    3. Superadminlogout: Called when a Super Admin is logged out.
    4. Adminuser: Runs during an Admin log in. See Description of 'Superuser Slot' in No. 2 for extra detail
    5. Adminlogout: Called when an Admin is logged out.
    6. Studentuser: Runs during a User/Student log in. See Description of 'Superuser Slot' in No. 2 for extra detail
    7. Userlogout: Called when a User/Student is logged out.
    8. Registersuper: Called when Registering a Super Admin or Admin
    9. Removesuper: Called when Removing a Super Admin or Admin
    10. Feature: Called to assign the variable which tells the program what activity was chosen. Helps to Display and Load the correct page
    11. Switchfeature: Called to emit Signals which display Activity window, Logged user's name, and Account balance. See 'Loggeduser Signal' in No. 4 of Signal List
    12. Purchasefeature: Called to assign the variable which tells the program what amount was spent
    13. Transferfeature: Called to assign the variables which tell the program what amount was transferred, the Recipient, and Recipient's means of identification
    14. Registeruser: Called to assign the variables which tell the program Reg No., Password, and Fingerprint of New User
    15. Transactiondone: Called after a Purchase or Transfer was attempted regardless if it was successful or not
    """

    @Slot()
    def closeapp(self):
        if self.report: print("The following transactions occurred in this session")
        for items in self.report: print(items)
        
    
    @Slot(list)
    def superuser(self, s_user):
        #self.userdetails(s_user, 0) #ANSWER
        self.super = s_user[0]
        s_password = s_user[1]
        self.superlog = s_user[2] # Remove this line when fingerprint if-block is done
        # Write an if block for when fingerprint is used
        if self.super in self.supersheet:
            password = self.supersheet[self.super]
            if s_password == password: self.loaded(self.pageindex[2]); self.log("1101", self.super)
            else: self.loaded(self.pageindex[1]); self.incorrect.emit(1); self.log("1001", self.super)
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
        if self.admin in self.adminsheet:
            password = self.adminsheet[self.admin]
            if a_password == password: self.loaded(self.pageindex[3]); self.log("1100", self.admin)
            else: self.loaded(self.pageindex[2]); self.incorrect.emit(1); self.log("1000", self.admin)
        else: self.loaded(self.pageindex[2]); self.incorrect.emit(1); self.log("1000", self.admin)

    @Slot()
    def adminlogout(self):
        self.log("51-0", self.admin)
        self.admin, self.adminlog = "", ""

    @Slot(list)
    def registersuper(self, details):
        # self.userdetails(details, 3) # ANSWER
        entry = details[0]
        auth = details[1]
        password = details[2]
        fingerprint = details[3]
        # check if (super/admin)sheet already contains username
        '''if entry in self.googlesheet('admins'):
            self.invalid.emit(1); self.log("40-1", entry) if auth == 1 else self.log("40-0", entry)'''
        # write new entry to the googlesheet
        self.log("41-1", entry) if auth == 'Super Admin' else self.log("41-0", entry)

    @Slot(list) # str incoming
    def removesuper(self, details):
        #self.userdetails(details, 4) # ANSWER
        removename = details[0]
        removerank = details[1] #Would be gotten from sheet, remove later
        supername = details[2]
        auth = "Pin" if details[3] == "Pin" else "Fingerprint"
        # check if (super/admin)sheet doesn't contain removename
        '''if removename not in gs('admins'):
            self.invalid.emit(1); self.log(['6','0','',supername,auth], removename)'''
        # remove name from googlesheet
        self.log(['6','1',removerank,supername,auth], removename)
    
    @Slot(list) # str incoming data
    def studentuser(self, user): #user = [name, pin, "Fingerprint/Pin"]
        #self.userdetails(user, 2) # ANSWER
        self.student = user[0]
        u_password = user[1]
        self.studentlog = user[2]
        if self.student in self.customersheet:
            password = self.customersheet[self.student]
            if u_password == password: self.loaded(self.pageindex[self.activity]); self.switchfeature(); self.log("1102", self.student)
            else: self.loaded('close'); self.incorrect.emit(1); self.log("1002", self.student)
        else: self.loaded('close'); self.incorrect.emit(1); self.log("1002", self.student)

    @Slot()
    def userlogout(self):
        self.log("51-2", self.student)
        self.student, self.studentlog, self.activity = "", "", ""

    @Slot(str)
    def feature(self, activity):
        self.activity = activity
        if activity == "Register": self.featuremode.emit("Registration")

    @Slot()
    def switchfeature(self):
        self.loggeduser.emit(self.student)
        self.featuremode.emit(self.activity)
        self.accbalance.emit(self.availbal)
        
    @Slot(float)
    def purchasefeature(self, amount):
        self.amount = amount

    @Slot(list)
    def transferfeature(self, details): # details = [amount, fingerpicture/ username, "Fingerprint/ Typed"]
        self.amount = 0.0 if details[0] == '' else float(details[0])
        self.recipient = details[1]
        self.recipientlog = details[2]
        if self.recipient not in self.customersheet: self.loaded('close'); self.incorrect.emit(2)
        # ANSWER BELOW
        """self.amount = 0.0 if details[0] == '' else float(details[0])
        if self.recipientlog == "Fingerprint":
            if self.recipient in self.googlesheet('users')[fingerprint]:
                self.recipient = self.googlesheet('users')[fingerprint][self.recipient] # return a name
            else: self.loaded('close'); self.incorrect.emit(2)
        elif self.recipientlog == "Typed":
            if self.recipient not in self.customersheet: self.loaded('close'); self.incorrect.emit(2)"""
        
    @Slot(list)
    def registeruser(self, details): # apply str to all incoming data
        # self.userdetails(details, 32) # ANSWER
        self.student = details[0]
        password = details[1]
        fingerprint = details[2]
        #check if user exists in database
        #if self.student in gs('students'): self.invalid.emit(1); self.log(4) # failed
        """if details not in self.googlesheet('students'):
            with open (gs('students'), 'a+') as file:
                file.write(details)
                self.log(5), self.log("41-2", self.student)
        else: self.log(4), self.log("40-2", self.student)"""
        self.log("41-2", self.student)

    @Slot(int)
    def transactiondone(self, code):
        if code == 0:
            self.log("2112", self.student) if self.studentlog == "Fingerprint" else self.log("2102", self.student)            
        elif code == 1:
            self.log("3112", self.student) if self.studentlog == "Fingerprint" else self.log("3102", self.student)
        # self.googlesheet('users')[self.student].writedata['amount'] = self.availbal - self.amount #For deducting from account
   
    """
    Script Functions
    1. Test_gspread: Retrieves Googlesheet from cloud
    2. Loaded: Called to close Loading page after a process has completed
    3. Log: Called after an activity has been executed successfully or failingly
    4. Writeout: Executed activity is written to external log file. 'Log Function' calls 'Writout'
    """
    
    def test_gspread(self):
        self.googlesheet = Sheet()
        if self.googlesheet: print(f'Loaded: {len(self.googlesheet.table)-1} entries')
        #print(self.googlesheet.get_entireTableUser())
        self.finishedprocess.emit(self.pageindex[1])
    
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
        userkey = {'1': 'Super Admin', '0': 'Admin', '2': 'User'}
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
        self.writeout(message)
        self.report.append(message)
        # the 'register and delete (super) admin' codes to write to spreadsheet
        
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
    engine.load('UI/Home.ui.qml')
    back.test_gspread()
    engine.quit.connect(app.quit)
    engine.load('UI/P3Form.ui.qml')
    sys.exit(app.exec())
