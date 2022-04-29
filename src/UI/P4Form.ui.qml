import QtQuick 2.14
import QtQuick.Controls 2.5
import "keyboard"

Item {
    id: window
    Rectangle {
        id: time ; width: 10 ; height: 10 ; visible: false
    }

    // Navigation Buttons -- Use Pin, Log in, Use fingerprint, Back button, Switch for Pin/Fingerprint, register account?
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
        anchors.left: parent.left
        anchors.leftMargin: use_fingerprint_button.anchors.leftMargin
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
        anchors.top: log_in_button.top ; anchors.topMargin: 0.5 ; visible: log_in_button.visible
        anchors.left: log_in_button.left ; anchors.leftMargin: -1
        height: log_in_button.height + 2.5 ; width: log_in_button.width + 1.5 ; radius: log_in_button.radius + 1
        color: "#e0e0e0"
    }
    Rectangle {
        id: log_in_button
        visible: use_fingerprint_button.visible
        width: use_pin_button.width
        height: use_pin_button.height
        anchors.bottom: use_pin_button.bottom
        anchors.right: parent.right
        anchors.rightMargin: biometrics.anchors.leftMargin + 100
        color: "black"
        radius: use_pin_button.radius
        Text {
            width: 150
            height: 40
            color: "white"
            text: qsTr("Log In")
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
            onClicked: { if (username.text === "" | password.text === "") { displaydialog(3) }
                else {
                    stack.push('Loadfeature.ui.qml');
                    backend.studentuser([username.text, password.text, "Pin"]);
                }
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
        radius: use_pin_button.radius
        //border.width: 3
        width: 230
        height: use_pin_button.height
        anchors.bottom: use_pin_button.bottom
        visible: switch1.checked
        anchors.left: parent.left
        anchors.leftMargin: log_in_button.anchors.rightMargin
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
            onClicked: { switch1.checked = !switch1.checked }
        }
    }
    // Navigation Buttons -- Authenticate
    Rectangle {
        anchors.top: authenticate_button.top ; anchors.topMargin: 0.5 ; visible: authenticate_button.visible
        anchors.left: authenticate_button.left ; anchors.leftMargin: -1
        height: authenticate_button.height + 2.5 ; width: authenticate_button.width + 1.5 ; radius: authenticate_button.radius + 1
        color: "#e0e0e0"
    }
    Rectangle {
        id: authenticate_button
        visible: use_pin_button.visible
        width: constant.button1width - 20 // 230 - 20
        height: constant.button1height // 53
        anchors.bottom: parent.bottom
        anchors.bottomMargin: constant.button2bottommargin // 120
        anchors.right: parent.right
        anchors.rightMargin: use_fingerprint_button.anchors.leftMargin
        color: "black"
        radius: constant.button2radius // 8
        Text {
            id: authenticate_text
            width: 150
            height: 40
            color: "white"
            text: qsTr("Authenticate")
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
            onClicked: { if (username.text === "") { displaydialog(3) }
                else { fingerprint.opacity = 1 } }
        }
    }

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
            onClicked: { backend.stopthread() ; stack.pop() ; stack.replace('P3Form.ui.qml') }
        }
    }
    Switch {
        id: switch1
        checked: false
        visible: false
    }
    Text {
        id: registeraccount
        //visible: use_pin_button.visible
        anchors.bottom: use_pin_button.top
        anchors.bottomMargin: 50
        anchors.left: biometrics.left
        width: 300
        height: 41
        text: qsTr("No Account? Click here to <b>Register</b>")
        font.pixelSize: constant.fontsize3 // 18
        verticalAlignment: Text.AlignVCenter
        font.capitalization: Font.Capitalize
        font.family: "Verdana"
        font.styleName: "Regular"
        MouseArea {
            anchors.right: parent.right; anchors.verticalCenter: parent.verticalCenter
            height: parent.height; width: 80
            onClicked: { backend.stopthread() ; backend.feature("Register") ; stack.replace("Register.ui.qml") }
        }
    }

    // Biometric Elements -- User Rank, Fingerprint picture, "Place Finger" text
    Text {
        id: biometrics
        visible: false //!switch1.checked
        anchors.left: parent.left ; anchors.leftMargin: 100
        anchors.top: parent.top ; anchors.topMargin: 210
        width: 152
        height: 41
        text: qsTr("Customer")
        font.pixelSize: 20
        font.bold: true
        verticalAlignment: Text.AlignVCenter        
        font.capitalization: Font.AllUppercase
        font.family: "Verdana"
        font.styleName: "Regular"
    }
    Image {
        id: fingerprint
        visible: use_pin_button.visible
        opacity: 0
        y: 320
        width: 200
        height: width
        source: "../images/whitefinger.jpg"
        anchors.horizontalCenter: parent.horizontalCenter
        fillMode: Image.PreserveAspectFit
        onOpacityChanged: {
            if (opacity == 1){ backend.biometrics([5, username.text,"Fingerprint"]) ; enrolldialog("place finger on scanner") }
            else if (opacity == 0){ backend.stopthread() }
        }        
        Behavior on opacity { PropertyAnimation { duration: 500 } }
    }
    /*Text {
        id: place_finger
        font.family: "Calibri"
        visible: use_pin_button.visible
        opacity: fingerprint.opacity
        x: 297
        width: 262
        height: 50        
        text: qsTr("Place Finger on Scanner")
        anchors.top: fingerprint.bottom
        anchors.topMargin: 10
        font.pixelSize: 22
        font.italic: true
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignTop        
        anchors.horizontalCenter: fingerprint.horizontalCenter
    }*/

    // Typed Elements -- Rank, Username & Pin Text box
    Text {
        id: customer
        //visible: switch1.checked
        anchors.top: biometrics.top
        height: 41
        anchors.left: biometrics.left
        anchors.right: parent.right
        text: qsTr("Customer")
        font.pixelSize: biometrics.font.pixelSize
        font.bold: true
        verticalAlignment: Text.AlignVCenter
        font.capitalization: Font.AllUppercase
        font.family: "Verdana"
        font.styleName: "Regular"
        TextField {
            id: username
            font.family: "Calibri"
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
            onPressed: inputPaneln.showKeyboard = true
            placeholderText: qsTr("Reg No. / Username")
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
            anchors.rightMargin: biometrics.anchors.leftMargin
            Rectangle {
                color: "black"
                height: 1
                anchors.left: parent.left
                anchors.top: parent.bottom
                anchors.topMargin: 0.5
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
        visible: use_fingerprint_button.visible
        anchors.left: biometrics.left
        anchors.top: parent.top ; anchors.topMargin: 400
        width: 152
        height: 41
        text: qsTr("Pin")
        font.pixelSize: customer.font.pixelSize
        font.bold: true
        verticalAlignment: Text.AlignVCenter        
        font.capitalization: Font.AllUppercase
        font.family: "Verdana"
        font.styleName: "Regular"        
        TextField {
            id: password
            font.family: "Calibri"
            echoMode: TextInput.Password
            height: username_box.height - 2
            visible: use_fingerprint_button.visible
            anchors.verticalCenter: password_box.verticalCenter
            anchors.left: password_box.left
            anchors.right: password_box.right
            anchors.rightMargin: 1
            anchors.leftMargin: 1
            font.pointSize: 12
            topPadding: 7
            //leftPadding: 9
            rightPadding: 35
            onPressed: inputPaneln.showKeyboard = true
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
            anchors.topMargin: 0
            anchors.leftMargin: 0
            visible: use_fingerprint_button.visible
            Rectangle {
                color: "black"
                height: 1
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

    Connections {
        target: backend

        function onLoadstack() { stack.push('Loadfeature.ui.qml') }
        function onBiofailed() { displaydialog(2) }

        function onIncorrect(number) { if (number === 1) { fingerprint.opacity = 0 ; displaydialog(1) } }
        function onHidekeyboard() { inputPaneln.showKeyboard = inputPanel.showKeyboard = false }
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

    // Dialog Box functions
    function displaydialog(functionnum) {
        center_border2.visible = bad_picture2.visible = true
        dialog_timer.running = false ; time.width = 10
        dialog_small.anchors.bottomMargin = constant.smalldialogbottommargin // 20
        dialog_timer.running = true
        information2.font.bold = false
        information2.font.pixelSize = 20
        // 1 incorrectDialog
        if (functionnum === 1) { information2.text = qsTr("Invalid Username or Password") }
        // 2 bioDialog
        if (functionnum === 2) { information2.text = qsTr("Fingerprint did not match") }
        // 3 emptyDialog
        if (functionnum === 3) { information2.text = qsTr("Fill your details before logging in") }
    }
    function enrolldialog(info) {
        center_border2.visible = bad_picture2.visible = false
        dialog_timer.running = false ; time.width = 10
        dialog_small.anchors.bottomMargin = 40
        dialog_timer.running = true
        information2.font.bold = true
        information2.font.pixelSize = 24
        information2.text = qsTr(info)
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
            visible: center_border2.visible
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
    //Component.onCompleted: fingerprint.opacity = 1
}
