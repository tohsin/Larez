import QtQuick 2.14
import QtQuick.Controls 2.5
import "keyboard"

Item {
    id: window
    property string correctpage: ""
    property real aNum: 0

    Rectangle {
        id: time ; width: 10 ; height: 10 ; visible: false
    }

    // Navigation Buttons -- Use Pin, Use Finger, Menu Bar
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
        width: 150
        height: 53
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 120
        visible: !switch1.checked
        anchors.horizontalCenter: parent.horizontalCenter
        Text {
            id: pin_text
            width: 150
            height: 40
            text: qsTr("Use Pin")
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
            onClicked: { switch1.checked = !switch1.checked ; fingerprint.opacity = 0 }
        }
    }
    Rectangle {
        anchors.top: submit_button.top ; anchors.topMargin: 0.5 ; visible: submit_button.visible
        anchors.left: submit_button.left ; anchors.leftMargin: -1
        height: submit_button.height + 2.5 ; width: submit_button.width + 1.5 ; radius: submit_button.radius + 1
        color: "#e0e0e0"
    }
    Rectangle {
        id: submit_button
        visible: use_fingerprint_button.visible
        width: use_pin_button.width
        height: use_pin_button.height
        anchors.bottom: use_pin_button.bottom
        anchors.right: parent.right
        anchors.rightMargin: amount.anchors.leftMargin + 100
        color: "black"
        radius: 8
        Text {
            width: 150
            height: 40
            color: "white"
            text: qsTr("Submit")
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: pin_text.font.pixelSize
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.bold: true
            font.family: "Verdana"
            anchors.horizontalCenter: parent.horizontalCenter
        }
        MouseArea {
            anchors.fill: parent
            onClicked: {
                if ( ver.text === "" | password.text === "" | amount_field.text === "" ) { displaydialog(1) }
                else { displaybigdialog(2,1) }
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
        radius: use_pin_button.radius
        //border.width: 3
        width: 230
        height: use_pin_button.height
        anchors.bottom: use_pin_button.bottom
        visible: switch1.checked
        anchors.left: parent.left
        anchors.leftMargin: submit_button.anchors.rightMargin
        Text {
            width: 160
            height: 40
            text: qsTr("Use Fingerprint")
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: pin_text.font.pixelSize
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.bold: true
            font.family: "Verdana"
            anchors.horizontalCenter: parent.horizontalCenter
        }
        MouseArea {
            anchors.fill: parent
            onClicked: { switch1.checked = !switch1.checked ; fingerprint.opacity = 1 }
        }
    }
    // Verification Details -- Fingerprint, "Place finger" Information
    Image {
        id: fingerprint
        visible: use_pin_button.visible
        opacity: 0
        y: 360
        width: 150
        height: 150
        source: "../images/whitefinger.jpg"
        anchors.horizontalCenter: parent.horizontalCenter
        fillMode: Image.PreserveAspectFit
        Behavior on opacity { PropertyAnimation { duration: 500 } }
        MouseArea {
            anchors.fill: parent
            onClicked: {
                if ( amount_field.text === "" ) { displaydialog(1) }
                else { displaybigdialog(2,1) }
            }
        }
    }
    Text {
        id: place_finger
        visible: fingerprint.visible
        opacity: fingerprint.opacity
        x: 297
        width: 262
        height: 50
        text: qsTr("Place Finger on Scanner")
        anchors.top: fingerprint.bottom
        anchors.topMargin: 10
        font.family: "Calibri"
        font.pixelSize: 22
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignTop
        font.italic: true
        anchors.horizontalCenter: fingerprint.horizontalCenter
    }
    // Menu Button
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

    // Deposit Field contd -- Amount Text box
    Text {
        id: amount
        anchors.top: parent.top ; anchors.topMargin: 170
        height: 41
        anchors.left: parent.left ; anchors.leftMargin: 100
        anchors.right: parent.right
        text: qsTr("Amount")
        font.pixelSize: 20
        verticalAlignment: Text.AlignVCenter
        font.capitalization: Font.AllUppercase
        font.family: "Verdana"
        font.styleName: "Regular"
        font.bold: true
        TextField {
            id: amount_field
            font.family: "Calibri"
            height: amount_box.height - 2
            anchors.verticalCenter: amount_box.verticalCenter
            anchors.left: amount_box.left
            anchors.right: amount_box.right
            anchors.rightMargin: 1
            anchors.leftMargin: 1
            baselineOffset: 15
            font.pointSize: 12
            topPadding: 7
            //leftPadding: 9
            rightPadding: 35
            placeholderText: qsTr("Deposit Amount")
            onPressed: inputPaneln.showKeyboard = true
            Rectangle {
                anchors.fill: parent ; color: "transparent" ; border.width: 1 ; border.color: "white"
            }
        }
        Rectangle {
            id: amount_box
            height: 40
            color: "transparent"
            radius: 5
            //border.width: 1
            anchors.left: parent.left
            anchors.top: parent.bottom
            anchors.right: parent.right
            anchors.rightMargin: amount.anchors.leftMargin
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
            id: clearamount
            height: 14
            width: height
            anchors.verticalCenter: amount_box.verticalCenter
            anchors.right: amount_box.right
            anchors.rightMargin: 10
            source: "../images/closebutton.png"
            sourceSize.width: 20
            sourceSize.height: 20
            MouseArea {
                id: clusr
                anchors.fill: parent
                onClicked: amount_field.text = ""
            }
        }
    }
    // Verification Typed Elements -- Username & Pin Text box
    Text {
        id: verify
        anchors.left: amount.left
        y: 300
        width: 180
        height: 41
        text: qsTr("Verify Deposit")
        font.pixelSize: amount.font.pixelSize + 1
        verticalAlignment: Text.AlignVCenter
        fontSizeMode: Text.Fit
        font.capitalization: Font.AllUppercase
        font.family: "Verdana"
        font.styleName: "Regular"
        font.bold: true
        font.italic: true
    }
    Text {
        id: ver
        visible: use_fingerprint_button.visible
        y: 350
        height: 41
        anchors.left: amount.left
        anchors.right: parent.right
        text: qsTr("Username")
        font.pixelSize: amount.font.pixelSize
        verticalAlignment: Text.AlignVCenter
        font.capitalization: Font.AllUppercase
        font.family: "Verdana"
        font.styleName: "Regular"
        font.bold: true
        TextField {
            id: ver_field
            font.family: "Calibri"
            height: ver_box.height - 2
            anchors.verticalCenter: ver_box.verticalCenter
            anchors.left: ver_box.left
            anchors.right: ver_box.right
            anchors.rightMargin: 1
            anchors.leftMargin: 1
            baselineOffset: 15
            font.pointSize: 12
            topPadding: 7
            //leftPadding: 9
            rightPadding: 35
            placeholderText: qsTr("(Super) Admin Username")
            onPressed: inputPaneln.showKeyboard = true
            Rectangle {
                anchors.fill: parent ; color: "transparent" ; border.width: 1 ; border.color: "white"
            }
        }
        Rectangle {
            id: ver_box
            height: 40
            color: "transparent"
            radius: 5
            //border.width: 1
            anchors.left: parent.left
            anchors.top: parent.bottom
            anchors.right: parent.right
            anchors.rightMargin: amount.anchors.leftMargin
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
            id: clearver
            height: 14
            width: height
            anchors.verticalCenter: ver_box.verticalCenter
            anchors.right: ver_box.right
            anchors.rightMargin: 10
            source: "../images/closebutton.png"
            sourceSize.width: 20
            sourceSize.height: 20
            MouseArea {
                id: clver
                anchors.fill: parent
                onClicked: ver_field.text = ""
            }
        }
    }
    // Verification Typed Elements contd -- Pin Text box
    Text {
        id: pin
        visible: use_fingerprint_button.visible
        anchors.left: amount.left
        y: 480
        width: 152
        height: 41
        text: qsTr("Pin")
        font.pixelSize: amount.font.pixelSize
        verticalAlignment: Text.AlignVCenter
        font.capitalization: Font.AllUppercase
        font.family: "Verdana"
        font.styleName: "Regular"
        font.bold: true
        TextField {
            id: password
            font.family: "Calibri"
            echoMode: TextInput.Password
            height: ver_box.height - 2
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
            onPressed: inputPaneln.showKeyboard = true
            Rectangle {
                anchors.fill: parent ; color: "transparent" ; border.width: 1 ; border.color: "white"
            }
        }
        Rectangle {
            id: password_box
            width: ver_box.width
            height: ver_box.height
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
            id: clearpin
            height: 14
            width: height
            anchors.verticalCenter: password_box.verticalCenter
            anchors.right: password_box.right
            anchors.rightMargin: 10
            source: "../images/closebutton.png"
            sourceSize.width: 20
            sourceSize.height: 20
            MouseArea {
                id: clpin
                anchors.fill: parent
                onClicked: password.text = ""
            }
        }
    }

    // Page / User Information -- Feature name, Name of User, Account Balance of User
    Text {
        id: modename
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.horizontalCenterOffset: -40
        width: 150
        height: 20
        text: qsTr(" Window")
        font.pixelSize: 25
        anchors.top: parent.top
        anchors.topMargin: 40
        font.family: "Verdana"
        font.styleName: "Regular"
        font.bold: true
    }
    Rectangle {
        id: profilebox
        radius: height / 2
        color: "transparent"
        /*color: "#e1e1e0"
        color: "black"*/
        width: 160
        height: 40
        anchors.top: parent.top
        anchors.topMargin: 100
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.horizontalCenterOffset: -100
        Image {
            id: profile
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 20
            source: '../images/profile.png'
            height: 25
            width: height
            sourceSize.width: 100
            sourceSize.height: 100
        }
        Text {
            id: loggeduser
            width: 100
            height: 20
            text: "Hi, "
            font.pixelSize: 18
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: profile.right
            anchors.leftMargin: 10
            font.family: "Verdana"
            font.styleName: "Regular"
        }
    }
    Rectangle {
        id: creditbox
        radius: height / 2
        color: "transparent"
        /*color: "#e1e1e0"*/
        /*color: "black"*/
        width: 160
        height: 40
        anchors.top: profilebox.top
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.horizontalCenterOffset: -(profilebox.anchors.horizontalCenterOffset)
        Image {
            id: credit
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 20
            source: '../images/credit.png'
            height: 35
            width: height
            sourceSize.width: 100
            sourceSize.height: 100
        }
        Text {
            id: acbal
            width: 150
            height: 20
            text: "Available "
            font.pixelSize: loggeduser.font.pixelSize
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: credit.right
            anchors.leftMargin: 10
            font.family: "Verdana"
            font.styleName: "Regular"
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
            onClicked: closemenu()
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
        width: 280
        height: menu.radius + first_menu.height + second_menu.height + third_menu.height + fourth_menu.height + menu.radius
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
                onClicked: displaybigdialog(2,2)
            }
            Text {
                id: logout
                anchors.verticalCenter: first_menu.verticalCenter
                anchors.left: parent.left
                verticalAlignment: Text.AlignVCenter
                height: 30
                font.family: "Verdana"
                width: parent.width
                font.pixelSize: 16
                text: qsTr("Logout User")
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
            color: fourth_menu.color
        }
        Rectangle {
            id: second_menu
            anchors.left: parent.left
            anchors.top: first_menu.bottom
            anchors.right: parent.right
            height: first_menu.height + menu.radius // 40
            color: menu.color
            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                onEntered: second_menu.color = "#e8e8e8"
                onExited: second_menu.color = menu.color
                onClicked: { backend.feature("Transfer") ; stack.replace("Transfermulti2.ui.qml") ; backend.switchfeature() }
            }
            Text {
                id: transfer_menu
                anchors.left: parent.left
                anchors.verticalCenter: second_menu.verticalCenter
                verticalAlignment: Text.AlignVCenter
                height: 30
                font.family: "Verdana"
                width: parent.width
                font.pixelSize: logout.font.pixelSize
                text: qsTr("Switch to Transfer Mode")
                leftPadding: logout.leftPadding
            }
        }
        Rectangle {
            id: third_menu
            anchors.left: parent.left
            anchors.top: second_menu.bottom
            anchors.right: parent.right
            height: second_menu.height
            color: menu.color
            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                onEntered: third_menu.color = "#e8e8e8"
                onExited: third_menu.color = menu.color
                onClicked: { backend.feature("Purchase") ; stack.replace("Purchasemulti2.ui.qml") ; backend.switchfeature() }
            }
            Text {
                id: purchase_menu
                anchors.verticalCenter: third_menu.verticalCenter
                anchors.left: parent.left
                verticalAlignment: Text.AlignVCenter
                height: 30
                font.family: "Verdana"
                width: parent.width
                font.pixelSize: logout.font.pixelSize
                text: qsTr("Switch to Purchase Mode")
                leftPadding: logout.leftPadding
            }
        }
        Rectangle {
            id: fourth_menu
            anchors.left: parent.left
            anchors.top: third_menu.bottom
            anchors.right: parent.right
            height: first_menu.height
            color: menu.color
            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                onEntered: fourth_menu.color = "#e8e8e8"
                onExited: fourth_menu.color = menu.color
                onClicked: displaybigdialog(2,3)
            }
            Text {
                id: register_menu
                anchors.verticalCenter: fourth_menu.verticalCenter
                anchors.left: parent.left
                verticalAlignment: Text.AlignVCenter
                height: 30
                font.family: "Verdana"
                width: parent.width
                font.pixelSize: logout.font.pixelSize
                text: qsTr("Switch to Registration Mode")
                leftPadding: logout.leftPadding
            }
        }
    }

    Connections {
        target: backend

        function onLoggeduser(customer) {
            loggeduser.text = "<b>" + customer + "</b>"
        }
        function onFeaturemode(activity) {
            modename.text = activity + " Window"
        }
        function onAccbalance(cash) {
            acbal.text = "<b>" + cash + "</b>"
            aNum = cash
        }
        function onIncorrect(number) { if (number === 3) { displaydialog(2) } }
        function onProceed(value) {
            if (value === 1) { displaybigdialog(0,4) ; exitbutton.visible = true }
        }
        function onFinishedprocess(pagetoload){ correctpage = pagetoload }
        function onHidekeyboard() { inputPaneln.showKeyboard = inputPanel.showKeyboard = false }
    }

    Component.onCompleted: {
        image.scale = 0.6
        image.anchors.horizontalCenterOffset = (mainwindow.width / 2) - 45
        image.anchors.topMargin = -25

        fingerprint.opacity = 1
    }
    function revert() { image.scale = 1 ; image.anchors.horizontalCenterOffset = image.anchors.topMargin = 0 }

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

    // Dialog Box functions
    function displaydialog(functionnum) {
        dialog_timer.running = false ; time.width = 10
        dialog_small.anchors.bottomMargin = 20
        dialog_timer.running = true
        // 1 incompleteDialog
        if (functionnum === 1) {
            information2.text = qsTr("Details You Entered Are Incomplete. Fill the empty fields")
        }

        // 2 incorrectDialog
        if (functionnum === 2) { information2.text = qsTr("Invalid Verification Username or Password") }

    }
    function closebigdialog() { dialog_big.visible = false ; f1_switch.checked = f2_switch.checked = f3_switch.checked = false }

    function closemenu() { menu.scale = 0 ; background.visible = menu.visible = false ; menuarea.visible = true }

    function displaybigdialog(buttonnum, functionnum) {
        if (buttonnum === 0) { dialog_big.visible = true ; button_number.checked = false ; good_picture.visible = false ; box.radius = 5 }
        if (buttonnum === 1) { dialog_big.visible = true ; button_number.checked = true ; good_picture.visible = true }
        if (buttonnum === 2) { dialog_big.visible = true ; button_number.checked = true ; good_picture.visible = false ; box.radius = 10 }

        // 1 depositDialog
        if (functionnum === 1) {
            information.text = qsTr("You Are About To Make A Deposit of " + amount_field.text + " Naira. Do You Want To Continue?")
            header.text = qsTr("Deposit")
            f1_switch.checked = true
            right_button.clicked.connect(closebigdialog)
        }
        // 2 userLogoutDialog
        if (functionnum === 2) {
            information.text = qsTr("You Are About To Logout. Do You Want To Continue?")
            header.text = qsTr("Logout")
            f2_switch.checked = true
            right_button.clicked.connect(closebigdialog)
        }
        // 3 LogoutToRegistrationDialog
        if (functionnum === 3) {
            information.text = qsTr("Switching to Registration Will Log You Out Of Your Current Session. Do You Want To Continue?")
            header.text = qsTr("Leaving Page")
            f3_switch.checked = true
            right_button.clicked.connect(closebigdialog)
        }
        // 4 successDialog
        if (functionnum === 4) {
            information.text = qsTr("Your Account Has Been Credited Successfully")
            header.text = qsTr("Deposit Successful")
        }
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
            Rectangle {
                id: greenslip; visible: !button_number.checked
                anchors.top: box.top ; height: box.height ; width: box.radius * 2
                anchors.left: box.left; radius: box.radius ; color: "darkgreen"
            }
            Rectangle {
                visible: greenslip.visible
                anchors.top: greenslip.top ; anchors.bottom: greenslip.bottom; anchors.right: greenslip.right
                anchors.rightMargin: -1 ; width: greenslip.radius ; color: "white"
            }
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
                anchors.bottom: b1.top
                font.family: "Verdana"
                font.styleName: "Regular"
                width: parent.width - 40
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
                onClicked: { closebigdialog() ; backend.deposit([amount_field.text, ver_field.text, password.text, "Pin"]) } // Use code var to do fingerprint
            }
            MouseArea {
                id: left_f2
                visible: button_number.checked & f2_switch.checked
                anchors.fill: b1
                hoverEnabled: true
                onEntered: { b1.color = "#a0a0a0" }
                onExited: { b1.color = "black" }
                onClicked: { revert() ; backend.userlogout() ; stack.pop() ; stack.pop() }
            }
            MouseArea {
                id: left_f3
                visible: button_number.checked & f3_switch.checked
                anchors.fill: b1
                hoverEnabled: true
                onEntered: { b1.color = "#a0a0a0" }
                onExited: { b1.color = "black" }
                onClicked: { backend.userlogout() ; backend.feature("Register") ; stack.pop() ; stack.replace("Register.ui.qml") ; backend.switchfeature() }
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
                    font.pixelSize: yes.font.pixelSize
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    color: "black"
                    text: qsTr("No")
                    font.bold: true
                }
            }
            Rectangle {
                anchors.top: b3.top ; anchors.topMargin: -0.5 ; visible: b3.visible
                anchors.left: b3.left ; anchors.leftMargin: -1
                height: b3.height + 3.5 ; width: b3.width + 1.5 ; radius: b3.radius + 1
                color: "#e0e0e0"
            }
            Rectangle {
                id: b3
                visible: !button_number.checked
                height: b1.height
                width: box.width/2 + 100 //
                color: "white"
                radius: b1.radius
                anchors.bottom: b1.bottom
                anchors.horizontalCenter: parent.horizontalCenter
            }
            MouseArea {
                id: center_button
                visible: !button_number.checked
                anchors.fill: b3
                hoverEnabled: true
                onEntered: { ok.color = "#a0a0a0" }
                onExited: { ok.color = "black" }
                Text {
                    id: ok
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    font.family: "Verdana"
                    font.styleName: "Regular"
                    width: 152
                    height: parent.height
                    font.pixelSize: yes.font.pixelSize
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    color: "black"
                    text: qsTr("Ok")
                    font.bold: true
                }
            }
        }

        // Switches for Logic
        Switch {
            id: button_number
            visible: false ; checked: true
        }
        Switch {
            id: f1_switch
            visible: false ; checked: false
        }
        Switch {
            id: f2_switch
            visible: false ; checked: false
        }
        Switch {
            id: f3_switch
            visible: false ; checked: false
        }
        Switch {
            id: switch1
            visible: false ; checked: false
        }
    }
    MouseArea {
        id: exitbutton
        visible: false
        anchors.fill: parent
        onClicked: { revert() ; stack.replace('P3Form.ui.qml') }
    }    
}
