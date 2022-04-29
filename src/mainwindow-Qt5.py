from PyQt5.QtWidgets import QApplication
from PyQt5.QtQml import QQmlApplicationEngine
from PyQt5.QtCore import QRunnable, pyqtSlot as Slot

from backendhandler import Handler

import sys


class Worker(QRunnable):
    """thread"""
    def __init__(self, values, function):
        super().__init__()
        self.instructions = values
        self.function = function
        self.isalive = True
        self.killed = False

    def run(self):
        while self.isalive & (not self.killed):
            try:
                self.isalive = self.function(self.instructions)
            except RuntimeError: return

    def kill(self):
        self.isalive = False
        self.killed = True

class Backend(Handler):
    googlesheet = None

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
        self._superlogin(s_user)

    @Slot(int)
    def superadminlogout(self, code):
        self._superlogout(code)

    @Slot(list)
    def adminuser(self, a_user):
        self._adminlogin(a_user)

    @Slot()
    def adminlogout(self):
        self._adminlogout()

    @Slot(list)
    def checksuper(self, details):
        self._checksuper(details)       
    
    @Slot(list)
    def removesuper(self, details):
        self._removesuper(details)
    
    @Slot(list)
    def studentuser(self, user):
        self._userlogin(user)

    @Slot()
    def userlogout(self):
        self._userlogout()

    @Slot(str)
    def feature(self, activity):
        self._feature(activity)

    @Slot(int)
    def menubranch(self, stem):
        self._menubranch(stem)

    @Slot()
    def switchfeature(self):
        self._switchfeature()
        
    @Slot(list)
    def purchaseamounts(self, amounts):
        self._purchaseamounts(amounts)

    @Slot(float)
    def purchasefeature(self, amount):
        self._purchasefeature(amount)

    @Slot(list)
    def transferrecipient(self, info):
        self._transferrecipient(info)
        
    @Slot(list)
    def transferfeature(self, details):
        self._transferfeature(details)         

    @Slot(list)
    def deposit(self, details):
        self._deposit(details)

    @Slot(str)
    def checkuser(self, name):
        self._checkuser(name)

    @Slot(int)
    def transactiondone(self, code):
        self._transactiondone(code)

    """
    Keyboard Slots and Signals
    1. sendKeyToFocusItem: Slot inputs pressed key into the textbox
    2. hideKeyboard: Slot receives the instruction and emits the signal to the keyboard
    """

    @Slot(str)
    def sendKeyToFocusItem(self, text):        
        self._sendKeyToFocusItem(text)

    @Slot()
    def hideKeyboard(self): # K in Keyboard is capital
        self._hideKeyboard()

    @Slot()
    def stopthread(self):
        self.worker.kill()
        
    @Slot(list)
    def biometrics(self, instructions): #(self,code,processinfo)
        self.worker = Worker(instructions, self._biometrics)
        self.threadpool.start(self.worker)

if __name__ == "__main__":
    print('>', end='')
    app = QApplication(sys.argv)
    engine = QQmlApplicationEngine()    
    back = Backend()
    engine.rootContext().setContextProperty("backend", back)
    print('> ', end= '')
    engine.load('UI/Home.ui.qml')
    print("loaded")
    back.biometrics("Start") # Start up
    engine.quit.connect(app.quit)
    result = app.exec_()
    back.closeapp()
    sys.exit(result)


