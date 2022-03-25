import QtQuick 2.14
import QtQuick.Controls 6.2
import Qt.labs.platform 1.1

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

        // Features elements -- Purchase, Transfer, Register
        FocusScope {
            id: focusScope
            anchors.horizontalCenter: parent.horizontalCenter
            y: 501
            width: 491
            height: 160
            scale: 0.85

            Image {
                id: purc
                anchors.right: tran.left
                anchors.rightMargin: 60
                y: 5
                width: 100
                height: 100
                source: "../images/pur.png"
                fillMode: Image.PreserveAspectFit

                Behavior on scale { PropertyAnimation { duration: 100 } }
                Text {
                    id: pur
                    y: 120
                    width: 152
                    height: 41
                    text: qsTr("Purchase")
                    font.pixelSize: 20
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    anchors.horizontalCenter: purc.horizontalCenter
                    fontSizeMode: Text.Fit
                    font.capitalization: Font.AllUppercase
                    font.family: "Verdana"
                    font.styleName: "Regular"
                    font.bold: true
                }
                MouseArea {
                    id: mouse_pur
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: -45
                    anchors.rightMargin: -10
                    anchors.leftMargin: -10
                    anchors.topMargin: 0
                    hoverEnabled: true
                    onClicked: { stack.push("P4Form.ui.qml"); backend.feature(pur.text) }
                    onEntered: purc.scale = 1.2
                    onExited: purc.scale = 1
                }
            }

            Image {
                id: tran
                anchors.horizontalCenter: parent.horizontalCenter
                y: 5
                width: 100
                height: 100
                source: "../images/trans.png"
                fillMode: Image.PreserveAspectFit

                Behavior on scale { PropertyAnimation { duration: 100 } }
                Text {
                    id: trans
                    y: 120
                    width: 152
                    height: 41
                    text: qsTr("Transfer")
                    font.pixelSize: 20
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    wrapMode: Text.NoWrap
                    anchors.horizontalCenter: parent.horizontalCenter
                    fontSizeMode: Text.Fit
                    font.capitalization: Font.AllUppercase
                    font.family: "Verdana"
                    font.styleName: "Regular"
                    font.bold: true
                }
                MouseArea {
                    id: mouse_tran
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: trans.bottom
                    anchors.bottomMargin: 0
                    anchors.rightMargin: -10
                    anchors.leftMargin: -10
                    anchors.topMargin: 0
                    hoverEnabled: true
                    onClicked: { stack.push("P4Form.ui.qml"); backend.feature(trans.text) }
                    onEntered: tran.scale = 1.2
                    onExited: tran.scale = 1
                }
            }

            Image {
                id: regi
                anchors.left: tran.right
                anchors.leftMargin: purc.anchors.rightMargin
                y: 5
                width: 100
                height: 100
                source: "../images/reg.png"
                fillMode: Image.PreserveAspectFit
                Behavior on scale { PropertyAnimation { duration: 100 } }
                Text {
                    id: reg
                    y: 120
                    width: 152
                    height: 41
                    text: qsTr("Register")
                    font.pixelSize: 20
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    wrapMode: Text.NoWrap
                    anchors.horizontalCenter: parent.horizontalCenter
                    fontSizeMode: Text.Fit
                    font.capitalization: Font.AllUppercase
                    font.family: "Verdana"
                    font.styleName: "Regular"
                    font.bold: true
                }
                MouseArea {
                    id: mouse_reg
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: reg.bottom
                    anchors.bottomMargin: 0
                    anchors.rightMargin: -10
                    anchors.leftMargin: -10
                    anchors.topMargin: 0
                    hoverEnabled: true
                    onClicked: { stack.push("Register.ui.qml"); backend.feature(reg.text) }
                    onEntered: regi.scale = 1.2
                    onExited: regi.scale = 1
                }
            }
        }

        // "Redirect to Log In" Information
        Text {
            id: redirect
            y: 170
            width: 160
            height: 41
            text: qsTr("Tapping a feature will redirect you to the Login Page")
            font.pixelSize: 14
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
                onClicked: { menu.scale = 0 ; background.visible = false ; menu21.visible = false ; menuarea.visible = true }
            }
        }
        Image {
            anchors.left: parent.left
            anchors.leftMargin: 40
            anchors.top: parent.top
            anchors.topMargin: 80
            source: '../images/menubutton.png'
            height: 25
            width: height + 2
            id: menubar
            MouseArea {
                id: menuarea
                anchors.fill: parent
                onClicked: { background.visible = true ; menu.scale = 1 ; menuarea.visible = false }
            }
        }

        // Menu Bar Item Components -- First, Second, Third; Menu 21, Menu 22
        Rectangle {
            id: menu
            color: "#f8f8f8"
            anchors.left: menubar.left
            anchors.top: menubar.top
            anchors.topMargin: 35
            width: 200
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
                height: 35 - menu.radius
                color: menu.color
                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered: first_menu.color = "#e8e8e8"
                    onExited: first_menu.color = menu.color
                    onClicked: menu21.visible = !menu21.visible
                }
                Text {
                    id: logout
                    anchors.verticalCenter: first_menu.verticalCenter
                    anchors.left: parent.left
                    verticalAlignment: Text.AlignVCenter
                    height: 30
                    font.family: "Verdana"
                    width: parent.width
                    font.pixelSize: 14
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
                height: 35
                color: menu.color
                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered: second_menu.color = "#e8e8e8"
                    onExited: second_menu.color = menu.color
                    onClicked: displaybigdialog(2,1)
                }
                Text {
                    id: new_user
                    anchors.left: parent.left
                    anchors.verticalCenter: second_menu.verticalCenter
                    verticalAlignment: Text.AlignVCenter
                    height: 30
                    font.family: "Verdana"
                    width: parent.width
                    font.pixelSize: 14
                    text: qsTr("Logout Admin")
                    leftPadding: logout.leftPadding
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
                    id: remove_user
                    anchors.verticalCenter: third_menu.verticalCenter
                    anchors.left: parent.left
                    verticalAlignment: Text.AlignVCenter
                    height: 30
                    font.family: "Verdana"
                    width: parent.width
                    font.pixelSize: 14
                    text: qsTr("Logout Super Admin")
                    leftPadding: logout.leftPadding
                }
            }
            Rectangle {
                id: menu21
                visible: false
                anchors.left: first_menu.right
                anchors.top: first_menu.top
                height: 30
                width: 150
                color: menu.color
                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered: menu21.color = "#e8e8e8"
                    onExited: menu21.color = menu.color
                    onClicked: { page_loader.source = "Registersuper.ui.qml" ; backend.menubranch(3) }
                }
                Text {
                    anchors.verticalCenter: menu21.verticalCenter
                    anchors.left: parent.left
                    verticalAlignment: Text.AlignVCenter
                    height: 30
                    width: parent.width
                    font.family: "Verdana"
                    font.pixelSize: 13
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
                    font.pixelSize: 13
                    text: qsTr("Remove Admin")
                    leftPadding: 25
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
        if (buttonnum === 0) { dialog_big.visible = true ; button_number.checked = false ; good_picture.visible = true }
        if (buttonnum === 1) { dialog_big.visible = true ; button_number.checked = true }
        if (buttonnum === 2) { dialog_big.visible = true ; button_number.checked = true ; good_picture.visible = false }

        // 1 adminlogoutDialog
        if (functionnum === 1) {
            information.text = qsTr("You Are About To Logout Admin. Do You Want To Continue?")
            f1_switch.checked = true
            right_button.clicked.connect(closebigdialog)
        }
        // 2 superadminlogoutDialog
        if (functionnum === 2) {
            information.text = qsTr("Logging out Super Admin also logs out current Admin. Do You Want To Continue?")
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
            width: 400
            height: 200
            radius: 10
            Text {
                id: information
                anchors.top: good_picture.bottom
                anchors.topMargin: 20
                anchors.left: parent.left
                anchors.leftMargin: 20
                anchors.bottom: center_border.top
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
                anchors.horizontalCenter: parent.horizontalCenter
                width: 30
                height: width
                sourceSize.width: 50
                sourceSize.height: 50
                source: "../images/check.png"
                fillMode: Image.PreserveAspectFit
            }
            Rectangle {
                id: top_border
                color: "dimgray"
                opacity: 0.7
                height: 1
                width: box.width * 4 / 5
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 50
                anchors.horizontalCenter: parent.horizontalCenter
            }
            Rectangle {
                id: center_border
                visible: button_number.checked
                color: "dimgray"
                opacity: 0.7
                width: 1
                anchors.top: top_border.bottom
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 5
                anchors.horizontalCenter: parent.horizontalCenter
            }
            /*Rectangle {
                id: b1
                height: 40
                width: 140
                color: "#f0f0f0"
                radius: 3
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 20
                anchors.left: parent.left
                anchors.leftMargin: 30
                MouseArea {
                    anchors.fill: parent
                    onClicked: { top_border.visible = !top_border.visible ; center_border.visible = !center_border.visible ; ok.visible = !ok.visible ; no.visible = !no.visible ; left_f1.visible = false}
                }
            }
            Rectangle {
                height: b1.height
                width: b1.width
                color: b1.color
                radius: b1.radius
                anchors.bottom: parent.bottom
                anchors.bottomMargin: b1.anchors.bottomMargin
                anchors.right: parent.right
                anchors.rightMargin: b1.anchors.leftMargin
            }*/
            Item {
                visible: button_number.checked
                anchors.top: top_border.bottom
                anchors.right: center_border.left
                anchors.left: parent.left
                anchors.bottom: parent.bottom
                Text {
                    id: yes
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
                    text: qsTr("Yes")
                }
            }
            MouseArea {
                id: left_f1
                visible: button_number.checked & f1_switch.checked
                anchors.top: top_border.bottom
                anchors.right: center_border.left
                anchors.left: parent.left
                anchors.bottom: parent.bottom
                hoverEnabled: true
                onEntered: { yes.font.pixelSize = 16 ; yes.font.bold = true }
                onExited: { yes.font.pixelSize = 15 ; yes.font.bold = false }
                onClicked: { backend.adminlogout() ; page_loader.source = "P2Form.ui.qml"}
            }
            MouseArea {
                id: left_f2
                visible: button_number.checked & f2_switch.checked
                anchors.top: top_border.bottom
                anchors.right: center_border.left
                anchors.left: parent.left
                anchors.bottom: parent.bottom
                hoverEnabled: true
                onEntered: { yes.font.pixelSize = 16 ; yes.font.bold = true }
                onExited: { yes.font.pixelSize = 15 ; yes.font.bold = false }
                onClicked: { backend.superadminlogout(1) ; page_loader.source = "P1Form.ui.qml"}
            }
            MouseArea {
                id: right_button
                visible: button_number.checked
                anchors.top: top_border.bottom
                anchors.left: center_border.right
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                hoverEnabled: true
                onEntered: { no.font.pixelSize = 16 ; no.font.bold = true }
                onExited: { no.font.pixelSize = 15 ; no.font.bold = false }
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
