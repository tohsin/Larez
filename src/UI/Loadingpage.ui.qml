import QtQuick 2.14
import QtQuick.Controls 2.5

Item {
    id: window
    property string correctpage: ""

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
        height: parent.height * 2 / 3
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
    /*AnimatedImage {
        id: pic
        source: "../images/loading2.gif"
        width: 450
        height: (6/8) * width
        anchors.horizontalCenter: box.horizontalCenter
        anchors.bottom: box.bottom
        anchors.bottomMargin: 85
        cache: false
    }*/
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

        function onFinishedprocess(correctpage){
            page_loader.source = correctpage
        }
    }
}
