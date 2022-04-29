import QtQuick 2.14
import QtQuick.Controls 2.5

Item {
    id: window

    // Stack View Transition Properties
    StackView {
        id: stack
        anchors.fill: parent
        initialItem: features
        popEnter: Transition {
            PropertyAnimation {
                property: "scale"
                to: 1
                duration: 200
                easing.type: Easing.InQuart
            }
        }
        popExit: Transition {
            PropertyAnimation {
                property: "scale"
                to: 0
                duration: 200
                easing.type: Easing.OutQuart
            }
        }
        pushEnter: Transition {
            PropertyAnimation {
                property: "scale"
                to: 1
                duration: 200
                easing.type: Easing.InQuart
            }
        }
        pushExit: Transition {
            PropertyAnimation {
                property: "scale"
                to: 0
                duration: 200
                easing.type: Easing.OutQuart
            }
        }
        replaceEnter: Transition {
            PropertyAnimation {
                property: "scale"
                to: 1
                duration: 200
                easing.type: Easing.InQuart
            }
        }
        replaceExit: Transition {
            PropertyAnimation {
                property: "scale"
                to: 0
                duration: 200
                easing.type: Easing.OutQuart
            }
        }
    }

    // Body of Code -- Features components
    FocusScope {
        id: features
        // Features elements -- Purchase, Transfer, Deposit, Register
        Rectangle {
            id: greybackground
            anchors.top: parent.top ; anchors.topMargin: 150
            width: parent.width ; anchors.bottom: parent.bottom
            color: "#f8f8f8"
            Rectangle { anchors.bottom: greybackground.top ; width: parent.width ; height: 1.5 ; color: "darkgray" }
        }

        Rectangle {
            id: grid_1_1_purchase
            anchors.left: parent.left
            anchors.leftMargin: 80
            anchors.top: greybackground.top
            anchors.topMargin: 80
            width: 400
            height: 200
            radius: 4
            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                onClicked: { stack.push("P4Form.ui.qml"); backend.feature("Purchase") }
                onEntered: { greenslip.width = parent.radius * 2 ; edit1.scale = 1.15 }
                onExited: { greenslip.width = 0 ; edit1.scale = 1 }
            }

            Rectangle {
                id: greenslip
                anchors.top: parent.top ; height: parent.height ; width: 0
                anchors.left: parent.left; radius: parent.radius ; color: "purple"
                Behavior on width { PropertyAnimation { duration: 100 } }
            }
            Rectangle {
                anchors.top: greenslip.top ; anchors.bottom: greenslip.bottom; anchors.right: greenslip.right
                anchors.rightMargin: -1 ; width: greenslip.radius ; color: "white"
            }
            Image {
                anchors.top: parent.top
                anchors.topMargin: 30
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.horizontalCenterOffset: -6
                width: 100
                height: width
                sourceSize.height: 100
                sourceSize.width: 100
                source: "../images/pur.png"
                fillMode: Image.PreserveAspectFit
                scale: edit1.scale
            }
            Text {
                id: edit1
                width: 160
                height: 41
                text: qsTr("Purchase")
                font.pixelSize: 18
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 25
                font.capitalization: Font.AllUppercase
                font.family: "Verdana"
                font.styleName: "Regular"
                font.bold: true
                Behavior on scale { PropertyAnimation { duration: 100 } }
            }
        }

        Rectangle {
            id: grid_1_2_transfer
            anchors.right: parent.right
            anchors.rightMargin: grid_1_1_purchase.anchors.leftMargin
            anchors.top: grid_1_1_purchase.top
            width: grid_1_1_purchase.width
            height: grid_1_1_purchase.height
            radius: 4
            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                onClicked: { stack.push("P4Form.ui.qml"); backend.feature("Transfer") }
                onEntered: { slip2.width = parent.radius * 2 ; edit2.scale = 1.15 }
                onExited: { slip2.width = 0 ; edit2.scale = 1 }
            }

            Rectangle {
                id: slip2
                anchors.top: parent.top ; height: parent.height ; width: 0
                anchors.left: parent.left; radius: parent.radius ; color: "purple"
                Behavior on width { PropertyAnimation { duration: 100 } }
            }
            Rectangle {
                anchors.top: slip2.top ; anchors.bottom: slip2.bottom; anchors.right: slip2.right
                anchors.rightMargin: -1 ; width: slip2.radius ; color: "white"
            }
            Image {
                anchors.top: parent.top
                anchors.topMargin: 30
                anchors.horizontalCenter: parent.horizontalCenter
                width: 100
                height: width
                sourceSize.height: 100
                sourceSize.width: 100
                source: "../images/trans.png"
                fillMode: Image.PreserveAspectFit
                scale: edit2.scale
            }
            Text {
                id: edit2
                width: 160
                height: 41
                text: qsTr("Transfer")
                font.pixelSize: 18
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 25
                font.capitalization: Font.AllUppercase
                font.family: "Verdana"
                font.styleName: "Regular"
                font.bold: true
                Behavior on scale { PropertyAnimation { duration: 100 } }
            }
        }

        Rectangle {
            id: grid_2_1_deposit
            anchors.left: grid_1_1_purchase.left
            anchors.top: grid_1_1_purchase.bottom
            anchors.topMargin: 50
            width: grid_1_1_purchase.width
            height: grid_1_1_purchase.height
            radius: 4
            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                onClicked: { stack.push("P4Form.ui.qml"); backend.feature("Deposit") }
                onEntered: { slip3.width = parent.radius * 2 ; edit3.scale = 1.15 }
                onExited: { slip3.width = 0 ; edit3.scale = 1 }
            }

            Rectangle {
                id: slip3
                anchors.top: parent.top ; height: parent.height ; width: 0
                anchors.left: parent.left; radius: parent.radius ; color: "purple"
                Behavior on width { PropertyAnimation { duration: 100 } }
            }
            Rectangle {
                anchors.top: slip3.top ; anchors.bottom: slip3.bottom; anchors.right: slip3.right
                anchors.rightMargin: -1 ; width: slip3.radius ; color: "white"
            }
            Image {
                anchors.top: parent.top
                anchors.topMargin: 30
                anchors.horizontalCenter: parent.horizontalCenter
                source: "../images/deposit.png"
                width: 100
                height: width
                sourceSize.width: 100
                sourceSize.height: 100
                fillMode: Image.PreserveAspectFit
                scale: edit3.scale
            }
            Text {
                id: edit3
                width: 160
                height: 41
                text: qsTr("Deposit")
                font.pixelSize: 18
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 25
                font.capitalization: Font.AllUppercase
                font.family: "Verdana"
                font.styleName: "Regular"
                font.bold: true
                Behavior on scale { PropertyAnimation { duration: 100 } }
            }
        }

        Rectangle {
            id: grid_2_2_register
            anchors.right: grid_1_2_transfer.right
            anchors.top: grid_2_1_deposit.top
            width: grid_1_1_purchase.width
            height: grid_1_1_purchase.height
            radius: 4
            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                onClicked: { stack.push("Register.ui.qml"); backend.feature("Register") }
                onEntered: { slip4.width = parent.radius * 2 ; edit4.scale = 1.15 }
                onExited: { slip4.width = 0 ; edit4.scale = 1 }
            }

            Rectangle {
                id: slip4
                anchors.top: parent.top ; height: parent.height ; width: 0
                anchors.left: parent.left; radius: parent.radius ; color: "purple"
                Behavior on width { PropertyAnimation { duration: 100 } }
            }
            Rectangle {
                anchors.top: slip4.top ; anchors.bottom: slip4.bottom; anchors.right: slip4.right
                anchors.rightMargin: -1 ; width: slip4.radius ; color: "white"
            }
            Image {
                anchors.top: parent.top
                anchors.topMargin: 30
                anchors.horizontalCenter: parent.horizontalCenter
                width: 100
                height: width
                sourceSize.height: 100
                sourceSize.width: 100
                source: "../images/reg.png"
                fillMode: Image.PreserveAspectFit
                scale: edit4.scale
            }
            Text {
                id: edit4
                width: 160
                height: 41
                text: qsTr("Register")
                font.pixelSize: 18
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 25
                font.capitalization: Font.AllUppercase
                font.family: "Verdana"
                font.styleName: "Regular"
                font.bold: true
                Behavior on scale { PropertyAnimation { duration: 100 } }
            }
        }

        // "Redirect to Log In" Information
        Text {
            id: redirect
            y: 160
            width: 160
            height: 41
            text: qsTr("Tapping a feature will redirect you to the Login Page")
            font.pixelSize: 16
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            anchors.horizontalCenter: parent.horizontalCenter
            font.capitalization: Font.Capitalize
            font.family: "Verdana"
            font.styleName: "Regular"
            font.italic: true
        }

        // Menu Button -- Background, Menu picture
        Rectangle {
            id: background
            anchors.fill: parent
            color: "dimgray"
            opacity: 0.5
            visible: false
            MouseArea {
                anchors.fill: parent
                onClicked: { menu.scale = 0 ; background.visible = menu.visible = false ; menu21.visible = false ; menuarea.visible = true }
            }
        }
        Image {
            anchors.left: parent.left
            anchors.leftMargin: 40
            anchors.top: parent.top
            anchors.topMargin: 40
            source: '../images/menubutton.png'
            height: 25
            width: height + 2
            id: menubar
            MouseArea {
                id: menuarea
                anchors.fill: parent
                onClicked: { background.visible = menu.visible = true ; menu.scale = 1 ; menuarea.visible = false }
            }
        }

        // Menu Bar Item Components -- First, Second, Third; Menu 21, Menu 22
        Rectangle {
            id: menu
            color: "#f8f8f8"
            visible: false
            anchors.left: menubar.left
            anchors.top: menubar.bottom
            anchors.topMargin: 10
            width: 230
            height: menu.radius + first_menu.height + second_menu.height + third_menu.height + menu.radius
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
                    onClicked: menu21.visible = !menu21.visible
                }
                Text {
                    id: manage
                    anchors.verticalCenter: first_menu.verticalCenter
                    anchors.left: parent.left
                    verticalAlignment: Text.AlignVCenter
                    height: 30
                    font.family: "Verdana"
                    width: parent.width
                    font.pixelSize: 16
                    text: qsTr("Manage Admins")
                    leftPadding: 30
                }
                Image {
                    anchors.verticalCenter: first_menu.verticalCenter
                    anchors.right: parent.right
                    anchors.rightMargin: 15
                    source: '../images/right.png'
                    height: 10
                    width: height + 2
                    sourceSize.width: 30
                    sourceSize.height: 30
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
                color: third_menu.color
            }
            Rectangle {
                id: second_menu
                anchors.left: parent.left
                anchors.top: first_menu.bottom
                anchors.right: parent.right
                height: 40
                color: menu.color
                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered: second_menu.color = "#e8e8e8"
                    onExited: second_menu.color = menu.color
                    onClicked: displaybigdialog(2,1)
                }
                Text {
                    id: logout
                    anchors.left: parent.left
                    anchors.verticalCenter: second_menu.verticalCenter
                    verticalAlignment: Text.AlignVCenter
                    height: 30
                    font.family: "Verdana"
                    width: parent.width
                    font.pixelSize: manage.font.pixelSize
                    text: qsTr("Logout Admin")
                    leftPadding: manage.leftPadding
                }
            }
            Rectangle {
                id: third_menu
                anchors.left: parent.left
                anchors.top: second_menu.bottom
                anchors.right: parent.right
                height: first_menu.height
                color: menu.color
                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered: third_menu.color = "#e8e8e8"
                    onExited: third_menu.color = menu.color
                    onClicked: displaybigdialog(2,2)
                }
                Text {
                    id: logout_super
                    anchors.verticalCenter: third_menu.verticalCenter
                    anchors.left: parent.left
                    verticalAlignment: Text.AlignVCenter
                    height: 30
                    font.family: "Verdana"
                    width: parent.width
                    font.pixelSize: manage.font.pixelSize
                    text: qsTr("Logout Super Admin")
                    leftPadding: manage.leftPadding
                }
            }
            Rectangle {
                id: menu21
                visible: false
                anchors.left: first_menu.right
                anchors.top: first_menu.top
                height: 40
                width: 180
                color: menu.color
                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered: menu21.color = "#e8e8e8"
                    onExited: menu21.color = menu.color
                    onClicked: { page_loader.source = "Registersuper.ui.qml" ; backend.menubranch(3) }
                }
                Text {
                    id: reg_admin
                    anchors.verticalCenter: menu21.verticalCenter
                    anchors.left: parent.left
                    verticalAlignment: Text.AlignVCenter
                    height: 30
                    width: parent.width
                    font.family: "Verdana"
                    font.pixelSize: 16
                    text: qsTr("Register Admin")
                    leftPadding: 25
                }
            }
            Rectangle {
                id: menu22
                visible: menu21.visible
                anchors.left: menu21.left
                anchors.top: menu21.bottom
                height: menu21.height
                width: menu21.width
                color: menu.color
                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered: menu22.color = "#e8e8e8"
                    onExited: menu22.color = menu.color
                    onClicked: { page_loader.source = "Removesuper.ui.qml" ; backend.menubranch(3) }
                }
                Text {
                    anchors.left: parent.left
                    anchors.verticalCenter: menu22.verticalCenter
                    verticalAlignment: Text.AlignVCenter
                    height: 30
                    font.family: "Verdana"
                    width: parent.width
                    font.pixelSize: reg_admin.font.pixelSize
                    text: qsTr("Remove Admin")
                    leftPadding: reg_admin.leftPadding
                }
            }
            Rectangle {
                visible: menu21.visible
                anchors.top: menu21.top
                anchors.bottom: menu22.bottom
                anchors.right: menu22.right
                anchors.left: menu21.left
                border.width: 1
                color: "transparent"
                border.color: "darkgray"
            }
        }
    }

    // Dialog Box functions
    function closebigdialog() { dialog_big.visible = false ; f1_switch.checked = f2_switch.checked = false }

    function displaybigdialog(buttonnum, functionnum) {
        if (buttonnum === 0) { dialog_big.visible = true ; button_number.checked = false ; good_picture.visible = false ; box.radius = 5 }
        if (buttonnum === 1) { dialog_big.visible = true ; button_number.checked = true }
        if (buttonnum === 2) { dialog_big.visible = true ; button_number.checked = true ; good_picture.visible = false ; box.radius = 10 }

        // 1 adminlogoutDialog
        if (functionnum === 1) {
            information.text = qsTr("You Are About To Logout Admin. Do You Want To Continue?")
            header.text = qsTr("Logout")
            f1_switch.checked = true
            right_button.clicked.connect(closebigdialog)
        }
        // 2 superadminlogoutDialog
        if (functionnum === 2) {
            information.text = qsTr("Logging out Super Admin also logs out current Admin. Do You Want To Continue?")
            header.text = qsTr("Logout")
            f2_switch.checked = true
            right_button.clicked.connect(closebigdialog)
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
                onClicked: closebigdialog()
            }
        }
        Rectangle {
            id: box
            color: "white"
            anchors.centerIn: parent
            width: 700
            height: width / 2
            radius: 10
            Text {
                id: header
                anchors.top: parent.top
                anchors.topMargin: 30
                anchors.horizontalCenter: parent.horizontalCenter
                height: 40
                font.family: "Verdana"
                font.styleName: "Regular"
                width: parent.width - 40
                font.pixelSize: 24
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                color: "black"
                font.capitalization: Font.Capitalize
                font.bold: true
                text: qsTr("Dialog Header")
            }
            Text {
                id: information
                anchors.top: header.bottom
                anchors.topMargin: header.anchors.topMargin // 30
                anchors.left: parent.left
                anchors.leftMargin: anchors.topMargin
                anchors.right: parent.right
                anchors.rightMargin: anchors.leftMargin
                anchors.bottom: b1.top
                font.family: "Verdana"
                font.styleName: "Regular"
                font.pixelSize: 21
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
                anchors.topMargin: 20
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
                height: 50
                width: 170
                color: "black"
                radius: 8
                anchors.bottom: parent.bottom
                anchors.bottomMargin: header.anchors.topMargin + 20 // 50
                anchors.left: parent.left
                anchors.leftMargin: anchors.bottomMargin * 2 // 60
                Text {
                    id: yes
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    font.family: "Verdana"
                    font.styleName: "Regular"
                    width: 152
                    height: parent.height
                    font.pixelSize: 22
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    color: "white"
                    text: qsTr("Yes")
                    font.bold: true
                }
            }
            MouseArea {
                id: left_f1
                visible: button_number.checked & f1_switch.checked
                anchors.fill: b1
                hoverEnabled: true
                onEntered: { b1.color = "#a0a0a0" }
                onExited: { b1.color = "black" }
                onClicked: { backend.adminlogout() ; page_loader.source = "P2Form.ui.qml"}
            }
            MouseArea {
                id: left_f2
                visible: button_number.checked & f2_switch.checked
                anchors.fill: b1
                hoverEnabled: true
                onEntered: { b1.color = "#a0a0a0" }
                onExited: { b1.color = "black" }
                onClicked: { backend.superadminlogout(1) ; page_loader.source = "P1Form.ui.qml"}
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
                    font.pixelSize: 15
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    color: "black"
                    text: qsTr("No")
                    font.bold: true
                }
            }
        }

        // Switches for Logic -- button number, first left button, second left button
        Switch {
            id: button_number
            visible: false
            checked: true
        }
        Switch {
            id: f1_switch
            visible: false
            checked: false
        }
        Switch {
            id: f2_switch
            visible: false
            checked: false
        }
    }
}
