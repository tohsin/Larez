import QtQuick 2.14
import QtQuick.Controls 6.2

Item {
    id: window
    Rectangle {
        id: time ; width: 10 ; height: 10 ; visible: false
    }

    // Navigation Buttons -- Back button
    Image {
        id: back_button
        anchors.left: parent.left
        anchors.leftMargin: 35
        anchors.top: parent.top
        anchors.topMargin: 80
        width: 30
        height: 30
        source: "../images/back.jpg"
        sourceSize.width: 100
        sourceSize.height: 100
        MouseArea {
            anchors.fill: parent
            onClicked: { stack.pop() ; revert() }
        }
    }

    // Registration Field -- Fingerprint, "Place finger to scan" Information
    Image {
        id: fingerprint
        y: 550
        width: 140
        height: 140
        visible: false
        source: "../images/whitefinger.jpg"
        anchors.horizontalCenter: parent.horizontalCenter
        fillMode: Image.PreserveAspectFit
        MouseArea {
            anchors.fill: parent
            onClicked: {
                if ( regno_field.text === "" | password.text === "" ) { displaydialog(2)
                } else { backend.checkuser(regno_field.text) }
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
        text: qsTr("User Reg No")
        font.pixelSize: 20
        verticalAlignment: Text.AlignVCenter
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
            placeholderText: qsTr("Reg No. / Username")
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
    // Registration Field contd -- Acc Name Text box
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
        Text {
            id: enterfingerprint
            x: 336
            width: 140
            height: 40
            text: qsTr("Enter Fingerprint  >")
            anchors.right: password_box.right
            anchors.top: password_box.bottom
            font.pixelSize: 16
            font.bold: true
            horizontalAlignment: Text.AlignRight
            anchors.topMargin: 13
            MouseArea {
                anchors.fill: parent
                onClicked: { fingerprint.visible = true ; goback.visible = true ; enterfingerprint.visible = false }
            }
        }
        Text {
            id: goback
            visible: false
            x: 336
            width: 140
            height: 40
            text: qsTr("<  Go Back")
            anchors.right: password_box.right
            anchors.top: password_box.bottom
            font.pixelSize: 16
            font.bold: true
            horizontalAlignment: Text.AlignRight
            anchors.topMargin: 13
            MouseArea {
                anchors.fill: parent
                onClicked: { fingerprint.visible = false ; goback.visible = false ; enterfingerprint.visible = true }
            }
        }
    }
    Connections {
        target: backend

        function onInvalid(number) { if (number === 1) { displaydialog(1) } }
        function onProceed(value) { if (value === 1) { displaybigdialog(1,1) } }
    }

    // Page Information -- Feature name
    Text {
        id: modename
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.horizontalCenterOffset: -40
        width: 150
        height: 20
        text: qsTr("Registration Page")
        font.pixelSize: 22
        anchors.top: parent.top
        anchors.topMargin: 80
        font.family: "Verdana"
        font.styleName: "Regular"
        font.bold: true
    }
    Component.onCompleted: {
        image.scale = 0.6
        image.anchors.horizontalCenterOffset = 180
        image.anchors.topMargin = 20
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
        if (functionnum === 1) { information2.text = qsTr("Reg No is either already in use or doesn't exist") }
        // 2 incompleteDialog
        if (functionnum === 2) { information2.text = qsTr("Details You Entered Are Incomplete. Fill the empty fields") }

    }
    function closebigdialog() { dialog_big.visible = false ; f1_switch.checked  = false }

    function displaybigdialog(buttonnum, functionnum) {
        if (buttonnum === 0) { dialog_big.visible = true ; button_number.checked = false ; good_picture.visible = true }
        if (buttonnum === 1) { dialog_big.visible = true ; button_number.checked = true ; good_picture.visible = true }
        if (buttonnum === 2) { dialog_big.visible = true ; button_number.checked = true ; good_picture.visible = false }

        // 1 confirmDialog
        if (functionnum === 1) {
            information.text = qsTr("You Are About To Register " + regno_field.text + ". Do You Want To Continue?")
            header.text = qsTr("Registering User")
            f1_switch.checked = true
            right_button.clicked.connect(closebigdialog)
        }
        // 2 successDialog
        if (functionnum === 2) {
            information.text = qsTr("New User Has Been Registered Successfully")
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
                onClicked: { backend.registeruser([regno_field.text, accname_field.text, password.text, password.text]) ; displaybigdialog(0,2) ; exitbutton.visible = true}
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
        onClicked: { stack.replace('P3Form.ui.qml') ; revert() }
    }
}
