import QtQuick 2.14
import QtQuick.Controls 2.5
import "keyboard"

Item {
    id: window
    property string code: ""
    property string correctpage: ""
    property int stationpicked: 0
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
            anchors.topMargin: 40
            width: 30
            height: 30
            source: "../images/back.jpg"
            sourceSize.width: 100
            sourceSize.height: 100
            MouseArea {
                anchors.fill: parent
                onClicked: { backend.stopthread() ; revert() ; page_loader.source = correctpage }
            }
        }
        Rectangle {
            anchors.top: next_button.top ; anchors.topMargin: 0.5 ; visible: next_button.visible
            anchors.left: next_button.left ; anchors.leftMargin: -1
            height: next_button.height + 2.5 ; width: next_button.width + 1.5 ; radius: next_button.radius + 1
            color: "#e0e0e0"
        }
        Rectangle {
            id: next_button
            color: "#ffffff"
            radius: 8
            width: 180
            height: 53
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 100
            anchors.horizontalCenter: parent.horizontalCenter
            Text {
                width: 160
                height: 40
                text: qsTr("Next")
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: 20
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.bold: true
                font.family: "Verdana"
                anchors.horizontalCenter: parent.horizontalCenter
            }
            MouseArea {
                id: next_area
                anchors.fill: parent
                onClicked: {
                    if (super_box.checked === true) { code = "Super Admin"
                    } else { code = "Admin" }

                    if ( regno_field.text === "" | accname_field.text === "" | password.text === "" ) { displaydialog(2) }
                    else if(stationpicked === 0) { displaydialog(4) }
                    else { backend.checksuper([regno_field.text, code]) }
                }
            }
        }

        // Registration Field contd -- Reg No Text box
        Text {
            id: regno
            anchors.top: parent.top ; anchors.topMargin: 120
            height: 41
            anchors.left: parent.left
            anchors.leftMargin: 100
            anchors.right: parent.right
            text: qsTr("Username")
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
                placeholderText: qsTr("Username")
                onPressed: { hidekeyboard() ; inputPaneln.showKeyboard = true }
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
        // Registration Field contd -- Account Name Text box
        Text {
            id: accname
            anchors.top: parent.top ; anchors.topMargin: 240
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
                onPressed: { hidekeyboard() ; inputPanel.showKeyboard = true }
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
        // Registration Field contd -- Station
        Text {
            id: stationpicker
            anchors.top: parent.top ; anchors.topMargin: 360
            height: 41
            anchors.left: parent.left ; anchors.leftMargin: regno.anchors.leftMargin
            anchors.right: parent.right
            text: qsTr("Station")
            font.pixelSize: regno.font.pixelSize
            verticalAlignment: Text.AlignVCenter
            font.capitalization: Font.AllUppercase
            font.family: "Verdana"
            font.styleName: "Regular"
            font.bold: true
            MouseArea {
                id: stationpicker_area
                visible: (!verwindow.visible) & (!enrollwindow.visible)
                anchors.fill: parent
                onClicked: { background.visible = menu.visible = true ; menu.scale = 1 }
            }
            Text {
                id: stationname
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: 120
                height: 41
                font.pixelSize: 17
                verticalAlignment: Text.AlignVCenter
                text: qsTr("<i>Click to select station</i>")
                font.family: "Verdana"
                font.styleName: "Regular"
            }
            Image {
                id: clearstation
                height: 14
                width: height
                anchors.verticalCenter: stationname.verticalCenter
                anchors.right: parent.right
                anchors.rightMargin: 10 + regno.anchors.leftMargin
                source: "../images/closebutton.png"
                sourceSize.width: 20
                sourceSize.height: 20
                MouseArea {
                    id: clstat
                    anchors.fill: parent
                    onClicked: { stationname.text = qsTr("<i>Click to select station</i>") ; stationpicked = 0 ; stationname.font.pixelSize = 17  }
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
                onPressed: { hidekeyboard() ; inputPaneln.showKeyboard = true }
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
        }

        // (Super) Admin Check box
        FocusScope {
            id: row
            x: regno.anchors.leftMargin
            y: 530
            width: 260
            height: 40
            CheckBox {
                id: super_box
                width: 13
                height: 13
                scale: 1.15
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.topMargin: 6
                anchors.leftMargin: 6
                onCheckedChanged: {
                    if ( regno_field.text === "" | accname_field.text === "" | password.text === "" ) { displaydialog(2) }
                    if (super_box.checked === true & admin_box.checked === true) { admin_box.checked = false }
                }
            }

            Text {
                id: super_text
                height: 20
                text: qsTr("Super Admin")
                anchors.verticalCenter: super_box.verticalCenter
                anchors.left: super_box.right
                anchors.leftMargin: 20
                font.pixelSize: 18
                font.family: "Verdana"                
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
                anchors.leftMargin: 40
                scale: super_box.scale
                onCheckedChanged: {
                    if ( regno_field.text === "" | accname_field.text === "" | password.text === "" ) { displaydialog(2) }
                    if (admin_box.checked === true & super_box.checked === true) { super_box.checked = false }
                }
            }

            Text {
                id: admin_text
                height: 20
                text: qsTr("Admin")
                anchors.verticalCenter: super_box.verticalCenter
                anchors.left: admin_box.right
                font.pixelSize: super_text.font.pixelSize
                font.family: "Verdana"
                anchors.leftMargin: super_text.anchors.leftMargin
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
            font.pixelSize: 25
            anchors.top: parent.top
            anchors.topMargin: 40
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
                sourceSize.height: 300
                sourceSize.width: 300
                anchors.horizontalCenter: parent.horizontalCenter
                fillMode: Image.PreserveAspectFit
            }
            // Navigation -- Back button, Submit button, Use Pin, Use Fingerprint, Switch
            Image {
                id: back
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
                    onClicked: { verwindow.visible = false ; next_area.visible = true ; username1.text = '' ; password1.text = '' ; fingerprint1.opacity = 0 }
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
                width: 150
                height: 53
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 120
                anchors.right: parent.right
                anchors.rightMargin: use_fingerprint_button1.anchors.leftMargin
                color: "black"
                radius: 8
                Text {
                    id: submit_text
                    width: 150
                    height: 40
                    color: "white"
                    text: qsTr("Submit")
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
                        backend.biometrics([3, regno_field.text, accname_field.text, code, stationname.text, password.text, username1.text, password1.text , "Pin"])
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
                radius: submit_button1.radius
                //border.width: 3
                width: submit_button1.width
                height: submit_button1.height
                anchors.bottom: submit_button1.bottom
                visible: !switch1.checked
                anchors.left: parent.left
                anchors.leftMargin: use_fingerprint_button1.anchors.leftMargin
                Text {
                    width: 150
                    height: 40
                    text: qsTr("Use Pin")
                    anchors.verticalCenter: parent.verticalCenter
                    font.pixelSize: submit_text.font.pixelSize
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font.bold: true
                    font.family: "Verdana"
                    anchors.horizontalCenter: parent.horizontalCenter
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: { switch1.checked = !switch1.checked ; fingerprint1.opacity = 0 }
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
                visible: use_pin_button1.visible
                width: constant.button1width - 20 // 230 - 20
                height: constant.button1height // 53
                anchors.bottom: parent.bottom
                anchors.bottomMargin: constant.button2bottommargin // 120
                anchors.right: parent.right
                anchors.rightMargin: use_fingerprint_button1.anchors.leftMargin
                color: "black"
                radius: constant.button2radius // 8
                Text {
                    id: authenticate_text
                    width: 150
                    height: 40
                    color: "white"
                    text: qsTr("Authenticate")
                    anchors.verticalCenter: parent.verticalCenter
                    font.pixelSize: submit_text.font.pixelSize
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font.bold: true
                    font.family: "Verdana"
                    anchors.horizontalCenter: parent.horizontalCenter
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: { if (username1.text === "") { displaydialog(5) }
                        else { fingerprint1.opacity = 1 } }
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
                width: 230
                height: submit_button1.height
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 120
                visible: switch1.checked
                anchors.left: parent.left
                anchors.leftMargin: biometric1.anchors.leftMargin + 100
                Text {
                    width: 160
                    height: 40
                    text: qsTr("Use Fingerprint")
                    anchors.verticalCenter: parent.verticalCenter
                    font.pixelSize: submit_text.font.pixelSize
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
            visible: false //!switch1.checked
            anchors.left: parent.left ; anchors.leftMargin: 100
            y: 210
            width: 152
            height: 41
            text: qsTr("Super Admin")
            font.pixelSize: regno.font.pixelSize
            verticalAlignment: Text.AlignVCenter
            font.capitalization: Font.AllUppercase
            font.family: "Verdana"
            font.styleName: "Regular"
            font.bold: true
        }
        Image {
            id: fingerprint1
            visible: !switch1.checked
            opacity: 0
            y: 330
            width: 200
            height: 200
            source: "../images/whitefinger.jpg"
            anchors.horizontalCenter: parent.horizontalCenter
            fillMode: Image.PreserveAspectFit
            onOpacityChanged: {
                if (opacity == 1){ backend.biometrics([3, regno_field.text, accname_field.text, code, stationname.text, password.text, username1.text, "Fingerprint"]) ; enrolldialog("place finger on scanner") }
                else if (opacity == 0){ backend.stopthread() }
            }
            Behavior on opacity { PropertyAnimation { duration: 500 } } 
        }
        /*Text {
            id: place_finger1
            font.family: "Calibri"
            visible: !switch1.checked
            x: 297
            width: 262
            height: 50
            text: qsTr("Place Finger on Scanner")
            anchors.top: fingerprint1.bottom
            anchors.topMargin: 10
            font.pixelSize: 22
            font.italic: true
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignTop            
            anchors.horizontalCenter: fingerprint1.horizontalCenter
        }*/

        // Typed Elements -- Rank, Username & Pin Text box
        Text {
            id: superadmin1
            //visible: switch1.checked
            y: 210
            height: 41
            anchors.left: parent.left
            anchors.leftMargin: biometric1.anchors.leftMargin
            anchors.right: parent.right
            text: qsTr("Super Admin")
            font.pixelSize: regno.font.pixelSize
            verticalAlignment: Text.AlignVCenter
            font.capitalization: Font.AllUppercase
            font.family: "Verdana"
            font.styleName: "Regular"
            font.bold: true
            TextField {
                id: username1
                font.family: "Calibri"
                width: username_box1.width
                height: username_box1.height - 2
                placeholderText: qsTr("Username")
                font.pixelSize: 20
                topPadding: 7
                //leftPadding: 9
                rightPadding: 35
                anchors.verticalCenter: username_box1.verticalCenter
                anchors.left: username_box1.left
                anchors.right: username_box1.right
                anchors.rightMargin: 1
                anchors.leftMargin: 1
                onPressed: inputPaneln.showKeyboard = true
                Rectangle {
                    anchors.fill: parent ; color: "transparent" ; border.width: 1 ; border.color: "white"
                }
            }
            Rectangle {
                id: username_box1
                height: 40
                color: "transparent"
                radius: 5
                //border.width: 1
                anchors.left: parent.left
                anchors.top: parent.bottom
                anchors.right: parent.right
                anchors.rightMargin: biometric1.anchors.leftMargin
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
            anchors.left: superadmin1.left
            y: 400
            width: 152
            height: 41
            text: qsTr("Pin")
            font.pixelSize: superadmin1.font.pixelSize
            verticalAlignment: Text.AlignVCenter
            font.capitalization: Font.AllUppercase
            font.family: "Verdana"
            font.styleName: "Regular"
            font.bold: true
            TextField {
                id: password1
                font.family: "Calibri"
                echoMode: TextInput.Password
                width: username_box1.width
                height: username_box1.height - 2
                placeholderText: qsTr("Pin")
                font.pixelSize: username1.font.pixelSize
                topPadding: 7
                //leftPadding: 9
                rightPadding: 35
                anchors.verticalCenter: password_box1.verticalCenter
                anchors.left: password_box1.left
                anchors.right: password_box1.right
                anchors.rightMargin: 1
                anchors.leftMargin: 1
                onPressed: inputPaneln.showKeyboard = true
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
            anchors.horizontalCenterOffset: -60
            width: 150
            height: 20
            text: qsTr("Registration Verification")
            font.pixelSize: 25
            anchors.top: parent.top
            anchors.topMargin: 40
            font.family: "Verdana"
            font.styleName: "Regular"
            font.bold: true
        }
    }

    // Enrollment Page
    Rectangle {
        id: enrollwindow
        visible: false
        anchors.fill: parent

        // Fingerprint, Follow the prompt
        Image {
            id: fingerprint
            opacity: 0
            y: 200
            width: 250
            height: 250
            source: "../images/whitefinger.jpg"
            anchors.horizontalCenter: parent.horizontalCenter
            fillMode: Image.PreserveAspectFit
            onOpacityChanged: if (opacity == 0){ backend.stopthread() }
            Behavior on opacity { PropertyAnimation { duration: 500 } }
        }
        Text {
            id: follow_prompts
            width: 262
            height: 50
            text: qsTr("Follow The Prompts As They Pop Up")
            anchors.top: fingerprint.bottom
            anchors.topMargin: 20
            anchors.horizontalCenter: fingerprint.horizontalCenter
            font.family: "Calibri" ; font.styleName: "Regular"
            font.pixelSize: 22
            font.italic: true
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignTop
        }
        // Enroll Page Information -- Feature Name
        Text {
            id: modename2
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.horizontalCenterOffset: -60
            width: 150
            height: 20
            text: qsTr("Biometrics Enrollment")
            font.pixelSize: 25
            anchors.top: parent.top
            anchors.topMargin: 40
            font.family: "Verdana"
            font.styleName: "Regular"
            font.bold: true
        }
    }

    Connections {
        target: backend

        function onEnrollinfo(info) { enrolldialog(info) }
        function onRetryenroll() { enrollwindow.visible = false ; fingerprint.opacity = fingerprint1.opacity = 0 }

        function onInvalid(number) { if (number === 1) { displaydialog(1) } }
        function onIncorrect(number) { if (number === 3) { fingerprint1.opacity = 0 ; displaydialog(3) } }
        function onProceed(value) {
            if (value === 1) { displaybigdialog(0,2) ; exitbutton.visible = true }
            else if (value === 2) { if (correctpage === 'Superview.ui.qml'){ displaybigdialog(2,3) } else { displaybigdialog(2,1) } }
            else if (value === 3) { enrollwindow.visible = true ; fingerprint.opacity = 1 ; verwindow.visible = false }
        }
        function onFinishedprocess(pagetoload){ correctpage = pagetoload }
        function onHidekeyboard() { inputPaneln.showKeyboard = inputPanel.showKeyboard = false }
    }

    Component.onCompleted: {
        image.scale = logo.scale = 0.6
        image.anchors.horizontalCenterOffset = logo.anchors.horizontalCenterOffset = (mainwindow.width / 2) - 45
        image.anchors.topMargin = logo.anchors.topMargin = -25
    }
    function revert() { image.scale = 1 ; image.anchors.horizontalCenterOffset = image.anchors.topMargin = 0 }
    function hidekeyboard() { inputPaneln.showKeyboard = inputPanel.showKeyboard = false }
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
        dialog_small.anchors.bottomMargin = 20
        dialog_timer.running = true
        information2.font.bold = false
        information2.font.pixelSize = 20
        // 1 invalidDialog
        if (functionnum === 1) { information2.text = qsTr("Username is already taken") }
        // 2 incompleteDialog
        if (functionnum === 2) {
            information2.text = qsTr("Details You Entered Are Incomplete. Fill the empty fields")
            super_box.checked = admin_box.checked = false
        }
        // 3 incorrectDialog
        if (functionnum === 3) { information2.text = qsTr("Invalid Verification Username or Password") }
        // 4 stationDialog
        if (functionnum === 4) { information2.text = qsTr("You haven't selected a station") }
        // 5 incompleteDialog
        if (functionnum === 5) { information2.text = qsTr("Username field is empty. Fill all fields before verifying") }
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
    function closebigdialog() { dialog_big.visible = false ; f1_switch.checked = f2_switch.checked = false }

    function closemenu() { menu.scale = 0 ; background.visible = menu.visible = false }

    function displaybigdialog(buttonnum, functionnum) {
        if (buttonnum === 0) { dialog_big.visible = true ; button_number.checked = false ; good_picture.visible = false ; box.radius = 5 }
        if (buttonnum === 1) { dialog_big.visible = true ; button_number.checked = true ; good_picture.visible = true }
        if (buttonnum === 2) { dialog_big.visible = true ; button_number.checked = true ; good_picture.visible = false ; box.radius = 10 }

        // 1 confirmDialog
        if (functionnum === 1) {
            information.text = qsTr("You Are About To Register " + code + " " + regno_field.text + ". Do You Want To Continue?")
            header.text = qsTr("Registering " + code)
            f1_switch.checked = true
            right_button.clicked.connect(closebigdialog)
        }
        // 2 successDialog
        if (functionnum === 2) {
            information.text = qsTr("New " + code + " Has Been Registered Successfully")
            header.text = qsTr("Registration Successful")
        }
        // 3 confirmDialog
        if (functionnum === 3) {
            information.text = qsTr("You Are About To Register " + code + " " + regno_field.text + ". Do You Want To Continue?")
            header.text = qsTr("Registering " + code)
            f2_switch.checked = true
            right_button.clicked.connect(closebigdialog)
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
                onClicked: { verwindow.visible = true ; closebigdialog() ; next_area.visible = false }
            }
            MouseArea {
                id: left_f2
                visible: button_number.checked & f2_switch.checked
                anchors.fill: b1
                hoverEnabled: true
                onEntered: { b1.color = "#a0a0a0" }
                onExited: { b1.color = "black" }
                onClicked: { closebigdialog() ; next_area.visible = false ; backend.biometrics([3, regno_field.text, accname_field.text, code, stationname.text, password.text, "Verified"]) }
                // onClicked: { closebigdialog() ; next_area.visible = false ; displaybigdialog(0,2) ; exitbutton.visible = true }
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
                anchors.bottom: b1.bottom
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
        Switch { // For Superview
            id: f2_switch
            visible: false
            checked: false
        }
    }
    MouseArea {
        id: exitbutton
        visible: false
        anchors.fill: parent
        onClicked: { revert() ; page_loader.source = correctpage }
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
    // Menu Bar Items Components -- First, Second, Third; Menu 21, Menu 22
    Rectangle {
        id: menu
        visible: false
        color: "#f8f8f8"
        anchors.left: parent.left ; anchors.leftMargin: stationpicker.anchors.leftMargin + stationname.anchors.leftMargin
        anchors.top: parent.top
        anchors.topMargin: stationpicker.anchors.topMargin
        width: 180
        height: (40*3)
        radius: 3
        scale: 0
        transformOrigin: Item.Top
        Behavior on scale { PropertyAnimation { duration: 100 } }
        Rectangle {
            id: first_menu
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.topMargin: menu.radius
            anchors.right: parent.right
            height: 40
            color: menu.color
            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                onEntered: first_menu.color = "#e8e8e8"
                onExited: first_menu.color = menu.color
                onClicked: { closemenu() ; stationname.text = "Caf 1" ; stationpicked = 1 ; stationname.font.pixelSize = 17 }
            }
            Text {
                id: caf1
                anchors.verticalCenter: first_menu.verticalCenter
                anchors.right: parent.right
                verticalAlignment: Text.AlignVCenter
                height: 30
                font.family: "Verdana"
                width: parent.width
                font.pixelSize: 18
                text: qsTr("Caf 1")
                leftPadding: 25
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
            height: first_menu.height
            color: menu.color
            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                onEntered: second_menu.color = "#e8e8e8"
                onExited: second_menu.color = menu.color
                onClicked: { closemenu() ; stationname.text = "Caf 2" ; stationpicked = 1 ; stationname.font.pixelSize = 17 }
            }
            Text {
                id: caf2
                anchors.right: parent.right
                anchors.verticalCenter: second_menu.verticalCenter
                verticalAlignment: Text.AlignVCenter
                height: 30
                font.family: "Verdana"
                width: parent.width
                font.pixelSize: caf1.font.pixelSize
                text: qsTr("Caf 2")
                leftPadding: caf1.leftPadding
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
                onClicked: { closemenu() ; stationname.text = "CDS Buttery" ; stationpicked = 1 ; stationname.font.pixelSize = 17 }
            }
            Text {
                id: cdsbuttery
                anchors.right: parent.right
                anchors.verticalCenter: third_menu.verticalCenter
                verticalAlignment: Text.AlignVCenter
                height: 30
                font.family: "Verdana"
                width: parent.width
                font.pixelSize: caf1.font.pixelSize
                text: qsTr("CDS Buttery")
                leftPadding: caf1.leftPadding
            }
        }
    }
}
