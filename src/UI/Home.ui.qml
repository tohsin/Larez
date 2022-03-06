import QtQuick 2.14
import QtQuick.Controls 6.2

ApplicationWindow {
    id: window
    width: 600
    height: 800
    visible: true
    visibility: "Windowed"
    x: (Screen.width - width) / 2
    y: (Screen.height - height) / 2
    title: "CU Pay"
    flags: Qt.FramelessWindowHint
    color: "transparent"

    Rectangle {
        id: white_rectangle
        visible: true
        color: "#ffffff"
        anchors.fill: parent
        radius: 8   
    }
    Image {
        id: image
        width: 150
        height: 150
        visible: false
        anchors.top: white_rectangle.top
        source: "../images/culogo.jpg"
        anchors.topMargin: 40
        anchors.horizontalCenter: white_rectangle.horizontalCenter
        fillMode: Image.PreserveAspectFit
    }
    Loader {
        id: page_loader
        source: "Splash.ui.qml"
        anchors.fill: parent
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
    Connections {
        target: backend

        function onFinishedprocess(correctpage) {
            if (correctpage === 'P1Form.ui.qml') { image.visible = true }

        }
    }
}
