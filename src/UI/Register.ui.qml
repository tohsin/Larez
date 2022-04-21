import QtQuick 2.14
import QtQuick.Controls 2.5

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
        anchors.topMargin: 40
        width: 30
        height: 30
        source: "../images/back.jpg"
        sourceSize.width: 100
        sourceSize.height: 100
        MouseArea {
            anchors.fill: parent
            onClicked: { revert() ; stack.pop() ; stack.replace('P3Form.ui.qml') }
        }
    }

    // Registration Field -- Fingerprint, "Place finger to scan" Information
    Image {
        id: fingerprint
        visible: false
        opacity: 0
        y: 530
        width: 140
        height: 140        
        source: "../images/whitefinger.jpg"
        anchors.horizontalCenter: parent.horizontalCenter
        fillMode: Image.PreserveAspectFit
        Behavior on opacity { PropertyAnimation { duration: 500 } }
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
        visible: fingerprint.visible
        opacity: fingerprint.opacity
        x: 297
        width: 262
        height: 50        
        text: qsTr("Place Finger on Scanner to Register Fingerprint")
        anchors.top: fingerprint.bottom
        font.family: "Calibri"
        font.pixelSize: 22
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
        anchors.leftMargin: 100
        anchors.right: parent.right
        text: qsTr("User Reg No")
        font.pixelSize: 20
        verticalAlignment: Text.AlignVCenter
        font.capitalization: Font.AllUppercase
        font.family: "Verdana"
        font.styleName: "Regular"
        font.bold: true
        TextField {
            id: regno_field
            font.family: "Calibri"
            height: regno_box.height - 2
            anchors.verticalCenter: regno_box.verticalCenter
            anchors.left: regno_box.left
            anchors.right: regno_box.right
            anchors.rightMargin: 1
            anchors.leftMargin: 1
            baselineOffset: 15
            font.pointSize: 12
            topPadding: 7
            //leftPadding: 9
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
            //border.width: 1
            anchors.left: parent.left
            anchors.top: parent.bottom
            anchors.right: parent.right
            anchors.rightMargin: regno.anchors.leftMargin
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
        anchors.left: regno.left
        anchors.right: parent.right
        text: qsTr("Account Name")
        font.pixelSize: regno.font.pixelSize
        verticalAlignment: Text.AlignVCenter
        font.capitalization: Font.AllUppercase
        font.family: "Verdana"
        font.styleName: "Regular"
        font.bold: true
        TextField {
            id: accname_field
            font.family: "Calibri"
            height: accname_box.height - 2
            anchors.verticalCenter: accname_box.verticalCenter
            anchors.left: accname_box.left
            anchors.right: accname_box.right
            anchors.rightMargin: 1
            anchors.leftMargin: 1
            baselineOffset: 15
            font.pointSize: 12
            topPadding: 7
            //leftPadding: 9
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
            //border.width: 1
            anchors.left: parent.left
            anchors.top: parent.bottom
            anchors.right: parent.right
            anchors.rightMargin: regno.anchors.leftMargin
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
        anchors.left: regno.left
        y: 430
        width: 152
        height: 41
        text: qsTr("Pin")
        font.pixelSize: regno.font.pixelSize
        verticalAlignment: Text.AlignVCenter
        font.capitalization: Font.AllUppercase
        font.family: "Verdana"
        font.styleName: "Regular"
        font.bold: true
        TextField {
            id: password
            font.family: "Calibri"
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
            //leftPadding: 9
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
        Text {
            id: enterfingerprint
            x: 336
            width: 140
            height: 40
            text: qsTr("Enter Fingerprint  >")
            anchors.right: password_box.right
            anchors.top: password_box.bottom
            font.family: "Verdana"
            font.pixelSize: 18
            font.bold: true
            horizontalAlignment: Text.AlignRight
            anchors.topMargin: 15
            MouseArea {
                anchors.fill: parent
                onClicked: { fingerprint.visible = true ; fingerprint.opacity = 1 ; goback.visible = true ; enterfingerprint.visible = false }
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
            font.family: enterfingerprint.font.family
            font.pixelSize: enterfingerprint.font.pixelSize
            font.bold: true
            horizontalAlignment: Text.AlignRight
            anchors.topMargin: enterfingerprint.anchors.topMargin
            MouseArea {
                anchors.fill: parent
                onClicked: { fingerprint.visible = false ; fingerprint.opacity = 0 ; goback.visible = false ; enterfingerprint.visible = true }
            }
        }
    }
    Connections {
        target: backend

        function onInvalid(number) { if (number === 1) { displaydialog(1) } }
        function onProceed(value) { if (value === 1) { displaybigdialog(2,1) } }
    }

    // Page Information -- Feature name
    Text {
        id: modename
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.horizontalCenterOffset: -40
        width: 150
        height: 20
        text: qsTr("Registration Page")
        font.pixelSize: 25
        anchors.top: parent.top
        anchors.topMargin: 40
        font.family: "Verdana"
        font.styleName: "Regular"
        font.bold: true
    }
    Component.onCompleted: {
        image.scale = 0.6
        image.anchors.horizontalCenterOffset = (mainwindow.width / 2) - 45
        image.anchors.topMargin = -25
    }
    function revert() { image.scale = 1 ; image.anchors.horizontalCenterOffset = 0 ; image.anchors.topMargin = 0 }

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
        // 1 invalidDialog
        if (functionnum === 1) { information2.text = qsTr("Reg No is either already in use or doesn't exist") }
        // 2 incompleteDialog
        if (functionnum === 2) { information2.text = qsTr("Details You Entered Are Incomplete. Fill the empty fields") }

    }
    function closebigdialog() { dialog_big.visible = false ; f1_switch.checked  = false }

    function displaybigdialog(buttonnum, functionnum) {
        if (buttonnum === 0) { dialog_big.visible = true ; button_number.checked = false ; good_picture.visible = false ; box.radius = 5 }
        if (buttonnum === 1) { dialog_big.visible = true ; button_number.checked = true ; good_picture.visible = true }
        if (buttonnum === 2) { dialog_big.visible = true ; button_number.checked = true ; good_picture.visible = false ; box.radius = 10 }

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
                onClicked: { backend.registeruser([regno_field.text, accname_field.text, password.text, password.text]) ; displaybigdialog(0,2) ; exitbutton.visible = true }
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
        onClicked: { revert() ; stack.replace('P3Form.ui.qml') }
    }
}
