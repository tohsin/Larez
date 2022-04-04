import QtQuick 2.14
import QtQuick.Controls 6.2

Item {
    id: window
    anchors.fill: parent
    property int code: 0
    Rectangle {
        id: time ; width: 10 ; height: 10 ; visible: false
    }

    // Navigation Buttons -- Log in, Use Pin, Use Fingerprint, Settings box, Menu bar
    Rectangle {
        anchors.top: log_in_button.top ; anchors.topMargin: 0.5 ; visible: log_in_button.visible
        anchors.left: log_in_button.left ; anchors.leftMargin: -1
        height: log_in_button.height + 2.5 ; width: log_in_button.width + 1.5 ; radius: log_in_button.radius + 1
        color: "#e0e0e0"
    }
    Rectangle {
        id: log_in_button
        visible: switch1.checked
        width: 114
        height: 40
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 120
        anchors.right: parent.right
        anchors.rightMargin: 60
        color: "black"
        radius: 8
        Text {
            width: 150
            height: 40
            color: "white"
            text: qsTr("Log In")
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 15
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.bold: true
            font.family: "Verdana"
            anchors.horizontalCenter: parent.horizontalCenter
        }
        MouseArea {
            anchors.fill: parent
            onClicked: {
                page_loader.source = 'Loadingpage.ui.qml';
                backend.superuser([username.text, password.text , "Pin", code]);
            }
        }
    }
    Rectangle {
        anchors.top: use_pin_button.top ; anchors.topMargin: -0.5 ; visible: use_pin_button.visible
        anchors.left: use_pin_button.left ; anchors.leftMargin: -1
        height: use_pin_button.height + 3.5 ; width: use_pin_button.width + 1.5 ; radius: use_pin_button.radius + 1
        color: "#e0e0e0"
    }
    Rectangle {
        id: use_pin_button
        color: "#ffffff"
        radius: 8
        //border.width: 3
        width: 114
        height: 40
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 120
        visible: !switch1.checked
        anchors.horizontalCenter: parent.horizontalCenter
        Text {
            width: 150
            height: 40
            text: qsTr("Use Pin")
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 15
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.bold: true
            font.family: "Verdana"
            anchors.horizontalCenter: parent.horizontalCenter
        }
        MouseArea {
            anchors.fill: parent
            onClicked: { switch1.checked = !switch1.checked ; fingerprint.opacity = 0 ; settings_text.anchors.leftMargin = toggleswitch.anchors.rightMargin = 60 ; settings_text.anchors.bottomMargin = 130 }
        }
    }
    Rectangle {
        anchors.top: use_fingerprint_button.top ; anchors.topMargin: 0.5 ; visible: use_fingerprint_button.visible
        anchors.left: use_fingerprint_button.left ; anchors.leftMargin: -1
        height: use_fingerprint_button.height + 2.5 ; width: use_fingerprint_button.width + 1.5 ; radius: use_fingerprint_button.radius + 1
        color: "#e0e0e0"
    }
    Rectangle {
        id: use_fingerprint_button
        color: "#ffffff"
        radius: 8
        //border.width: 3
        width: 156
        height: 40
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 120
        visible: switch1.checked
        anchors.left: parent.left
        anchors.leftMargin: 60        
        Text {
            width: 160
            height: 40
            text: qsTr("Use Fingerprint")
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 15
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.bold: true
            font.family: "Verdana"
            anchors.horizontalCenter: parent.horizontalCenter
        }
        MouseArea {
            anchors.fill: parent
            onClicked: { switch1.checked = !switch1.checked ; fingerprint.opacity = 1 ; settings_text.anchors.leftMargin = 95 ; settings_text.anchors.bottomMargin = 120 ; toggleswitch.anchors.rightMargin = 80 }
        }
    }
    CheckBox {
        id: settings_box ; visible: false
        onCheckedChanged: {
            if (settings_box.checked === true) { code = 1 }
            else { code = 0 }
        }
    }
    Text {
        id: settings_text
        height: 20
        text: qsTr("Open Settings On Log In")
        anchors.bottom: use_fingerprint_button.top
        anchors.bottomMargin: 120
        anchors.left: parent.left
        anchors.leftMargin: 95
        font.pixelSize: 14
        font.family: "Verdana"
        MouseArea {
            anchors.fill: parent
            onClicked: settings_box.checked = !settings_box.checked
        }
    }
    Rectangle {
        id: toggleswitch
        anchors.right: parent.right ; anchors.rightMargin: 80
        anchors.verticalCenter: settings_text.verticalCenter
        color: "darkred" ; width: height * 1.5 ; height: 24 ; radius: height/2
        MouseArea {
            anchors.fill: parent
            onClicked: { settings_box.checked = !settings_box.checked ; togglecolor() }
        }
        Rectangle {
            id: flicker
            height: parent.height - 4 ; width: height ; radius: height/2
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.horizontalCenterOffset: -(toggleswitch.height / 4)
            Behavior on anchors.horizontalCenterOffset { PropertyAnimation { duration: 100 } }
        }
    }

    Switch {
        id: switch1
        checked: false ; visible: false
    }
    Text {
        visible: use_pin_button.visible
        anchors.bottom: use_pin_button.top ; anchors.bottomMargin: 50
        anchors.horizontalCenter: parent.horizontalCenter
        width: 260 ; height: 41
        text: qsTr("No Account? Click here to <b>Register</b>")
        font.pixelSize: 15
        verticalAlignment: Text.AlignVCenter
        font.capitalization: Font.Capitalize
        font.family: "Verdana" ; font.styleName: "Regular"
        MouseArea {
            anchors.right: parent.right ; anchors.verticalCenter: parent.verticalCenter
            height: parent.height ; width: 75
            onClicked: { page_loader.source = "Registersuper.ui.qml" ; backend.menubranch(1) }
        }
    }
    Text {
        id: registeraccount
        visible: use_fingerprint_button.visible
        anchors.bottom: use_fingerprint_button.top ; anchors.bottomMargin: 60
        anchors.left: parent.left ; anchors.leftMargin: 60
        width: 260 ; height: 41
        text: qsTr("No Account? Click here to <b>Register</b>")
        font.pixelSize: 15
        verticalAlignment: Text.AlignVCenter
        font.capitalization: Font.Capitalize
        font.family: "Verdana" ; font.styleName: "Regular"
        MouseArea {
            anchors.right: parent.right; anchors.verticalCenter: parent.verticalCenter
            height: parent.height; width: 75
            onClicked: { page_loader.source = "Registersuper.ui.qml" ; backend.menubranch(1) }
        }
    }

    // Menu Button -- Menu
    Image {
        id: menubar
        anchors.left: parent.left
        anchors.leftMargin: 40
        anchors.top: parent.top
        anchors.topMargin: 40
        source: '../images/menubutton.png'
        height: 25
        width: height + 2
        MouseArea {
            id: menuarea
            anchors.fill: parent
            onClicked: { background.visible = menu.visible = true ; menu.scale = 1 ; menuarea.visible = false }
        }
    }

    // Biometric Elements -- User Rank, Fingerprint picture, "Place Finger" text
    Text {
        id: biometric
        visible: !switch1.checked
        anchors.left: parent.left ; anchors.leftMargin: 60
        anchors.top: parent.top ; anchors.topMargin: 200
        width: 152 ; height: 41
        text: qsTr("Super Admin")
        font.pixelSize: 19
        verticalAlignment: Text.AlignVCenter
        font.capitalization: Font.AllUppercase
        font.family: "Verdana"
        font.styleName: "Regular"
        font.bold: true
    }
    Image {
        id: fingerprint
        visible: !switch1.checked
        opacity: 0
        anchors.top: biometric.bottom
        anchors.topMargin: 30
        width: 150
        height: 150
        source: "../images/whitefinger.jpg"
        anchors.horizontalCenter: parent.horizontalCenter
        fillMode: Image.PreserveAspectFit
        Behavior on opacity { PropertyAnimation { duration: 500 } }
        MouseArea {
            anchors.fill: parent;
            onClicked: {
                page_loader.source = "Loadingpage.ui.qml";
                backend.superuser(['11', '0011', "Fingerprint", code]);
            }
        }
    }
    Text {
        id: place_finger
        visible: !switch1.checked
        opacity: fingerprint.opacity
        x: 297
        width: 262
        height: 50        
        text: qsTr("Place Finger on Scanner")
        anchors.top: fingerprint.bottom
        anchors.topMargin: 10
        anchors.horizontalCenter: fingerprint.horizontalCenter
        font.pixelSize: 18
        font.italic: true
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignTop
    }

    // Typed Elements -- Rank, Username & Pin Text box
    Text {
        id: superadmin
        visible: switch1.checked
        anchors.top: parent.top ; anchors.topMargin: 200
        anchors.left: parent.left ;  anchors.leftMargin: 60
        anchors.right: parent.right
        height: 41
        text: qsTr("Super Admin")
        font.pixelSize: 19
        verticalAlignment: Text.AlignVCenter
        font.capitalization: Font.AllUppercase
        font.family: "Verdana"
        font.styleName: "Regular"
        font.bold: true
        TextField {
            id: username
            width: username_box.width
            height: username_box.height - 2
            placeholderText: qsTr("Username")
            font.pixelSize: 16
            topPadding: 7
            //leftPadding: 9
            rightPadding: 35
            anchors.verticalCenter: username_box.verticalCenter
            anchors.left: username_box.left
            anchors.right: username_box.right
            anchors.rightMargin: 1
            anchors.leftMargin: 1
            Rectangle {
                anchors.fill: parent ; color: "transparent" ; border.width: 1 ; border.color: "white"
            }
        }        
        Rectangle {
            id: username_box
            height: 40
            color: "transparent"
            radius: 5
            //border.width: 1
            anchors.left: parent.left
            anchors.top: parent.bottom
            anchors.right: parent.right
            anchors.rightMargin: 60
            Rectangle {
                color: "black"
                height: 1.5
                anchors.left: parent.left
                anchors.top: parent.bottom
                anchors.topMargin: 1
                anchors.right: parent.right
            }
        }
        Image {
            id:clearusername
            height: 14
            width: height
            anchors.verticalCenter: username_box.verticalCenter
            anchors.right: username_box.right
            anchors.rightMargin: 10
            source: "../images/closebutton.png"
            sourceSize.width: 20
            sourceSize.height: 20
            MouseArea {
                id:clusr
                anchors.fill: parent
                onClicked: username.text = ""
            }
        }
    }
    // Typed Elements contd. -- Pin Text box
    Text {
        id: pin
        visible: switch1.checked
        anchors.left: parent.left ; anchors.leftMargin: 60
        anchors.top: parent.top ; anchors.topMargin: 370
        width: 152
        height: 41
        text: qsTr("Pin")
        font.pixelSize: 19
        verticalAlignment: Text.AlignVCenter
        font.capitalization: Font.AllUppercase
        font.family: "Verdana"
        font.styleName: "Regular"
        font.bold: true
        TextField {
            id: password
            echoMode: TextInput.Password
            width: username_box.width
            height: username_box.height - 2
            placeholderText: qsTr("Pin")
            font.pixelSize: 16
            topPadding: 7
            //leftPadding: 9
            rightPadding: 35
            anchors.verticalCenter: password_box.verticalCenter
            anchors.left: password_box.left
            anchors.right: password_box.right
            anchors.rightMargin: 1
            anchors.leftMargin: 1
            Rectangle {
                anchors.fill: parent ; color: "transparent" ; border.width: 1 ; border.color: "white"
            }
        }
        Rectangle {
            id: password_box
            width: username_box.width
            height: username_box.height
            color: "transparent"
            radius: 5
            //border.width: 1
            anchors.left: parent.left
            anchors.top: parent.bottom
            Rectangle {
                color: "black"
                height: 1.5
                anchors.left: parent.left
                anchors.top: parent.bottom
                anchors.topMargin: 1
                anchors.right: parent.right
            }
        }
        Image {
            id:clearpin
            height: 14
            width: height
            anchors.verticalCenter: password_box.verticalCenter
            anchors.right: password_box.right
            anchors.rightMargin: 10
            source: "../images/closebutton.png"
            sourceSize.width: 20
            sourceSize.height: 20
            MouseArea {
                id:clpin
                anchors.fill: parent
                onClicked: password.text = ""
            }
        }
    }

    // Small Dialog Display Timer
    SequentialAnimation {
        id: dialog_timer
        PropertyAnimation {
            target: time
            property: "width"
            duration: 4000
            to: 100
        }
        ScriptAction { script: { dialog_small.anchors.bottomMargin = -100 ; time.width = 10 } }
    }
    function togglecolor() {
        if (settings_box.checked === true) { toggleswitch.color = "darkgreen" ; flicker.anchors.horizontalCenterOffset = (toggleswitch.height / 4) }
        else { toggleswitch.color = "darkred" ; flicker.anchors.horizontalCenterOffset = -(toggleswitch.height / 4) }
    }

    // Dialog Box functions
    function displaydialog(functionnum) {
        dialog_timer.running = false ; time.width = 10
        dialog_small.anchors.bottomMargin = 10
        dialog_timer.running = true
        // 1 incorrectDialog
        if (functionnum === 1) { information2.text = qsTr("Invalid Username or Password") }
    }
    // Small Dialog Box Components
    Rectangle {
        id: dialog_small
        visible: true
        color: "#f0f0f0"
        border.width: 0
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: -100
        width: 400
        height: 80
        radius: 15
        Behavior on anchors.bottomMargin { PropertyAnimation { duration: 100 } }
        Text {
            id: information2
            anchors.left: bad_picture2.right
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: center_border2.left
            anchors.leftMargin: 10
            anchors.rightMargin: 10
            font.family: "Verdana"
            font.styleName: "Regular"
            height: parent.height
            font.pixelSize: 14
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            color: "black"
            wrapMode: Text.WordWrap
            fontSizeMode: Text.Fit
            font.capitalization: Font.Capitalize
            text: qsTr("Dialog Information")
        }
        Image {
            id: bad_picture2
            anchors.left: parent.left
            anchors.leftMargin: 15
            anchors.verticalCenter: parent.verticalCenter
            width: 25
            height: width
            sourceSize.width: 50
            sourceSize.height: 50
            source: "../images/warning.png"
            fillMode: Image.PreserveAspectFit
        }
        Rectangle {
            id: center_border2
            color: "dimgray"
            opacity: 0.7
            width: 2
            anchors.top: parent.top
            anchors.topMargin: 10
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 10
            anchors.right: parent.right
            anchors.rightMargin: 60
        }
        MouseArea {
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.left: center_border2.right
            height: parent.height
            onClicked: { dialog_small.anchors.bottomMargin = -100 ; time.width = 10 }
            Text {
                id: ok2
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                font.family: "Verdana"
                font.styleName: "Regular"
                width: 152
                height: parent.height
                font.pixelSize: 14
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                color: "black"
                text: qsTr("Ok")
            }
        }
    }

    Connections {
        target: backend

        function onIncorrect(number) {
            if (number === 1) { displaydialog(1) }
        }
    }

    // Menu Bar Items Components
    Rectangle {
        id: background
        anchors.fill: parent
        color: "dimgray"
        opacity: 0.5
        visible: false
        MouseArea {
            anchors.fill: parent
            onClicked: { menu.scale = 0 ; background.visible = menu.visible = false ; menuarea.visible = true }
        }
    }
    Rectangle {
        id: menu
        color: "#f8f8f8"
        visible: false
        anchors.left: menubar.left
        anchors.top: menubar.bottom
        anchors.topMargin: 10
        width: 150
        height: menu.radius + first_menu.height + second_menu.height + menu.radius
        radius: 5
        scale: 0
        transformOrigin: Item.TopLeft
        Behavior on scale { PropertyAnimation { duration: 100 } }
        Rectangle {
            id: first_menu
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.topMargin: menu.radius
            anchors.right: parent.right
            height: 35 - menu.radius
            color: menu.color
            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                onEntered: first_menu.color = "#e8e8e8"
                onExited: first_menu.color = menu.color
                onClicked: { page_loader.source = "Registersuper.ui.qml" ; backend.menubranch(1) }
            }
            Text {
                id: newadmin
                anchors.verticalCenter: first_menu.verticalCenter
                anchors.right: parent.right
                verticalAlignment: Text.AlignVCenter
                height: 30
                font.family: "Verdana"
                width: parent.width
                font.pixelSize: 14
                text: qsTr("New Admin")
                leftPadding: 15
            }
        }
        Rectangle {
            id: first_radius
            radius: menu.radius
            height: menu.radius * 2
            width: first_menu.width
            anchors.top: menu.top
            color: first_menu.color
        }
        Rectangle {
            id: second_radius
            radius: menu.radius
            height: menu.radius * 2
            width: first_menu.width
            anchors.bottom: menu.bottom
            color: second_menu.color
        }
        Rectangle {
            id: second_menu
            anchors.left: parent.left
            anchors.top: first_menu.bottom
            anchors.right: parent.right
            height: first_menu.height
            color: menu.color
            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                onEntered: second_menu.color = "#e8e8e8"
                onExited: second_menu.color = menu.color
                onClicked: { page_loader.source = "Removesuper.ui.qml" ; backend.menubranch(1) }
            }
            Text {
                id: removeadmin
                anchors.right: parent.right
                anchors.verticalCenter: second_menu.verticalCenter
                verticalAlignment: Text.AlignVCenter
                height: 30
                font.family: "Verdana"
                width: parent.width
                font.pixelSize: 14
                text: qsTr("Remove Admin")
                leftPadding: newadmin.leftPadding
            }
        }
    }
    Component.onCompleted: fingerprint.opacity = 1
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:700;width:600}D{i:2}D{i:1}D{i:3}D{i:5}D{i:6}D{i:4}D{i:8}
D{i:9}D{i:7}
}
##^##*/
