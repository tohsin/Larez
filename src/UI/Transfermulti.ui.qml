import QtQuick 2.14
import QtQuick.Controls 6.2
import Qt.labs.platform 1.1

Item {
    id: window
    /*width: (9 / 16) * height
    height: 800
    visible: true*/

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
        onYesClicked: { stack.push('Success.ui.qml'); click.running = true ; revert() }

    }
    MessageDialog {
        title: "Making Transfer"
        id: transferDialogBio
        text: "You Are About To Make A Transfer of " + amount_field.text + " Amount to Bio-ID A2"
        informativeText: "Do You Want To Continue?"
        buttons: MessageDialog.Yes | MessageDialog.No
        onYesClicked: { stack.push('Success.ui.qml'); click.running = true ; revert() }
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
        text: "Amount You Entered Exceeds Your Available Balance"
        buttons: MessageDialog.Ok
    }
    MessageDialog {
        title: "Logout User"
        id: userlogoutDialog
        text: "You Are About To Logout"
        informativeText: "Do You Want To Continue?"
        buttons: MessageDialog.Yes | MessageDialog.No
        onYesClicked: { backend.userlogout() ; stack.pop() ; stack.pop(); revert() }
    }
    MessageDialog {
        title: "Logout User"
        id: userlogoutDialog1
        text: "Switching to Registration Will Log You Out Of Your Current Session"
        informativeText: "Do You Want To Continue?"
        buttons: MessageDialog.Yes | MessageDialog.No
        onYesClicked: { backend.userlogout() ; backend.feature("Register") ; stack.pop() ; stack.replace("Register.ui.qml") ; backend.switchfeature() }
    }
    FocusScope {
        id: white_rectangle
        anchors.fill: parent

        Switch {
            id: switch1
            checked: false
            visible: false
        }
        Switch {
            id: switch2
            checked: false
            visible: false
        }
        Switch {
            id: switch3
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
        width: height + 2
        id: menubar
        MouseArea {
            anchors.fill: parent
            onClicked: menu.open()
        }
        Menu {
            id: menu
            MenuItem {
                text: qsTr("Logout User") ;
                onTriggered: userlogoutDialog.open()
            }
            MenuSeparator {}
            MenuItem {
                text: qsTr("Switch to Purchase Mode")
                onTriggered: { backend.feature("Purchase") ; stack.replace("Purchase.ui.qml") ; backend.switchfeature() }
            }
            MenuItem {
                text: qsTr("Switch to Registration Mode")
                onTriggered: userlogoutDialog1.open()
            }
        }
    }
    ScrollView {
        id: scrollView
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: userbox.bottom
        anchors.topMargin: 15
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 180
        /*ScrollBar.vertical.interactive: true*/
        contentHeight: 300
        clip: true

        width: 200
        height: 200
        Image {
            id: fingerprint
            anchors.top: amount.bottom
            anchors.topMargin: 90
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
                    else { transferDialogBio.open() ; backend.transferfeature([amount_field.text, "'Bio ID - 00'", "Fingerprint"]) }
                }
            }
            Text {
                id: place_finger
                width: 262
                height: 50
                visible: use_username_button.visible
                text: qsTr("Place Finger on Scanner")
                anchors.top: fingerprint.bottom
                font.pixelSize: 20
                font.italic: true
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignTop
                anchors.horizontalCenter: fingerprint.horizontalCenter
            }
        }
        Rectangle {
            id: use_username_button
            color: "#ffffff"
            radius: 8
            border.width: 3
            width: 150
            height: 40
            anchors.top: fingerprint.bottom
            anchors.topMargin: 60
            visible: !switch1.checked & amount_checkBox.checked
            anchors.horizontalCenterOffset: 0
            anchors.horizontalCenter: parent.horizontalCenter
            Text {
                width: 160
                height: 40
                text: qsTr("Type Number")
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
            anchors.top: fingerprint.bottom
            anchors.topMargin: use_username_button.anchors.topMargin
            visible: switch1.checked & amount_checkBox.checked
            anchors.horizontalCenterOffset: 0
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

        Text {
            id: amount
            anchors.top: parent.top
            height: 41
            anchors.left: parent.left
            anchors.leftMargin: 60
            anchors.right: parent.right
            text: qsTr("Amount")
            font.pixelSize: 20
            verticalAlignment: Text.AlignVCenter
            fontSizeMode: Text.Fit
            font.capitalization: Font.AllUppercase
            font.family: "Verdana"
            font.styleName: "Regular"

            Rectangle {
                id: amount_box
                height: 40
                color: "#ffffff"
                radius: 5
                border.width: 1
                anchors.left: parent.left
                anchors.top: parent.bottom
                anchors.right: amount_checkBox.left
                anchors.rightMargin: 15
            }
            CheckBox {
                id: amount_checkBox
                y: 304
                width: 13
                height: 12
                scale: 2.4
                anchors.verticalCenter: amount_box.verticalCenter
                anchors.right: parent.right
                anchors.rightMargin: 60
                checked: false
                /*onClicked: {
                    if (amount_checkBox.checked == true){ checkamount(amount_field.text) }
                }*/
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
                height: amount_box.height - 2
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
                readOnly: amount_checkBox.checked
                validator: IntValidator {bottom: 1; top: 100000}
                inputMethodHints: Qt.ImhDigitsOnly
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
            visible: use_fingerprint_button.visible
            anchors.top: amount.bottom
            anchors.topMargin: 160
            height: 41
            anchors.left: parent.left
            anchors.leftMargin: 60
            anchors.right: parent.right
            text: qsTr("Recipient")
            font.pixelSize: 20
            verticalAlignment: Text.AlignVCenter
            fontSizeMode: Text.Fit
            font.capitalization: Font.AllUppercase
            font.family: "Verdana"
            font.styleName: "Regular"

            Rectangle {
                id: username_box
                visible: use_fingerprint_button.visible
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
                id: username_field
                height: username_box.height - 2
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
                        else { transferDialog.open() ; backend.transferfeature([amount_field.text, username_field.text, "Typed"]) }
                        checkamount(amount_field.text)
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
        Text {
            id: multiple
            visible: !multi_switch.checked
            anchors.left: parent.left
            anchors.leftMargin: 60
            anchors.top: amount.bottom
            anchors.topMargin: 65
            text: qsTr("Multiple Transfers  >")
            font.pixelSize: 14
            verticalAlignment: Text.AlignVCenter
            font.bold: true
            font.family: "Verdana"
            height: 30
            width: 180
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    /*submit_button.anchors.bottomMargin = 60*/
                    scrollView.anchors.bottomMargin = 60
                    scrollView.contentHeight = 1300
                    multi_switch.checked = !multi_switch.checked
                }
            }
        }
        Text {
            id: goback
            visible: multi_switch.checked
            anchors.left: parent.left
            anchors.leftMargin: 60
            anchors.top: amount.bottom
            anchors.topMargin: 65
            text: qsTr("<  Single Transfer")
            font.pixelSize: 14
            verticalAlignment: Text.AlignVCenter
            font.bold: true
            font.family: "Verdana"
            height: 30
            width: 180
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    /*submit_button.anchors.bottomMargin = 120*/
                    scrollView.anchors.bottomMargin = 180
                    scrollView.contentHeight = 300
                    multi_switch.checked = !multi_switch.checked
                }
            }
        }
        Switch {
            id: multi_switch
            visible: false
            checked: false
        }
        Image {
            id: fingerprint2
            anchors.top: amount2.bottom
            anchors.topMargin: 90
            width: 150
            height: 150
            visible: use_username_button2.visible
            source: "../images/whitefinger.jpg"
            anchors.horizontalCenter: parent.horizontalCenter
            fillMode: Image.PreserveAspectFit
            MouseArea {
                anchors.fill: parent;
                onClicked: {
                    if (amount_field2.text < 50.0) { warnDialog.open() ; amount_checkBox2.checked = false }
                    if (amount_field2.text > aNum) { insufDialog.open() ; amount_checkBox2.checked = false }
                    else { transferDialogBio.open() ; backend.transferfeature([amount_field2.text, "'Bio ID - 00'", "Fingerprint"]) }
                }
            }
            Text {
                id: place_finger2
                width: 262
                height: 50
                visible: use_username_button2.visible
                text: qsTr("Place Finger on Scanner")
                anchors.top: fingerprint2.bottom
                font.pixelSize: 20
                font.italic: true
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignTop
                anchors.horizontalCenter: fingerprint2.horizontalCenter
            }
        }
        Rectangle {
            id: use_username_button2
            color: "#ffffff"
            radius: 8
            border.width: 3
            width: 150
            height: 40
            anchors.top: fingerprint2.bottom
            anchors.topMargin: use_username_button.anchors.topMargin
            visible: !switch2.checked & amount_checkBox2.checked
            anchors.horizontalCenterOffset: 0
            anchors.horizontalCenter: parent.horizontalCenter
            Text {
                width: 160
                height: 40
                text: qsTr("Type Number")
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
                onClicked: switch2.checked = !switch2.checked
            }
        }
        Rectangle {
            id: use_fingerprint_button2
            color: "#ffffff"
            radius: 8
            border.width: 3
            width: 156
            height: 40
            anchors.top: fingerprint2.bottom
            anchors.topMargin: use_username_button.anchors.topMargin
            visible: switch2.checked & amount_checkBox2.checked
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
                onClicked: switch2.checked = !switch2.checked
            }
        }

        Text {
            id: amount2
            visible: multi_switch.checked
            anchors.top: username.bottom
            anchors.topMargin: 180
            height: 41
            anchors.left: parent.left
            anchors.leftMargin: 60
            anchors.right: parent.right
            text: qsTr("Amount 2")
            font.pixelSize: 20
            verticalAlignment: Text.AlignVCenter
            fontSizeMode: Text.Fit
            font.capitalization: Font.AllUppercase
            font.family: "Verdana"
            font.styleName: "Regular"

            Rectangle {
                id: amount_box2
                height: 40
                color: "#ffffff"
                radius: 5
                border.width: 1
                anchors.left: parent.left
                anchors.top: parent.bottom
                anchors.right: amount_checkBox2.left
                anchors.rightMargin: 15
            }
            CheckBox {
                id: amount_checkBox2
                width: 13
                height: 12
                scale: 2.4
                anchors.verticalCenter: amount_box2.verticalCenter
                anchors.right: parent.right
                anchors.rightMargin: 60
                checked: false
                /*onClicked: {
                    if (amount_checkBox.checked == true){ checkamount(amount_field.text) }
                }*/
            }

            Text {
                id: check_uncheck2
                x: 336
                width: 127
                height: 25
                text: qsTr("Click To Check/Uncheck")
                anchors.right: amount_checkBox2.right
                anchors.top: amount_box2.bottom
                font.pixelSize: 13
                horizontalAlignment: Text.AlignRight
                anchors.topMargin: 10
                anchors.rightMargin: -7
            }

            TextField {
                id: amount_field2
                height: amount_box.height - 2
                anchors.verticalCenter: amount_box2.verticalCenter
                anchors.left: amount_box2.left
                anchors.right: amount_box2.right
                anchors.rightMargin: 1
                anchors.leftMargin: 1
                baselineOffset: 15
                font.pointSize: 12
                topPadding: 7
                leftPadding: 9
                rightPadding: 35
                placeholderText: qsTr("Amount 2")
                readOnly: amount_checkBox2.checked
                validator: IntValidator {bottom: 1; top: 100000}
                inputMethodHints: Qt.ImhDigitsOnly
            }
            Image {
                id:clearamount2
                height: 14
                width: height
                anchors.verticalCenter: amount_box2.verticalCenter
                anchors.right: amount_box2.right
                anchors.rightMargin: 10
                source: "../images/closebutton.png"
                sourceSize.width: 20
                sourceSize.height: 20
                MouseArea {
                    id:clamt2
                    anchors.fill: parent
                    onClicked: amount_field.text = ""
                }
            }
        }
        Text {
            id: username2
            visible: use_fingerprint_button2.visible
            anchors.top: amount2.bottom
            anchors.topMargin: 160
            height: 41
            anchors.left: parent.left
            anchors.leftMargin: 60
            anchors.right: parent.right
            text: qsTr("Recipient 2")
            font.pixelSize: 20
            verticalAlignment: Text.AlignVCenter
            fontSizeMode: Text.Fit
            font.capitalization: Font.AllUppercase
            font.family: "Verdana"
            font.styleName: "Regular"

            Rectangle {
                id: username_box2
                visible: use_fingerprint_button2.visible
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
                id: username_field2
                height: username_box.height - 2
                visible: use_fingerprint_button2.visible
                anchors.verticalCenter: username_box2.verticalCenter
                anchors.left: username_box2.left
                anchors.right: username_box2.right
                anchors.rightMargin: 1
                anchors.leftMargin: 1
                baselineOffset: 15
                font.pointSize: 12
                topPadding: 7
                leftPadding: 9
                rightPadding: 35
                placeholderText: qsTr("Account No. / Reg No. 2")
            }
            Text {
                id: proceed2
                x: 336
                width: 140
                height: 40
                text: qsTr("Proceed  >")
                anchors.right: username_box2.right
                anchors.top: username_box2.bottom
                font.pixelSize: 16
                font.bold: true
                horizontalAlignment: Text.AlignRight
                anchors.topMargin: 13
                anchors.rightMargin: -5
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        if (username_field.text === '') { warnDialog2.open() }
                        else { transferDialog.open() ; backend.transferfeature([amount_field.text, username_field.text, "Typed"]) }
                        checkamount(amount_field.text)
                    }
                }
            }
            Image {
                id:clearusername2
                height: 14
                width: height
                anchors.verticalCenter: username_box2.verticalCenter
                anchors.right: username_box2.right
                anchors.rightMargin: 10
                source: "../images/closebutton.png"
                sourceSize.width: 20
                sourceSize.height: 20
                MouseArea {
                    id:clusr2
                    anchors.fill: parent
                    onClicked: username_field2.text = ""
                }
            }
        }

        Image {
            id: fingerprint3
            anchors.top: amount3.bottom
            anchors.topMargin: 90
            width: 150
            height: 150
            visible: use_username_button3.visible
            source: "../images/whitefinger.jpg"
            anchors.horizontalCenter: parent.horizontalCenter
            fillMode: Image.PreserveAspectFit
            MouseArea {
                anchors.fill: parent;
                onClicked: {
                    if (amount_field3.text < 50.0) { warnDialog.open() ; amount_checkBox3.checked = false }
                    if (amount_field3.text > aNum) { insufDialog.open() ; amount_checkBox3.checked = false }
                    else { transferDialogBio.open() ; backend.transferfeature([amount_field3.text, "'Bio ID - 00'", "Fingerprint"]) }
                }
            }
            Text {
                id: place_finger3
                width: 262
                height: 50
                visible: use_username_button3.visible
                text: qsTr("Place Finger on Scanner")
                anchors.top: fingerprint3.bottom
                font.pixelSize: 20
                font.italic: true
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignTop
                anchors.horizontalCenter: fingerprint3.horizontalCenter
            }
        }
        Rectangle {
            id: use_username_button3
            color: "#ffffff"
            radius: 8
            border.width: 3
            width: 150
            height: 40
            anchors.top: fingerprint3.bottom
            anchors.topMargin: use_username_button.anchors.topMargin
            visible: !switch3.checked & amount_checkBox3.checked
            anchors.horizontalCenterOffset: 0
            anchors.horizontalCenter: parent.horizontalCenter
            Text {
                width: 160
                height: 40
                text: qsTr("Type Number")
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
                onClicked: switch3.checked = !switch3.checked
            }
        }
        Rectangle {
            id: use_fingerprint_button3
            color: "#ffffff"
            radius: 8
            border.width: 3
            width: 156
            height: 40
            anchors.top: fingerprint3.bottom
            anchors.topMargin: use_username_button.anchors.topMargin
            visible: switch3.checked & amount_checkBox3.checked
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
                onClicked: switch3.checked = !switch3.checked
            }
        }

        Text {
            id: amount3
            visible: multi_switch.checked
            anchors.top: username2.bottom
            anchors.topMargin: 180
            height: 41
            anchors.left: parent.left
            anchors.leftMargin: 60
            anchors.right: parent.right
            text: qsTr("Amount 3")
            font.pixelSize: 20
            verticalAlignment: Text.AlignVCenter
            fontSizeMode: Text.Fit
            font.capitalization: Font.AllUppercase
            font.family: "Verdana"
            font.styleName: "Regular"

            Rectangle {
                id: amount_box3
                height: 40
                color: "#ffffff"
                radius: 5
                border.width: 1
                anchors.left: parent.left
                anchors.top: parent.bottom
                anchors.right: amount_checkBox3.left
                anchors.rightMargin: 15
            }
            CheckBox {
                id: amount_checkBox3
                width: 13
                height: 12
                scale: 2.4
                anchors.verticalCenter: amount_box3.verticalCenter
                anchors.right: parent.right
                anchors.rightMargin: 60
                checked: false
                /*onClicked: {
                    if (amount_checkBox.checked == true){ checkamount(amount_field.text) }
                }*/
            }

            Text {
                id: check_uncheck3
                x: 336
                width: 127
                height: 25
                text: qsTr("Click To Check/Uncheck")
                anchors.right: amount_checkBox3.right
                anchors.top: amount_box3.bottom
                font.pixelSize: 13
                horizontalAlignment: Text.AlignRight
                anchors.topMargin: 10
                anchors.rightMargin: -7
            }

            TextField {
                id: amount_field3
                height: amount_box.height - 2
                anchors.verticalCenter: amount_box3.verticalCenter
                anchors.left: amount_box3.left
                anchors.right: amount_box3.right
                anchors.rightMargin: 1
                anchors.leftMargin: 1
                baselineOffset: 15
                font.pointSize: 12
                topPadding: 7
                leftPadding: 9
                rightPadding: 35
                placeholderText: qsTr("Amount 3")
                readOnly: amount_checkBox3.checked
                validator: IntValidator {bottom: 1; top: 100000}
                inputMethodHints: Qt.ImhDigitsOnly
            }
            Image {
                id:clearamount3
                height: 14
                width: height
                anchors.verticalCenter: amount_box3.verticalCenter
                anchors.right: amount_box3.right
                anchors.rightMargin: 10
                source: "../images/closebutton.png"
                sourceSize.width: 20
                sourceSize.height: 20
                MouseArea {
                    id:clamt3
                    anchors.fill: parent
                    onClicked: amount_field.text = ""
                }
            }
        }
        Text {
            id: username3
            visible: use_fingerprint_button3.visible
            anchors.top: amount3.bottom
            anchors.topMargin: 160
            height: 41
            anchors.left: parent.left
            anchors.leftMargin: 60
            anchors.right: parent.right
            text: qsTr("Recipient 3")
            font.pixelSize: 20
            verticalAlignment: Text.AlignVCenter
            fontSizeMode: Text.Fit
            font.capitalization: Font.AllUppercase
            font.family: "Verdana"
            font.styleName: "Regular"

            Rectangle {
                id: username_box3
                visible: use_fingerprint_button3.visible
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
                id: username_field3
                height: username_box.height - 2
                visible: use_fingerprint_button3.visible
                anchors.verticalCenter: username_box3.verticalCenter
                anchors.left: username_box3.left
                anchors.right: username_box3.right
                anchors.rightMargin: 1
                anchors.leftMargin: 1
                baselineOffset: 15
                font.pointSize: 12
                topPadding: 7
                leftPadding: 9
                rightPadding: 35
                placeholderText: qsTr("Account No. / Reg No. 3")
            }
            Text {
                id: proceed3
                x: 336
                width: 140
                height: 40
                text: qsTr("Proceed  >")
                anchors.right: username_box3.right
                anchors.top: username_box3.bottom
                font.pixelSize: 16
                font.bold: true
                horizontalAlignment: Text.AlignRight
                anchors.topMargin: 13
                anchors.rightMargin: -5
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        if (username_field.text === '') { warnDialog2.open() }
                        else { transferDialog.open() ; backend.transferfeature([amount_field.text, username_field.text, "Typed"]) }
                        checkamount(amount_field.text)
                    }
                }
            }
            Image {
                id:clearusername3
                height: 14
                width: height
                anchors.verticalCenter: username_box3.verticalCenter
                anchors.right: username_box3.right
                anchors.rightMargin: 10
                source: "../images/closebutton.png"
                sourceSize.width: 20
                sourceSize.height: 20
                MouseArea {
                    id:clusr3
                    anchors.fill: parent
                    onClicked: username_field3.text = ""
                }
            }
        }
    }
    Connections {
        target: backend

        function onLoggeduser(customer){ loggeduser.text = "<i>Hi</i>, <b>" + customer + "</b>" }
        function onFeaturemode(activity){ modename.text = activity + " Window" }
        function onAccbalance(cash){ acbal.text = "<i>Available:</i> <b>" + cash + "</b>" ; aNum = cash }
        function onIncorrect(number) { if (number === 2) { warnDialog2.open() ; transferDialog.close() ; transferDialogBio.close() } }
    }
    Text {
        id: modename
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.horizontalCenterOffset: -40
        width: 150
        height: 20
        text: qsTr(" Window")
        font.pixelSize: 22
        anchors.top: parent.top
        anchors.topMargin: 80
        font.family: "Verdana"
        font.styleName: "Regular"
        font.bold: true
    }
    Rectangle {
        id: userbox
        radius: 3
        /*color: "transparent"
        color: "#e1e1e0"*/
        color: "black"
        width: 120
        height: 30
        anchors.top: parent.top
        anchors.topMargin: 170
        /*anchors.left: amount.left*/
        anchors.left: parent.left
        anchors.leftMargin: 60
        Text {
            id: userinfo
            color: "white"
            width: 100
            height: 20
            text: qsTr("USER INFO")
            font.pixelSize: 16
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 10
            /*anchors.horizontalCenter: parent.horizontalCenter*/
            font.family: "Verdana"
            font.styleName: "Regular"
            font.bold: true
        }
        Text {
            id: loggeduser
            width: 100
            height: 20
            text: qsTr("Hi, ")
            font.pixelSize: 16
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: userinfo.right
            anchors.leftMargin: 20
            font.family: "Verdana"
            font.styleName: "Regular"
        }
        Text {
            id: acbal
            width: 150
            height: 20
            text: qsTr("Available ")
            font.pixelSize: 16
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: loggeduser.right
            anchors.leftMargin: -20
            font.family: "Verdana"
            font.styleName: "Regular"
        }
    }
    Component.onCompleted: {
        image.scale = 0.6
        image.anchors.horizontalCenterOffset = 180
        image.anchors.topMargin = 20
    }
    function revert() { image.scale = 1 ; image.anchors.horizontalCenterOffset = 0 }
    function checkamount(amount) {
        if (amount < 50.0) { warnDialog.open() ; amount_checkBox.checked = false ; transferDialog.close() ; transferDialogBio.close() }
        if (amount > aNum) { insufDialog.open() ; amount_checkBox.checked = false ; transferDialog.close() ; transferDialogBio.close() }
    }
}
