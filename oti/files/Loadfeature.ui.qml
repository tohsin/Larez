import QtQuick 2.14
import QtQuick.Controls 6.2
import Qt.labs.platform 1.1

Item {
    id: window
    width: Screen.width
    height: Screen.height


    /*x: -600
    y: -700
    x: (Screen.width - width) / 2
    y: (Screen.height - height) / 2*/
    anchors.centerIn: parent
    property string correctpage: ""

    Rectangle {
        id: shadow
        visible: true
        color: "dimgrey"
        anchors.fill: parent
        radius: 8
        opacity: 0.6
    }
    Rectangle {
        id: white_rectangle
        visible: true
        color: "white"
        anchors.centerIn: parent
        width: height
        height: parent.height / 2
        radius: 8
    }

    Rectangle {
        id: time
        width: 1
        height: 15
        visible: true
        color: "black"
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: -15
        anchors.horizontalCenterOffset: 0
        anchors.horizontalCenter: parent.horizontalCenter
    }
    Text {
        id: loading
        anchors.top: time.bottom
        anchors.horizontalCenter: time.horizontalCenter
        font.family: "Verdana"
        font.styleName: "Regular"
        width: 152
        height: 41
        font.pixelSize: 20
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignBottom
        color: "black"
        text: qsTr("Loading...")
    }
    SequentialAnimation {
        id: click
        loops: Animation.Infinite
        PropertyAnimation {
            target: time
            property: "width"
            duration: 1000
            to: 100
        }
        PropertyAnimation {
            target: time
            property: "width"
            duration: 1000
            to: 1
        }
    }
    Component.onCompleted: {
        click.running = true ;
    }
    Connections {
        target: backend

        function onFinishedprocess(correctpage) {
            if (correctpage === 'close') { stack.pop() }
            else { stack.replace(correctpage) }
        }
    }
}

/*##^##
Designer {
    D{i:0;formeditorZoom:0.66}D{i:1}D{i:2}D{i:3}D{i:4}D{i:6}D{i:7}D{i:5}D{i:8}
}
##^##*/

