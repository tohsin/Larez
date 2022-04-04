import QtQuick 2.14
import QtQuick.Controls 6.2

Item {
    id: window
    anchors.fill: parent
    Rectangle { anchors.top: parent.top ; width: parent.width ; height: 10 }
    Rectangle { id: topbar ; anchors.top: parent.top ; width: parent.width - 90 ; height: 96 }    
    Rectangle { anchors.top: topbar.bottom ; width: parent.width ; height: 1.5 ; color: "darkgray" }

    Rectangle {
        id: time ; width: 10 ; height: 10 ; visible: false
    }

    // Navigation buttons -- logout, continue
    Rectangle {
        anchors.top: logout_button.top ; anchors.topMargin: 0.5 ; visible: logout_button.visible
        anchors.left: logout_button.left ; anchors.leftMargin: -1
        height: logout_button.height + 2.5 ; width: logout_button.width + 1.5 ; radius: logout_button.radius + 1
        color: "#e0e0e0"
    }
    Rectangle {
        id: logout_button
        radius: 8
        width: 115
        height: 40
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 100
        anchors.left: parent.left
        anchors.leftMargin: 60
        Text {
            width: 150
            height: 40
            text: qsTr("Log Out")
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
            onClicked: { revert() ; backend.adminlogout() ; page_loader.source = "P2Form.ui.qml" }
        }
    }
    Rectangle {
        anchors.top: continue_button.top ; anchors.topMargin: 0.5 ; visible: continue_button.visible
        anchors.left: continue_button.left ; anchors.leftMargin: -1
        height: continue_button.height + 2.5 ; width: continue_button.width + 1.5 ; radius: continue_button.radius + 1
        color: "#e0e0e0"
    }
    Rectangle {
        id: continue_button
        width: 115
        height: 40
        anchors.bottom: logout_button.bottom
        anchors.right: parent.right
        anchors.rightMargin: 60
        color: "black"
        radius: 8
        Text {
            width: 150
            height: 40
            color: "white"
            text: qsTr("Continue")
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
            onClicked: { revert() ; page_loader.source = 'P3Form.ui.qml' }
        }
    }

    // Admin Features
    Rectangle {
        id: level1
        anchors.left: parent.left
        anchors.leftMargin: 20
        anchors.top: topbar.bottom
        anchors.topMargin: 80
        width: 190
        height: width //+ 30
        radius: 4
        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            //onClicked: { page_loader.source = "" }
            onClicked: displaydialog(1)
            onEntered: { greenslip.width = level1.radius * 2 ; edit1.scale = 1.1 }
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
            anchors.topMargin: 35
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.horizontalCenterOffset: 10
            width: 60
            height: width
            sourceSize.height: 60
            sourceSize.width: 60
            source: "../images/edit.png"
            fillMode: Image.PreserveAspectFit
            scale: edit1.scale
        }
        Text {
            id: edit1
            width: 160
            height: 41
            text: qsTr("Edit Your Profile")
            font.pixelSize: 15
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 35
            font.capitalization: Font.Capitalize
            font.family: "Verdana"
            font.styleName: "Regular"
            font.bold: true
            Behavior on scale { PropertyAnimation { duration: 100 } }
        }
    }
    Rectangle {
        anchors.right: parent.right
        anchors.rightMargin: 20
        anchors.top: level1.top
        width: 190
        height: width //+ 30
        radius: 4
        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            //onClicked: { page_loader.source = "" }
            onClicked: displaydialog(1)
            onEntered: { slip2.width = parent.radius * 2 ; edit2.scale = 1.1 }
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
            anchors.topMargin: 35
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.horizontalCenterOffset: 10
            width: 60
            height: width
            sourceSize.height: 60
            sourceSize.width: 60
            source: "../images/edit.png"
            fillMode: Image.PreserveAspectFit
            scale: edit2.scale
        }
        Text {
            id: edit2
            width: 160
            height: 41
            text: qsTr("View Transactions")
            font.pixelSize: 15
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 35
            font.capitalization: Font.Capitalize
            font.family: "Verdana"
            font.styleName: "Regular"
            font.bold: true
            Behavior on scale { PropertyAnimation { duration: 100 } }
        }
    }
    Rectangle {
        id: level2
        anchors.left: level1.left
        anchors.top: level1.bottom
        anchors.topMargin: 30
        width: 190
        height: width //+ 30
        radius: 4
        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            //onClicked: { page_loader.source = "" }
            onClicked: displaydialog(1)
            onEntered: { slip3.width = parent.radius * 2 ; edit3.scale = 1.1 }
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
            anchors.topMargin: 35
            anchors.horizontalCenter: parent.horizontalCenter
            source: '../images/profile.png'
            height: 60
            width: height
            sourceSize.width: 100
            sourceSize.height: 100
            scale: edit3.scale
        }
        Text {
            id: edit3
            width: 160
            height: 41
            text: qsTr("View Admin Log")
            font.pixelSize: 15
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 35
            font.capitalization: Font.Capitalize
            font.family: "Verdana"
            font.styleName: "Regular"
            font.bold: true
            Behavior on scale { PropertyAnimation { duration: 100 } }
        }
    }
    Rectangle {
        anchors.right: parent.right
        anchors.rightMargin: 20
        anchors.top: level2.top
        width: 190
        height: width //+ 30
        radius: 4
        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            //onClicked: { page_loader.source = "" }
            onClicked: displaydialog(1)
            onEntered: { slip4.width = parent.radius * 2 ; edit4.scale = 1.1 }
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
            anchors.topMargin: 35
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.horizontalCenterOffset: 10
            width: 60
            height: width
            sourceSize.height: 60
            sourceSize.width: 60
            source: "../images/edit.png"
            fillMode: Image.PreserveAspectFit
            scale: edit4.scale
        }
        Text {
            id: edit4
            width: 160
            height: 41
            text: qsTr("Print Statement")
            font.pixelSize: 15
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 35
            font.capitalization: Font.Capitalize
            font.family: "Verdana"
            font.styleName: "Regular"
            font.bold: true
            Behavior on scale { PropertyAnimation { duration: 100 } }
        }
    }

    Connections {
        target: backend

        function onAccountname(info) { // [ accName, station ]
            loggeduser.text = qsTr("Name:  <b>" + info[0] + "</b>")
            station.text = qsTr("Station:  <b>" + info[1] + "</b>")

        }
    }

    // "Redirect to Log In" Information
    Text {
        id: modename
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.horizontalCenterOffset: -40
        width: 150
        height: 20
        text: qsTr("Admin Dashboard")
        font.pixelSize: 20
        anchors.top: parent.top
        anchors.topMargin: 40
        font.family: "Verdana"
        font.styleName: "Regular"
        font.bold: true
    }
    Text {
        id: loggeduser
        width: 100
        height: 30
        text: ""
        font.pixelSize: 16
        anchors.top: topbar.bottom
        anchors.topMargin: 20
        anchors.left: parent.left
        anchors.leftMargin: 40
        font.family: "Verdana"
        font.styleName: "Regular"
        //font.bold: true
        font.capitalization: "AllUppercase"
    }

    Text {
        id: station
        width: 150
        height: 30
        text: ""
        font.pixelSize: 16
        anchors.top: loggeduser.top
        anchors.right: parent.right
        anchors.rightMargin: 40
        font.family: "Verdana"
        font.styleName: "Regular"
        //font.bold: true
        font.capitalization: "AllUppercase"
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
                onClicked: { revert() ; page_loader.source = "Registersuper.ui.qml" ; backend.menubranch(5) }
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
                onClicked: { revert() ; page_loader.source = "Removesuper.ui.qml" ; backend.menubranch(5) }
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

    Component.onCompleted: {
        image.scale = 0.6
        image.anchors.horizontalCenterOffset = 180
        image.anchors.topMargin = -25
        white_rectangle.color = "#f8f8f8"
    }
    function revert() {
        image.scale = 1
        image.anchors.horizontalCenterOffset = image.anchors.topMargin = 0
        white_rectangle.color = "white"
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
    // Dialog Box functions
    function closebigdialog() { dialog_big.visible = false ; f1_switch.checked = f2_switch.checked = false }

    function displaydialog(functionnum) {
        dialog_timer.running = false ; time.width = 10
        dialog_small.anchors.bottomMargin = 10
        dialog_timer.running = true
        // 1 scamDialog
        if (functionnum === 1) { information2.text = qsTr("No function has been assigned to any...lol") }
    }

    function displaybigdialog(buttonnum, functionnum) {
        if (buttonnum === 0) { dialog_big.visible = true ; button_number.checked = false ; good_picture.visible = false ; box.radius = 5 }
        if (buttonnum === 1) { dialog_big.visible = true ; button_number.checked = true ; good_picture.visible = true }
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
                id: left_f1
                visible: button_number.checked & f1_switch.checked
                anchors.fill: b1
                hoverEnabled: true
                onEntered: { b1.color = "#a0a0a0" }
                onExited: { b1.color = "black" }
                onClicked: { revert() ; backend.adminlogout() ; page_loader.source = "P2Form.ui.qml" }
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
