import QtQuick 2.14
import QtQuick.Controls 6.2

Item {
    id: window
    width: 600
    height: 700
    Rectangle {
        id: white_rectangle
        visible: true
        color: "#ffffff"
        anchors.fill: parent
        transformOrigin: Item.Center
        radius: 8

        Button {
            id: use_pin_button
            y: 522
            width: 114
            height: 40
            text: qsTr("Use Pin")
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 120
            visible: !switch1.checked & username_checkBox.checked
            anchors.horizontalCenterOffset: 0
            font.pointSize: 12
            font.family: "Verdana"
            anchors.horizontalCenter: parent.horizontalCenter
            onClicked: switch1.checked = !switch1.checked
        }
        Button {
            id: use_fingerprint_button
            y: 522
            width: 156
            height: 40
            text: qsTr("Use Fingerprint")
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 120
            visible: switch1.checked & username_checkBox.checked
            anchors.horizontalCenterOffset: 0
            font.pointSize: 12
            font.family: "Verdana"
            anchors.horizontalCenter: parent.horizontalCenter
            onClicked: switch1.checked = !switch1.checked
        }

        Switch {
            id: switch1
            x: 254
            y: 194
            text: qsTr("Switch")
            checked: false
            visible: false
        }
    }

    Button {
        id: back_button
        width: 67
        height: 35
        text: qsTr("BACK")
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.leftMargin: 32
        anchors.topMargin: 150
        onClicked: stack.pop()
    }

    Image {
        id: image
        width: 100
        height: 100
        anchors.top: parent.top
        source: "../../../Downloads/Ps/OTI/Untitled-1.jpg"
        anchors.topMargin: 40
        anchors.horizontalCenter: white_rectangle.horizontalCenter
        fillMode: Image.PreserveAspectFit
    }
    Image {
        id: fingerprint
        y: 360
        width: 136
        height: 124
        visible: use_pin_button.visible
        source: "../../../Downloads/Ps/GUI/fingerprint.png"
        anchors.horizontalCenter: parent.horizontalCenter
        fillMode: Image.PreserveAspectFit
        MouseArea { anchors.fill: parent; onClicked: stack.push("P3Form.ui.qml") }
    }

    Text {
        id: place_finger
        x: 297
        width: 262
        height: 50
        visible: use_pin_button.visible
        text: qsTr("Place Finger on Scanner")
        anchors.top: fingerprint.bottom
        font.pixelSize: 18
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignTop
        anchors.topMargin: -10
        anchors.horizontalCenter: fingerprint.horizontalCenter
    }

    Text {
        id: admin
        x: 60
        y: 245
        width: 152
        height: 41
        text: qsTr("Admin:")
        font.pixelSize: 20
        verticalAlignment: Text.AlignVCenter
        wrapMode: Text.NoWrap
        fontSizeMode: Text.Fit
        font.capitalization: Font.AllUppercase
        font.family: "Verdana"
        font.styleName: "Regular"

        Rectangle {
            id: username_box
            width: 430
            height: 40
            color: "#ffffff"
            radius: 5
            border.width: 1
            anchors.left: parent.left
            anchors.top: parent.bottom
            anchors.topMargin: 0
            anchors.leftMargin: 0
        }
        CheckBox {
            id: username_checkBox
            x: 428
            y: 304
            width: 13
            height: 12
            scale: 2.4
            anchors.verticalCenter: username_box.verticalCenter
            anchors.left: username_box.right
            checked: true
            anchors.leftMargin: 15
        }

        Text {
            id: check_uncheck
            x: 336
            width: 127
            height: 25
            text: qsTr("Click To Check/Uncheck")
            anchors.right: username_checkBox.right
            anchors.top: username_box.bottom
            font.pixelSize: 13
            horizontalAlignment: Text.AlignRight
            anchors.topMargin: 10
            anchors.rightMargin: -7
        }

        TextField {
            id: username
            height: 38
            anchors.verticalCenter: username_box.verticalCenter
            anchors.left: username_box.left
            anchors.right: username_box.right
            anchors.rightMargin: 1
            anchors.leftMargin: 1
            baselineOffset: 15
            font.pointSize: 12
            topPadding: 7
            leftPadding: 9
            placeholderText: qsTr("Username")
        }
    }
    Text {
        id: pin
        x: 60
        y: 400
        width: 152
        height: 41
        visible: use_fingerprint_button.visible
        text: qsTr("Pin:")
        font.pixelSize: 20
        verticalAlignment: Text.AlignVCenter
        fontSizeMode: Text.Fit
        font.capitalization: Font.AllUppercase
        font.family: "Verdana"
        font.styleName: "Regular"

        Rectangle {
            id: password_box
            width: 427
            height: 40
            color: "#ffffff"
            radius: 5
            border.width: 1
            anchors.left: parent.left
            anchors.top: parent.bottom
            anchors.topMargin: 0
            anchors.leftMargin: 0
            visible: use_fingerprint_button.visible
        }

        TextField {
            id: password
            height: 38
            visible: use_fingerprint_button.visible
            anchors.verticalCenter: password_box.verticalCenter
            anchors.left: password_box.left
            anchors.right: password_box.right
            anchors.rightMargin: 1
            anchors.leftMargin: 1
            baselineOffset: 15
            font.pointSize: 12
            topPadding: 7
            leftPadding: 9
            placeholderText: qsTr("Pin")
        }
        Text {
            id: p_check_uncheck
            x: 336
            width: 127
            height: 25
            text: qsTr("Click To Check/Uncheck")
            anchors.right: password_checkBox.right
            anchors.top: password_box.bottom
            font.pixelSize: 13
            horizontalAlignment: Text.AlignRight
            anchors.topMargin: 10
            anchors.rightMargin: -7
        }
        CheckBox {
            id: password_checkBox
            width: 13
            height: 12
            scale: 2.4
            anchors.verticalCenter: password_box.verticalCenter
            anchors.left: password.right
            checked: false
            anchors.leftMargin: 15
            onClicked: stack.push("P3Form.ui.qml")
        }
    }
}
