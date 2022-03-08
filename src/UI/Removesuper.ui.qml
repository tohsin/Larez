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
    Rectangle {
        id: use_pin_button
        color: "#ffffff"
        radius: 8
        border.width: 3
        width: 114
        height: 40
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 120
        visible: fingerprint.visible
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
        id: submit_button
        color: "black"
        visible: use_fingerprint_button.visible
        radius: 8
        width: 114
        height: 40
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 120
        anchors.horizontalCenterOffset: 100
        anchors.horizontalCenter: parent.horizontalCenter
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
                if ( regno_field.text === "" | ver_field.text === "" | password.text === "" ) { incompleteDialog.open() }
                else {
                    backend.removesuper([regno_field.text, ver_field.text, "Pin", password.text]);
                }
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
        visible: ver.visible
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
                    backend.removesuper([regno_field.text, ver_field.text, "Fingerprint", "Bio - C1"])
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
        y: 170
        height: 41
        anchors.left: parent.left
        anchors.leftMargin: 60
        anchors.right: parent.right
        text: qsTr("Username")
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
            anchors.right: regno_checkBox.left
            anchors.rightMargin: 15
        }
        CheckBox {
            id: regno_checkBox
            width: 13
            height: 12
            scale: 2.4
            anchors.verticalCenter: regno_box.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: 60
            checked: false
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
            readOnly: regno_checkBox.checked
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
        y: 350
        height: 41
        anchors.left: parent.left
        anchors.leftMargin: 60
        anchors.right: parent.right
        text: qsTr("Username")
        font.pixelSize: 20
        verticalAlignment: Text.AlignVCenter
        fontSizeMode: Text.Fit
        font.capitalization: Font.AllUppercase
        font.family: "Verdana"
        font.styleName: "Regular"

        Rectangle {
            id: ver_box
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
            height: 14
            width: height
            anchors.verticalCenter: ver_box.verticalCenter
            anchors.right: ver_box.right
            anchors.rightMargin: 10
            source: "../images/closebutton.png"
            sourceSize.width: 20
            sourceSize.height: 20
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
            text: "Username Doesn't Exist"
            buttons: MessageDialog.Ok
        }
        MessageDialog {
            title: "Removal Successful"
            id: successDialog
            text: "New (Super) Admin Has Been Removed Successfully"
            buttons: MessageDialog.Ok
            onOkClicked: { page_loader.source = "P2Form.ui.qml" ; revert() }
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
            onOkClicked: { incompleteDialog.close() }
        }
        MessageDialog {
            title: "Incorrect Details Entered"
            id: incorrectDialog
            text: "Invalid Verification Username or Password"
            buttons: MessageDialog.Ok
        }
    }
    Connections {
        target: backend

        function onInvalid(number) {
            if (number === 1) { invalidDialog.open() ; regno_checkBox.checked = false }
        }
        function onIncorrect(number) { if (number === 3) { incorrectDialog.open() } }
        function onProceed(value) { if (value == 1) { confirmDialog.open() } }
    }

    Text {
        id: modename
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.horizontalCenterOffset: -40
        width: 150
        height: 20
        text: qsTr("Admin Removal")
        font.pixelSize: 22
        anchors.top: parent.top
        anchors.topMargin: 87
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
