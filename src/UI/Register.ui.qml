import QtQuick 2.14
import QtQuick.Controls 6.2
import Qt.labs.platform 1.1

Item {
    id: window
    width: 600
    height: 700

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
    Button {
        id: back_button
        width: 65
        height: 35
        text: qsTr("<  BACK")
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.leftMargin: 32
        anchors.topMargin: 80
        onClicked: stack.pop()
    }

    Image {
        id: fingerprint
        y: 460
        width: 136
        height: 124
        visible: password_checkBox.checked & regno_checkBox.checked
        source: "whitefinger.jpg"
        anchors.horizontalCenter: parent.horizontalCenter
        fillMode: Image.PreserveAspectFit
        MouseArea {
            anchors.fill: parent
            onClicked: {
                stack.push('Success.ui.qml')
                backend.registeruser([regno_field.text, '0000', "Biometric ID - 001"])
                click.running = true
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
        anchors.topMargin: -10
        anchors.horizontalCenter: fingerprint.horizontalCenter
    }

    Text {
        id: regno
        x: 60
        y: 200
        width: 152
        height: 41
        text: qsTr("User Reg No:")
        font.pixelSize: 20
        verticalAlignment: Text.AlignVCenter
        wrapMode: Text.NoWrap
        fontSizeMode: Text.Fit
        font.capitalization: Font.AllUppercase
        font.family: "Verdana"
        font.styleName: "Regular"

        Rectangle {
            id: regno_box
            width: 430
            height: 40
            color: "#ffffff"
            radius: 5
            border.width: 1
            anchors.left: parent.left
            anchors.top: parent.bottom
            anchors.topMargin: 0
            anchors.leftMargin: 0
        }
        CheckBox {
            id: regno_checkBox
            x: 428
            y: 304
            width: 13
            height: 12
            scale: 2.4
            anchors.verticalCenter: regno_box.verticalCenter
            anchors.left: regno_box.right
            checked: false
            anchors.leftMargin: 15
        }

        Text {
            id: check_uncheck
            x: 336
            width: 127
            height: 25
            text: qsTr("Click To Check/Uncheck")
            anchors.right: regno_checkBox.right
            anchors.top: regno_box.bottom
            font.pixelSize: 13
            horizontalAlignment: Text.AlignRight
            anchors.topMargin: 10
            anchors.rightMargin: -7
        }

        TextField {
            id: regno_field
            height: 38
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
            height: 15
            width: height
            anchors.verticalCenter: regno_box.verticalCenter
            anchors.right: regno_box.right
            anchors.rightMargin: 10
            source: "cleartext.png"

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
        y: 360
        width: 152
        height: 41
        text: qsTr("Pin:")
        font.pixelSize: 20
        verticalAlignment: Text.AlignVCenter
        fontSizeMode: Text.Fit
        font.capitalization: Font.AllUppercase
        font.family: "Verdana"
        font.styleName: "Regular"

        Rectangle {
            id: password_box
            width: 427
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
            id: password
            echoMode: TextInput.Password
            height: 38
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
            source: "cleartext.png"

            MouseArea {
                id: clpin
                anchors.fill: parent
                onClicked: password.text = ""
            }
        }
        Text {
            id: p_check_uncheck
            x: 336
            width: 127
            height: 25
            text: qsTr("Click To Check/Uncheck")
            anchors.right: password_checkBox.right
            anchors.top: password_box.bottom
            font.pixelSize: 13
            horizontalAlignment: Text.AlignRight
            anchors.topMargin: 10
            anchors.rightMargin: -7
        }
        CheckBox {
            id: password_checkBox
            width: 13
            height: 12
            scale: 2.4
            anchors.verticalCenter: password_box.verticalCenter
            anchors.left: password.right
            checked: false
            anchors.leftMargin: 15
        }
        MessageDialog {
            title: "Invalid Username"
            id: invalidDialog
            text: "Reg No is either already in use or doesn't exist"
            buttons: MessageDialog.Ok
        }

        Connections {
            target: backend

            function onInvalid(number) {
                if (number === 1) {
                    invalidDialog.open()
                    regno_checkBox.checked = false
                }
            }
        }
    }
}
