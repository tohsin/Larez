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
    property var aNum: ""
    SequentialAnimation {
        id: click
        PropertyAnimation {
            target: time;
            property: "width";
            duration: 2000;
            to: 100;
        }
        ScriptAction { script: { backend.purchasefeature(enter_amount.text); stack.replace('P3Form.ui.qml') ; backend.log(1) } }
    }

    FocusScope {
        id: white_rectangle
        anchors.fill: parent      
        Button {
            id: submit
            y: 522
            width: 115
            height: 40
            text: qsTr("Submit")
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 120
            anchors.horizontalCenterOffset: 0
            font.pointSize: 12
            font.family: "Verdana"
            anchors.horizontalCenter: parent.horizontalCenter
            onClicked: {
                if (enter_amount.text < 50 | enter_amount.text > aNum) {
                    if (enter_amount.text < 50.0) { warnDialog.open() }
                    if (enter_amount.text > aNum) { insufDialog.open() }
                } else { purchaseDialog.open() }
            }
        }
    }
    MessageDialog {
        title: "Making Purchase"
        id: purchaseDialog
        text: "You Are About To Make A Purchase with " + enter_amount.text + " Naira"
        informativeText: "Do You Want To Continue?"
        buttons: MessageDialog.Yes | MessageDialog.No
        onYesClicked: { stack.push('Success.ui.qml'); click.running = true }
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
        text: "Amount You Entered Supercedes Your Available Balance"
        buttons: MessageDialog.Ok
    }

    Image {
        anchors.left: parent.left
        anchors.leftMargin: 40
        anchors.top: parent.top
        anchors.topMargin: 60
        source: '../images/menubutton.png'
        height: 30
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
                text: qsTr("Switch to Transfer Mode")
                onTriggered: { backend.feature("Transfer") ; stack.replace("Transfer.ui.qml") ; backend.switchfeature() }
            }
            MenuItem {
                text: qsTr("Switch to Register Mode")
                onTriggered: { backend.feature("Register") ; stack.pop() ; stack.replace("Register.ui.qml") ; backend.switchfeature() }
            }
        }
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

        TextField {
            id: enter_amount
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
            placeholderText: qsTr("Enter Amount")
        }
        Image {
            id:clearamount
            height: 15
            width: height
            anchors.verticalCenter: amount_box.verticalCenter
            anchors.right: amount_box.right
            anchors.rightMargin: 10
            source: "../images/cleartext.png"

            MouseArea {
                id:clamt
                anchors.fill: parent
                onClicked: enter_amount.text = ""
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
        text: " Window"
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
            text: "Hi, "
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
            text: "Available "
            font.pixelSize: 16
            anchors.top: loggeduser.bottom
            anchors.right: parent.right
            font.family: "Verdana"
            font.styleName: "Regular"
            font.italic: true
        }
    }

}
