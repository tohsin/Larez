import QtQuick 2.14
import QtQuick.Controls 2.5
import "keyboard"

Item {
    id: window
    anchors.fill: parent
    property int code: 0
    // scale: Math.max(1,(mainwindow.width - 1000)*1.2 / 920)
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
        width: 150
        height: 53
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 120
        anchors.right: parent.right
        anchors.rightMargin: use_fingerprint_button.anchors.leftMargin
        color: "black"
        radius: 8
        Text {
            id: login_text
            width: 150
            height: 40
            color: "white"
            text: qsTr("Log In")
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 20
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
        radius: log_in_button.radius
        width: log_in_button.width
        height: log_in_button.height
        anchors.bottom: parent.bottom
        anchors.bottomMargin: log_in_button.anchors.bottomMargin
        visible: !switch1.checked
        anchors.horizontalCenter: parent.horizontalCenter
        Text {
            width: 150
            height: 40
            text: qsTr("Use Pin")
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: login_text.font.pixelSize
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.bold: true
            font.family: "Verdana"
            anchors.horizontalCenter: parent.horizontalCenter
        }
        MouseArea {
            anchors.fill: parent
            onClicked: { switch1.checked = !switch1.checked ; fingerprint.opacity = 0 ; settings_text.anchors.leftMargin = toggleswitch.anchors.rightMargin = biometric.anchors.leftMargin ; settings_text.anchors.bottomMargin = 100 }
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
        radius: log_in_button.radius
        //border.width: 3
        width: 230
        height: log_in_button.height
        anchors.bottom: parent.bottom
        anchors.bottomMargin: log_in_button.anchors.bottomMargin
        visible: switch1.checked
        anchors.left: parent.left
        anchors.leftMargin: biometric.anchors.leftMargin + 100
        Text {
            width: 160
            height: 40
            text: qsTr("Use Fingerprint")
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: login_text.font.pixelSize
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.bold: true
            font.family: "Verdana"
            anchors.horizontalCenter: parent.horizontalCenter
        }
        MouseArea {
            anchors.fill: parent
            onClicked: { switch1.checked = !switch1.checked ; fingerprint.opacity = 1 ; settings_text.anchors.leftMargin = 200 ; settings_text.anchors.bottomMargin = 100 ; toggleswitch.anchors.rightMargin = settings_text.anchors.leftMargin }
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
        anchors.bottomMargin: 100
        anchors.left: parent.left
        anchors.leftMargin: 100
        font.pixelSize: 16
        font.family: "Verdana"
        MouseArea {
            anchors.fill: parent
            onClicked: settings_box.checked = !settings_box.checked
        }
    }
    Rectangle {
        id: toggleswitch
        anchors.right: parent.right ; anchors.rightMargin: settings_text.anchors.leftMargin
        anchors.verticalCenter: settings_text.verticalCenter
        color: "darkred" ; width: height * 1.5 ; height: 28 ; radius: height/2
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
        id: registeraccount
        anchors.bottom: use_fingerprint_button.top ; anchors.bottomMargin: 40
        anchors.left: settings_text.left
        width: 300 ; height: 40
        text: qsTr("No Account? Click here to <b>Register</b>")
        font.pixelSize: 16
        verticalAlignment: Text.AlignVCenter
        font.capitalization: Font.Capitalize
        font.family: "Verdana" ; font.styleName: "Regular"
        MouseArea {
            anchors.right: parent.right; anchors.verticalCenter: parent.verticalCenter
            height: parent.height; width: 80
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
        anchors.left: parent.left ; anchors.leftMargin: 100
        anchors.top: parent.top ; anchors.topMargin: 200
        width: 152 ; height: 41
        text: qsTr("Super Admin")
        font.pixelSize: 20
        verticalAlignment: Text.AlignVCenter
        font.capitalization: Font.AllUppercase
        font.family: "Verdana"
        font.styleName: "Regular"
        font.bold: true
        MouseArea {
            anchors.fill: parent
            onClicked: console.log(window.scale, mainwindow.width)
        }
    }
    Image {
        id: fingerprint
        visible: !switch1.checked
        opacity: 0
        anchors.top: biometric.bottom
        anchors.topMargin: 10
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
        font.family: "Calibri" ; font.styleName: "Regular"
        font.pixelSize: 22
        font.italic: true
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignTop
    }

    // Typed Elements -- Rank, Username & Pin Text box
    Text {
        id: superadmin
        visible: switch1.checked
        anchors.top: parent.top ; anchors.topMargin: 200
        anchors.left: parent.left ;  anchors.leftMargin: biometric.anchors.leftMargin
        anchors.right: parent.right
        height: 41
        text: qsTr("Super Admin")
        font.pixelSize: biometric.font.pixelSize
        verticalAlignment: Text.AlignVCenter
        font.capitalization: Font.AllUppercase
        font.family: "Verdana"
        font.styleName: "Regular"
        font.bold: true
        TextField {
            id: username
            font.family: "Calibri"
            width: username_box.width
            height: username_box.height - 2
            placeholderText: qsTr("Username")
            font.pixelSize: 20
            topPadding: 7
            //leftPadding: 9
            rightPadding: 35
            anchors.verticalCenter: username_box.verticalCenter
            anchors.left: username_box.left
            anchors.right: username_box.right
            anchors.rightMargin: 1
            anchors.leftMargin: 1
            onPressed: { hidekeyboard() ; inputPaneln.showKeyboard = true }
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
            anchors.rightMargin: biometric.anchors.leftMargin
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
        anchors.left: superadmin.left
        anchors.top: parent.top ; anchors.topMargin: 370
        width: 152
        height: 41
        text: qsTr("Pin")
        font.pixelSize: biometric.font.pixelSize
        verticalAlignment: Text.AlignVCenter
        font.capitalization: Font.AllUppercase
        font.family: "Verdana"
        font.styleName: "Regular"
        font.bold: true
        TextField {
            id: password
            font.family: "Calibri"
            echoMode: TextInput.Password
            width: username_box.width
            height: username_box.height - 2
            placeholderText: qsTr("Pin")
            font.pixelSize: username.font.pixelSize
            topPadding: 7
            //leftPadding: 9
            rightPadding: 35
            anchors.verticalCenter: password_box.verticalCenter
            anchors.left: password_box.left
            anchors.right: password_box.right
            anchors.rightMargin: 1
            anchors.leftMargin: 1
            onPressed: inputPaneln.showKeyboard = true
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

    // Keyboards
    InputPanelN {
        id: inputPaneln
        property bool showKeyboard :  false
        y: showKeyboard ? parent.height - height : parent.height
        Behavior on y {
            NumberAnimation {
                duration: 200
                easing.type: Easing.InOutQuad
            }
        }
        anchors.leftMargin: mainwindow.width/10
        anchors.rightMargin: mainwindow.width/10
        anchors.left: parent.left
        anchors.right: parent.right
        Rectangle {
            id: leftblackn
            anchors.right: parent.left ; anchors.top: parent.top ; anchors.bottom: parent.bottom ; width: mainwindow.width/10 ; color: "black"
        }
        Rectangle {
            id: rightblackn
            anchors.left: parent.right ; anchors.top: parent.top ; anchors.bottom: parent.bottom ; width: mainwindow.width/10 ; color: "black"
        }
    }
    InputPanel {
        id: inputPanel
        property bool showKeyboard :  false
        y: showKeyboard ? parent.height - height : parent.height
        Behavior on y {
            NumberAnimation {
                duration: 200
                easing.type: Easing.InOutQuad
            }
        }
        anchors.leftMargin: mainwindow.width/10
        anchors.rightMargin: mainwindow.width/10
        anchors.left: parent.left
        anchors.right: parent.right
        Rectangle {
            id: leftblack
            anchors.right: parent.left ; anchors.top: parent.top ; anchors.bottom: parent.bottom ; width: mainwindow.width/10 ; color: "black"
        }
        Rectangle {
            id: rightblack
            anchors.left: parent.right ; anchors.top: parent.top ; anchors.bottom: parent.bottom ; width: mainwindow.width/10 ; color: "black"
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
        ScriptAction { script: { dialog_small.anchors.bottomMargin = -(dialog_small.height + 20) ; time.width = 10 } }
    }
    function togglecolor() {
        if (settings_box.checked === true) { toggleswitch.color = "darkgreen" ; flicker.anchors.horizontalCenterOffset = (toggleswitch.height / 4) }
        else { toggleswitch.color = "darkred" ; flicker.anchors.horizontalCenterOffset = -(toggleswitch.height / 4) }
    }
    function hidekeyboard() { inputPaneln.showKeyboard = inputPanel.showKeyboard = false }

    // Dialog Box functions
    function displaydialog(functionnum) {
        dialog_timer.running = false ; time.width = 10
        dialog_small.anchors.bottomMargin = 20
        dialog_timer.running = true
        // 1 incorrectDialog
        if (functionnum === 1) { information2.text = qsTr("Invalid Username or Password") }
    }

    // Small Dialog Box Components
    Rectangle {
        id: dialog_small
        visible: true
        color: "#f0f0f0"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: -(height + 20)
        width: 700
        height: (width / 5) - 30
        radius: 15
        Behavior on anchors.bottomMargin { PropertyAnimation { duration: 100 } }
        Text {
            id: information2
            anchors.left: bad_picture2.right
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: center_border2.left
            anchors.leftMargin: 10
            anchors.rightMargin: anchors.leftMargin
            font.family: "Verdana"
            font.styleName: "Regular"
            height: parent.height
            font.pixelSize: 20
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
            anchors.leftMargin: width/2
            anchors.verticalCenter: parent.verticalCenter
            width: 50
            height: width
            sourceSize.width: width + 20
            sourceSize.height: width + 20
            source: "../images/warning.png"
            fillMode: Image.PreserveAspectFit
        }
        Rectangle {
            id: center_border2
            color: "dimgray"
            opacity: 0.7
            width: 2
            anchors.top: parent.top
            anchors.topMargin: 20
            anchors.bottom: parent.bottom
            anchors.bottomMargin: anchors.topMargin
            anchors.right: parent.right
            anchors.rightMargin: 100
        }
        MouseArea {
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.left: center_border2.right
            height: parent.height
            onClicked: { dialog_small.anchors.bottomMargin = -(dialog_small.height + 20) ; time.width = 10 }
            Text {
                id: ok2
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                font.family: "Verdana"
                font.styleName: "Regular"
                width: 152
                height: parent.height
                font.pixelSize: information2.font.pixelSize
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
        function onHidekeyboard() { inputPaneln.showKeyboard = inputPanel.showKeyboard = false }
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
        width: 190
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
            height: 40 - menu.radius
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
                font.pixelSize: 16
                text: qsTr("New Admin")
                leftPadding: 30
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
                font.pixelSize: newadmin.font.pixelSize
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
