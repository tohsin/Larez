import QtQuick 2.14
import QtQuick.Controls 6.2

Item {
    id: window
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
        id: box
        visible: true
        color: "#f6f6f6"
        anchors.centerIn: parent
        width: height
        height: parent.height / 2
        radius: 8
    }
    AnimatedImage {
        id: pic
        source: "../images/loading.gif"
        width: 250
        height: (6/8) * width
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
        font.pixelSize: 20
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignBottom
        color: "black"
        text: qsTr("Loading...")
        font.bold: true
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

