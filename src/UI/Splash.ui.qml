import QtQuick 2.14
import QtQuick.Controls 2.5

Item {
    id: window
    anchors.fill: parent
    property string correctpage: ""

    Switch {
        id: switch1
        checked: true
        visible: false
    }

    Image {
        id: logo
        visible: switch1.checked
        source: "../images/culogo.jpg"
        width: 250
        height: width
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: -35
    }
    Text {
        id: loading
        visible: switch1.checked
        anchors.top: logo.bottom
        anchors.topMargin: -10
        anchors.horizontalCenter: parent.horizontalCenter
        font.family: "Verdana"
        font.styleName: "Regular"
        font.bold: true
        width: 152
        height: 41
        font.pixelSize: 24
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignBottom
        color: "black"
        text: qsTr("CU Pay")
    }

    Connections {
        target: backend

        function onFinishedprocess(correctpage) {
            page_loader.source = correctpage

        }
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}D{i:1}D{i:2}D{i:3}
}
##^##*/

