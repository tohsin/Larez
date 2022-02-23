import sys
from PySide6.QtCore import QObject, Signal, Slot
from PySide6.QtQml import QQmlApplicationEngine
from PySide6.QtWidgets import QApplication
from database import Sheet
import gspread
import datetime
def test_gspread():
    sh = Sheet()
    print(sh.get_entireTableUser())
    
    
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
        for items in self.report: print(items)
        app.quit()

    finishedprocess = Signal(str)

    def loaded(self, code):
        ''' Called after process has finished'''
        self.finishedprocess.emit(code)

    incorrect = Signal(int)
    
    @Slot(list)
    def superuser(self, s_user):
        print(f"Hey superuser, {s_user[0]}. You used {s_user[2]}")
        self.super = s_user[0]
        s_password = s_user[1]
        self.superlog = s_user[2]
        if self.super in self.supersheet:
            password = self.supersheet[self.super]
            if s_password == password: self.loaded(self.pageindex[2])
            else: self.loaded(self.pageindex[1]); self.incorrect.emit(1)
        else: self.loaded(self.pageindex[1]); self.incorrect.emit(1)

    @Slot()
    def superadminlogout(self):
        print(f"Bye superadmin, {self.super} at {datetime.datetime.now().__str__()[:19]}")
        self.super = ""
        self.superlog = ""
        self.adminlogout()

    @Slot(list)
    def adminuser(self, a_user):
        print(f"Hey admin, {a_user[0]}. You used {a_user[2]}")
        self.admin = a_user[0]
        a_password = a_user[1] # Calls pi to capture finger for processing
        self.adminlog = a_user[2]
        if self.admin in self.adminsheet:
            password = self.adminsheet[self.admin]
            if a_password == password: self.loaded(self.pageindex[3])
            else: self.loaded(self.pageindex[2]); self.incorrect.emit(1)
        else: self.loaded(self.pageindex[2]); self.incorrect.emit(1)

    @Slot()
    def adminlogout(self):
        print(f"Bye admin, {self.admin} at {datetime.datetime.now().__str__()[:19]}")
        self.admin = ""
        self.adminlog = ""

    # function will be called to extract important info
    '''def userdetails(self, information):
        data = gspread.open('customer.doc')[information]
        return data'''
        
    loggeduser = Signal(str)
    accbalance = Signal(float)
    
    @Slot(list)
    def studentuser(self, user):
        #self.student, password, balance, = userdetails(self, user)
        print(f"Hey student, {user[0]}")
        self.student = user[0]
        u_password = user[1]
        self.studentlog = user[2]
        if self.student in self.customersheet:
            password = self.customersheet[self.student]
            if u_password == password: self.loaded(self.pageindex[self.activity]); self.switchfeature()
            else: self.loaded('close'); self.incorrect.emit(1)
        else: self.loaded('close'); self.incorrect.emit(1)

    featuremode = Signal(str)
    
    @Slot(str)
    def feature(self, activity):
        print(f"{activity} chosen")
        self.activity = activity

    @Slot()
    def switchfeature(self):
        self.loggeduser.emit(self.student)
        self.featuremode.emit(self.activity)
        self.accbalance.emit(self.availbal)
        
    @Slot(float)
    def purchasefeature(self, amount):
        print(f"{amount} involved")
        self.amount = amount

    @Slot(list)
    def transferfeature(self, details):
        print(f"{details[1]} {details[2]} details and received {details[0]}")
        # if details[2] == 'fingerprint': pass #fetch user from database if biometrics
        self.amount = 0.0 if details[0] == '' else float(details[0])
        self.recipient = details[1]
        self.recipientlog = details[2]
        if self.recipient not in self.customersheet: self.loaded('close')

    invalid = Signal(int)
    @Slot(list)
    def registeruser(self, details):
        print(f"{details[0]} has Registered been")
        self.student = details[0]
        #check if user exists in database
        #if self.student in gs('students'): self.invalid.emit(1); self.log(4) # failed
        """if details not in gs('students'):
            with open (gs('students'), 'a+') as file:
                file.write(details)
                self.log(5)
        else: self.log(4)"""
        self.log(5)

    @Slot()
    def userlogout(self):
        print(f"Bye user, {self.student} at {datetime.datetime.now().__str__()[:19]}")
        self.student = ""
        self.studentlog = ""
        self.activity = ""

    @Slot(int)
    def log(self, instruction):
        # Purchase Success
        if instruction == 1:
            message = f"Success: {self.student} {self.activity} {self.amount:.2f} by {datetime.datetime.now().__str__()[:19]}"
            print(message) ; self.report.append(message)
        # Purchase failed
        elif instruction == 0:
            message = f"Failed: {self.student} {self.activity} {self.amount:.2f} by {datetime.datetime.now().__str__()[:19]}"
            print(message) ; self.report.append(message)

        # Transfer Success
        elif instruction == 3:
            message = f"Success: {self.student} {self.activity} {self.amount:.2f} to {self.recipient} by {datetime.datetime.now().__str__()[:19]}"
            print(message) ; self.report.append(message)
        # Transfer failed
        elif instruction == 2:
            message = f"Failed: {self.student} {self.activity} {self.amount:.2f} to {self.recipient} by {datetime.datetime.now().__str__()[:19]}"
            print(message) ; self.report.append(message)
            
        # Registration success
        elif instruction == 5:
            message = f"Success: {self.student} {self.activity} by {datetime.datetime.now().__str__()[:19]}"
            print(message) ; self.report.append(message)
        # Registration failed
        elif instruction == 4:
            message = f"Failed: {self.student} {self.activity} by {datetime.datetime.now().__str__()[:19]}"
            print(message) ; self.report.append(message)
        #Sends email to user
        def writeout(reportfile):
            # read report and rewrite or append value
            # return
            ''' gss = pygsheets.open('CU pay.sheets')
            with open (gss, 'a') as writer:
                writer.write(report)'''
            pass
        #writeout(self.report)
        
    def reset_vars(self):
        ''' Called after a log has been printed'''
        self.student = ""
        self.studentlog = ""
        self.activity = ""
        self.recepient = ""
        self.recepientlog = ""
        self.amount = None
        

test_gspread()
if __name__ == "__main__":
    
    app = QApplication(sys.argv)
    engine = QQmlApplicationEngine()
    back = Backend()
    engine.rootContext().setContextProperty("backend", back)
    engine.quit.connect(app.quit)
    # engine.load('Home.ui.qml')
    engine.load('oti/files/Home.ui.qml')
    engine.load('oti/files/P3Form.ui.qml')
    #gs = gspread.service_account(filename='service_accnt.json')
    #gc = pygsheets.authorize(service_file='service_accnt.json')
    sys.exit(app.exec())

