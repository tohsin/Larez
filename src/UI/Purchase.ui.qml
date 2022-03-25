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
        ScriptAction { script: { backend.purchasefeature(enter_amount.text); stack.replace('P3Form.ui.qml') ; backend.transactiondone(0) } }
    }

    FocusScope {
        id: white_rectangle
        anchors.fill: parent

        Rectangle {
            id: submit_button
            color: "black"
            radius: 8
            width: 115
            height: 40
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 120
            anchors.horizontalCenterOffset: 0
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
                    if (enter_amount.text < 50 | enter_amount.text > aNum) {
                        if (enter_amount.text < 50.0) { warnDialog.open() }
                        if (enter_amount.text > aNum) { insufDialog.open() }
                    } else { purchaseDialog.open() }
                }
            }
        }
    }
    MessageDialog {
        title: "Making Purchase"
        id: purchaseDialog
        text: "You Are About To Make A Purchase with " + enter_amount.text + " Naira"
        informativeText: "Do You Want To Continue?"
        buttons: MessageDialog.Yes | MessageDialog.No
        onYesClicked: { stack.push('Success.ui.qml'); click.running = true ; revert() }
    }
    MessageDialog {
        title: "Invalid Amount"
        id: warnDialog
        text: "You Cannot Make Purchase With less than 50 Naira"
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
        onYesClicked: { backend.userlogout() ; stack.pop() ; stack.pop() ; revert() }
    }
    MessageDialog {
        title: "Logout User"
        id: userlogoutDialog1
        text: "Switching to Registration Will Log You Out Of Your Current Session"
        informativeText: "Do You Want To Continue?"
        buttons: MessageDialog.Yes | MessageDialog.No
        onYesClicked: { backend.userlogout() ; backend.feature("Register") ; stack.pop() ; stack.replace("Register.ui.qml") ; backend.switchfeature() }
    }

    Image {
        id: menubar
        anchors.left: parent.left
        anchors.leftMargin: 40
        anchors.top: parent.top
        anchors.topMargin: 80
        source: '../images/menubutton.png'
        height: 25
        width: height + 2
        MouseArea {
            id: menuarea
            anchors.fill: parent
            onClicked: { background.visible = true ; menu.scale = 1 ; menuarea.visible = false }
        }

        /*Menu {
            id: menu
            MenuItem {
                text: qsTr("Logout User") ;
                onTriggered: userlogoutDialog.open()
            }
            MenuSeparator { }
            MenuItem {
                text: qsTr("Switch to Transfer Mode")
                onTriggered: { backend.feature("Transfer") ; stack.replace("Transfer.ui.qml") ; backend.switchfeature() }
            }
            MenuItem {
                text: qsTr("Switch to Registration Mode")
                onTriggered: userlogoutDialog1.open()
            }
        }*/
    }

    Text {
        id: amount
        y: 245
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
            anchors.right: parent.right
            anchors.rightMargin: 60
        }

        TextField {
            id: enter_amount
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
            placeholderText: qsTr("Enter Amount")
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
                onClicked: enter_amount.text = ""
            }
        }
    }

    Connections {
        target: backend

        function onLoggeduser(customer){ loggeduser.text = "<b>" + customer + "</b>" }
        function onFeaturemode(activity){ modename.text = activity + " Window" }
        function onAccbalance(cash){ acbal.text = "<b>" + cash + "</b>" ; aNum = cash }
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
        id: profilebox
        radius: height / 2
        /*color: "transparent"*/
        color: "#e1e1e0"
        /*color: "black"*/
        width: 160
        height: 40
        anchors.top: parent.top
        anchors.topMargin: 170
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.horizontalCenterOffset: -100
        Image {
            id: profile
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 20
            source: '../images/profile.png'
            height: 25
            width: height
            sourceSize.width: 100
            sourceSize.height: 100
        }
        Text {
            id: loggeduser
            width: 100
            height: 20
            text: "Hi, "
            font.pixelSize: 16
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: profile.right
            anchors.leftMargin: 10
            font.family: "Verdana"
            font.styleName: "Regular"
        }
    }
    Rectangle {
        id: creditbox
        radius: height / 2
        color: "transparent"
        /*color: "#e1e1e0"*/
        /*color: "black"*/
        width: 160
        height: 40
        anchors.top: parent.top
        anchors.topMargin: 170
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.horizontalCenterOffset: -(profilebox.anchors.horizontalCenterOffset)
        Image {
            id: credit
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 20
            source: '../images/credit.png'
            height: 35
            width: height
            sourceSize.width: 100
            sourceSize.height: 100
        }
        Text {
            id: acbal
            width: 150
            height: 20
            text: "Available "
            font.pixelSize: 16
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: credit.right
            anchors.leftMargin: 10
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

    Rectangle {
        id: background
        anchors.fill: parent
        color: "dimgray"
        opacity: 0.5
        visible: false
        MouseArea {
            anchors.fill: parent
            onClicked: { menu.scale = 0 ; background.visible = false ; menuarea.visible = true }
        }
    }
    Rectangle {
        id: menu
        color: "#f8f8f8"
        anchors.left: menubar.left
        anchors.top: menubar.top
        anchors.topMargin: 35
        width: 250
        height: menu.radius + first_menu.height + second_menu.height + third_menu.height + menu.radius
        radius: 5
        scale: 0
        transformOrigin: Item.TopLeft
        Behavior on scale { PropertyAnimation { duration: 100 } }
        Rectangle {
            id: first_menu
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.topMargin: menu.radius
            anchors.right: parent.right
            height: 35 - menu.radius
            color: menu.color
            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                onEntered: first_menu.color = "#e8e8e8"
                onExited: first_menu.color = menu.color
                onClicked: userlogoutDialog.open()
            }
            Text {
                id: logout
                anchors.verticalCenter: first_menu.verticalCenter
                anchors.left: parent.left
                verticalAlignment: Text.AlignVCenter
                height: 30
                font.family: "Verdana"
                width: parent.width
                font.pixelSize: 14
                text: qsTr("Logout User")
                leftPadding: 30
            }
        }
        Rectangle {
            id: first_radius
            radius: menu.radius
            height: menu.radius * 2
            width: first_menu.width
            anchors.top: menu.top
            color: first_menu.color
        }
        Rectangle {
            id: second_radius
            radius: menu.radius
            height: menu.radius * 2
            width: first_menu.width
            anchors.bottom: menu.bottom
            color: third_menu.color
        }
        Rectangle {
            id: second_menu
            anchors.left: parent.left
            anchors.top: first_menu.bottom
            anchors.right: parent.right
            height: 35
            color: menu.color
            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                onEntered: second_menu.color = "#e8e8e8"
                onExited: second_menu.color = menu.color
                onClicked: { backend.feature("Transfer") ; stack.replace("Transfer.ui.qml") ; backend.switchfeature() }
            }
            Text {
                id: new_user
                anchors.left: parent.left
                anchors.verticalCenter: second_menu.verticalCenter
                verticalAlignment: Text.AlignVCenter
                height: 30
                font.family: "Verdana"
                width: parent.width
                font.pixelSize: 14
                text: qsTr("Switch to Transfer Mode")
                leftPadding: logout.leftPadding
            }
        }
        Rectangle {
            id: third_menu
            anchors.left: parent.left
            anchors.top: second_menu.bottom
            anchors.right: parent.right
            height: first_menu.height
            color: menu.color
            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                onEntered: third_menu.color = "#e8e8e8"
                onExited: third_menu.color = menu.color
                onClicked: userlogoutDialog1.open()
            }
            Text {
                id: remove_user
                anchors.verticalCenter: third_menu.verticalCenter
                anchors.left: parent.left
                verticalAlignment: Text.AlignVCenter
                height: 30
                font.family: "Verdana"
                width: parent.width
                font.pixelSize: 14
                text: qsTr("Switch to Registration Mode")
                leftPadding: logout.leftPadding
            }
        }
    }
}
