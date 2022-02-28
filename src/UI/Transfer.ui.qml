import QtQuick 2.14
import QtQuick.Controls 6.2
import Qt.labs.platform 1.1

Item {
    id: window

    Rectangle {
        id: time ; width: 10 ; height: 10 ; visible: false
    }
    property var aNum: ""
    SequentialAnimation {
        id: click
        PropertyAnimation {
            target: time;
            property: "width";
            duration: 2000;
            to: 100;
        }
        ScriptAction { script: { stack.replace('P3Form.ui.qml') ; backend.transactiondone(1) } }
    }
    MessageDialog {
        title: "Making Transfer"
        id: transferDialog
        text: "You Are About To Make A Transfer of " + amount_field.text + " Amount to " + username_field.text
        informativeText: "Do You Want To Continue?"
        buttons: MessageDialog.Yes | MessageDialog.No
        onYesClicked: { stack.push('Success.ui.qml'); click.running = true }

    }
    MessageDialog {
        title: "Making Transfer"
        id: transferDialogBio
        text: "You Are About To Make A Transfer of " + amount_field.text + " Amount to Biometric-ID A2"
        informativeText: "Do You Want To Continue?"
        buttons: MessageDialog.Yes | MessageDialog.No
        onYesClicked: { stack.push('Success.ui.qml'); click.running = true }
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
    MessageDialog {
        title: "Invalid Amount"
        id: insufDialog
        text: "Amount You Entered Supercedes Your Available Balance"
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
            text: qsTr("Switch")
            checked: false
            visible: false
        }
    }

    Image {
        anchors.left: parent.left
        anchors.leftMargin: 40
        anchors.top: parent.top
        anchors.topMargin: 80
        source: '../images/menubutton.png'
        height: 25
        width: height + 5
        id: menubar
        MouseArea {
            anchors.fill: parent
            onClicked: menu.open()
        }
        MessageDialog {
            title: "Logout User"
            id: userlogoutDialog
            text: "You Are About To Logout"
            informativeText: "Do You Want To Continue?"
            buttons: MessageDialog.Yes | MessageDialog.No
            onYesClicked: { backend.userlogout() ; stack.pop() ; stack.pop() }
        }
        Menu {
            id: menu
            MenuItem {
                text: qsTr("Logout User") ;
                onTriggered: userlogoutDialog.open()
            }
            MenuItem {
                text: qsTr("Switch to Purchase Mode")
                onTriggered: { backend.feature("Purchase") ; stack.replace("Purchase.ui.qml") ; backend.switchfeature() }
            }
            MenuItem {
                text: qsTr("Switch to Register Mode")
                onTriggered: { backend.feature("Register") ; stack.pop() ; stack.replace("Register.ui.qml") ; backend.switchfeature() }
            }
        }
    }

    Image {
        id: fingerprint
        y: 360
        width: 150
        height: 150
        visible: use_username_button.visible
        source: "../images/whitefinger.jpg"
        anchors.horizontalCenter: parent.horizontalCenter
        fillMode: Image.PreserveAspectFit
        MouseArea {
            anchors.fill: parent;
            onClicked: {
                if (amount_field.text < 50.0) { warnDialog.open() ; amount_checkBox.checked = false }
                if (amount_field.text > aNum) { insufDialog.open() ; amount_checkBox.checked = false }
                else { transferDialogBio.open() ; backend.transferfeature([amount_field.text, "'Biometrics ID - 00'", "Fingerprint"]) }
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
        font.pixelSize: 20
        font.italic: true
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignTop
        anchors.topMargin: 10
        anchors.horizontalCenter: fingerprint.horizontalCenter
    }

    Text {
        id: amount
        x: 60
        y: 245
        width: 152
        height: 41
        text: qsTr("Amount")
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
            onClicked: {
                if (amount_checkBox.checked == true){
                    if (amount_field.text < 50.0) { warnDialog.open() ; amount_checkBox.checked = false }
                    if (amount_field.text > aNum) { insufDialog.open() ; amount_checkBox.checked = false }
                }
            }
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
            rightPadding: 35
            placeholderText: qsTr("Amount")
        }
        Image {
            id:clearamount
            height: 14
            width: height
            anchors.verticalCenter: amount_box.verticalCenter
            anchors.right: amount_box.right
            anchors.rightMargin: 10
            source: "../images/closebutton.png"
            sourceSize.width: 20
            sourceSize.height: 20
            MouseArea {
                id:clamt
                anchors.fill: parent
                onClicked: amount_field.text = ""
            }
        }
    }
    Text {
        id: username
        x: 60
        y: 400
        width: 152
        height: 41
        visible: use_fingerprint_button.visible
        text: qsTr("Recepient")
        font.pixelSize: 20
        verticalAlignment: Text.AlignVCenter
        fontSizeMode: Text.Fit
        font.capitalization: Font.AllUppercase
        font.family: "Verdana"
        font.styleName: "Regular"

        Rectangle {
            id: username_box
            width: 470
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
            rightPadding: 35
            placeholderText: qsTr("Account No. / Reg No.")
        }
        Text {
            id: proceed
            x: 336
            width: 140
            height: 40
            text: qsTr("Proceed  >")
            anchors.right: username_box.right
            anchors.top: username_box.bottom
            font.pixelSize: 16
            font.bold: true
            horizontalAlignment: Text.AlignRight
            anchors.topMargin: 13
            anchors.rightMargin: -5
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    if (username_field.text === '') { warnDialog2.open() }
                    else { transferDialog.open() ; backend.transferfeature([amount_field.text, username_field.text, "typed"]) }
                }
            }
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
                onClicked: username_field.text = ""
            }
        }
    }
    Connections {
        target: backend

        function onLoggeduser(customer){ loggeduser.text = "Hi, " + customer }
        function onFeaturemode(activity){ modename.text = activity + " Window" }
        function onAccbalance(cash){ acbal.text = "Available: " + cash ; aNum = cash }
    }
    Text {
        id: modename
        x: parent.width - 210
        width: 150
        height: 20
        text: qsTr(" Window")
        font.pixelSize: 18
        anchors.top: parent.top
        anchors.topMargin: 125
        font.family: "Verdana"
        font.styleName: "Regular"
        font.italic: true
        font.bold: true

        Text {
            id: loggeduser
            width: 150
            height: 20
            text: qsTr("Hi, ")
            font.pixelSize: 16
            anchors.top: parent.bottom
            anchors.right: parent.right
            font.family: "Verdana"
            font.styleName: "Regular"
            font.italic: true
        }
        Text {
            id: acbal
            width: 150
            height: 20
            text: qsTr("Available ")
            font.pixelSize: 16
            anchors.top: loggeduser.bottom
            anchors.right: parent.right
            font.family: "Verdana"
            font.styleName: "Regular"
            font.italic: true
        }
    }
}
