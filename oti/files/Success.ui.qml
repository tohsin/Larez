import QtQuick 2.14
import QtQuick.Controls 6.2

Item {
    width: 600
    height: 700

    Rectangle {
        id: rect
        anchors.fill: parent
    }
    Image {
        id: success
        height: 300
        width: height
        anchors.centerIn: parent
        source: "success.png"
    }
}
