import QtQuick 2.14
import QtQuick.Controls 6.2
import Qt.labs.platform 1.1

Item {
    id: window

    FocusScope {
        id: white_rectangle
        anchors.fill: parent
    }
    Rectangle {
        id: time ; width: 10 ; height: 10 ; visible: false
    }
    SequentialAnimation {
        id: click
        PropertyAnimation {
            target: time
            property: "width"
            duration: 2000
            to: 100
        }
        ScriptAction { script: stack.replace('P3Form.ui.qml') }
    }
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
            onClicked: stack.pop()
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
            onClicked: confirmDialog.open()
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
        text: qsTr("User Reg No")
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
            onOkClicked: {
                stack.push('Success.ui.qml')
                backend.registeruser([regno_field.text, '0000', "Biometric ID - 001"])
                click.running = true
            }
        }
    }
    Connections {
        target: backend

        function onInvalid(number) { if (number === 1) { invalidDialog.open() ; regno_checkBox.checked = false } }
        function onFeaturemode(activity){ modename.text = activity + " Page" }
    }

    Text {
        id: modename
        x: parent.width - 225
        width: 150
        height: 20
        text: qsTr(" Page")
        font.pixelSize: 18
        anchors.top: parent.top
        anchors.topMargin: 87
        font.family: "Verdana"
        font.styleName: "Regular"
        font.italic: true
        font.bold: true
    }
}
