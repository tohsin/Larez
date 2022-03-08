import QtQuick 2.14
import QtQuick.Controls 6.2
import Qt.labs.platform 1.1

Item {
    id: window

    FocusScope {
        id: white_rectangle
        anchors.fill: parent
    }

    Image {
        id: back_button
        anchors.left: parent.left
        anchors.leftMargin: 35
        anchors.top: parent.top
        anchors.topMargin: 80
        width: 30
        height: 30
        source: "../images/back.jpg"
        sourceSize.width: 100
        sourceSize.height: 100
        MouseArea {
            anchors.fill: parent
            onClicked: { stack.pop() ; revert() }
        }
    }

    Image {
        id: fingerprint
        y: 500
        width: 140
        height: 140
        visible: false
        source: "../images/whitefinger.jpg"
        anchors.horizontalCenter: parent.horizontalCenter
        fillMode: Image.PreserveAspectFit
        MouseArea {
            anchors.fill: parent
            onClicked: backend.checkuser(regno_field.text)
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
        text: qsTr("User Reg No")
        font.pixelSize: 20
        verticalAlignment: Text.AlignVCenter
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
            placeholderText: qsTr("Reg No. / Username")
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
        Text {
            id: enterfingerprint
            x: 336
            width: 140
            height: 40
            text: qsTr("Enter Fingerprint  >")
            anchors.right: password_box.right
            anchors.top: password_box.bottom
            font.pixelSize: 16
            font.bold: true
            horizontalAlignment: Text.AlignRight
            anchors.topMargin: 13
            MouseArea {
                anchors.fill: parent
                onClicked: { fingerprint.visible = true ; goback.visible = true ; enterfingerprint.visible = false }
            }
        }
        Text {
            id: goback
            visible: false
            x: 336
            width: 140
            height: 40
            text: qsTr("<  Go Back")
            anchors.right: password_box.right
            anchors.top: password_box.bottom
            font.pixelSize: 16
            font.bold: true
            horizontalAlignment: Text.AlignRight
            anchors.topMargin: 13
            MouseArea {
                anchors.fill: parent
                onClicked: { fingerprint.visible = false ; goback.visible = false ; enterfingerprint.visible = true }
            }
        }
        MessageDialog {
            title: "Invalid Username"
            id: invalidDialog
            text: "Reg No is either already in use or doesn't exist"
            buttons: MessageDialog.Ok
        }
        MessageDialog {
            title: "User Registration"
            id: confirmDialog
            text: "You Are About To Register " + regno_field.text
            buttons: MessageDialog.Ok | MessageDialog.Cancel
            onOkClicked: { backend.registeruser([regno_field.text, password.text, password.text]) ; successDialog.open() }
        }
        MessageDialog {
            title: "Registration Successful"
            id: successDialog
            text: "New User Has Been Registered Successfully"
            buttons: MessageDialog.Ok
            onOkClicked: { stack.replace('P3Form.ui.qml') ; revert() }
        }
    }
    Connections {
        target: backend

        function onInvalid(number) { if (number === 1) { invalidDialog.open() } }
        function onProceed(value) { if (value == 1) { confirmDialog.open() } }
    }

    Text {
        id: modename
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.horizontalCenterOffset: -40
        width: 150
        height: 20
        text: qsTr("Registration Page")
        font.pixelSize: 22
        anchors.top: parent.top
        anchors.topMargin: 80
        font.family: "Verdana"
        font.styleName: "Regular"
        font.bold: true
    }
    Component.onCompleted: {
        image.scale = 0.6
        image.anchors.horizontalCenterOffset = 180
        image.anchors.topMargin = 20
    }
    function revert() { image.scale = 1 ; image.anchors.horizontalCenterOffset = 0 }
}
