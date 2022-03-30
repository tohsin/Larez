import QtQuick 2.14
import QtQuick.Controls 6.2

Item {
    id: window
    property var code: ""
    property var correctpage: ""
    Rectangle {
        id: time ; width: 10 ; height: 10 ; visible: false
    }

    // Registration Page
    FocusScope {
        id: regwindow
        anchors.fill: parent

        // Navigation Buttons -- Back button
        Image {
            id: back_button
            anchors.left: parent.left
            anchors.leftMargin: 35
            anchors.top: parent.top
            anchors.topMargin: 87
            width: 30
            height: 30
            source: "../images/back.jpg"
            sourceSize.width: 100
            sourceSize.height: 100
            MouseArea {
                anchors.fill: parent
                onClicked: { page_loader.source = correctpage ; revert() }
            }
        }

        // Registration Field -- Fingerprint, "Place finger to scan" Information
        Image {
            id: fingerprint
            y: 550
            width: 140
            height: 140
            visible: admin_box.checked | super_box.checked
            source: "../images/whitefinger.jpg"
            anchors.horizontalCenter: parent.horizontalCenter
            fillMode: Image.PreserveAspectFit
            MouseArea {
                id: regfinger
                anchors.fill: parent
                onClicked: {
                    if (super_box.checked === true) { code = "Super Admin"
                    } else { code = "Admin" }
                    backend.checksuper([regno_field.text, code])
                }
            }
        }
        Text {
            id: place_finger
            x: 297
            width: 262
            height: 50
            visible: fingerprint.visible
            text: qsTr("Place Finger on Scanner to Register Fingerprint")
            anchors.top: fingerprint.bottom
            font.pixelSize: 20
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignTop
            font.italic: true
            anchors.topMargin: 10
            anchors.horizontalCenter: fingerprint.horizontalCenter
        }

        // Registration Field contd -- Reg No Text box
        Text {
            id: regno
            y: 160
            height: 41
            anchors.left: parent.left
            anchors.leftMargin: 60
            anchors.right: parent.right
            text: qsTr("Username")
            font.pixelSize: 20
            verticalAlignment: Text.AlignVCenter
            wrapMode: Text.NoWrap
            fontSizeMode: Text.Fit
            font.capitalization: Font.AllUppercase
            font.family: "Verdana"
            font.styleName: "Regular"

            TextField {
                id: regno_field
                height: regno_box.height - 2
                anchors.verticalCenter: regno_box.verticalCenter
                anchors.left: regno_box.left
                anchors.right: regno_box.right
                anchors.rightMargin: 1
                anchors.leftMargin: 1
                baselineOffset: 15
                font.pointSize: 12
                topPadding: 7
                leftPadding: 9
                rightPadding: 35
                placeholderText: qsTr("Username")
                Rectangle {
                    anchors.fill: parent ; color: "transparent" ; border.width: 1 ; border.color: "white"
                }
            }
            Rectangle {
                id: regno_box
                height: 40
                color: "transparent"
                radius: 5
                border.width: 1
                anchors.left: parent.left
                anchors.top: parent.bottom
                anchors.right: parent.right
                anchors.rightMargin: 60
            }
            Image {
                id: clearregno
                height: 14
                width: height
                anchors.verticalCenter: regno_box.verticalCenter
                anchors.right: regno_box.right
                anchors.rightMargin: 10
                source: "../images/closebutton.png"
                sourceSize.width: 20
                sourceSize.height: 20
                MouseArea {
                    id: clusr
                    anchors.fill: parent
                    onClicked: regno_field.text = ""
                }
            }
        }
        // Registration Field contd -- Account Name Text box
        Text {
            id: accname
            y: 300
            height: 41
            anchors.left: parent.left
            anchors.leftMargin: 60
            anchors.right: parent.right
            text: qsTr("Account Name")
            font.pixelSize: 20
            verticalAlignment: Text.AlignVCenter
            wrapMode: Text.NoWrap
            fontSizeMode: Text.Fit
            font.capitalization: Font.AllUppercase
            font.family: "Verdana"
            font.styleName: "Regular"

            TextField {
                id: accname_field
                height: accname_box.height - 2
                anchors.verticalCenter: accname_box.verticalCenter
                anchors.left: accname_box.left
                anchors.right: accname_box.right
                anchors.rightMargin: 1
                anchors.leftMargin: 1
                baselineOffset: 15
                font.pointSize: 12
                topPadding: 7
                leftPadding: 9
                rightPadding: 35
                placeholderText: qsTr("Account Name")
                Rectangle {
                    anchors.fill: parent ; color: "transparent" ; border.width: 1 ; border.color: "white"
                }
            }
            Rectangle {
                id: accname_box
                height: 40
                color: "transparent"
                radius: 5
                border.width: 1
                anchors.left: parent.left
                anchors.top: parent.bottom
                anchors.right: parent.right
                anchors.rightMargin: 60
            }
            Image {
                id: clearaccname
                height: 14
                width: height
                anchors.verticalCenter: accname_box.verticalCenter
                anchors.right: accname_box.right
                anchors.rightMargin: 10
                source: "../images/closebutton.png"
                sourceSize.width: 20
                sourceSize.height: 20
                MouseArea {
                    id: clacc
                    anchors.fill: parent
                    onClicked: accname_field.text = ""
                }
            }
        }
        // Registration Field contd -- Pin Text box
        Text {
            id: pin
            x: 60
            y: 430
            width: 152
            height: 41
            text: qsTr("Pin")
            font.pixelSize: 20
            verticalAlignment: Text.AlignVCenter
            fontSizeMode: Text.Fit
            font.capitalization: Font.AllUppercase
            font.family: "Verdana"
            font.styleName: "Regular"

            TextField {
                id: password
                echoMode: TextInput.Password
                height: regno_box.height - 2
                anchors.verticalCenter: password_box.verticalCenter
                anchors.left: password_box.left
                anchors.right: password_box.right
                anchors.rightMargin: 1
                anchors.leftMargin: 1
                baselineOffset: 15
                font.pointSize: 12
                topPadding: 7
                leftPadding: 9
                rightPadding: 35
                placeholderText: qsTr("Pin")
                Rectangle {
                    anchors.fill: parent ; color: "transparent" ; border.width: 1 ; border.color: "white"
                }
            }
            Rectangle {
                id: password_box
                width: regno_box.width
                height: regno_box.height
                color: "transparent"
                radius: 5
                border.width: 1
                anchors.left: parent.left
                anchors.top: parent.bottom
                anchors.topMargin: 0
                anchors.leftMargin: 0
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

        // (Super) Admin Check box
        FocusScope {
            id: row
            x: 60
            y: 530
            width: 260
            height: 40
            CheckBox {
                id: super_box
                width: 13
                height: 13
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.topMargin: 6
                anchors.leftMargin: 6
                scale: 2
                onCheckedChanged: {
                    if ( regno_field.text === "" | password.text === "" ) { displaydialog(2) }
                    if (super_box.checked === true & admin_box.checked === true) { admin_box.checked = false }
                }
            }

            Text {
                id: super_text
                height: 20
                text: qsTr("Super Admin")
                anchors.verticalCenter: super_box.verticalCenter
                anchors.left: super_box.right
                font.pixelSize: 15
                font.family: "Verdana"
                anchors.leftMargin: 15
                MouseArea {
                    anchors.fill: parent
                    onClicked: super_box.checked = !super_box.checked
                }
            }
            CheckBox {
                id: admin_box
                width: 13
                height: 13
                anchors.verticalCenter: super_box.verticalCenter
                anchors.left: super_text.right
                anchors.leftMargin: 30
                scale: 2
                onCheckedChanged: {
                    if ( regno_field.text === "" | password.text === "" ) { displaydialog(2) }
                    if (admin_box.checked === true & super_box.checked === true) { super_box.checked = false }
                }
            }

            Text {
                id: admin_text
                height: 20
                text: qsTr("Admin")
                anchors.verticalCenter: super_box.verticalCenter
                anchors.left: admin_box.right
                font.pixelSize: 15
                font.family: "Verdana"
                anchors.leftMargin: 15
                MouseArea {
                    anchors.fill: parent
                    onClicked: admin_box.checked = !admin_box.checked
                }
            }
        }

        // Page Information -- Feature Name
        Text {
            id: modename
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.horizontalCenterOffset: -50
            width: 150
            height: 20
            text: qsTr("Admin Registration")
            font.pixelSize: 20
            anchors.top: parent.top
            anchors.topMargin: 87
            font.family: "Verdana"
            font.styleName: "Regular"
            font.bold: true
        }
    }

    // Verification Page
    Item {
        id: verwindow
        visible: false
        anchors.fill: parent
        Rectangle {
            radius: 8
            anchors.fill: parent
            color: "white"

            Image {
                id: logo
                width: 150
                height: 150
                anchors.top: parent.top
                source: "../images/culogo.jpg"
                anchors.topMargin: 40
                anchors.horizontalCenter: parent.horizontalCenter
                fillMode: Image.PreserveAspectFit
            }
            // Navigation -- Back button, Submit button, Use Pin, Use Fingerprint, Switch
            Image {
                id: back
                anchors.left: parent.left
                anchors.leftMargin: 35
                anchors.top: parent.top
                anchors.topMargin: 87
                width: 30
                height: 30
                source: "../images/back.jpg"
                sourceSize.width: 100
                sourceSize.height: 100
                MouseArea {
                    anchors.fill: parent
                    onClicked: { verwindow.visible = false ; regfinger.visible = true ; username1.text = '' ; password1.text = '' }
                }
            }
            // Navigation contd
            Rectangle {
                anchors.top: submit_button1.top ; anchors.topMargin: 0.5 ; visible: submit_button1.visible
                anchors.left: submit_button1.left ; anchors.leftMargin: -1
                height: submit_button1.height + 2.5 ; width: submit_button1.width + 1.5 ; radius: submit_button1.radius + 1
                color: "#e0e0e0"
            }
            Rectangle {
                id: submit_button1
                visible: switch1.checked
                width: 114
                height: 40
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 120
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.horizontalCenterOffset: 100
                color: "black"
                radius: 8
                Text {
                    width: 150
                    height: 40
                    color: "white"
                    text: qsTr("Submit")
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
                        backend.registersuper([regno_field.text, accname_field.text, code, password.text, password.text, username1.text, password1.text , "Pin"])
                    }
                }
            }
            // Navigation contd
            Rectangle {
                anchors.top: use_pin_button1.top ; anchors.topMargin: -0.5 ; visible: use_pin_button1.visible
                anchors.left: use_pin_button1.left ; anchors.leftMargin: -1
                height: use_pin_button1.height + 3.5 ; width: use_pin_button1.width + 1.5 ; radius: use_pin_button1.radius + 1
                color: "#e0e0e0"
            }
            Rectangle {
                id: use_pin_button1
                color: "#ffffff"
                radius: 8
                //border.width: 3
                width: 114
                height: 40
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 120
                visible: !switch1.checked
                anchors.horizontalCenterOffset: 0
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
                    onClicked: switch1.checked = !switch1.checked
                }
            }
            // Navigation contd
            Rectangle {
                anchors.top: use_fingerprint_button1.top ; anchors.topMargin: 0.5 ; visible: use_fingerprint_button1.visible
                anchors.left: use_fingerprint_button1.left ; anchors.leftMargin: -1
                height: use_fingerprint_button1.height + 2.5 ; width: use_fingerprint_button1.width + 1.5 ; radius: use_fingerprint_button1.radius + 1
                color: "#e0e0e0"
            }
            Rectangle {
                id: use_fingerprint_button1
                color: "#ffffff"
                radius: 8
                //border.width: 3
                width: 156
                height: 40
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 120
                visible: switch1.checked
                anchors.horizontalCenterOffset: -100
                anchors.horizontalCenter: parent.horizontalCenter
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
                    onClicked: switch1.checked = !switch1.checked
                }
            }
            // Navigation contd
            Switch {
                id: switch1
                checked: false
                visible: false
            }
        }
        // Biometric Elements -- User Rank, Fingerprint picture, "Place Finger" text
        Text {
            id: biometric1
            visible: !switch1.checked
            x: 60
            y: 245
            width: 152
            height: 41
            text: qsTr("Super Admin")
            font.pixelSize: 20
            verticalAlignment: Text.AlignVCenter
            wrapMode: Text.NoWrap
            fontSizeMode: Text.Fit
            font.capitalization: Font.AllUppercase
            font.family: "Verdana"
            font.styleName: "Regular"
        }
        Image {
            id: fingerprint1
            visible: !switch1.checked
            y: 360
            width: 150
            height: 150
            source: "../images/whitefinger.jpg"
            anchors.horizontalCenter: parent.horizontalCenter
            fillMode: Image.PreserveAspectFit
            MouseArea {
                anchors.fill: parent;
                onClicked: {
                    backend.registersuper([regno_field.text, accname_field.text, code, password.text, password.text, '', '' , "Fingerprint"])
                }
            }
        }
        Text {
            id: place_finger1
            visible: !switch1.checked
            x: 297
            width: 262
            height: 50
            text: qsTr("Place Finger on Scanner")
            anchors.top: fingerprint1.bottom
            font.pixelSize: 20
            font.italic: true
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignTop
            anchors.topMargin: 10
            anchors.horizontalCenter: fingerprint1.horizontalCenter
        }

        // Typed Elements -- Rank, Username & Pin Text box
        Text {
            id: superadmin1
            visible: switch1.checked
            y: 245
            height: 41
            anchors.left: parent.left
            anchors.leftMargin: 60
            anchors.right: parent.right
            text: qsTr("Super Admin")
            font.pixelSize: 20
            verticalAlignment: Text.AlignVCenter
            fontSizeMode: Text.Fit
            font.capitalization: Font.AllUppercase
            font.family: "Verdana"
            font.styleName: "Regular"

            TextField {
                id: username1
                width: username_box1.width
                height: username_box1.height - 2
                placeholderText: qsTr("Username")
                font.pixelSize: 16
                topPadding: 7
                leftPadding: 9
                rightPadding: 35
                anchors.verticalCenter: username_box1.verticalCenter
                anchors.left: username_box1.left
                anchors.right: username_box1.right
                anchors.rightMargin: 1
                anchors.leftMargin: 1
                Rectangle {
                    anchors.fill: parent ; color: "transparent" ; border.width: 1 ; border.color: "white"
                }
            }
            Rectangle {
                id: username_box1
                height: 40
                color: "transparent"
                radius: 5
                border.width: 1
                anchors.left: parent.left
                anchors.top: parent.bottom
                anchors.right: parent.right
                anchors.rightMargin: 60
            }
            Image {
                id: clearusername1
                height: 14
                width: height
                anchors.verticalCenter: username_box1.verticalCenter
                anchors.right: username_box1.right
                anchors.rightMargin: 10
                source: "../images/closebutton.png"
                sourceSize.width: 20
                sourceSize.height: 20
                MouseArea {
                    anchors.fill: parent
                    onClicked: username1.text = ""
                }
            }
        }
        // Typed Elements contd. -- Pin Text box
        Text {
            id: pin1
            visible: switch1.checked
            x: 60
            y: 400
            width: 152
            height: 41
            text: qsTr("Pin")
            font.pixelSize: 20
            verticalAlignment: Text.AlignVCenter
            wrapMode: Text.NoWrap
            fontSizeMode: Text.Fit
            font.capitalization: Font.AllUppercase
            font.family: "Verdana"
            font.styleName: "Regular"

            TextField {
                id: password1
                echoMode: TextInput.Password
                width: username_box1.width
                height: username_box1.height - 2
                placeholderText: qsTr("Pin")
                font.pixelSize: 16
                topPadding: 7
                leftPadding: 9
                rightPadding: 35
                anchors.verticalCenter: password_box1.verticalCenter
                anchors.left: password_box1.left
                anchors.right: password_box1.right
                anchors.rightMargin: 1
                anchors.leftMargin: 1
                Rectangle {
                    anchors.fill: parent ; color: "transparent" ; border.width: 1 ; border.color: "white"
                }
            }
            Rectangle {
                id: password_box1
                width: username_box1.width
                height: username_box1.height
                color: "transparent"
                radius: 5
                border.width: 1
                anchors.left: parent.left
                anchors.top: parent.bottom
                anchors.topMargin: 0
                anchors.leftMargin: 0
            }
            Image {
                height: 14
                width: height
                anchors.verticalCenter: password_box1.verticalCenter
                anchors.right: password_box1.right
                anchors.rightMargin: 10
                source: "../images/closebutton.png"
                sourceSize.width: 20
                sourceSize.height: 20
                MouseArea {
                    anchors.fill: parent
                    onClicked: password1.text = ""
                }
            }
        }
        // Verification Page Information -- Feature Name
        Text {
            id: modename1
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.horizontalCenterOffset: -70
            width: 150
            height: 20
            text: qsTr("Registration Verification")
            font.pixelSize: 20
            anchors.top: parent.top
            anchors.topMargin: 87
            font.family: "Verdana"
            font.styleName: "Regular"
            font.bold: true
        }
    }

    Connections {
        target: backend

        function onInvalid(number) { if (number === 1) { displaydialog(1) } }
        function onIncorrect(number) { if (number === 3) { displaydialog(3) } }
        function onProceed(value) {
            if (value === 1) { displaybigdialog(0,2) ; exitbutton.visible = true  }
            if (value === 2) { displaybigdialog(1,1) }
        }
        function onFinishedprocess(pagetoload){ correctpage = pagetoload }
    }

    Component.onCompleted: {
        image.scale = 0.6
        image.anchors.horizontalCenterOffset = 180
        image.anchors.topMargin = 20

        logo.scale = 0.6
        logo.anchors.horizontalCenterOffset = 180
        logo.anchors.topMargin = 20

    }
    function revert() { image.scale = 1 ; image.anchors.horizontalCenterOffset = 0 }

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
    function displaydialog(functionnum) {
        dialog_small.anchors.bottomMargin = 10
        dialog_timer.running = true
        // 1 invalidDialog
        if (functionnum === 1) { information2.text = qsTr("Username is already taken") }

        // 2 incompleteDialog
        if (functionnum === 2) {
            information2.text = qsTr("Details You Entered Are Incomplete. Fill the empty fields")
            super_box.checked = false
            admin_box.checked = false
        }

        // 3 incorrectDialog
        if (functionnum === 3) { information2.text = qsTr("Invalid Verification Username or Password") }

    }
    function closebigdialog() { dialog_big.visible = false ; f1_switch.checked = false }

    function displaybigdialog(buttonnum, functionnum) {
        if (buttonnum === 0) { dialog_big.visible = true ; button_number.checked = false ; good_picture.visible = true }
        if (buttonnum === 1) { dialog_big.visible = true ; button_number.checked = true ; good_picture.visible = true }
        if (buttonnum === 2) { dialog_big.visible = true ; button_number.checked = true ; good_picture.visible = false }

        // 1 confirmDialog
        if (functionnum === 1) {
            information.text = qsTr("You Are About To Register " + code + " " + regno_field.text + ". Do You Want To Continue?")
            header.text = qsTr("Registering Admin")
            f1_switch.checked = true
            right_button.clicked.connect(closebigdialog)
        }
        // 2 successDialog
        if (functionnum === 2) {
            information.text = qsTr("New " + code + " Has Been Registered Successfully")
            header.text = qsTr("Registration Successful")
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
            onClicked: dialog_small.anchors.bottomMargin = -100
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
                onClicked: { verwindow.visible = true ; closebigdialog() ; regfinger.visible = false }
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
            Rectangle {
                anchors.top: b3.top ; anchors.topMargin: -0.5 ; visible: b3.visible
                anchors.left: b3.left ; anchors.leftMargin: -1
                height: b3.height + 3.5 ; width: b3.width + 1.5 ; radius: b3.radius + 1
                color: "#e0e0e0"
            }
            Rectangle {
                id: b3
                visible: !button_number.checked
                height: 43
                width: 280
                color: "white"
                radius: 8
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 20
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
                    font.pixelSize: 16
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
            visible: false
            checked: true
        }
        Switch {
            id: f1_switch
            visible: false
            checked: false
        }
    }
    MouseArea {
        id: exitbutton
        visible: false
        anchors.fill: parent
        onClicked: { page_loader.source = correctpage ; revert() }
    }
}
