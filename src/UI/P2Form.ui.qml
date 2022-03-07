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
        /*Button {
            id: use_pin_button
            visible: !switch1.checked
            y: 522
            width: 114
            height: 40
            text: qsTr("Use Pin")
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 120
            anchors.horizontalCenterOffset: 0
            font.pointSize: 12
            font.family: "Verdana"
            anchors.horizontalCenter: parent.horizontalCenter
            onClicked: switch1.checked = !switch1.checked
        }*/

        Rectangle {
            id: log_in_button
            visible: use_fingerprint_button.visible
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
                    backend.adminuser([username.text, password.text , "Pin"]);
                }
            }
        }
        /*Button {
            id: log_in_button
            visible: use_fingerprint_button.visible
            y: 506
            width: 114
            height: 40
            text: qsTr("Log In")
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 120
            enabled: true
            font.pointSize: 12
            font.family: "Verdana"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.horizontalCenterOffset: 100
            onClicked: {
                page_loader.source = 'Loadingpage.ui.qml';
                backend.adminuser([username.text, password.text , "Pin"]);
            }
        }*/

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
        /*Button {
            id: use_fingerprint_button
            visible: switch1.checked
            y: 522
            width: 156
            height: 40
            text: qsTr("Use Fingerprint")
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 120
            anchors.horizontalCenterOffset: -100
            font.pointSize: 12
            font.family: "Verdana"
            anchors.horizontalCenter: parent.horizontalCenter
            onClicked: switch1.checked = !switch1.checked
        }*/

        Switch {
            id: switch1
            checked: false
            visible: false
        }
    }
    Text {
        id: biometric
        visible: use_pin_button.visible
        x: 60
        y: 245
        width: 152
        height: 41
        text: qsTr("Admin")
        font.pixelSize: 20
        verticalAlignment: Text.AlignVCenter
        wrapMode: Text.NoWrap
        fontSizeMode: Text.Fit
        font.capitalization: Font.AllUppercase
        font.family: "Verdana"
        font.styleName: "Regular"
    }
    MessageDialog {
        title: "Going Back Will Logout the Super Admin"
        id: logoutDialog
        text: "Do You Want to Continue"
        buttons: MessageDialog.Yes | MessageDialog.No
        onYesClicked: { page_loader.source = 'P1Form.ui.qml'; backend.superadminlogout(0) }
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
            onClicked: logoutDialog.open()
        }
    }
    Rectangle {
        id: dotdot
        border.width: 3
        radius: width/2
        width: 32
        height: width
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.rightMargin: 50
        anchors.topMargin: 82
        MouseArea {
            anchors.fill: parent
            onClicked: menu.open()
        }
        Menu {
            id: menu
            MenuItem {
                text: qsTr("New Admin") ;
                onTriggered: page_loader.source = "Registersuper.ui.qml"
            }
            MenuItem {
                text: qsTr("Remove Admin")
                onTriggered: page_loader.source = "Removesuper.ui.qml"
            }
        }
    }
    Image {
        anchors.verticalCenter: dotdot.verticalCenter
        anchors.horizontalCenter: dotdot.horizontalCenter
        width: 25
        height: width
        source: "../images/menucircle.png"
        sourceSize.width: 100
        sourceSize.height: 100
    }
    Image {
        id: fingerprint
        visible: use_pin_button.visible
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
                backend.adminuser(['12', '0012', "Fingerprint"]);
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
        font.pixelSize: 20
        font.italic: true
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignTop
        anchors.topMargin: 10
        anchors.horizontalCenter: fingerprint.horizontalCenter
    }

    Text {
        id: admin
        visible: use_fingerprint_button.visible
        /*x: 60
        width: 152*/
        y: 245
        height: 41
        anchors.left: parent.left
        anchors.leftMargin: 60
        anchors.right: parent.right
        text: qsTr("Admin")
        font.pixelSize: 20
        verticalAlignment: Text.AlignVCenter
        fontSizeMode: Text.Fit
        font.capitalization: Font.AllUppercase
        font.family: "Verdana"
        font.styleName: "Regular"

        Rectangle {
            id: username_box
            /*width: 480*/
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
            height: username_box.height - 2
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
        x: 60
        y: 400
        width: 152
        height: 41
        visible: use_fingerprint_button.visible
        text: qsTr("Pin")
        font.pixelSize: 20
        verticalAlignment: Text.AlignVCenter
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
        }

        TextField {
            id: password
            echoMode: TextInput.Password
            height: username_box.height - 2
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
