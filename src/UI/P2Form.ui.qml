import QtQuick 2.14
import QtQuick.Controls 6.2

Item {
    id: window
    anchors.fill: parent
    property int code: 0
    Rectangle {
        id: time ; width: 10 ; height: 10 ; visible: false
    }

    // Navigation Buttons -- Use Pin, Log in, Use Fingerprint, Back button, register account?
    Rectangle {
        anchors.top: use_pin_button.top ; anchors.topMargin: -0.5 ; visible: use_pin_button.visible
        anchors.left: use_pin_button.left ; anchors.leftMargin: -1
        height: use_pin_button.height + 3.5 ; width: use_pin_button.width + 1.5 ; radius: use_pin_button.radius + 1
        color: "#e0e0e0"
    }
    Rectangle {
        id: use_pin_button
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
        anchors.top: log_in_button.top ; anchors.topMargin: 0.5 ; visible: log_in_button.visible
        anchors.left: log_in_button.left ; anchors.leftMargin: -1
        height: log_in_button.height + 2.5 ; width: log_in_button.width + 1.5 ; radius: log_in_button.radius + 1
        color: "#e0e0e0"
    }
    Rectangle {
        id: log_in_button
        visible: use_fingerprint_button.visible
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
                backend.adminuser([username.text, password.text , "Pin", code]);
            }
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
        font.pixelSize: 15
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
    Image {
        id: back_button
        anchors.left: parent.left
        anchors.leftMargin: 40
        anchors.top: parent.top
        anchors.topMargin: 40
        width: 30
        height: 30
        source: "../images/back.jpg"
        sourceSize.width: 100
        sourceSize.height: 100
        MouseArea {
            anchors.fill: parent
            onClicked: displaybigdialog(2,1)
        }
    }
    Text {
        id: registeraccount_finger
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
            anchors.right: parent.right; anchors.verticalCenter: parent.verticalCenter
            height: parent.height; width: 75
            onClicked: { page_loader.source = "Registersuper.ui.qml" ; backend.menubranch(2) }
        }
    }
    Text {
        id: registeraccount_pin
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
            onClicked: { page_loader.source = "Registersuper.ui.qml" ; backend.menubranch(2) }
        }
    }

    // Biometric Elements -- User Rank, Fingerprint picture, "Place Finger" text
    Text {
        id: biometric
        visible: use_pin_button.visible
        anchors.left: parent.left ; anchors.leftMargin: 60
        anchors.top: parent.top ; anchors.topMargin: 200
        width: 152 ; height: 41
        text: qsTr("Admin")
        font.pixelSize: 19
        verticalAlignment: Text.AlignVCenter
        font.capitalization: Font.AllUppercase
        font.family: "Verdana"
        font.styleName: "Regular"
        font.bold: true
    }
    Image {
        id: fingerprint
        visible: use_pin_button.visible
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
                backend.adminuser(['12', '0012', "Fingerprint", code]);
            }
        }
    }
    Text {
        id: place_finger
        opacity: fingerprint.opacity
        visible: use_pin_button.visible
        x: 297
        width: 262
        height: 50        
        text: qsTr("Place Finger on Scanner")
        anchors.top: fingerprint.bottom
        anchors.topMargin: 10
        font.pixelSize: 18
        font.italic: true
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignTop
        anchors.horizontalCenter: fingerprint.horizontalCenter
    }

    // Menu Button -- Menu Bar
    Image {
        id: menubar
        anchors.right: parent.right
        anchors.rightMargin: 40
        anchors.top: parent.top
        anchors.topMargin: 40
        width: height + 2
        height: 25
        source: "../images/menubutton.png"
        sourceSize.width: 100
        sourceSize.height: 100
        MouseArea {
            id: menuarea
            anchors.fill: parent
            onClicked: { background.visible = menu.visible = true ; menu.scale = 1 ; menuarea.visible = false }
        }
    }

    // Typed Elements -- Rank, Username & Pin Text box
    Text {
        id: admin
        visible: use_fingerprint_button.visible
        height: 41
        anchors.top: parent.top ; anchors.topMargin: 200
        anchors.left: parent.left ;  anchors.leftMargin: 60
        anchors.right: parent.right
        text: qsTr("Admin")
        font.pixelSize: 19
        verticalAlignment: Text.AlignVCenter
        font.capitalization: Font.AllUppercase
        font.family: "Verdana"
        font.styleName: "Regular"
        font.bold: true
        TextField {
            id: username
            height: username_box.height - 2
            anchors.verticalCenter: username_box.verticalCenter
            anchors.left: username_box.left
            anchors.right: username_box.right
            anchors.rightMargin: 1
            anchors.leftMargin: 1
            baselineOffset: 15
            font.pointSize: 12
            topPadding: 7
            //leftPadding: 9
            rightPadding: 35
            placeholderText: qsTr("Username")
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
        anchors.left: parent.left ; anchors.leftMargin: 60
        anchors.top: parent.top ; anchors.topMargin: 370
        width: 152
        height: 41
        visible: use_fingerprint_button.visible
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
            height: username_box.height - 2
            anchors.verticalCenter: password_box.verticalCenter
            anchors.left: password_box.left
            anchors.right: password_box.right
            anchors.rightMargin: 1
            anchors.leftMargin: 1
            baselineOffset: 15
            font.pointSize: 12
            topPadding: 7
            //leftPadding: 9
            rightPadding: 35
            placeholderText: qsTr("Pin")
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
    function displaybigdialog(buttonnum, functionnum) {
        if (buttonnum === 0) { dialog_big.visible = true ; button_number.checked = false ; good_picture.visible = false ; box.radius = 5 }
        if (buttonnum === 1) { dialog_big.visible = true ; button_number.checked = true }
        if (buttonnum === 2) { dialog_big.visible = true ; button_number.checked = true ; good_picture.visible = false ; box.radius = 10 }
        function closebigdialog() { dialog_big.visible = false }
        // 1 logoutDialog
        if (functionnum === 1) {
            information.text = qsTr("Going Back Will Logout the Super Admin. Do You Want to Continue?")
            header.text = qsTr("Logout")
            right_button.clicked.connect(closebigdialog)
        }
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

    // Big Dialog Box Components
    Item {
        id: dialog_big
        anchors.fill: parent
        visible: false
        Rectangle {
            id: shadow
            color: "dimgray"
            anchors.fill: parent
            radius: 8
            opacity: 0.4
            MouseArea {
                anchors.fill: parent
                onClicked: dialog_big.visible = false
            }
        }
        Rectangle {
            id: box
            color: "white"
            anchors.centerIn: parent
            width: 400
            height: 200
            radius: 10
            Text {
                id: header
                anchors.top: parent.top
                anchors.topMargin: 15
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.leftMargin: 20
                height: 40
                font.family: "Verdana"
                font.styleName: "Regular"
                width: parent.width - 40
                font.pixelSize: 17
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                color: "black"
                font.capitalization: Font.Capitalize
                font.bold: true
                text: qsTr("Dialog Header")
            }
            Text {
                id: information
                anchors.top: good_picture.bottom
                anchors.topMargin: 20
                anchors.left: parent.left
                anchors.leftMargin: 20
                anchors.bottom: b1.top
                font.family: "Verdana"
                font.styleName: "Regular"
                width: parent.width - 40
                font.pixelSize: 14
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignTop
                color: "black"
                wrapMode: Text.WordWrap
                /*fontSizeMode: Text.Fit*/
                font.capitalization: Font.Capitalize
                text: qsTr("Dialog Information")
            }
            Image {
                id: good_picture
                visible: true
                anchors.top: parent.top
                anchors.topMargin: 15
                anchors.left: parent.left
                anchors.leftMargin: 18
                width: 35
                height: width
                sourceSize.width: 50
                sourceSize.height: 50
                source: "../images/check.png"
                fillMode: Image.PreserveAspectFit
            }
            Rectangle {
                anchors.top: b1.top ; anchors.topMargin: 0.5 ; visible: b1.visible
                anchors.left: b1.left ; anchors.leftMargin: -1
                height: b1.height + 2.5 ; width: b1.width + 1.5 ; radius: b1.radius + 1
                color: "#e0e0e0"
            }
            Rectangle {
                id: b1
                visible: button_number.checked
                height: 43
                width: 140
                color: "black"
                radius: 8
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 20
                anchors.left: parent.left
                anchors.leftMargin: 30
                Text {
                    id: yes
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    font.family: "Verdana"
                    font.styleName: "Regular"
                    width: 152
                    height: parent.height
                    font.pixelSize: 16
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    color: "white"
                    text: qsTr("Yes")
                    font.bold: true
                }
            }
            MouseArea {
                id: left_button
                visible: button_number.checked
                anchors.fill: b1
                hoverEnabled: true
                onEntered: { b1.color = "#a0a0a0" }
                onExited: { b1.color = "black" }
                onClicked: { page_loader.source = 'P1Form.ui.qml'; backend.superadminlogout(0) }
            }
            Rectangle {
                anchors.top: b2.top ; anchors.topMargin: 0.5 ; visible: b2.visible
                anchors.left: b2.left ; anchors.leftMargin: -1
                height: b2.height + 2.5 ; width: b2.width + 1.5 ; radius: b2.radius + 1
                color: "#e0e0e0"
            }
            Rectangle {
                id: b2
                visible: button_number.checked
                height: b1.height
                width: b1.width
                color: "white"
                radius: b1.radius
                anchors.bottom: parent.bottom
                anchors.bottomMargin: b1.anchors.bottomMargin
                anchors.right: parent.right
                anchors.rightMargin: b1.anchors.leftMargin
            }
            MouseArea {
                id: right_button
                visible: button_number.checked
                anchors.fill: b2
                hoverEnabled: true
                onEntered: { no.color = "#a0a0a0" }
                onExited: { no.color = "black" }
                onClicked: dialog_big.visible = false
                Text {
                    id: no
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    font.family: "Verdana"
                    font.styleName: "Regular"
                    width: 152
                    height: parent.height
                    font.pixelSize: 16
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    color: "black"
                    text: qsTr("No")
                    font.bold: true
                }
            }
        }
        Switch {
            id: button_number
            visible: false
            checked: true
        }
    }

    Connections {
        target: backend

        function onIncorrect(number) {
            if (number === 1) { displaydialog(1) }
        }
    }

    // Menu Bar Component contd -- Background
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
    // Menu Bar Items Components -- First, Second, Third; Menu 21, Menu 22
    Rectangle {
        id: menu
        visible: false
        color: "#f8f8f8"
        anchors.right: menubar.right
        anchors.top: menubar.bottom
        anchors.topMargin: 10
        width: 150
        height: menu.radius + first_menu.height + second_menu.height + menu.radius
        radius: 5
        scale: 0
        transformOrigin: Item.TopRight
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
                onClicked: { page_loader.source = "Registersuper.ui.qml" ; backend.menubranch(2) }
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
                onClicked: { page_loader.source = "Removesuper.ui.qml"; backend.menubranch(2) }
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
