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
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: -80
        source: "../images/success.png"
    }
    Text {
        text: qsTr("Printing Customer Receipt...")
        anchors.top: success.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: 35
        width: 140
        height: 40
        font.pixelSize: 26
        font.bold: true
        font.capitalization: Font.Capitalize
        font.family: "Verdana"
        font.styleName: "Regular"
        horizontalAlignment: Text.AlignHCenter
        font.italic: true
        verticalAlignment: Text.AlignVCenter
    }
}
