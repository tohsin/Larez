import QtQuick 2.14

Item {

    Rectangle {
        id: rect
        anchors.fill: parent
        radius: 10
    }
    Image {
        id: success
        height: 300
        width: height
        anchors.centerIn: parent
        source: "../images/success.png"
    }
}
