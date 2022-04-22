import QtQuick 2.14
import QtQuick.Controls 2.5
import QtQuick.Window 2.15


ApplicationWindow {
    id: mainwindow
    width: (4/3) * height
    height: 768
    //width: Screen.width
    //height: Screen.height
    visible: true
    visibility: "Windowed"
    title: "CU Pay"
    //flags: Qt.FramelessWindowHint
    color: "transparent"

    Constants { id: constant }

    Rectangle {
        id: white_rectangle
        visible: true
        color: "#ffffff"
        anchors.fill: parent
    }
    Image {
        id: image
        width: 150
        height: 150
        visible: false
        anchors.top: white_rectangle.top
        source: "../images/culogo.jpg"
        sourceSize.height: 300
        sourceSize.width: 300
        anchors.horizontalCenter: white_rectangle.horizontalCenter
        fillMode: Image.PreserveAspectFit
    }
    Loader {
        id: page_loader
        source: "Splash.ui.qml"
        anchors.fill: parent
    }
    Connections {
        target: backend

        function onFinishedprocess(correctpage) {
            if (correctpage === 'P1Form.ui.qml') { image.visible = true }

        }
    }
}
