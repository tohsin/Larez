import QtQuick 2.14
import QtQuick.Controls 6.2
import Qt.labs.platform 1.1

Item {
    id: window
    width: 600
    height: 700
    Rectangle {
        id: time ; width: 10 ; height: 10 ; visible: false
    }

    SequentialAnimation {
        id: click
        PropertyAnimation {
            target: time;
            property: "width";
            duration: 2000;
            to: 100;
        }
        ScriptAction { script: { stack.replace('P3Form.ui.qml') ; backend.log(3) } }
    }
    MessageDialog {
        title: "Making Transfer"
        id: transferDialog
        text: "You Are About To Make A Transfer of " + amount_field.text + " Naira to " + username_field.text
        informativeText: "Do You Want To Continue?"
        buttons: MessageDialog.Yes | MessageDialog.No | MessageDialog.Cancel
        onYesClicked: { stack.push('Success.ui.qml'); click.running = true }
        onCancelClicked: { stack.pop() ; stack.pop() }
    }
    MessageDialog {
        title: "Invalid Amount"
        id: warnDialog
        text: "You Cannot Make Transfer With less than 50 Naira"
        buttons: MessageDialog.Ok
    }
    MessageDialog {
        title: "Invalid Recipient"
        id: warnDialog2
        text: "Recipient Either Doesn't exist or You Left The Column Empty"
        buttons: MessageDialog.Ok
    }
    FocusScope {
        id: white_rectangle
        anchors.fill: parent

        Button {
            id: use_username_button
            y: 522
            width: 150
            height: 40
            text: qsTr("Type Number")
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 120
            visible: !switch1.checked & amount_checkBox.checked
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
            visible: switch1.checked & amount_checkBox.checked
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
        onClicked: stack.pop()
    }

    Image {
        id: fingerprint
        y: 360
        width: 136
        height: 124
        visible: use_username_button.visible
        source: "whitefinger.jpg"
        anchors.horizontalCenter: parent.horizontalCenter
        fillMode: Image.PreserveAspectFit
        MouseArea {
            anchors.fill: parent;
            onClicked: {
                if (amount_field.text < 50.0) { warnDialog.open() ; amount_checkBox.checked = false}
                else { transferDialog.open() ; backend.transferfeature([amount_field.text, "'Biometrics ID - 00'", "fingerprint"]) }
            }
        }
    }

    Text {
        id: place_finger
        x: 297
        width: 262
        height: 50
        visible: use_username_button.visible
        text: qsTr("Place Finger on Scanner")
        anchors.top: fingerprint.bottom
        font.pixelSize: 18
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignTop
        anchors.topMargin: -10
        anchors.horizontalCenter: fingerprint.horizontalCenter
    }

    Text {
        id: amount
        x: 60
        y: 245
        width: 152
        height: 41
        text: qsTr("Amount:")
        font.pixelSize: 20
        verticalAlignment: Text.AlignVCenter
        wrapMode: Text.NoWrap
        fontSizeMode: Text.Fit
        font.capitalization: Font.AllUppercase
        font.family: "Verdana"
        font.styleName: "Regular"

        Rectangle {
            id: amount_box
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
            id: amount_checkBox
            x: 428
            y: 304
            width: 13
            height: 12
            scale: 2.4
            anchors.verticalCenter: amount_box.verticalCenter
            anchors.left: amount_box.right
            checked: false
            anchors.leftMargin: 15
        }

        Text {
            id: check_uncheck
            x: 336
            width: 127
            height: 25
            text: qsTr("Click To Check/Uncheck")
            anchors.right: amount_checkBox.right
            anchors.top: amount_box.bottom
            font.pixelSize: 13
            horizontalAlignment: Text.AlignRight
            anchors.topMargin: 10
            anchors.rightMargin: -7
        }

        TextField {
            id: amount_field
            height: 38
            anchors.verticalCenter: amount_box.verticalCenter
            anchors.left: amount_box.left
            anchors.right: amount_box.right
            anchors.rightMargin: 1
            anchors.leftMargin: 1
            baselineOffset: 15
            font.pointSize: 12
            topPadding: 7
            leftPadding: 9
            placeholderText: qsTr("Amount")
        }
    }
    Text {
        id: username
        x: 60
        y: 400
        width: 152
        height: 41
        visible: use_fingerprint_button.visible
        text: qsTr("Recepient:")
        font.pixelSize: 20
        verticalAlignment: Text.AlignVCenter
        fontSizeMode: Text.Fit
        font.capitalization: Font.AllUppercase
        font.family: "Verdana"
        font.styleName: "Regular"

        Rectangle {
            id: username_box
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
            id: username_field
            height: 38
            visible: use_fingerprint_button.visible
            anchors.verticalCenter: username_box.verticalCenter
            anchors.left: username_box.left
            anchors.right: username_box.right
            anchors.rightMargin: 1
            anchors.leftMargin: 1
            baselineOffset: 15
            font.pointSize: 12
            topPadding: 7
            leftPadding: 9
            placeholderText: qsTr("Account No. / Mat No.")
        }
        Text {
            id: p_check_uncheck
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
        CheckBox {
            id: username_checkBox
            width: 13
            height: 12
            scale: 2.4
            anchors.verticalCenter: username_box.verticalCenter
            anchors.left: username_field.right
            checked: false
            anchors.leftMargin: 15
            onClicked: {
                if (username_checkBox.checked == true){
                    if (amount_field.text < 50.0) { warnDialog.open() ; amount_checkBox.checked = false}
                    if (username_field.text === '') { warnDialog2.open()  ; username_checkBox.checked = false}
                    else { transferDialog.open() ; backend.transferfeature([amount_field.text, username_field.text, "typed"]) }
                }
            }
        }
    }
    Connections {
        target: backend

        function onLoggeduser(customer){ loggeduser.text = "Hi, " + customer }
    }
    Text {
        id: loggeduser
        x: 390
        width: 150
        height: 40
        text: "Hi, "
        font.pixelSize: 20
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        anchors.top: back_button.bottom
        anchors.topMargin: 30
        font.family: "Verdana"
        font.styleName: "Regular"
        font.italic: true
    }
}