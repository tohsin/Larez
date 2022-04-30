import QtQuick 2.14
import QtQuick.Controls 2.5

Item {
    id: window
    anchors.fill: parent
    property string correctpage: ""

    Switch {
        id: switch1
        checked: true
        visible: false
    }

    Image {
        id: logo
        visible: switch1.checked
        source: "../images/culogo.jpg"
        width: 250
        height: width
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: -70
    }
    Text {
        id: loading
        visible: switch1.checked
        anchors.top: logo.bottom
        anchors.topMargin: -10
        anchors.horizontalCenter: parent.horizontalCenter
        font.family: "Verdana"
        font.styleName: "Regular"
        font.bold: true
        width: 152
        height: 41
        font.pixelSize: 24
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignBottom
        color: "black"
        text: qsTr("CU Pay")
    }

    Connections {
        target: backend

        function onFinishedprocess(correctpage) { page_loader.source = correctpage }
        function onRetryenroll() { enrolldialog("Failed to establish a connection to the internet. Please restart the application") }
    }

    // Dialog Settings
    Rectangle {
        id: time ; width: 10 ; height: 10 ; visible: false
    }
    // Small Dialog Display Timer
    SequentialAnimation {
        id: dialog_timer
        PropertyAnimation {
            target: time
            property: "width"
            duration: 10000
            to: 100
        }
        ScriptAction { script: { dialog_small.anchors.bottomMargin = -(dialog_small.height + 20) ; time.width = 10 } }
        ScriptAction { script: help.visible = true }
    }
    function enrolldialog(info) {
        bad_picture2.visible = true
        dialog_timer.running = false ; time.width = 10
        dialog_small.anchors.bottomMargin = 40
        dialog_timer.running = true
        information2.font.bold = true
        information2.font.pixelSize = 24
        information2.text = qsTr(info)
    }

    // Small Dialog Box Components
    Rectangle {
        id: dialog_small
        visible: true
        color: "#f0f0f0"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: -(height + 20)
        width: constant.smalldialogwidth // 700
        height: (width / 5) - 30
        radius: constant.smalldialogradius // 15
        Behavior on anchors.bottomMargin { PropertyAnimation { duration: 100 } }
        Text {
            id: information2
            anchors.left: bad_picture2.right
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.leftMargin: 10
            anchors.rightMargin: anchors.leftMargin
            font.family: "Verdana"
            font.styleName: "Regular"
            height: parent.height
            font.pixelSize: 20
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            color: "black"
            wrapMode: Text.WordWrap
            fontSizeMode: Text.Fit
            font.capitalization: Font.Capitalize
            text: qsTr("Dialog Information")
        }
        Image {
            id: bad_picture2
            anchors.left: parent.left
            anchors.leftMargin: width/2
            anchors.verticalCenter: parent.verticalCenter
            width: 50
            height: width
            sourceSize.width: width + 20
            sourceSize.height: width + 20
            source: "../images/warning.png"
            fillMode: Image.PreserveAspectFit
        }
    }

    Rectangle {
        anchors.top: help_button.top ; anchors.topMargin: 0.5 ; visible: help_button.visible
        anchors.left: help_button.left ; anchors.leftMargin: -1
        height: help_button.height + 2.5 ; width: help_button.width + 1.5 ; radius: help_button.radius + 1
        color: "#e0e0e0"
    }
    Rectangle {
        id: help_button
        color: "#ffffff"
        radius: 8
        width: constant.button1width // 230
        height: constant.button1height // 53
        anchors.verticalCenter: help.verticalCenter
        anchors.horizontalCenter: help.horizontalCenter
        visible: help.visible
    }
    Text {
        id: help
        visible: false
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: loading.bottom ; anchors.topMargin: 40
        width: 152
        height: 41
        text: qsTr("Click for help")
        font.pixelSize: 18
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        font.capitalization: Font.AllUppercase
        font.family: "Verdana"
        font.styleName: "Regular"; font.bold: true
        MouseArea {
            anchors.fill: parent
            onClicked: enrolldialog("Internet connection is either too slow or the device is not connected to the internet")
        }
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}D{i:1}D{i:2}D{i:3}
}
##^##*/

