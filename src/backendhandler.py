from PyQt5.QtWidgets import QApplication
from PyQt5.Qt import QInputMethodEvent
from PyQt5.QtCore import QObject, QThreadPool, pyqtSignal as Signal

from fingerprintfunctions import *
# from checkfunc import *
from database import *

import datetime


class Handler(QObject):
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
        self.intermediatepage = 0
        self.event = QInputMethodEvent()
        self.threadpool = QThreadPool()

    report = []
    pageindex = {
        1: "P1Form.ui.qml", 2: "P2Form.ui.qml", 3: "P3Form.ui.qml",
        'supersetting': 'Superview.ui.qml', 'adminsetting': 'Adminview.ui.qml',
        'Purchase': 'Purchasemulti2.ui.qml', 'Transfer': 'Transfermulti2.ui.qml',
        'Deposit': 'Deposit.ui.qml', 'Register': 'Register.ui.qml',
        'Removesuper': 'Removesuper.ui.qml'
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
    10. Biofailed: Emitted when scanned fingerprint doesn't match
    11. Loadloader: When finger is scanned, it makes the loading page to appear. Used in pages that loaded
    12. Loadstack: When finger is scanned, it makes the loading page to appear. Used in pages that are stacked
    13. Enrollinfo: Displays the information that the scanner is sending
    14. Retryenroll: If the enrollment process fails, this resets the page
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
    biofailed = Signal()
    loadloader = Signal()
    loadstack = Signal()
    enrollinfo = Signal(str)
    retryenroll = Signal()

    """
    Slots are used to communicate with Python from QML
    1. _superlogin: Runs during a Super Admin log in. It passes the information entered and, at the end, emits appropriate Signal(s) based on the outcome of the login attempt
    1.1 _superloginbio: Waits for fingerprint and runs functions based on the result
    2. _superlogout: Called when a Super Admin is logged out.
    3. _adminlogin: Runs during an Admin log in. See Description of 'Superuser Slot' in No. 2 for extra detail
    3.1 _adminloginbio: Waits for fingerprint and runs functions based on the result
    4. _adminlogout: Called when an Admin is logged out.
    5. _verifysuper: Used to verify super for Registersuper, Removesuper, Deposit functions which require confirmation before executing
    5.1 _verifysuperbio: Fingerprint version of _verifysuper. The verification is done with fingerprint
    6. _checksuper: Used when Removing/Registering to certify they exist/don't exist respectively
    7. _registersuper: Called when Registering a Super Admin or Admin
    7.1 _completeregistration: Called by _registersuper after successful verification
    8. _removesuper: Called when Removing a Super Admin or Admin. The verification is done by typing details
    8.1 _removesuperbio: The verification is done with fingerprint
    9. _userlogin: Runs during a User/Student log in. See Description of 'Superuser Slot' in No. 2 for extra detail
    9.1 _userloginbio: Waits for fingerprint and runs functions based on the result
    10. _userlogout: Called when a User/Student is logged out.
    11. _feature: Called to assign the variable which tells the program what activity was chosen. Helps to Display and Load the correct page
    12. _menubranch: Tells the code what page the menu branched out from
    13. _switchfeature: Called to emit Signals which display Activity window, Logged user's name, and Account balance. See 'Loggeduser Signal' in No. 4 of Signal List
    14. _purchaseamounts: Used to sum the multiple purchase values. Calls totalexp Signal
    15. _purchasefeature: Called to assign the variable which tells the program what amount was spent
    16. _transferrecipient: Checks if the beneficiary of a transaction exists
    17. _transferfeature: Called to assign the variables which tell the program what amount was transferred, the Recipient, and Recipient's means of identification
    18. _deposit: Called when making a deposit to confirm admin to verify the deposit and update the database
    18.1 _depositbio: The verification is done with fingerprint
    19. _checkuser: Called when registering a new user to be sure reg no doesn't already exist
    20. _registeruser: Called to assign the variables which tell the program Reg No., Password, and Fingerprint of New User
    20.1 _registeruserbio: Called to register fingerprint. If successful, calls _registeruser and passes in the information
    21. _transactiondone: Called after a Purchase or Transfer was attempted regardless if it was successful or not
    """

    def _superlogin(self, s_user):
        self.super = s_user[0]
        s_password = s_user[1]
        self.superlog = s_user[2]  # Remove this line when fingerprint if-block is done
        # Write an if block for when fingerprint is used

        if self.supersheet['Name'].get(self.super) is None: self.loaded(self.pageindex[1]); self.incorrect.emit(1); self.log("1001", self.super)
        else:
            data = self.supersheet.loc[self.supersheet['Name'].get(self.super)]
            if s_password == data.Pin:
                self.loaded(self.pageindex[2]) if s_user[3] == 0 else self.loaded(self.pageindex['supersetting']); self.accountname.emit([data['Account Name'], data.Station])
                self.log("1101", self.super)
            else: self.loaded(self.pageindex[1]); self.incorrect.emit(1); self.log("1001", self.super)

    def _superloginbio(self, s_user):
        breakout = False
        self.super, self.superlog = s_user[:2]

        try:
            bioinput = auth(self.superbiosheet[self.super])
        except KeyError:
            self.loaded(self.pageindex[1]); self.incorrect.emit(1); self.log("1011", self.super)
            return False

        for output in bioinput:
            # False finger didn't match
            if output is False: self.loaded(self.pageindex[1]); self.log("1011", self.super); self.biofailed.emit(); breakout = True; break
            # None finger wasn't scanned
            elif output is None: print('none timed out'); breakout = True; break
            elif output is True: self.loadloader.emit() # True finger was scanned
            elif type(output) == str: self.enrollinfo.emit(output) # str - verifying
            elif output == "Found": break

        if breakout is True: return True

        data = self.supersheet.loc[self.supersheet['Name'].get(self.super)]

        self.loaded(self.pageindex[2]) if s_user[2] == 0 else self.loaded(self.pageindex['supersetting']); self.accountname.emit([data['Account Name'], data.Station])
        self.log("1111", self.super)

        return False  # successful

    def _superlogout(self, code):
        self.log("51-1", self.super)
        self.super, self.superlog = "", ""
        if code == 1: self.adminlogout()

    def _adminlogin(self, a_user):
        self.admin = a_user[0]
        a_password = a_user[1]  # Calls pi to capture finger for processing
        self.adminlog = a_user[2]

        if self.adminsheet['Name'].get(self.admin) is None: self.loaded(self.pageindex[2]); self.incorrect.emit(1); self.log("1000", self.admin)
        else:
            data = self.adminsheet.loc[self.adminsheet['Name'].get(self.admin)]
            if a_password == data.Pin:
                self.loaded(self.pageindex[3]) if a_user[3] == 0 else self.loaded(self.pageindex['adminsetting']); self.accountname.emit([data['Account Name'], data.Station, str(data.Amount)])
                self.log("1100", self.admin) if self.adminlog == 'Pin' else self.log("1110", self.admin)
            else: self.loaded(self.pageindex[2]); self.incorrect.emit(1); self.log("1000", self.admin)

    def _adminloginbio(self, a_user):
        breakout = False
        self.admin, self.adminlog = a_user[:2]

        try:
            bioinput = auth(self.adminbiosheet[self.admin])
        except KeyError:
            self.loaded(self.pageindex[2]); self.incorrect.emit(1); self.log("1010", self.admin)
            return False

        for output in bioinput:
            # False finger didn't match
            if output is False: self.loaded(self.pageindex[2]); self.log("1010", self.admin); self.biofailed.emit(); breakout = True; break
            # None finger wasn't scanned
            elif output is None: print('none timed out'); breakout = True; break
            elif output is True: self.loadloader.emit() # True finger was scanned
            elif type(output) == str: self.enrollinfo.emit(output) # str - verifying
            elif output == "Found": break

        if breakout is True: return True

        data = self.adminsheet.loc[self.adminsheet['Name'].get(self.admin)]

        self.loaded(self.pageindex[3]) if a_user[2] == 0 else self.loaded(self.pageindex['adminsetting']); self.accountname.emit([data['Account Name'], data.Station, str(data.Amount)])
        self.log("1110", self.admin)

        return False  # successful

    def _adminlogout(self):
        self.log("51-0", self.admin)
        self.admin, self.adminlog = "", ""

    def _verifysuper(self, code, details):
        if code == 0:  # For Register
            regno, rank = details[0], details[2]
            supername, superpassword, superlog = details[5:8]
            if self.supersheet['Name'].get(supername) is None:
                self.log('40-1', f"{regno} Unfound {supername}") if rank == 'Super Admin' else self.log('40-0', f"{regno} Unfound {supername}")
                self.incorrect.emit(3); return True
            else:
                data = self.supersheet.loc[self.supersheet['Name'].get(supername)]
                if superpassword != data.Pin:
                    self.log('40-1', f"{regno} Unverified {supername}") if rank == 'Super Admin' else self.log('40-0', f"{regno} Unverified {supername}")
                    self.incorrect.emit(3); return True
            return False  # successful

        elif code == 1:  # For Removal
            removename, supername, superpassword, superlog = details

            if self.supersheet['Name'].get(supername) is None: self.log(['6', '0', 'Unfound', f'Unfound {supername}', superlog], removename); self.incorrect.emit(3); return True
            else:
                data = self.supersheet.loc[self.supersheet['Name'].get(supername)]
                if superpassword != data.Pin:
                    self.log(['6', '0', 'Unfound', f"Unverified {supername}", superlog], removename)
                    self.incorrect.emit(3); return True
            return False  # successful

        elif code == 2:  # For Deposit
            amount = float(details[0])
            supername, superpin, superlog = details[1:4]

            if self.supersheet['Name'].get(supername) is not None:  # Super Verified
                data = self.supersheet.loc[self.supersheet['Name'].get(supername)]
                rank = '1'
                if superpin != data.Pin:
                    self.log(['7', '0', rank,supername, f"Unverified {superlog}"], amount)
                    self.incorrect.emit(3); return True
            elif self.adminsheet['Name'].get(supername) is not None: # Admin Verified
                data = self.adminsheet.loc[self.adminsheet['Name'].get(supername)]
                rank = '0'
                if superpin != data.Pin:
                    self.log(['7','0',rank,supername,f"Unverified {superlog}"], amount)
                    self.incorrect.emit(3); return True
            else:
                self.log(['7','0','3',supername,f"Unfound {superlog}"], amount)
                self.incorrect.emit(3); return True
            return False  # successful

    def _verifysuperbio(self, code, details):
        breakout = False

        if code == 0:  # For Register
            regno, rank = details[0], details[2]
            supername, superlog = details[5:7]
            try:
                bioinput = auth(self.superbiosheet[supername])
            except KeyError:
                self.log('40-1', f"{regno} Unfound {supername}") if rank == 'Super Admin' else self.log('40-0', f"{regno} Unfound {supername}")
                self.incorrect.emit(3); return None

            for output in bioinput:
                # False - finger didn't match
                if output is False:
                    self.log('40-1', f"{regno} Unverified {supername}") if rank == 'Super Admin' else self.log('40-0', f"{regno} Unverified {supername}")
                    self.biofailed.emit(); breakout = True; break
                # None - no finger was scanned
                elif output is None: print('none timed out'); breakout = True; break
                # elif output == True: self.enrollinfo.emit("Processing Fingerprint. Please Wait...") # True - finger was scanned
                elif type(output) == str: self.enrollinfo.emit(output) # str - verifying
                elif output == "Found": break

            if breakout is True: return True

            return False  # successful

        elif code == 1:  # For Removal
            removename, supername, superlog = details
            try:
                bioinput = auth(self.superbiosheet[supername])
            except KeyError:
                self.log(['6', '0', 'Unfound', f'Unfound {supername}', superlog], removename); self.incorrect.emit(3)
                return None

            for output in bioinput:
                # False finger didn't match
                if output is False: self.loaded(self.pageindex['Removesuper']); self.log(['6', '0', 'Unfound', f'Unverified {supername}', superlog], removename); self.biofailed.emit(); self._menubranch(self.intermediatepage); breakout = True; break
                # None finger wasn't scanned
                elif output is None: print('none timed out'); breakout = True; break
                elif output is True: self.loadloader.emit() # True finger was scanned
                elif type(output) == str: self.enrollinfo.emit(output) # str - verifying
                elif output == "Found": break

            if breakout is True: return True

            return False

        elif code == 2:  # For Deposit
            amount = float(details[0])
            supername, superlog = details[1:3]  # supername, superpin, superlog = details[1:4]

            admin_n_super_bio = self.adminbiosheet
            admin_n_super_bio.update(self.superbiosheet)
            try:
                bioinput = auth(admin_n_super_bio[supername])  # used in all the codes
            except KeyError:
                self.log(['7', '0', '3', supername, f"Unfound {superlog}"], amount)
                self.incorrect.emit(3); return None

            for output in bioinput:
                # False finger didn't match
                if output is False: self.loaded('close'); self.log(['7', '0', '3', supername, f"Unverified {superlog}"], amount); self.biofailed.emit(); breakout = True; break
                # None finger wasn't scanned
                elif output is None: print('none timed out'); breakout = True; break
                elif output is True: self.loadstack.emit()  # True finger was scanned
                elif type(output) == str: self.enrollinfo.emit(output)  # str - verifying
                elif output == "Found": break

            if breakout is True: return True

            return False  # successful

    def _checksuper(self, details):
        regno = details[0]
        rank = details[1]
        # Condition fails if name is found in corresponding adminlist
        if ((rank == 'Super Admin') & (self.supersheet['Name'].get(regno) is not None)) | ((rank == 'Admin') & (self.adminsheet['Name'].get(regno) is not None)):
            self.invalid.emit(1); self.log("40-1", regno) if rank == 'Super Admin' else self.log("40-0", regno)
        else: self.proceed.emit(2)

    def _registersuper(self, details):  # [regno, accname, code, station, password, (supername,superpassword), 'Fingerprint'/'Pin/'Verified']
        # self.userdetails(details, 3) # ANSWER

        breakout = False
        if details[-1] == "Verified":
            regno, accname, rank, station, password, superlog = details
        else:
            regno, accname, rank, station, password, supername, superlog = details[:7]

        # Super verify
        if details[-1] == "Verified":  # Super Admin has not been verified already
            details.insert(5, self.super)
            # [regno_field.text, accname_field.text, code, stationname.text, password.text, supername, "Verified"]

        elif details[-1] == "Pin":
            supername, superpassword, superlog = details[5:8]
            if self._verifysuper(0, details) is True: return True  # unsuccessful
            # [regno_field.text, accname_field.text, code, stationname.text, password.text, username1.text, password1.text , "Pin"]

        elif details[-1] == "Fingerprint":
            result = self._verifysuperbio(0, details)
            if result is None: return False # for keyerrors - stops thread
            elif result is True: return True # unsuccessful
            # [regno_field.text, accname_field.text, code, stationname.text, password.text, supername, "Fingerprint"]

        self.proceed.emit(3)  # To go to enroll page

        # Enrolling fingerprint
        fingerdata = enroll_finger(regno)

        for output in fingerdata:
            if type(output) == str: self.enrollinfo.emit(output)
            elif type(output) == dict: enrolledfinger = output; break
            elif output is False: self.enrollinfo.emit('Error Occured'); breakout = True; break

        if breakout is True: self.retryenroll.emit(); return False

        # Data conformity
        details.insert(3, 0)
        details.insert(6, str(enrolledfinger[regno]))

        if rank == "Super Admin":
            self.superbiosheet.udpate(enrolledfinger)
        elif rank == "Admin":
            self.adminbiosheet.update(enrolledfinger)

        self._completeregistration(details)

        return False  # successful

    def _completeregistration(self, details):
        import csv

        information = details[:7]
        regno, rank = details[0], details[2]
        supername, superlog = details[7], details[-1]

        information.append(datetime.datetime.now().__str__()[:19])

        if rank == 'Super Admin': self.supersheet.loc[regno] = information
        else: self.adminsheet.loc[regno] = information

        all_admins = self.supersheet
        all_admins.update(self.adminsheet)

        self.adminworksheet = update_admin_database(all_admins, self.adminworksheet)

        self.proceed.emit(1) # Successful dialog

        '''
        with open ('admindummy.csv', 'a') as file:
            csv_writer = csv.writer(file)
            csv_writer.writerow(information)
        '''
        self.log("41-1", regno) if rank == 'Super Admin' else self.log("41-0", regno)
        # Regular Admin registering as Super Admin
        if (rank == 'Super Admin') & (self.adminsheet['Name'].get(regno) is not None):
            if details[-1] != "Verified": self.log("41-1", f"{regno} by Super: {supername} - {superlog}")
            else: self.log("41-1", f"{regno} by Super: {self.super} - {self.superlog}")

    def _removesuper(self, details):
        import csv
        # self.userdetails(details, 4) # ANSWER
        if details[-1] == 'Verified':
            removename, superlog, supername = details[:3]
            self._menubranch(self.intermediatepage)
        else:
            removename, supername, superpassword, superlog = details # Remove rank has been removed from details[1]

        # Super verify
        if superlog == 'Pin':  # if Fingerprint calls this function, it's been verified
            if self._verifysuper(1, details) is True: return  # True if failed

        # Removee verify
        if (self.supersheet['Name'].get(removename) is not None) | (self.adminsheet['Name'].get(removename) is not None):  # if a super admin and an admin, it'll remove admin profile
            if (self.supersheet['Name'].get(removename) is not None) & (self.adminsheet['Name'].get(removename) is not None):  # user in both lists
                data = list(self.adminsheet.loc[removename])
                self.adminsheet.drop(removename, inplace=True)
            elif self.supersheet['Name'].get(removename) is not None:  # user a superadmin
                data = list(self.supersheet.loc[removename])
                self.supersheet.drop(removename, inplace=True)
            elif self.adminsheet['Name'].get(removename) is not None:  # user an admin
                data = list(self.adminsheet.loc[removename])
                self.adminsheet.drop(removename, inplace=True)
            data.append(datetime.datetime.now().__str__()[:19])

            '''
            with open('deletedadmins.csv', 'a') as dfile:
                csv_writer = csv.writer(dfile)
                csv_writer.writerow(data)
           '''
            self.proceed.emit(1)

            all_admins = self.supersheet
            all_admins.update(self.adminsheet)
            self.adminworksheet = update_admin_database(all_admins, self.adminworksheet)

            removerank = data[2]
            '''
            formatted_list = self.pdtolist('Admins')            
            
            with open ('admindummy.csv', 'w') as file:
                csv_writer = csv.writer(file)
                csv_writer.writerows(formatted_list)
            '''
            self.log(['6','1',removerank,supername,superlog], removename)
        else:
            self.invalid.emit(1); self.log(['6','0','Unfound',supername,superlog], removename)

    def _removesuperbio(self, details):
        result = self._verifysuperbio(1, details)
        if result is False:
            details.append('Verified')
            self.loaded(self.pageindex['Removesuper'])
            self._removesuper(details)
            return False  # stops thread
        elif result is None: return False  # for keyerrors - stops thread
        elif result is True: return True  # it either failed or finger wasn't scanned

    def _userlogin(self, user):  # user = [name, pin, "Fingerprint/Pin"]
        # self.userdetails(user, 2) # ANSWER
        self.student = user[0]
        u_password = user[1]
        self.studentlog = user[2]

        if self.customersheet['Name'].get(self.student) is None: self.loaded('close'); self.incorrect.emit(1); self.log("1002", self.student)
        else:
            data = self.customersheet.loc[self.customersheet['Name'].get(self.student)]
            self.availbal = data.Amount
            self.accname = data['Account Name']
            if u_password == data.Pin:
                self.loaded(self.pageindex[self.activity]); self._switchfeature()
                self.log("1102", self.student)
            else: self.loaded('close'); self.incorrect.emit(1); self.log("1002", self.student)

    def _userloginbio(self, user):
        breakout = False
        self.student, self.studentlog = user[:2]

        try:
            bioinput = auth(self.userbiosheet[self.student])  # check what incorrect. emit causes
        except KeyError:
            self.loaded('close'); self.incorrect.emit(1); self.log("1012", self.student)
            return False

        for output in bioinput:
            # False finger didn't match
            if output is False: self.loaded('close'); self.log("1012", self.student); self.biofailed.emit(); breakout = True; break
            # None finger wasn't scanned
            elif output is None: print('none timed out'); breakout = True; break
            elif output is True: self.loadstack.emit() # True finger was scanned
            elif type(output) == str: self.enrollinfo.emit(output) # str - verifying
            elif output == "Found": break

        if breakout is True: return True

        data = self.customersheet.loc[self.customersheet['Name'].get(self.student)]

        self.availbal = data.Amount
        self.accname = data['Account Name']

        self.loaded(self.pageindex[self.activity]); self._switchfeature()
        self.log("1112", self.student)

        return False  # successful

    def _userlogout(self):
        self.log("51-2", self.student)
        self.student, self.studentlog, self.activity = "", "", ""

    def _feature(self, activity):
        self.activity = activity
        if activity == "Register": self.featuremode.emit("Registration")

    def _menubranch(self, stem):
        self.intermediatepage = stem
        if stem == 4: self.loaded(self.pageindex['supersetting']); return
        elif stem == 5: self.loaded(self.pageindex['adminsetting']); return
        self.loaded(self.pageindex[stem])

    def _switchfeature(self):
        self.loggeduser.emit(self.accname)
        self.featuremode.emit(self.activity)
        self.accbalance.emit(self.availbal)

    def _purchaseamounts(self, amounts):
        total = 0
        for amount in amounts:
            tempnum = 0
            if (amount.strip()).isnumeric():
                tempnum = int(amount.strip())
                if 0 < tempnum < 50: self.incorrect.emit(1); return
                total += tempnum
        else:
            self.incorrect.emit(1) if round(total, 2) == 0 else self.totalexp.emit(round(total, 2))

    def _purchasefeature(self, amount):
        self.amount = amount

    def _transferrecipient(self, info):  # info = [fingerpicture/username, code]
        if self.customersheet['Name'].get(info[0]) is None: self.incorrect.emit(2)
        else:
            recipient = self.customersheet.loc[info[0]]['Account Name']
            self.accountname.emit([recipient, info[1]])  # ; self.displayuser.emit(username)

    def _transferfeature(self, details):  # details = [amount, fingerpicture/ username, "Fingerprint/ Typed"]
        self.amount = 0.0 if details[0] == '' else float(details[0])
        self.recipient = details[1]

    def _deposit(self, details):
        import csv
        # Bio verify
        if details[-1] == 'Verified':
            amount = float(details[0])
            supername, superlog = details[1:3]
        else:
            amount = float(details[0])
            supername, superpin, superlog = details[1:4]

        # Super verify
        if superlog == 'Pin':  # if Fingerprint calls this function, it's been verified
            if self._verifysuper(2, details) is True: return  # True if failed

        self.availbal += round(amount, 2)
        self.customersheet.at[self.student, 'Amount'] = self.availbal
        self.proceed.emit(1)

        self.userworksheet = update_admin_database(self.customersheet, self.userworksheet)

        if self.supersheet['Name'].get(supername) is not None:  # Super Verified
            rank = '1'
        elif self.adminsheet['Name'].get(supername) is not None:  # Admin Verified
            rank = '0'
        else:
            rank = '3'
        '''
        formatted_list = self.pdtolist('Users')

        with open ('userdummy.csv', 'w') as file:
            csv_writer = csv.writer(file)
            csv_writer.writerows(formatted_list)
        '''
        self.log(['7', '1', rank, supername, superlog], amount)

    def _depositbio(self, details):
        result = self._verifysuperbio(2, details)
        if result is False:
            self.loaded('close')
            details.append('Verified')
            self._deposit(details)
            return False  # stops thread
        elif result is None: return False  # for keyerrors - stops thread
        elif result is True: return True  # it either failed or finger wasn't scanned

    def _checkuser(self, name):
        if self.customersheet['Name'].get(name) is not None:
            self.invalid.emit(1); self.log("40-2", name)
        else: self.proceed.emit(2)

    def _registeruser(self, details):  # details = [reg no, acc name, password, fingerpicture]
        import csv
        # self.userdetails(details, 32) # ANSWER
        self.student = details[0]
        details.insert(2, 'User')
        details.insert(3, 0)
        details.append(datetime.datetime.now().__str__()[:19])

        self.customersheet.loc[self.student] = details
        self.userworksheet = update_admin_database(self.customersheet, self.userworksheet)

        '''
        with open ('userdummy.csv', 'a+') as file:
            csv_writer = csv.writer(file)
            csv_writer.writerow(details)
        '''
        self.log("41-2", self.student)

    def _registeruserbio(self, details): # details = [reg no, acc name, password]
        breakout = False
        regno = details[0]

        fingerdata = enroll_finger(regno)

        for output in fingerdata:
            if type(output) == str: self.enrollinfo.emit(output)
            elif type(output) == dict: enrolledfinger = output; break
            elif output is False: self.enrollinfo.emit('Error Occured'); breakout = True; break

        if breakout is True: self.retryenroll.emit(); return False

        details.append(str(enrolledfinger[regno]))
        self.userbiosheet.update(enrolledfinger)

        self._registeruser(details)
        self.proceed.emit(1)

        return False

    def _transactiondone(self, code):
        import csv
        self.availbal = self.customersheet.loc[self.student]['Amount']
        self.availbal -= round(self.amount, 2)
        self.customersheet.at[self.student, 'Amount'] = self.availbal

        if code == 0:  # Purchase
            self.log("2112", self.student) if self.studentlog == "Fingerprint" else self.log("2102", self.student)
            adminbalance = self.adminsheet.loc[self.admin]['Amount']
            adminbalance += round(self.amount, 2)
            self.adminsheet.at[self.admin, 'Amount'] = adminbalance
            self.adminworksheet = update_admin_database(self.adminsheet, self.adminworksheet)
        elif code == 1:  # Transfer
            self.log("3112", self.student) if self.studentlog == "Fingerprint" else self.log("3102", self.student)
            recipientbal = self.customersheet.loc[self.recipient]['Amount']
            recipientbal += round(self.amount, 2)
            self.customersheet.at[self.recipient, 'Amount'] = recipientbal

        self.userworksheet = update_admin_database(self.customersheet, self.userworksheet)

        '''
        formatted_list = self.pdtolist('Users')

        with open ('userdummy.csv', 'w') as file:
            csv_writer = csv.writer(file)
            csv_writer.writerows(formatted_list)
        '''

    """
    Keyboard Slots and Signals
    1. hidekeyboard: Signals keyboard to hide by falling below the screen
    2. sendKeyToFocusItem: Slot inputs pressed key into the textbox
    3. hideKeyboard: Slot receives the instruction and emits the signal to the keyboard
    """
    hidekeyboard = Signal()

    def _sendKeyToFocusItem(self, text):
        self.event.setCommitString("", -1, 1) if text == '\x7F' else self.event.setCommitString(text)
        QApplication.sendEvent(QApplication.focusObject(), self.event)

    def _hideKeyboard(self):  # K in Keyboard is capital
        self.hidekeyboard.emit()

    """
    Script Functions
    1. Test_gspread: Retrieves Googlesheet from cloud and loads information into physical memory
    2. Pdtolist: After removing a (super) admin Or after a transaction, the function converts the dataframe to a list for writing to csv file
    3. Loaded: Called to close Loading page after a process has completed
    4. Writeout: Executed activity is written to external log file. 'Log Function' calls 'Writout'
    5. Log: Called after an activity has been executed successfully or failingly
    6. Closeapp: Runs when close button is clicked. It prints the activity log for that current session and closes the application
    7. _functionlist: Returns the appropriate function to run when called by _biometrics function
    8. _biometrics: Starts a thread to run the function returned from _functionlist in the thread
    """

    def test_gspread(self):
        # from pandas import read_csv
        run = True
        attempts = 10
        while run:
            try:
                spreadsheet, self.adminworksheet = load_admin_database()
                spreadsheet.set_index(spreadsheet['Name'], inplace=True)
                spreadsheet = spreadsheet.astype({'Amount': float})
                self.supersheet = spreadsheet.loc[spreadsheet['Rank'] == 'Super Admin']
                self.adminsheet = spreadsheet.loc[spreadsheet['Rank'] == 'Admin']

                self.customersheet, self.userworksheet = load_user_database()
                self.customersheet.set_index(self.customersheet['Name'], inplace=True)
                self.customersheet = self.customersheet.astype({'Amount': float})

                self.superbiosheet = {username: eval(finger) for finger, username in zip(self.supersheet['Fingerprint'],self.supersheet['Name'])}
                self.adminbiosheet = {username: eval(finger) for finger, username in zip(self.adminsheet['Fingerprint'],self.adminsheet['Name'])}
                self.userbiosheet = {username: eval(finger) for finger, username in zip(self.customersheet['Fingerprint'], self.customersheet['Name'])}

                '''
                # For When Internet Fails You
                spreadsheet = read_csv('admindummy.csv', dtype = str)
                spreadsheet.set_index(spreadsheet['Name'], inplace = True)
                spreadsheet = spreadsheet.astype({'Amount': float})
                self.supersheet = spreadsheet.loc[spreadsheet['Rank']=='Super Admin']
                self.adminsheet = spreadsheet.loc[spreadsheet['Rank']=='Admin']

                self.customersheet = read_csv('userdummy.csv', dtype = str)
                self.customersheet.set_index(self.customersheet['Name'], inplace = True)
                self.customersheet = self.customersheet.astype({'Amount': float})

                self.superbiosheet = {username: eval(finger) for finger, username in zip(self.supersheet['Fingerprint'],self.supersheet['Name'])}
                self.adminbiosheet = {username: eval(finger) for finger, username in zip(self.adminsheet['Fingerprint'],self.adminsheet['Name'])}
                self.userbiosheet = {username: eval(finger) for finger, username in zip(self.customersheet['Fingerprint'],self.customersheet['Name'])}


                admindf, adminworksheet = load_admin_database()
                userdf, userworksheet = load_user_database()

                adminworksheet = update_admin_database(spreadsheet, adminworksheet)
                userworksheet = update_admin_database(self.customersheet, userworksheet)
                '''

            except:
                attempts -= 1
                if attempts == 0:
                    self.retryenroll.emit()
                    return False  # ends function. Restart needed

            else:
                run = False  # stops loop successfully
        else:
            print(f"{spreadsheet}")
            print(f"Admins: {len(spreadsheet)} Entries\nUsers: {len(self.customersheet)} Entries")
            self.finishedprocess.emit(self.pageindex[1])

            return False  # successful

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

    def log(self, code, name):
        passkey = {'1': 'Success', '0': 'Fail'}
        biokey = {'1': 'Biometric', '0': 'Pin'}
        userkey = {'1': 'Super Admin', '0': 'Admin', '2': 'User', '3': 'Unfound'}
        if code[0] == '1':
            message = f"Login {passkey[code[1]]}: {userkey[code[3]]} {name} used {biokey[code[2]]} by {datetime.datetime.now().__str__()[:19]}\n"
        elif code[0] == '2':
            message = f"Purchase {passkey[code[1]]}: {userkey[code[3]]} {name} used {biokey[code[2]]} for {self.amount:.2f} by {datetime.datetime.now().__str__()[:19]}\n"
        elif code[0] == '3':
            message = f"Transfer {passkey[code[1]]}: {userkey[code[3]]} {name} used {biokey[code[2]]} for {self.amount:.2f} to {self.recipient} by {datetime.datetime.now().__str__()[:19]}\n"
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
        self.worker.kill()
        if self.report: print("The following transactions occurred in this session")
        for items in self.report: print(items)

    def _functionlist(self, code):
        handlerfunctions = {
            1: self._superloginbio, 2: self._adminloginbio, 3: self._registersuper,
            4: self._removesuperbio, 5: self._userloginbio, 6: 'self._transferrecipientbio',
            7: self._depositbio, 8: self._registeruserbio
        }
        return handlerfunctions[code]

    def _biometrics(self, instructions):
        if instructions == "Start": return self.test_gspread()

        code, *parameters = instructions
        function = self._functionlist(code)

        return function(parameters)
