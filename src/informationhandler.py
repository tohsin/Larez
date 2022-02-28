"""
1 - Still too early
go to the corresponding qml files to ensure the values returned match
    login
        information = ['Fingerprint', fingerpicture]
        information = [name, pin, 'Pin']
    register
        info = [name, rank, pin, fingerprint]
    remove
        info = [name, supername, 'Fingerprint/Pin', superlog]
    transfer
        info = [student, log, recipient, log] # Kind of good to go > details = [amount, fingerpicture/ username, "Fingerprint/ Typed"]

2 - make dummy table and test
table data
    data = [name, rank, pin, fingerprint] #super | admin
    data = [name, rank, accbal, pin, fingerprint] # user
    name synonymous with reg no / username
"""

def userdetails(self, information, code):
    if (code == 0) or (code == 1): # Superadmin | Admin
        if information[0] == 'Fingerprint': # information = ['Fingerprint', fingerpicture]
            fingerprint = information[1]
            # self.googlsheet('admins').get(fingerprint) # call data if present
            if fingerprint in self.googlesheet('admins')[fingerprint]:
                data = self.googlesheet('admins').row[fingerprint] # whole info from that row
                if (data[1] == 'Super Admin') and (code == 0): # data = [name, rank, pin, fingerprint]
                    self.super = data[0]
                    self.loaded(self.pageindex[2]); self.log("1111", self.super) # success
                elif (data[1] == 'Admin') and (code == 1):
                    self.admin = data[0]
                    self.loaded(self.pageindex[3]); self.log("1110", self.admin) # success
                else:
                    if code == 0 : self.loaded(self.pageindex[1]); self.incorrect.emit(1); self.log("1011", "Undefined")
                    elif code == 1:self.loaded(self.pageindex[2]); self.incorrect.emit(1); self.log("1010", "Undefined")
            else:
                if code == 0 : self.loaded(self.pageindex[1]); self.incorrect.emit(1); self.log("1011", "Undefined")
                elif code == 1:self.loaded(self.pageindex[2]); self.incorrect.emit(1); self.log("1010", "Undefined")
            
        elif information[2] == 'Pin': # information = [name, pin, 'Pin']
            user = information[0]
            s_password = information[1]
            if user in self.googlesheet('admins')[username]:
                data = self.googlesheet('admins').row[username]
                password = data[2]
                if s_password == password:
                    if (data[1] == 'Super Admin') and (code == 0):
                        self.super = user
                        self.loaded(self.pageindex[2]); self.log("1101", self.super)
                    elif (data[1] == 'Admin') and (code == 1):
                        self.admin = user
                        self.loaded(self.pageindex[3]); self.log("1100", self.admin)
                    else:
                        if code == 0 : self.loaded(self.pageindex[1]); self.incorrect.emit(1); self.log("1001", "Undefined")
                        elif code == 1:self.loaded(self.pageindex[2]); self.incorrect.emit(1); self.log("1000", "Undefined")
                else:
                    if code == 0: self.loaded(self.pageindex[1]); self.incorrect.emit(1); self.log("1001", f"'{data[1]} {data[0]}'")
                    elif code == 1: self.loaded(self.pageindex[2]); self.incorrect.emit(1); self.log("1000", f"'{data[1]} {data[0]}'")
            else:
                if code == 0 : self.loaded(self.pageindex[1]); self.incorrect.emit(1); self.log("1001", "Undefined")
                elif code == 1:self.loaded(self.pageindex[2]); self.incorrect.emit(1); self.log("1000", "Undefined")

    elif code == 2: # User #IN P4Form: change information from [name, pin, "Fingerprint/Pin"] >> not Done - ["Fingerprint", fingerpicture] & Done - [name, pin, "Pin"]
        if information[0] == 'Fingerprint':
            fingerprint = information[1]
            # self.googlsheet('admins').get(fingerprint) # call data if present
            if fingerprint in self.googlesheet('users')[fingerprint]:
                data = self.googlesheet('users').row[fingerprint] # whole info from that row
                self.student = data[0] # data = [name, rank, account, pin, fingerprint]
                self.availbal, self.studentlog = data[2], 'Fingerprint'
                self.loaded(self.pageindex[self.activity]); self.switchfeature(); self.log("1112", self.student)
            else: self.loaded('close'); self.incorrect.emit(1); self.log("1012", "Undefined")
        elif information[2] == 'Pin':
            self.student = information[0]
            u_password = information[1]
            if self.student in self.googlesheet('users')[username]:
                data = self.googlesheet('users').row[username] # data = [name, rank, account, pin, fingerprint]
                password = data[3]
                if u_password == password:
                    self.availbal, self.studentlog = data[2], 'Pin'
                    self.loaded(self.pageindex[self.activity]); self.switchfeature(); self.log("1102", self.student)
                else: self.loaded('close'); self.incorrect.emit(1); self.log("1002", self.student)
            else: self.loaded('close'); self.incorrect.emit(1); self.log("1002", self.student)
    elif code == 3: # Register Super or Admin
        name, rank = information[:2] # info = [name, rank, pin, fingerprint]
        if name in self.googlesheet('admins')[username]:
            if rank == 'Super Admin': self.invalid.emit(1); self.log('40-1', name) # fail
            elif rank == 'Admin': self.invalid.emit(1); self.log('40-0', name)
        else:
            self.googlesheet('admins').writerow[information]
            if rank == 'Super Admin': self.log('41-1', name) # success
            elif rank == 'Admin': self.log('41-0', name)

    elif code == 32: # Register user
        name = information[0] # info = [name, rank, pin, fingerprint]
        if name in self.googlesheet('users')[username]:
            self.incorrect.emit(1); self.log('40-2', name) # fail
        else:
            information.insert(2, 0) # account balance of zero at index 2 # data = [name, rank, accbal, pin, finger]
            self.googlesheet('users').writerow[information]
            self.log('41-2', name)

    elif code == 4: # Removing Super or Admin
        name, supername, auth, superlog = information # info = [name, supername, 'Fingerprint/Pin', superlog]
        # Super verification
        if auth == 'Fingerprint':
            if fingerprint not in self.googlesheet('admins').row[fingerprint]:
                self.log(['6','0','Unfound', 'Unfound', auth], name); self.incorrect.emit(1); return
            data = self.googlesheet('admins').row[fingerprint][superlog]
            supername = data[0]
        elif auth == 'Pin':
            if supername not in self.googlesheet('admins')[username]:
                self.log(['6','0','Unfound', f"{Unfound} {supername}", auth], name)
                self.incorrect.emit(1); return
            else:
                data = self.googlesheet('admins').row[username][supername]
                if superlog != data[2]:
                    self.log(['6','0','Unfound', f"{Unlogged} {supername}", auth], name)
                    self.incorrect.emit(1); return
        # Removee Verification                
        if name not in self.googlesheet('admins')[username]:
            self.incorrect.emit(1); self.log(['6','0','Unfound', supername, auth], name) # fail
        else: # data = [name, rank, pin, fingerprint]
            data = self.googlesheet('admins').row[username][name]
            self.googlesheet('admins').moverow[information].('deletedadmins')
            if data[1] == 'Super Admin': self.log(['6','1','Super Admin', supername, auth], name)
            elif data[1] == 'Admin': self.log(['6','1','Admin', supername, auth], name)
