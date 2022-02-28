import sys
import os
from PySide6.QtCore import QObject, Signal, Slot
from PySide6.QtQml import QQmlApplicationEngine
from PySide6.QtWidgets import QApplication
from database import Sheet
import datetime
import gspread    
    
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

    @Slot()
    def closeapp(self):
        if self.report: print("The following transactions occurred in this session")
        for items in self.report: print(items)

    finishedprocess = Signal(str) # To close the loading page and open the next correct page

    def test_gspread(self):
        self.googlesheet = Sheet()
        if self.googlesheet: print(f'Loaded: {len(self.googlesheet.table)-1} entries')
        #print(self.googlesheet.get_entireTableUser())
        self.finishedprocess.emit(self.pageindex[1])
    
    def loaded(self, code):
        ''' Called after process has finished'''
        self.finishedprocess.emit(code)

    incorrect = Signal(int) #Incorrect Signal for login and transfer. Check invalid Signal
    
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
        self.super = ""
        self.superlog = ""
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
        self.admin = ""
        self.adminlog = ""
        
    loggeduser = Signal(str) # Transfers login detail when mode changes from purchase to transfer and vice versa
    accbalance = Signal(float) # Transfers accbal when mode changes and displays it
    
    @Slot(list)
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

    featuremode = Signal(str) # To tell what page to go to after successful student log in
    
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
        """if self.recipientlog == "Fingerprint":
            if self.recipient in self.googlesheet('users')[fingerprint]:
                self.recipient = self.googlesheet('users')[fingerprint][self.recipient] # return a name
            else: self.loaded('close'); self.incorrect.emit(2)
        elif self.recipientlog == "Typed":
            if self.recipient not in self.customersheet: self.loaded('close'); self.incorrect.emit(2)"""

    @Slot(int)
    def transactiondone(self, code):
        if code == 0:
            self.log("2112", self.student) if self.studentlog == "Fingerprint" else self.log("2102", self.student)            
        elif code == 1:
            self.log("3112", self.student) if self.studentlog == "Fingerprint" else self.log("3102", self.student)
        # self.googlesheet('users')[self.student].writedata['amount'] = self.availbal - self.amount #For deducting from account
        
    invalid = Signal(int) # Invalid Signal for register and remove. Check Incorrect Signal
    @Slot(list)
    def registeruser(self, details):
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

    @Slot(list)
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
        
            
    @Slot()
    def userlogout(self):
        self.log("51-2", self.student)
        self.student = ""
        self.studentlog = ""
        self.activity = ""

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
