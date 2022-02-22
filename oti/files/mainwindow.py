import sys
from PySide6.QtCore import QObject, Signal, Slot
from PySide6.QtQml import QQmlApplicationEngine
from PySide6.QtWidgets import QApplication
#import gspread
import datetime

class Backend(QObject):
    def __init__(self):
        QObject.__init__(self)
        self.super = ""
        self.superlog = ""
        self.admin = ""
        self.adminlog = ""
        self.student = ""
        self.studentlog = ""
        self.activity = ""
        self.recipient = ""
        self.recipientlog = ""
        self.amount = None

    report = []
    #supersheet = {'100': '0000'}
    supersheet = {'1': ''}
    #adminsheet = {'200': '0000'}
    adminsheet = {'2': '0000'}
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

    loggeduser = Signal(str)
    
    @Slot(list)
    def studentuser(self, user):
        print(f"Hey student, {user[0]}")
        self.student = user[0]
        u_password = user[1]
        self.studentlog = user[2]
        if self.student in self.customersheet:
            password = self.customersheet[self.student]
            if u_password == password: self.loaded(self.pageindex[self.activity]); self.loggeduser.emit(self.student)
            else: self.loaded('close'); self.incorrect.emit(1)
        else: self.loaded('close'); self.incorrect.emit(1)

    @Slot(str)
    def feature(self, activity):
        print(f"{activity} chosen")
        self.activity = activity

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


    @Slot(int)
    def log(self, instruction):
        # Purchase Success
        if instruction == 1: print(f"Success: {self.student}'s {self.activity} {self.amount:.2f} by {datetime.datetime.now().__str__()[:19]}"); self.report.append(f"{self.activity} Success {self.student} {self.amount:.2f} {datetime.datetime.now().__str__()[:19]}")
        # Purchase failed
        elif instruction == 0: print(f"Failed: {self.student}'s {self.activity} {self.amount:.2f} by {datetime.datetime.now().__str__()[:19]}"); self.report.append(f"{self.activity} Failed {self.student} {self.amount:.2f} {datetime.datetime.now().__str__()[:19]}")
        # Transfer Success
        elif instruction == 3: print(f"Success: {self.student}'s {self.activity} {self.amount:.2f} to {self.recipient} by {datetime.datetime.now().__str__()[:19]}"); self.report.append(f"{self.activity} Success {self.student} to {self.recipient} {self.amount:.2f} {datetime.datetime.now().__str__()[:19]}")
        # Transfer failed
        elif instruction == 2: print(f"Failed: {self.student}'s {self.activity} {self.amount:.2f} to {self.recipient} by {datetime.datetime.now().__str__()[:19]}"); self.report.append(f"{self.activity} Failed {self.student} to {self.recipient} {self.amount:.2f} {datetime.datetime.now().__str__()[:19]}")
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
        


if __name__ == "__main__":
    app = QApplication(sys.argv)
    engine = QQmlApplicationEngine()
    back = Backend()
    engine.rootContext().setContextProperty("backend", back)
    engine.quit.connect(app.quit)
    engine.load('../example/Home.ui.qml')
    engine.load('../example/P3Form.ui.qml')
    #gs = gspread.service_account(filename='service_accnt.json')
    #gc = pygsheets.authorize(service_file='service_accnt.json')
    sys.exit(app.exec())

'''
1.

2.

'''
