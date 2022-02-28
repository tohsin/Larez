import QtQuick 2.14
import QtQuick.Controls 6.2
import Qt.labs.platform 1.1

Item {
    id: window

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
                    stack.push('Loadfeature.ui.qml');
                    backend.studentuser([username.text, password.text, "Pin"]);
                }
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
        id: biometrics
        visible: !switch1.checked
        x: 60
        y: 245
        width: 152
        height: 41
        text: qsTr("Customer")
        font.pixelSize: 20
        verticalAlignment: Text.AlignVCenter
        wrapMode: Text.NoWrap
        fontSizeMode: Text.Fit
        font.capitalization: Font.AllUppercase
        font.family: "Verdana"
        font.styleName: "Regular"
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
        y: 360
        width: 150
        height: 150
        visible: use_pin_button.visible
        source: "../images/whitefinger.jpg"
        anchors.horizontalCenter: parent.horizontalCenter
        fillMode: Image.PreserveAspectFit
        MouseArea {
            anchors.fill: parent;
            onClicked: {
                stack.push('Loadfeature.ui.qml')
                backend.studentuser(['3', '0000', "Fingerprint"]);
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
        id: customer
        visible: switch1.checked
        x: 60
        y: 245
        width: 152
        height: 41
        text: qsTr("Customer")
        font.pixelSize: 20
        verticalAlignment: Text.AlignVCenter
        wrapMode: Text.NoWrap
        fontSizeMode: Text.Fit
        font.capitalization: Font.AllUppercase
        font.family: "Verdana"
        font.styleName: "Regular"

        Rectangle {
            id: username_box
            width: 480
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
            placeholderText: qsTr("Reg No. / Username")
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
        visible: use_fingerprint_button.visible
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
            width: username_box.width
            height: username_box.height
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
            height: username_box.height - 2
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
