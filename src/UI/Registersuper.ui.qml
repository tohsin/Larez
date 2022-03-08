import QtQuick 2.14
import QtQuick.Controls 6.2
import Qt.labs.platform 1.1

Item {
    id: window
    property var code: ""

    FocusScope {
        id: regwindow
        anchors.fill: parent

        Image {
            id: back_button
            anchors.left: parent.left
            anchors.leftMargin: 35
            anchors.top: parent.top
            anchors.topMargin: 87
            width: 30
            height: 30
            source: "../images/back.jpg"
            sourceSize.width: 100
            sourceSize.height: 100
            MouseArea {
                anchors.fill: parent
                onClicked: { page_loader.source = 'P2Form.ui.qml' ; revert() }
            }
        }

        Image {
            id: fingerprint
            y: 545
            width: 140
            height: 140
            visible: admin_box.checked | super_box.checked
            source: "../images/whitefinger.jpg"
            anchors.horizontalCenter: parent.horizontalCenter
            fillMode: Image.PreserveAspectFit
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    if (super_box.checked === true) {
                        code = "Super Admin"
                    } else { code = "Admin" }
                    backend.checksuper([regno_field.text, code])
                }
            }
        }

        Text {
            id: place_finger
            x: 297
            width: 262
            height: 50
            visible: fingerprint.visible
            text: qsTr("Place Finger on Scanner to Register Fingerprint")
            anchors.top: fingerprint.bottom
            font.pixelSize: 20
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignTop
            font.italic: true
            anchors.topMargin: 10
            anchors.horizontalCenter: fingerprint.horizontalCenter
        }

        Text {
            id: regno
            y: 245
            height: 41
            anchors.left: parent.left
            anchors.leftMargin: 60
            anchors.right: parent.right
            text: qsTr("Username")
            font.pixelSize: 20
            verticalAlignment: Text.AlignVCenter
            wrapMode: Text.NoWrap
            fontSizeMode: Text.Fit
            font.capitalization: Font.AllUppercase
            font.family: "Verdana"
            font.styleName: "Regular"

            Rectangle {
                id: regno_box
                height: 40
                color: "#ffffff"
                radius: 5
                border.width: 1
                anchors.left: parent.left
                anchors.top: parent.bottom
                anchors.right: parent.right
                anchors.rightMargin: 60
            }
            TextField {
                id: regno_field
                height: regno_box.height - 2
                anchors.verticalCenter: regno_box.verticalCenter
                anchors.left: regno_box.left
                anchors.right: regno_box.right
                anchors.rightMargin: 1
                anchors.leftMargin: 1
                baselineOffset: 15
                font.pointSize: 12
                topPadding: 7
                leftPadding: 9
                rightPadding: 35
                placeholderText: qsTr("Username")
            }
            Image {
                id: clearregno
                height: 14
                width: height
                anchors.verticalCenter: regno_box.verticalCenter
                anchors.right: regno_box.right
                anchors.rightMargin: 10
                source: "../images/closebutton.png"
                sourceSize.width: 20
                sourceSize.height: 20
                MouseArea {
                    id: clusr
                    anchors.fill: parent
                    onClicked: regno_field.text = ""
                }
            }
        }
        Text {
            id: pin
            x: 60
            y: 400
            width: 152
            height: 41
            text: qsTr("Pin")
            font.pixelSize: 20
            verticalAlignment: Text.AlignVCenter
            fontSizeMode: Text.Fit
            font.capitalization: Font.AllUppercase
            font.family: "Verdana"
            font.styleName: "Regular"

            Rectangle {
                id: password_box
                width: regno_box.width
                height: regno_box.height
                color: "#ffffff"
                radius: 5
                border.width: 1
                anchors.left: parent.left
                anchors.top: parent.bottom
                anchors.topMargin: 0
                anchors.leftMargin: 0
            }
            TextField {
                id: password
                echoMode: TextInput.Password
                height: regno_box.height - 2
                anchors.verticalCenter: password_box.verticalCenter
                anchors.left: password_box.left
                anchors.right: password_box.right
                anchors.rightMargin: 1
                anchors.leftMargin: 1
                baselineOffset: 15
                font.pointSize: 12
                topPadding: 7
                leftPadding: 9
                rightPadding: 35
                placeholderText: qsTr("Pin")
            }
            Image {
                id: clearpin
                height: 14
                width: height
                anchors.verticalCenter: password_box.verticalCenter
                anchors.right: password_box.right
                anchors.rightMargin: 10
                source: "../images/closebutton.png"
                sourceSize.width: 20
                sourceSize.height: 20
                MouseArea {
                    id: clpin
                    anchors.fill: parent
                    onClicked: password.text = ""
                }
            }
            MessageDialog {
                title: "Invalid Username"
                id: invalidDialog
                text: "Username is already taken"
                buttons: MessageDialog.Ok
            }
            MessageDialog {
                title: "Incorrect Details Entered"
                id: incorrectDialog
                text: "Invalid Verification Username or Password"
                buttons: MessageDialog.Ok
            }
            MessageDialog {
                title: "Registration Successful"
                id: successDialog
                text: "New (Super) Admin Has Been Registered Successfully"
                buttons: MessageDialog.Ok
                onOkClicked: { page_loader.source = "P2Form.ui.qml" ; revert() }
            }
            MessageDialog {
                title: "Details You Entered Are Incomplete"
                id: incompleteDialog
                text: "Fill the empty fields"
                buttons: MessageDialog.Ok
                onOkClicked: { super_box.checked = false ; admin_box.checked = false ; incompleteDialog.close()}
            }
            MessageDialog {
                title: "Admin Registration"
                id: confirmDialog
                text: "You Are About To Register " + regno_field.text
                buttons: MessageDialog.Ok | MessageDialog.Cancel
                onOkClicked: successDialog.open()
            }
        }

        FocusScope {
            id: row
            x: 60
            y: 500
            width: 260
            height: 40

            CheckBox {
                id: super_box
                width: 13
                height: 13
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.topMargin: 6
                anchors.leftMargin: 6
                scale: 2
                onCheckedChanged: {
                    if ( regno_field.text === "" | password.text === "" ) { incompleteDialog.open() }
                    if (super_box.checked === true & admin_box.checked === true) { admin_box.checked = false }
                }
            }

            Text {
                id: super_text
                height: 20
                text: qsTr("Super Admin")
                anchors.verticalCenter: super_box.verticalCenter
                anchors.left: super_box.right
                font.pixelSize: 15
                font.family: "Verdana"
                anchors.leftMargin: 15
                MouseArea {
                    anchors.fill: parent
                    onClicked: super_box.checked = !super_box.checked
                }
            }
            CheckBox {
                id: admin_box
                width: 13
                height: 13
                anchors.verticalCenter: super_box.verticalCenter
                anchors.left: super_text.right
                anchors.leftMargin: 30
                scale: 2
                onCheckedChanged: {
                    if ( regno_field.text === "" | password.text === "" ) { incompleteDialog.open() }
                    if (admin_box.checked === true & super_box.checked === true) { super_box.checked = false }
                }
            }

            Text {
                id: admin_text
                height: 20
                text: qsTr("Admin")
                anchors.verticalCenter: super_box.verticalCenter
                anchors.left: admin_box.right
                font.pixelSize: 15
                font.family: "Verdana"
                anchors.leftMargin: 15
                MouseArea {
                    anchors.fill: parent
                    onClicked: admin_box.checked = !admin_box.checked
                }
            }
        }
        Connections {
            target: backend

            function onInvalid(number) { if (number === 1) { invalidDialog.open() } }
            function onIncorrect(number) { if (number === 3) { incorrectDialog.open() } }
            function onProceed(value) {
                if (value == 1) { confirmDialog.open() }
                if (value == 2) { verwindow.visible = true }
            }
        }

        Text {
            id: modename
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.horizontalCenterOffset: -50
            width: 150
            height: 20
            text: qsTr("Admin Registration")
            font.pixelSize: 22
            anchors.top: parent.top
            anchors.topMargin: 87
            font.family: "Verdana"
            font.styleName: "Regular"
            font.bold: true
        }
    }

    Item {
        id: verwindow
        visible: false
        anchors.fill: parent
        Rectangle {
            radius: 8
            anchors.fill: parent
            color: "white"

            Image {
                id: logo
                width: 150
                height: 150
                anchors.top: parent.top
                source: "../images/culogo.jpg"
                anchors.topMargin: 40
                anchors.horizontalCenter: parent.horizontalCenter
                fillMode: Image.PreserveAspectFit
            }
            Image {
                id: back
                anchors.left: parent.left
                anchors.leftMargin: 35
                anchors.top: parent.top
                anchors.topMargin: 87
                width: 30
                height: 30
                source: "../images/back.jpg"
                sourceSize.width: 100
                sourceSize.height: 100
                MouseArea {
                    anchors.fill: parent
                    onClicked: { verwindow.visible = false ; username1.text = '' ; password1.text = '' }
                }
            }
            Rectangle {
                id: submit_button1
                visible: switch1.checked
                width: 114
                height: 40
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 120
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.horizontalCenterOffset: 100
                color: "black"
                radius: 8
                Text {
                    width: 150
                    height: 40
                    color: "white"
                    text: qsTr("Submit")
                    anchors.verticalCenter: parent.verticalCenter
                    font.pixelSize: 15
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font.bold: true
                    font.family: "Verdana"
                    anchors.horizontalCenter: parent.horizontalCenter
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        backend.registersuper([regno_field.text, code, password.text, password.text, username1.text, password1.text , "Pin"])
                    }
                }
            }
            Rectangle {
                id: use_pin_button1
                color: "#ffffff"
                radius: 8
                border.width: 3
                width: 114
                height: 40
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 120
                visible: !switch1.checked
                anchors.horizontalCenterOffset: 0
                anchors.horizontalCenter: parent.horizontalCenter
                Text {
                    width: 150
                    height: 40
                    text: qsTr("Use Pin")
                    anchors.verticalCenter: parent.verticalCenter
                    font.pixelSize: 15
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font.bold: true
                    font.family: "Verdana"
                    anchors.horizontalCenter: parent.horizontalCenter
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: switch1.checked = !switch1.checked
                }
            }
            Rectangle {
                id: use_fingerprint_button1
                color: "#ffffff"
                radius: 8
                border.width: 3
                width: 156
                height: 40
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 120
                visible: switch1.checked
                anchors.horizontalCenterOffset: -100
                anchors.horizontalCenter: parent.horizontalCenter
                Text {
                    width: 160
                    height: 40
                    text: qsTr("Use Fingerprint")
                    anchors.verticalCenter: parent.verticalCenter
                    font.pixelSize: 15
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font.bold: true
                    font.family: "Verdana"
                    anchors.horizontalCenter: parent.horizontalCenter
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: switch1.checked = !switch1.checked
                }
            }
            Switch {
                id: switch1
                checked: false
                visible: false
            }
        }
        Text {
            id: biometric1
            visible: !switch1.checked
            x: 60
            y: 245
            width: 152
            height: 41
            text: qsTr("Super Admin")
            font.pixelSize: 20
            verticalAlignment: Text.AlignVCenter
            wrapMode: Text.NoWrap
            fontSizeMode: Text.Fit
            font.capitalization: Font.AllUppercase
            font.family: "Verdana"
            font.styleName: "Regular"
        }
        Image {
            id: fingerprint1
            visible: !switch1.checked
            y: 360
            width: 150
            height: 150
            source: "../images/whitefinger.jpg"
            anchors.horizontalCenter: parent.horizontalCenter
            fillMode: Image.PreserveAspectFit
            MouseArea {
                anchors.fill: parent;
                onClicked: {
                    backend.registersuper([regno_field.text, code, password.text, password.text, '', '' , "Fingerprint"])
                }
            }
        }
        Text {
            id: place_finger1
            visible: !switch1.checked
            x: 297
            width: 262
            height: 50
            text: qsTr("Place Finger on Scanner")
            anchors.top: fingerprint1.bottom
            font.pixelSize: 20
            font.italic: true
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignTop
            anchors.topMargin: 10
            anchors.horizontalCenter: fingerprint1.horizontalCenter
        }

        Text {
            id: superadmin1
            visible: switch1.checked
            y: 245
            height: 41
            anchors.left: parent.left
            anchors.leftMargin: 60
            anchors.right: parent.right
            text: qsTr("Super Admin")
            font.pixelSize: 20
            verticalAlignment: Text.AlignVCenter
            fontSizeMode: Text.Fit
            font.capitalization: Font.AllUppercase
            font.family: "Verdana"
            font.styleName: "Regular"

            Rectangle {
                id: username_box1
                height: 40
                color: "#ffffff"
                radius: 5
                border.width: 1
                anchors.left: parent.left
                anchors.top: parent.bottom
                anchors.right: parent.right
                anchors.rightMargin: 60
            }

            TextField {
                id: username1
                width: username_box1.width
                height: username_box1.height - 2
                placeholderText: qsTr("Username")
                font.pixelSize: 16
                topPadding: 7
                leftPadding: 9
                rightPadding: 35
                anchors.verticalCenter: username_box1.verticalCenter
                anchors.left: username_box1.left
                anchors.right: username_box1.right
                anchors.rightMargin: 1
                anchors.leftMargin: 1
            }
            Image {
                id: clearusername1
                height: 14
                width: height
                anchors.verticalCenter: username_box1.verticalCenter
                anchors.right: username_box1.right
                anchors.rightMargin: 10
                source: "../images/closebutton.png"
                sourceSize.width: 20
                sourceSize.height: 20
                MouseArea {
                    anchors.fill: parent
                    onClicked: username1.text = ""
                }
            }
        }
        Text {
            id: pin1
            visible: switch1.checked
            x: 60
            y: 400
            width: 152
            height: 41
            text: qsTr("Pin")
            font.pixelSize: 20
            verticalAlignment: Text.AlignVCenter
            wrapMode: Text.NoWrap
            fontSizeMode: Text.Fit
            font.capitalization: Font.AllUppercase
            font.family: "Verdana"
            font.styleName: "Regular"

            Rectangle {
                id: password_box1
                width: username_box1.width
                height: username_box1.height
                color: "#ffffff"
                radius: 5
                border.width: 1
                anchors.left: parent.left
                anchors.top: parent.bottom
                anchors.topMargin: 0
                anchors.leftMargin: 0
            }
            TextField {
                id: password1
                echoMode: TextInput.Password
                width: username_box1.width
                height: username_box1.height - 2
                placeholderText: qsTr("Pin")
                font.pixelSize: 16
                topPadding: 7
                leftPadding: 9
                rightPadding: 35
                anchors.verticalCenter: password_box1.verticalCenter
                anchors.left: password_box1.left
                anchors.right: password_box1.right
                anchors.rightMargin: 1
                anchors.leftMargin: 1
            }
            Image {
                height: 14
                width: height
                anchors.verticalCenter: password_box1.verticalCenter
                anchors.right: password_box1.right
                anchors.rightMargin: 10
                source: "../images/closebutton.png"
                sourceSize.width: 20
                sourceSize.height: 20
                MouseArea {
                    anchors.fill: parent
                    onClicked: password1.text = ""
                }
            }
        }
        Text {
            id: modename1
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.horizontalCenterOffset: -80
            width: 150
            height: 20
            text: qsTr("Registration Verification")
            font.pixelSize: 21
            anchors.top: parent.top
            anchors.topMargin: 87
            font.family: "Verdana"
            font.styleName: "Regular"
            font.bold: true
        }
    }
    Component.onCompleted: {
        image.scale = 0.6
        image.anchors.horizontalCenterOffset = 180
        image.anchors.topMargin = 20

        logo.scale = 0.6
        logo.anchors.horizontalCenterOffset = 180
        logo.anchors.topMargin = 20
    }
    function revert() { image.scale = 1 ; image.anchors.horizontalCenterOffset = 0 }
}
