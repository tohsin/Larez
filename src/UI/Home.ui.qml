import QtQuick 2.14
import QtQuick.Controls 6.2

ApplicationWindow {
    id: window
    width: 700
    height: 800
    visible: true
    visibility: "Windowed"
    x: (Screen.width - width) / 2
    y: (Screen.height - height) / 2
    title: "CU Pay"
    flags: Qt.FramelessWindowHint

    Image {
        id: back_image
        anchors.fill: parent
        source: "../images/wallpaper.jpg"
    }

    Rectangle {
        id: white_rectangle
        visible: true
        color: "#ffffff"
        width: 600
        height: 700
        radius: 8
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter

        Image {
            id: image
            width: 100
            height: 100
            anchors.top: parent.top
            source: "../images/Untitled-1.jpg"
            anchors.topMargin: 40
            anchors.horizontalCenter: white_rectangle.horizontalCenter
            fillMode: Image.PreserveAspectFit
        }
    }
    Loader {
        id: page_loader
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        source: "P1Form.ui.qml"
        width: 600
        height: 700
    }
    Image {
        id: close
        source: "../images/closebutton.png"
        x: 25
        y: x
        height: 20
        width: height
        MouseArea {
            anchors.fill: parent
            onClicked: { backend.closeapp() ; window.close() }
        }
    }
}
