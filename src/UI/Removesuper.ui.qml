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
    Switch {
        id: switch1
        checked: false
        visible: false
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
    Button {
        id: use_pin_button
        visible: fingerprint.visible
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
    }

    Button {
        id: submit_button
        visible: use_fingerprint_button.visible
        y: 506
        width: 114
        height: 40
        text: qsTr("Submit")
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 120
        enabled: true
        font.pointSize: 12
        font.family: "Verdana"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.horizontalCenterOffset: 100
        onClicked: {
            if ( regno_field.text === "" | ver_field.text === "" | password.text === "" ) { incompleteDialog.open() }
            else {
                backend.removesuper([regno_field.text, 'Admin', "1", "Pin"]);
                confirmDialog.open()
            }
        }
    }
    Button {
        id: use_fingerprint_button
        visible: ver.visible
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
    }

    Image {
        id: fingerprint
        y: 380
        width: 160
        height: 160
        visible: regno_checkBox.checked & !switch1.checked
        source: "../images/whitefinger.jpg"
        anchors.horizontalCenter: parent.horizontalCenter
        fillMode: Image.PreserveAspectFit
        MouseArea {
            anchors.fill: parent
            onClicked: {
                if ( regno_field.text === "" | ver_field.text === "" | password.text === "" ) { incompleteDialog.open() }
                else {
                    backend.removesuper([regno_field.text, 'Admin', "Biometric ID - C1", "Biometric"])
                    confirmDialog.open()
                }
            }
        }
    }

    Text {
        id: place_finger
        x: 297
        width: 262
        height: 50
        visible: fingerprint.visible
        text: qsTr("Place Finger on Scanner")
        anchors.top: fingerprint.bottom
        font.pixelSize: 20
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignTop
        font.italic: true
        anchors.topMargin: 10
        anchors.horizontalCenter: fingerprint.horizontalCenter
    }

    Text {
        id: removee
        x: 60
        y: 170
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
        id: verify
        visible: regno_checkBox.checked
        x: 60
        y: 300
        width: 180
        height: 41
        text: qsTr("Verify Removal")
        font.pixelSize: 20
        verticalAlignment: Text.AlignVCenter
        fontSizeMode: Text.Fit
        font.capitalization: Font.AllUppercase
        font.family: "Verdana"
        font.styleName: "Regular"
        font.bold: true
        font.italic: true
    }
    Text {
        id: ver
        visible: regno_checkBox.checked & switch1.checked
        x: 60
        y: 350
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
            id: ver_box
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
            id: ver_field
            height: ver_box.height - 2
            anchors.verticalCenter: ver_box.verticalCenter
            anchors.left: ver_box.left
            anchors.right: ver_box.right
            anchors.rightMargin: 1
            anchors.leftMargin: 1
            baselineOffset: 15
            font.pointSize: 12
            topPadding: 7
            leftPadding: 9
            rightPadding: 35
            placeholderText: qsTr("Super Admin Username")
        }
        Image {
            id: clearver
            height: 15
            width: height
            anchors.verticalCenter: ver_box.verticalCenter
            anchors.right: ver_box.right
            anchors.rightMargin: 10
            source: "../images/cleartext.png"

            MouseArea {
                id: clver
                anchors.fill: parent
                onClicked: ver_field.text = ""
            }
        }
    }
    Text {
        id: pin
        visible: regno_checkBox.checked & switch1.checked
        x: 60
        y: 480
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
            width: ver_box.width
            height: ver_box.height
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
            height: ver_box.height - 2
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
            title: "Removal Successful"
            id: successDialog
            text: "New (Super) Admin Has Been Removed Successfully"
            buttons: MessageDialog.Ok
            onOkClicked: page_loader.source = "P2Form.ui.qml"
        }
        MessageDialog {
            title: "Admin Removal"
            id: confirmDialog
            text: "You are about to remove (Super) Admin " + regno_field.text
            buttons: MessageDialog.Ok | MessageDialog.Cancel
            onOkClicked: successDialog.open()
        }
        MessageDialog {
            title: "Details You Entered Are Incomplete"
            id: incompleteDialog
            text: "Fill the empty fields"
            buttons: MessageDialog.Ok
            onOkClicked: { incompleteDialog.close()}
        }
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

    Text {
        id: modename
        x: parent.width - 225
        width: 150
        height: 20
        text: qsTr("Admin Removal")
        font.pixelSize: 18
        anchors.top: parent.top
        anchors.topMargin: 87
        font.family: "Verdana"
        font.styleName: "Regular"
        font.italic: true
        font.bold: true
    }
}
