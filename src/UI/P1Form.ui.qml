import QtQuick 2.14
import QtQuick.Controls 6.2
import Qt.labs.platform 1.1

Item {
    id: window
    anchors.fill: parent
    FocusScope {
        id: white_rectangle
        anchors.fill: parent

        Rectangle {
            id: log_in_button
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
                text: qsTr("Log In")
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
                    page_loader.source = 'Loadingpage.ui.qml';
                    backend.superuser([username.text, password.text , "Pin"]);
                }
            }
        }
        Rectangle {
            id: use_pin_button
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
            id: use_fingerprint_button
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
        id: biometric
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
        id: fingerprint
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
                page_loader.source = "Loadingpage.ui.qml";
                backend.superuser(['11', '0011', "Fingerprint"]);
            }
        }
    }
    Text {
        id: place_finger
        visible: !switch1.checked
        x: 297
        width: 262
        height: 50
        text: qsTr("Place Finger on Scanner")
        anchors.top: fingerprint.bottom
        font.pixelSize: 20
        font.italic: true
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignTop
        anchors.topMargin: 10
        anchors.horizontalCenter: fingerprint.horizontalCenter
    }

    Text {
        id: superadmin
        visible: switch1.checked
        y: 245
        anchors.left: parent.left
        anchors.leftMargin: 60
        anchors.right: parent.right
        height: 41
        text: qsTr("Super Admin")
        font.pixelSize: 20
        verticalAlignment: Text.AlignVCenter
        fontSizeMode: Text.Fit
        font.capitalization: Font.AllUppercase
        font.family: "Verdana"
        font.styleName: "Regular"

        Rectangle {
            id: username_box
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
            id: username
            width: username_box.width
            height: username_box.height - 2
            placeholderText: qsTr("Username")
            font.pixelSize: 16
            topPadding: 7
            leftPadding: 9
            rightPadding: 35
            anchors.verticalCenter: username_box.verticalCenter
            anchors.left: username_box.left
            anchors.right: username_box.right
            anchors.rightMargin: 1
            anchors.leftMargin: 1
        }
        Image {
            id:clearusername
            height: 14
            width: height
            anchors.verticalCenter: username_box.verticalCenter
            anchors.right: username_box.right
            anchors.rightMargin: 10
            source: "../images/closebutton.png"
            sourceSize.width: 20
            sourceSize.height: 20
            MouseArea {
                id:clusr
                anchors.fill: parent
                onClicked: username.text = ""
            }
        }
    }
    Text {
        id: pin
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
            id: password_box
            width: username_box.width
            height: username_box.height
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
            width: username_box.width
            height: username_box.height - 2
            placeholderText: qsTr("Pin")
            font.pixelSize: 16
            topPadding: 7
            leftPadding: 9
            rightPadding: 35
            anchors.verticalCenter: password_box.verticalCenter
            anchors.left: password_box.left
            anchors.right: password_box.right
            anchors.rightMargin: 1
            anchors.leftMargin: 1
        }
        Image {
            id:clearpin
            height: 14
            width: height
            anchors.verticalCenter: password_box.verticalCenter
            anchors.right: password_box.right
            anchors.rightMargin: 10
            source: "../images/closebutton.png"
            sourceSize.width: 20
            sourceSize.height: 20
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

/*##^##
Designer {
    D{i:0;autoSize:true;height:700;width:600}D{i:2}D{i:1}D{i:3}D{i:5}D{i:6}D{i:4}D{i:8}
D{i:9}D{i:7}
}
##^##*/

/*
TOC

*/
