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
                if (enter_amount.text < 50.0) { warnDialog.open() }
                else { purchaseDialog.open() }
            }
        }
    }
    MessageDialog {
        title: "Making Purchase"
        id: purchaseDialog
        text: "You Are About To Make A Purchase with " + enter_amount.text + " Naira"
        informativeText: "Do You Want To Continue?"
        buttons: MessageDialog.Yes | MessageDialog.No | MessageDialog.Cancel
        onYesClicked: { stack.push('Success.ui.qml'); click.running = true }
        onCancelClicked: { stack.pop() ; stack.pop() }
    }
    MessageDialog {
        title: "Invalid Amount"
        id: warnDialog
        text: "You Cannot Make Purchase With less than 50 Naira"
        buttons: MessageDialog.Ok
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
            placeholderText: qsTr("Enter Amount")
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
