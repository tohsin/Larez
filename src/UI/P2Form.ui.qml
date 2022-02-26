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

        Button {
            id: use_pin_button
            y: 522
            width: 114
            height: 40
            text: qsTr("Use Pin")
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 120
            visible: !switch1.checked & username_checkBox.checked
            anchors.horizontalCenterOffset: 0
            font.pointSize: 12
            font.family: "Verdana"
            anchors.horizontalCenter: parent.horizontalCenter
            onClicked: switch1.checked = !switch1.checked
        }
        Button {
            id: use_fingerprint_button
            y: 522
            width: 156
            height: 40
            text: qsTr("Use Fingerprint")
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 120
            visible: switch1.checked & username_checkBox.checked
            anchors.horizontalCenterOffset: 0
            font.pointSize: 12
            font.family: "Verdana"
            anchors.horizontalCenter: parent.horizontalCenter
            onClicked: switch1.checked = !switch1.checked
        }

        Switch {
            id: switch1
            x: 254
            y: 194
            text: qsTr("Switch")
            checked: false
            visible: false
        }
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
        onClicked: page_loader.source = 'P1Form.ui.qml'
    }

    Image {
        id: fingerprint
        y: 360
        width: 136
        height: 124
        visible: use_pin_button.visible
        source: "../images/whitefinger.jpg"
        anchors.horizontalCenter: parent.horizontalCenter
        fillMode: Image.PreserveAspectFit
        MouseArea {
            anchors.fill: parent;
            onClicked: {
                page_loader.source = "Loadingpage.ui.qml";
                backend.adminuser([username.text, '0000', "fingerprint"]);
            }
        }
    }

    Text {
        id: place_finger
        x: 297
        width: 262
        height: 50
        visible: use_pin_button.visible
        text: qsTr("Place Finger on Scanner")
        anchors.top: fingerprint.bottom
        font.pixelSize: 18
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignTop
        anchors.topMargin: -10
        anchors.horizontalCenter: fingerprint.horizontalCenter
    }

    Text {
        id: admin
        x: 60
        y: 245
        width: 152
        height: 41
        text: qsTr("Admin:")
        font.pixelSize: 20
        verticalAlignment: Text.AlignVCenter
        wrapMode: Text.NoWrap
        fontSizeMode: Text.Fit
        font.capitalization: Font.AllUppercase
        font.family: "Verdana"
        font.styleName: "Regular"

        Rectangle {
            id: username_box
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
            id: username_checkBox
            x: 428
            y: 304
            width: 13
            height: 12
            scale: 2.4
            anchors.verticalCenter: username_box.verticalCenter
            anchors.left: username_box.right
            checked: false
            anchors.leftMargin: 15
        }

        Text {
            id: check_uncheck
            x: 336
            width: 127
            height: 25
            text: qsTr("Click To Check/Uncheck")
            anchors.right: username_checkBox.right
            anchors.top: username_box.bottom
            font.pixelSize: 13
            horizontalAlignment: Text.AlignRight
            anchors.topMargin: 10
            anchors.rightMargin: -7
        }

        TextField {
            id: username
            height: 38
            anchors.verticalCenter: username_box.verticalCenter
            anchors.left: username_box.left
            anchors.right: username_box.right
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
            id:clearusername
            height: 15
            width: height
            anchors.verticalCenter: username_box.verticalCenter
            anchors.right: username_box.right
            anchors.rightMargin: 10
            source: "../images/cleartext.png"

            MouseArea {
                id:clusr
                anchors.fill: parent
                onClicked: username.text = ""
            }
        }
    }
    Text {
        id: pin
        x: 60
        y: 400
        width: 152
        height: 41
        visible: use_fingerprint_button.visible
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
            visible: use_fingerprint_button.visible
        }

        TextField {
            id: password
            echoMode: TextInput.Password
            height: 38
            visible: use_fingerprint_button.visible
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
            onClicked: {
                if (password_checkBox.checked == true) {
                    page_loader.source = "Loadingpage.ui.qml";
                    backend.adminuser([username.text, password.text, "Pin"]);
                }
            }
        }
        Image {
            id:clearpin
            height: 15
            width: height
            anchors.verticalCenter: password_box.verticalCenter
            anchors.right: password_box.right
            anchors.rightMargin: 10
            source: "../images/cleartext.png"

            MouseArea {
                id:clpin
                anchors.fill: parent
                onClicked: password.text = ""
            }
        }
        MessageDialog {
            title: "Incorrect Details Entered"
            id: incorrectDialog
            text: "Invalid Username or Password"
            buttons: MessageDialog.Ok
        }

        Connections {
            target: backend

            function onIncorrect(number) {
                if (number === 1) { incorrectDialog.open() }
            }
        }
    }
}
