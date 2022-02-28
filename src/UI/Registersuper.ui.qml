import QtQuick 2.14
import QtQuick.Controls 6.2
import Qt.labs.platform 1.1

Item {
    id: window
    property var code: ""
    FocusScope {
        id: white_rectangle
        anchors.fill: parent
    }
    Text {
        id: back_button
        anchors.left: parent.left
        anchors.leftMargin: 35
        anchors.top: parent.top
        anchors.topMargin: 87
        text: qsTr("<  Back")
        width: 80
        height: 40
        font.pixelSize: 18
        font.bold: true
        MouseArea {
            anchors.fill: parent
            onClicked: page_loader.source = 'P2Form.ui.qml'
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
                    code = 1
                } else { code = 0 }
                backend.registersuper([regno_field.text, '0000', "Biometric ID - 001", code])
                confirmDialog.open()
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
        x: 60
        y: 245
        width: 152
        height: 41
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
            width: 470
            height: 40
            color: "#ffffff"
            radius: 5
            border.width: 1
            anchors.left: parent.left
            anchors.top: parent.bottom
            anchors.topMargin: 0
            anchors.leftMargin: 0
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
            height: 15
            width: height
            anchors.verticalCenter: regno_box.verticalCenter
            anchors.right: regno_box.right
            anchors.rightMargin: 10
            source: "../images/cleartext.png"

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
            height: 15
            width: height
            anchors.verticalCenter: password_box.verticalCenter
            anchors.right: password_box.right
            anchors.rightMargin: 10
            source: "../images/cleartext.png"

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
            title: "Registration Successful"
            id: successDialog
            text: "New (Super) Admin Has Been Registered Successfully"
            buttons: MessageDialog.Ok
            onOkClicked: page_loader.source = "P2Form.ui.qml"
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

        function onInvalid(number) { if (number === 1) { invalidDialog.open() ; regno_checkBox.checked = false } }
    }

    Text {
        id: modename
        x: parent.width - 235
        width: 150
        height: 20
        text: qsTr("Admin Registration")
        font.pixelSize: 18
        anchors.top: parent.top
        anchors.topMargin: 87
        font.family: "Verdana"
        font.styleName: "Regular"
        font.italic: true
        font.bold: true
    }
}
