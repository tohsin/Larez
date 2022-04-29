import QtQuick 2.14
import QtQuick.Controls 2.5

Item {
    id: window
    property string correctpage: ""

    Rectangle {
        id: time ; width: 10 ; height: 10 ; visible: false
    }
    Rectangle {
        id: shadow
        visible: true
        color: "dimgrey"
        anchors.fill: parent
        opacity: 0.6
    }
    Rectangle {
        id: box
        visible: true
        color: "#f6f6f6"
        anchors.centerIn: parent
        width: height + 100
        height: parent.height * 2/ 3
        radius: 8
    }
    AnimatedImage {
        id: pic
        source: "../images/loading.gif"
        width: 450
        height: (3/4) * width
        anchors.horizontalCenter: box.horizontalCenter
        anchors.bottom: box.bottom
        anchors.bottomMargin: 85
        cache: false
    }
    Text {
        id: loading
        anchors.topMargin: 100
        anchors.top: box.top
        anchors.horizontalCenter: box.horizontalCenter
        font.family: "Verdana"
        font.styleName: "Regular"
        width: 152
        height: 41
        font.pixelSize: 24
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignBottom
        color: "black"
        text: qsTr("Loading...")
        font.bold: true
    }
    Connections {
        target: backend

        function onEnrollinfo(info) { enrolldialog(info) }

        function onFinishedprocess(correctpage) {
            if (correctpage === 'close') { stack.pop() }
            else { stack.replace(correctpage) }
        }                
    }

    // Small Dialog Display Timer
    SequentialAnimation {
        id: dialog_timer
        PropertyAnimation {
            target: time
            property: "width"
            duration: 4000
            to: 100
        }
        ScriptAction { script: { dialog_small.anchors.bottomMargin = -(dialog_small.height + 20) ; time.width = 10 } }
    }

    // Dialog Box functions
    function enrolldialog(info) {
        center_border2.visible = bad_picture2.visible = false
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
        width: 700
        height: (width / 5) - 30
        radius: 15
        Behavior on anchors.bottomMargin { PropertyAnimation { duration: 100 } }
        Text {
            id: information2
            anchors.left: bad_picture2.right
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: center_border2.left
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
        Rectangle {
            id: center_border2
            color: "dimgray"
            opacity: 0.7
            width: 2
            anchors.top: parent.top
            anchors.topMargin: 20
            anchors.bottom: parent.bottom
            anchors.bottomMargin: anchors.topMargin
            anchors.right: parent.right
            anchors.rightMargin: 100
        }
        MouseArea {
            visible: center_border2.visible
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.left: center_border2.right
            height: parent.height
            onClicked: { dialog_small.anchors.bottomMargin = -(dialog_small.height + 20) ; time.width = 10 }
            Text {
                id: ok2
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                font.family: "Verdana"
                font.styleName: "Regular"
                width: 152
                height: parent.height
                font.pixelSize: information2.font.pixelSize
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                color: "black"
                text: qsTr("Ok")
            }
        }
    }
}

/*##^##
Designer {
    D{i:0;formeditorZoom:0.66}D{i:1}D{i:2}D{i:3}D{i:4}D{i:6}D{i:7}D{i:5}D{i:8}
}
##^##*/

