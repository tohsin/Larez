import QtQuick 2.14
import QtQuick.Controls 2.5
import "keyboard"

Item {
    id: window

    property var switchmap: {
        2: multi_switch2,
        3: multi_switch3
    }
    property var amountmap: {
        1: amount_field,
        2: amount_field2,
        3: amount_field3
    }

    Rectangle {
        id: time ; width: 10 ; height: 10 ; visible: false
    }
    property string accName: ""
    property int code: 0
    property real aNum: 0
    property real aTotal: 0

    // Success Display Timer
    SequentialAnimation {
        id: click
        PropertyAnimation {
            target: time
            property: "width"
            duration: 2000
            to: 100
        }
        ScriptAction { script: { writeoff() ; stack.replace('P3Form.ui.qml') } }
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

    // Navigation Buttons -- Total Amount, Submit button, Menu bar, ScrollView
    Text {
        id: total
        width: 160
        height: 40
        text: qsTr("Total: " + aTotal)
        anchors.verticalCenter: submit_button.verticalCenter
        font.pixelSize: 18
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        font.bold: true
        font.family: "Verdana"
        anchors.left: submit_button.right
    }
    Rectangle {
        anchors.top: submit_button.top ; anchors.topMargin: 0.5 ; visible: submit_button.visible
        anchors.left: submit_button.left ; anchors.leftMargin: -1
        height: submit_button.height + 2.5 ; width: submit_button.width + 1.5 ; radius: submit_button.radius + 1
        color: "#e0e0e0"
    }
    Rectangle {
        id: submit_button
        color: "black"
        radius: 8
        width: 150
        height: 53
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 60
        anchors.horizontalCenter: parent.horizontalCenter
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
                if (aTotal > aNum) { displaydialog(1) }
                else { displaybigdialog(2,1) }
            }
        }
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

    // Body of Code -- scroll view, 3 text boxes,
    ScrollView {
        id: scrollView
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: profilebox.bottom
        anchors.topMargin: 20
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 120
        /*ScrollBar.vertical.interactive: true*/
        contentHeight: 500
        clip: true
        width: 200
        height: 200

        // Entry 1 first -- Fingerprint, Username/Fingerprint buttons, Amount, Username
        Image {
            id: fingerprint
            visible: use_username_button.visible
            opacity: 0
            anchors.top: amount.bottom
            anchors.topMargin: 60
            width: 120
            height: width            
            source: "../images/whitefinger.jpg"
            anchors.horizontalCenter: parent.horizontalCenter
            fillMode: Image.PreserveAspectFit
            Behavior on opacity { PropertyAnimation { duration: 500 } }
            MouseArea {
                anchors.fill: parent;
                onClicked: {
                    if (amount_field.text < 50.0) { displaydialog(2) }
                    else if (amount_field.text > aNum) { displaydialog(1) }
                    else { transferDialogBio.open() ; backend.transferfeature([amount_field.text, "'Bio ID - 00'", "Fingerprint"]) }
                }
            }
            Text {
                id: place_finger                
                width: 262
                height: 50
                visible: use_username_button.visible
                text: qsTr("Place Finger on Scanner")
                anchors.top: fingerprint.bottom
                font.family: "Calibri"
                font.pixelSize: 21
                font.italic: true
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignTop
                anchors.horizontalCenter: fingerprint.horizontalCenter
            }
        }
        // Entry 1 contd -- Username button, ( 3 left )
        Rectangle {
            anchors.top: use_username_button.top ; anchors.topMargin: 0.5 ; visible: use_username_button.visible
            anchors.left: use_username_button.left ; anchors.leftMargin: -1
            height: use_username_button.height + 2.5 ; width: use_username_button.width + 1.5 ; radius: use_username_button.radius + 1
            color: "#e0e0e0"
        }
        Rectangle {
            id: use_username_button
            color: "#ffffff"
            radius: 8
            //border.width: 3
            width: submit_button.width + 40
            height: submit_button.height
            anchors.top: fingerprint.bottom
            anchors.topMargin: 50
            anchors.horizontalCenter: parent.horizontalCenter
            visible: username.visible
            onVisibleChanged: animatefingerprint(1)
            Text {
                id: number_text
                width: 160
                height: 40
                text: qsTr("Confirm")
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: 18
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.bold: true
                font.family: "Verdana"
                anchors.horizontalCenter: parent.horizontalCenter
            }
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    if (username_field.text === '' | amount_field.text === '') { displaydialog(4) }
                    else if (checkamount(parseFloat(amount_field.text)) === 0) { return }
                    else { backend.transferrecipient([username_field.text, 1]) }
                    if (renderswitch1.checked === true) { rendered1.height = 85 ; scrollView.contentHeight = scrollView.contentHeight - 300 ; changecolor(1) }
                }
            }
        }
        // Entry 1 contd -- Fingerprint button, ( 2 left )
        /*Rectangle {
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
            width: 230
            height: submit_button.height
            anchors.top: fingerprint.bottom
            anchors.topMargin: use_username_button.anchors.topMargin
            visible: switch1.checked & !renderswitch1.checked
            anchors.horizontalCenter: parent.horizontalCenter
            Text {
                width: 160
                height: 40
                text: qsTr("Use Fingerprint")
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: number_text.font.pixelSize
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
        }*/
        // Entry 1 contd -- Amount, ( 1 left )
        Text {
            id: amount
            visible: !renderswitch1.checked
            anchors.top: rendered1.top
            anchors.topMargin: 20
            height: 41
            anchors.left: parent.left
            anchors.leftMargin: 100
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
                placeholderText: qsTr("Amount")
                validator: IntValidator { bottom: 1; top: 100000 }
                inputMethodHints: Qt.ImhDigitsOnly
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
                id:clearamount
                height: 14
                width: height
                anchors.verticalCenter: amount_box.verticalCenter
                anchors.right: amount_box.right
                anchors.rightMargin: 10
                source: "../images/closebutton.png"
                sourceSize.width: 20
                sourceSize.height: 20
                MouseArea {
                    id:clamt
                    anchors.fill: parent
                    onClicked: amount_field.text = ""
                }
            }
        }
        // Entry 1 last -- Username, ( Done )
        Text {
            id: username
            visible: switch1.checked & !renderswitch1.checked
            anchors.top: amount.bottom
            anchors.topMargin: 100
            height: 41
            anchors.left: amount.left
            anchors.right: parent.right
            text: qsTr("Recipient")
            font.pixelSize: amount.font.pixelSize
            verticalAlignment: Text.AlignVCenter
            font.capitalization: Font.AllUppercase
            font.family: "Verdana"
            font.styleName: "Regular"
            font.bold: true
            TextField {
                id: username_field
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
                placeholderText: qsTr("Account No. / Reg No.")
                onPressed: inputPaneln.showKeyboard = true
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
            /*Text {
                id: proceed
                x: 336
                width: 140
                height: 40
                text: qsTr("Proceed  >")
                font.family: "Verdana"
                anchors.right: username_box.right
                anchors.top: username_box.bottom
                font.pixelSize: 17
                font.bold: true
                horizontalAlignment: Text.AlignRight
                anchors.topMargin: 15
                anchors.rightMargin: -5
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        if (username_field.text === '' | amount_field.text === '') { displaydialog(4) }
                        else if (checkamount(parseFloat(amount_field.text)) === 0) { return }
                        else { backend.transferrecipient([username_field.text, 1]) }
                        if (renderswitch1.checked === true) { rendered1.height = 85 ; scrollView.contentHeight = scrollView.contentHeight - 300 ; changecolor(1) }
                    }
                }
            }*/
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
                    onClicked: username_field.text = ""
                }
            }
        }
        // Rendered 1 -- Ready to transfer
        Rectangle {
            id: rendered1
            radius: 5
            height: 360
            anchors.top: parent.top
            anchors.left: amount.left
            anchors.leftMargin: -20
            anchors.right: parent.right
            anchors.rightMargin: 100 + anchors.leftMargin
            color: "transparent"
            border.width: 1.5
            border.color: "#d0d0d0"
            Text {
                id: name1
                visible: renderswitch1.checked
                anchors.top: parent.top
                anchors.topMargin: 10
                anchors.left: parent.left
                anchors.leftMargin: 20
                height: 30
                width: 50
                text: qsTr("Recipient:  ")
                font.pixelSize: 17
                verticalAlignment: Text.AlignVCenter
                font.capitalization: Font.AllUppercase
                font.family: "Verdana"
                font.styleName: "Regular"
            }
            Text {
                id: renderamt1
                visible: renderswitch1.checked
                anchors.bottom: parent.bottom
                anchors.bottomMargin: name1.anchors.topMargin
                anchors.left: parent.left
                anchors.leftMargin: name1.anchors.leftMargin
                height: name1.height
                width: 50
                text: qsTr("Amount:  <b>" + amount_field.text + "</b>")
                font.pixelSize: name1.font.pixelSize
                verticalAlignment: Text.AlignVCenter
                font.capitalization: Font.AllUppercase
                font.family: "Verdana"
                font.styleName: "Regular"
            }
            Image {
                visible: renderswitch1.checked
                anchors.verticalCenter: parent.verticalCenter
                width: 30
                height: width
                sourceSize.height: 60
                sourceSize.width: 60
                source: "../images/edit.png"
                anchors.right: parent.right
                anchors.rightMargin: 20
                fillMode: Image.PreserveAspectFit
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        aTotal = aTotal - parseFloat(amount_field.text)
                        changecolor(0)
                        renderswitch1.checked = !renderswitch1.checked
                        rendered1.height = 360
                        scrollView.contentHeight = scrollView.contentHeight + 300
                    }
                }
            }
        }

        // Entry 2 first -- (+) Thing, Fingerprint, Username/Fingerprint buttons, Amount, Username
        Rectangle {
            id: entry2
            visible: !multi_switch2.checked
            anchors.top: rendered2.top
            anchors.topMargin: 20
            anchors.left: amount.left
            width: 55
            height: width
            radius: width / 2
            color: "dimgray"
            Text {
                id: add_tran2
                anchors.left: parent.right
                anchors.leftMargin: 20
                anchors.verticalCenter: parent.verticalCenter
                text: qsTr("Additional Transfer")
                font.pixelSize: 17
                verticalAlignment: Text.AlignVCenter
                font.bold: true
                font.family: "Verdana"
                height: 30
                width: 180
            }
            MouseArea {
                hoverEnabled: true
                anchors.fill: parent
                onEntered: entry2.color = "#e1e1e0"
                onExited: entry2.color = "dimgray"
                onClicked: {
                    multi_switch2.checked = !multi_switch2.checked
                    rendered2.height = 360
                    scrollView.contentHeight = scrollView.contentHeight + 400
                }
            }
            Rectangle {
                anchors.centerIn: parent
                height: entry2.width - 10
                width: 6
                radius: width / 2
            }
            Rectangle {
                anchors.centerIn: parent
                width: entry2.width - 10
                height: 6
                radius: height / 2
            }
        }

        // Entry 2 contd -- Fingerprint, (4 more)
        Image {
            id: fingerprint2
            opacity: 0
            anchors.top: amount2.bottom
            anchors.topMargin: 60
            width: 120
            height: width
            visible: use_username_button2.visible & multi_switch2.checked
            source: "../images/whitefinger.jpg"
            anchors.horizontalCenter: parent.horizontalCenter
            fillMode: Image.PreserveAspectFit
            Behavior on opacity { PropertyAnimation { duration: 500 } }
            MouseArea {
                anchors.fill: parent;
                onClicked: {
                    if (amount_field2.text < 50.0) { displaydialog(2) }
                    else if (amount_field2.text > aNum) { displaydialog(1) }
                    else { transferDialogBio.open() ; backend.transferfeature([amount_field2.text, "'Bio ID - 00'", "Fingerprint"]) }
                }
            }
            Text {
                id: place_finger2
                opacity: fingerprint2.opacity
                width: 262
                height: 50
                visible: use_username_button2.visible
                text: qsTr("Place Finger on Scanner")
                anchors.top: fingerprint2.bottom
                font.family: "Calibri"
                font.pixelSize: 21
                font.italic: true
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignTop
                anchors.horizontalCenter: fingerprint2.horizontalCenter
            }
        }
        // Entry 2 contd -- Username button, ( 3 left )
        Rectangle {
            anchors.top: use_username_button2.top ; anchors.topMargin: 0.5 ; visible: use_username_button2.visible
            anchors.left: use_username_button2.left ; anchors.leftMargin: -1
            height: use_username_button2.height + 2.5 ; width: use_username_button2.width + 1.5 ; radius: use_username_button2.radius + 1
            color: "#e0e0e0"
        }
        Rectangle {
            id: use_username_button2
            radius: use_username_button.radius
            //border.width: 3
            width: use_username_button.width
            height: use_username_button.height
            anchors.top: fingerprint2.bottom
            anchors.topMargin: 50
            visible: username2.visible
            anchors.horizontalCenter: parent.horizontalCenter
            onVisibleChanged: animatefingerprint(2)
            Text {
                width: 160
                height: 40
                text: qsTr("Confirm")
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: number_text.font.pixelSize
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.bold: true
                font.family: "Verdana"
                anchors.horizontalCenter: parent.horizontalCenter
            }
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    if (username_field2.text === '' | amount_field2.text === '') { displaydialog(4) }
                    else if (checkamount(parseFloat(amount_field2.text)) === 0) { return }
                    else { backend.transferrecipient([username_field2.text, 2]) }
                    if (renderswitch2.checked === true) { rendered2.height = 85 ; scrollView.contentHeight = scrollView.contentHeight - 300 ; changecolor(2) }
                }
            }
        }
        // Entry 2 contd -- Fingerprint button, ( 2 left )
        /*Rectangle {
            anchors.top: use_fingerprint_button2.top ; anchors.topMargin: 0.5 ; visible: use_fingerprint_button2.visible
            anchors.left: use_fingerprint_button2.left ; anchors.leftMargin: -1
            height: use_fingerprint_button2.height + 2.5 ; width: use_fingerprint_button2.width + 1.5 ; radius: use_fingerprint_button2.radius + 1
            color: "#e0e0e0"
        }
        Rectangle {
            id: use_fingerprint_button2
            radius: use_fingerprint_button.radius
            //border.width: 3
            width: use_fingerprint_button.width
            height: use_fingerprint_button.height
            anchors.top: fingerprint2.bottom
            anchors.topMargin: use_username_button2.anchors.topMargin
            visible: switch2.checked & !renderswitch2.checked & multi_switch2.checked
            anchors.horizontalCenter: parent.horizontalCenter
            Text {
                width: 160
                height: 40
                text: qsTr("Use Fingerprint")
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: number_text.font.pixelSize
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.bold: true
                font.family: "Verdana"
                anchors.horizontalCenter: parent.horizontalCenter
            }
            MouseArea {
                anchors.fill: parent
                onClicked: { switch2.checked = !switch2.checked ; fingerprint2.opacity = 1 }
            }
        }*/
        // Entry 2 contd -- Amount, ( 1 left )
        Text {
            id: amount2
            visible: !renderswitch2.checked & multi_switch2.checked
            anchors.top: rendered2.top
            anchors.topMargin: 20
            height: 41
            anchors.left: amount.left
            anchors.right: parent.right
            text: qsTr("Amount 2")
            font.pixelSize: amount.font.pixelSize
            verticalAlignment: Text.AlignVCenter
            font.capitalization: Font.AllUppercase
            font.family: "Verdana"
            font.styleName: "Regular"
            font.bold: true
            TextField {
                id: amount_field2
                font.family: "Calibri"
                height: amount_box2.height - 2
                anchors.verticalCenter: amount_box2.verticalCenter
                anchors.left: amount_box2.left
                anchors.right: amount_box2.right
                anchors.rightMargin: 1
                anchors.leftMargin: 1
                baselineOffset: 15
                font.pointSize: 12
                topPadding: 7
                //leftPadding: 9
                rightPadding: 35
                placeholderText: qsTr("Amount 2")
                validator: IntValidator {bottom: 1; top: 100000}
                inputMethodHints: Qt.ImhDigitsOnly
                onPressed: inputPaneln.showKeyboard = true
                Rectangle {
                    anchors.fill: parent ; color: "transparent" ; border.width: 1 ; border.color: "white"
                }
            }
            Rectangle {
                id: amount_box2
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
                id:clearamount2
                height: 14
                width: height
                anchors.verticalCenter: amount_box2.verticalCenter
                anchors.right: amount_box2.right
                anchors.rightMargin: 10
                source: "../images/closebutton.png"
                sourceSize.width: 20
                sourceSize.height: 20
                MouseArea {
                    id:clamt2
                    anchors.fill: parent
                    onClicked: amount_field2.text = ""
                }
            }
        }
        // Entry 2 last -- Username, ( Done )
        Text {
            id: username2
            visible: switch2.checked & !renderswitch2.checked & multi_switch2.checked
            anchors.top: amount2.bottom
            anchors.topMargin: 100
            height: 41
            anchors.left: amount.left
            anchors.right: parent.right
            text: qsTr("Recipient 2")
            font.pixelSize: amount.font.pixelSize
            verticalAlignment: Text.AlignVCenter
            font.capitalization: Font.AllUppercase
            font.family: "Verdana"
            font.styleName: "Regular"
            font.bold: true
            TextField {
                id: username_field2
                font.family: "Calibri"
                height: username_box2.height - 2
                anchors.verticalCenter: username_box2.verticalCenter
                anchors.left: username_box2.left
                anchors.right: username_box2.right
                anchors.rightMargin: 1
                anchors.leftMargin: 1
                baselineOffset: 15
                font.pointSize: 12
                topPadding: 7
                //leftPadding: 9
                rightPadding: 35
                placeholderText: qsTr("Account No. / Reg No. 2")
                onPressed: inputPaneln.showKeyboard = true
                Rectangle {
                    anchors.fill: parent ; color: "transparent" ; border.width: 1 ; border.color: "white"
                }
            }
            Rectangle {
                id: username_box2
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
            /*Text {
                id: proceed2
                width: 140
                height: 40
                text: qsTr("Proceed  >")
                font.family: proceed.font.family
                anchors.right: username_box2.right
                anchors.top: username_box2.bottom
                font.pixelSize: proceed.font.pixelSize
                font.bold: true
                horizontalAlignment: Text.AlignRight
                anchors.topMargin: proceed.anchors.topMargin
                anchors.rightMargin: -5
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        if (username_field2.text === '' | amount_field2.text === '') { displaydialog(4) }
                        else if (checkamount(parseFloat(amount_field2.text)) === 0) { return }
                        else { backend.transferrecipient([username_field2.text, 2]) }
                        if (renderswitch2.checked === true) { rendered2.height = 85 ; scrollView.contentHeight = scrollView.contentHeight - 300 ; changecolor(2) }
                    }
                }
            }*/
            Image {
                id:clearusername2
                height: 14
                width: height
                anchors.verticalCenter: username_box2.verticalCenter
                anchors.right: username_box2.right
                anchors.rightMargin: 10
                source: "../images/closebutton.png"
                sourceSize.width: 20
                sourceSize.height: 20
                MouseArea {
                    id:clusr2
                    anchors.fill: parent
                    onClicked: username_field2.text = ""
                }
            }
        }

        // Rendered 2 -- Ready to transfer
        Rectangle {
            id: rendered2
            radius: 5
            height: 90
            anchors.top: rendered1.bottom
            anchors.topMargin: 30
            anchors.left: amount2.left
            anchors.leftMargin: rendered1.anchors.leftMargin
            anchors.right: parent.right
            anchors.rightMargin: rendered1.anchors.rightMargin
            color: "transparent"
            border.width: rendered1.border.width
            border.color: rendered1.border.color
            Text {
                id: name2
                visible: renderswitch2.checked
                anchors.top: parent.top
                anchors.topMargin: name1.anchors.topMargin
                anchors.left: parent.left
                anchors.leftMargin: name1.anchors.leftMargin
                height: 30
                width: 50
                text: qsTr("Recipient 2:  ")
                font.pixelSize: name1.font.pixelSize
                verticalAlignment: Text.AlignVCenter
                font.capitalization: Font.AllUppercase
                font.family: "Verdana"
                font.styleName: "Regular"
            }
            Text {
                id: renderamt2
                visible: renderswitch2.checked
                anchors.bottom: parent.bottom
                anchors.bottomMargin: name2.anchors.topMargin
                anchors.left: parent.left
                anchors.leftMargin: name2.anchors.leftMargin
                height: name2.height
                width: 50
                text: qsTr("Amount 2:  <b>" + amount_field2.text + "</b>")
                font.pixelSize: name1.font.pixelSize
                verticalAlignment: Text.AlignVCenter
                font.capitalization: Font.AllUppercase
                font.family: "Verdana"
                font.styleName: "Regular"
            }
            Image {
                visible: renderswitch2.checked
                anchors.verticalCenter: parent.verticalCenter
                width: 30
                height: width
                sourceSize.height: 60
                sourceSize.width: 60
                source: "../images/edit.png"
                anchors.right: parent.right
                anchors.rightMargin: 20
                fillMode: Image.PreserveAspectFit
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        aTotal = aTotal - parseFloat(amount_field2.text)
                        changecolor(0)
                        renderswitch2.checked = !renderswitch2.checked
                        rendered2.height = 360
                        scrollView.contentHeight = scrollView.contentHeight + 300
                    }
                }
            }
        }
        Rectangle {
            id: exit2
            visible: multi_switch2.checked
            color: "#e1e1e0"
            height: 24
            width: height
            radius: height / 2
            anchors.top: rendered2.top
            anchors.topMargin: -(height/2)
            anchors.right: rendered2.right
            anchors.rightMargin: -(width/2)
            MouseArea {
                onEntered: exit2.color = "dimgray"
                onExited: exit2.color = "#e1e1e0"
                hoverEnabled: true
                anchors.fill: parent
                onClicked: {
                    if (amount_field2.text != "" & renderswitch2.checked === true) { aTotal = aTotal - parseFloat(amount_field2.text) }
                    changecolor(0)
                    if (multi_switch3.checked === false) {
                        amount_field2.text = username_field2.text = ''
                        multi_switch2.checked = !multi_switch2.checked
                        rendered2.height = 90
                        if (renderswitch2.checked === true) {
                            scrollView.contentHeight = scrollView.contentHeight - 100
                            renderswitch2.checked = false
                        } else { scrollView.contentHeight = scrollView.contentHeight - 400 }
                        switchoff(2,0)
                    } else { switchoff(2,1) }
                }
            }
            Image {
                height: exit2.height - 10
                width: height
                anchors.centerIn: parent
                source: "../images/closebutton.png"
                sourceSize.width: 20
                sourceSize.height: 20
            }
        }

        // Entry 3 first -- (+) Thing, Fingerprint, Username/Fingerprint buttons, Amount, Username
        Rectangle {
            id: entry3
            visible: !multi_switch3.checked & multi_switch2.checked
            anchors.top: rendered3.top
            anchors.topMargin: 20
            anchors.left: amount.left
            width: entry2.width
            height: width
            radius: width / 2
            color: "dimgray"
            Text {
                anchors.left: parent.right
                anchors.leftMargin: 20
                anchors.verticalCenter: parent.verticalCenter
                text: qsTr("Additional Transfer")
                font.pixelSize: add_tran2.font.pixelSize
                verticalAlignment: Text.AlignVCenter
                font.bold: true
                font.family: "Verdana"
                height: 30
                width: 180
            }
            MouseArea {
                hoverEnabled: true
                anchors.fill: parent
                onEntered: entry3.color = "#e1e1e0"
                onExited: entry3.color = "dimgray"
                onClicked: {
                    multi_switch3.checked = !multi_switch3.checked
                    rendered3.height = 360
                    scrollView.contentHeight = scrollView.contentHeight + 300
                }
            }
            Rectangle {
                anchors.centerIn: parent
                height: entry2.width - 10
                width: 6
                radius: width / 2
            }
            Rectangle {
                anchors.centerIn: parent
                width: entry2.width - 10
                height: 6
                radius: height / 2
            }
        }

        // Entry 3 contd -- Fingerprint, (4 more)
        Image {
            id: fingerprint3
            opacity: 0
            anchors.top: amount3.bottom
            anchors.topMargin: 60
            width: 120
            height: width
            visible: use_username_button3.visible & multi_switch3.checked
            source: "../images/whitefinger.jpg"
            anchors.horizontalCenter: parent.horizontalCenter
            fillMode: Image.PreserveAspectFit
            Behavior on opacity { PropertyAnimation { duration: 500 } }
            MouseArea {
                anchors.fill: parent;
                onClicked: {
                    if (amount_field3.text < 50.0) { displaydialog(2) }
                    else if (amount_field3.text > aNum) { displaydialog(1) }
                    else { transferDialogBio.open() ; backend.transferfeature([amount_field3.text, "'Bio ID - 00'", "Fingerprint"]) }
                }
            }
            Text {
                id: place_finger3
                opacity: fingerprint3.opacity
                width: 262
                height: 50
                visible: use_username_button3.visible
                text: qsTr("Place Finger on Scanner")
                anchors.top: fingerprint3.bottom
                font.family: "Calibri"
                font.pixelSize: 21
                font.italic: true
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignTop
                anchors.horizontalCenter: fingerprint3.horizontalCenter
            }
        }
        // Entry 3 contd -- Username button, ( 3 left )
        Rectangle {
            anchors.top: use_username_button3.top ; anchors.topMargin: 0.5 ; visible: use_username_button3.visible
            anchors.left: use_username_button3.left ; anchors.leftMargin: -1
            height: use_username_button3.height + 2.5 ; width: use_username_button3.width + 1.5 ; radius: use_username_button3.radius + 1
            color: "#e0e0e0"
        }
        Rectangle {
            id: use_username_button3
            radius: use_username_button.radius
            //border.width: 3
            width: use_username_button.width
            height: use_username_button.height
            anchors.top: fingerprint3.bottom
            anchors.topMargin: 50
            visible: username3.visible
            anchors.horizontalCenter: parent.horizontalCenter
            onVisibleChanged: animatefingerprint(3)
            Text {
                width: 160
                height: 40
                text: qsTr("Confirm")
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: number_text.font.pixelSize
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.bold: true
                font.family: "Verdana"
                anchors.horizontalCenter: parent.horizontalCenter
            }
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    if (username_field3.text === '' | amount_field3.text === '') { displaydialog(4) }
                    else if (checkamount(parseFloat(amount_field3.text)) === 0) { return }
                    else { backend.transferrecipient([username_field3.text, 3]) }
                    if (renderswitch3.checked === true) { rendered3.height = 85 ; scrollView.contentHeight = scrollView.contentHeight - 300 ; changecolor(3) }
                }
            }
        }
        // Entry 3 contd -- Fingerprint button, ( 2 left )
        /*Rectangle {
            anchors.top: use_fingerprint_button3.top ; anchors.topMargin: 0.5 ; visible: use_fingerprint_button3.visible
            anchors.left: use_fingerprint_button3.left ; anchors.leftMargin: -1
            height: use_fingerprint_button3.height + 2.5 ; width: use_fingerprint_button3.width + 1.5 ; radius: use_fingerprint_button3.radius + 1
            color: "#e0e0e0"
        }
        Rectangle {
            id: use_fingerprint_button3
            radius: use_fingerprint_button.radius
            //border.width: 3
            width: use_fingerprint_button.width
            height: use_fingerprint_button.height
            anchors.top: fingerprint3.bottom
            anchors.topMargin: use_username_button3.anchors.topMargin
            visible: switch3.checked & !renderswitch3.checked & multi_switch3.checked
            anchors.horizontalCenter: parent.horizontalCenter
            Text {
                width: 160
                height: 40
                text: qsTr("Use Fingerprint")
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: number_text.font.pixelSize
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.bold: true
                font.family: "Verdana"
                anchors.horizontalCenter: parent.horizontalCenter
            }
            MouseArea {
                anchors.fill: parent
                onClicked: { switch3.checked = !switch3.checked ; fingerprint3.opacity = 1 }
            }
        }*/
        // Entry 3 contd -- Amount, ( 1 left )
        Text {
            id: amount3
            visible: !renderswitch3.checked & multi_switch3.checked
            anchors.top: rendered3.top
            anchors.topMargin: 20
            height: 41
            anchors.left: amount.left
            anchors.right: parent.right
            text: qsTr("Amount 3")
            font.pixelSize: amount.font.pixelSize
            verticalAlignment: Text.AlignVCenter
            font.capitalization: Font.AllUppercase
            font.family: "Verdana"
            font.styleName: "Regular"
            font.bold: true
            TextField {
                id: amount_field3
                font.family: "Calibri"
                height: amount_box3.height - 2
                anchors.verticalCenter: amount_box3.verticalCenter
                anchors.left: amount_box3.left
                anchors.right: amount_box3.right
                anchors.rightMargin: 1
                anchors.leftMargin: 1
                baselineOffset: 15
                font.pointSize: 12
                topPadding: 7
                //leftPadding: 9
                rightPadding: 35
                placeholderText: qsTr("Amount 3")
                validator: IntValidator {bottom: 1; top: 100000}
                inputMethodHints: Qt.ImhDigitsOnly
                onPressed: inputPaneln.showKeyboard = true
                Rectangle {
                    anchors.fill: parent ; color: "transparent" ; border.width: 1 ; border.color: "white"
                }
            }
            Rectangle {
                id: amount_box3
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
                id:clearamount3
                height: 14
                width: height
                anchors.verticalCenter: amount_box3.verticalCenter
                anchors.right: amount_box3.right
                anchors.rightMargin: 10
                source: "../images/closebutton.png"
                sourceSize.width: 20
                sourceSize.height: 20
                MouseArea {
                    id:clamt3
                    anchors.fill: parent
                    onClicked: amount_field3.text = ""
                }
            }
        }
        // Entry 3 last -- Username, ( Done )
        Text {
            id: username3
            visible: switch3.checked & !renderswitch3.checked & multi_switch3.checked
            anchors.top: amount3.bottom
            anchors.topMargin: 100
            height: 41
            anchors.left: amount.left
            anchors.right: parent.right
            text: qsTr("Recipient 3")
            font.pixelSize: amount.font.pixelSize
            verticalAlignment: Text.AlignVCenter
            font.capitalization: Font.AllUppercase
            font.family: "Verdana"
            font.styleName: "Regular"
            font.bold: true
            TextField {
                id: username_field3
                font.family: "Calibri"
                height: username_box3.height - 2
                anchors.verticalCenter: username_box3.verticalCenter
                anchors.left: username_box3.left
                anchors.right: username_box3.right
                anchors.rightMargin: 1
                anchors.leftMargin: 1
                baselineOffset: 15
                font.pointSize: 12
                topPadding: 7
                //leftPadding: 9
                rightPadding: 35
                placeholderText: qsTr("Account No. / Reg No. 3")
                onPressed: inputPaneln.showKeyboard = true
                Rectangle {
                    anchors.fill: parent ; color: "transparent" ; border.width: 1 ; border.color: "white"
                }
            }
            Rectangle {
                id: username_box3
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
            Text {
                id: proceed3
                x: 336
                width: 140
                height: 40
                text: qsTr("Proceed  >")
                font.family: proceed.font.family
                anchors.right: username_box3.right
                anchors.top: username_box3.bottom
                font.pixelSize: proceed.font.pixelSize
                font.bold: true
                horizontalAlignment: Text.AlignRight
                anchors.topMargin: proceed.anchors.topMargin
                anchors.rightMargin: -5
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        if (username_field3.text === '' | amount_field3.text === '') { displaydialog(4) }
                        else if (checkamount(parseFloat(amount_field3.text)) === 0) { return }
                        else { backend.transferrecipient([username_field3.text, 3]) }
                        if (renderswitch3.checked === true) { rendered3.height = 85 ; scrollView.contentHeight = scrollView.contentHeight - 300 ; changecolor(3) }
                    }
                }
            }
            Image {
                id:clearusername3
                height: 14
                width: height
                anchors.verticalCenter: username_box3.verticalCenter
                anchors.right: username_box3.right
                anchors.rightMargin: 10
                source: "../images/closebutton.png"
                sourceSize.width: 20
                sourceSize.height: 20
                MouseArea {
                    id:clusr3
                    anchors.fill: parent
                    onClicked: username_field3.text = ""
                }
            }
        }

        // Rendered 3 -- Ready to transfer
        Rectangle {
            id: rendered3
            visible: entry3.visible | multi_switch3.checked
            radius: 5
            height: 90
            anchors.top: rendered2.bottom
            anchors.topMargin: 30
            anchors.left: amount3.left
            anchors.leftMargin: rendered1.anchors.leftMargin
            anchors.right: parent.right
            anchors.rightMargin: rendered1.anchors.rightMargin
            color: "transparent"
            border.width: rendered1.border.width
            border.color: rendered1.border.color
            Text {
                id: name3
                visible: renderswitch3.checked
                anchors.top: parent.top
                anchors.topMargin: name1.anchors.topMargin
                anchors.left: parent.left
                anchors.leftMargin: name1.anchors.leftMargin
                height: 30
                width: 50
                text: qsTr("Recipient 3:  ")
                font.pixelSize: name1.font.pixelSize
                verticalAlignment: Text.AlignVCenter
                font.capitalization: Font.AllUppercase
                font.family: "Verdana"
                font.styleName: "Regular"
            }
            Text {
                id: renderamt3
                visible: renderswitch3.checked
                anchors.bottom: parent.bottom
                anchors.bottomMargin: name3.anchors.topMargin
                anchors.left: parent.left
                anchors.leftMargin: name3.anchors.leftMargin
                height: name3.height
                width: 50
                text: qsTr("Amount 3:  <b>" + amount_field3.text + "</b>")
                font.pixelSize: name1.font.pixelSize
                verticalAlignment: Text.AlignVCenter
                font.capitalization: Font.AllUppercase
                font.family: "Verdana"
                font.styleName: "Regular"
            }
            Image {
                visible: renderswitch3.checked
                anchors.verticalCenter: parent.verticalCenter
                width: 30
                height: width
                sourceSize.height: 60
                sourceSize.width: 60
                source: "../images/edit.png"
                anchors.right: parent.right
                anchors.rightMargin: 20
                fillMode: Image.PreserveAspectFit
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        aTotal = aTotal - parseFloat(amount_field3.text)
                        changecolor(0)
                        renderswitch3.checked = !renderswitch3.checked
                        rendered3.height = 360
                        scrollView.contentHeight = scrollView.contentHeight + 300
                    }
                }
            }
        }
        Rectangle {
            id: exit3
            visible: multi_switch3.checked
            color: "#e1e1e0"
            height: 24
            width: height
            radius: height / 2
            anchors.top: rendered3.top
            anchors.topMargin: -(height/2)
            anchors.right: rendered3.right
            anchors.rightMargin: -(width/2)
            MouseArea {
                onEntered: exit3.color = "dimgray"
                onExited: exit3.color = "#e1e1e0"
                hoverEnabled: true
                anchors.fill: parent
                onClicked: {
                    if (amount_field3.text != "" & renderswitch3.checked === true) { aTotal = aTotal - parseFloat(amount_field3.text) }
                    changecolor(0)
                    amount_field3.text = username_field3.text = ''
                    multi_switch3.checked = !multi_switch3.checked
                    rendered3.height = 90
                    if (renderswitch3.checked === true) {
                        renderswitch3.checked = false
                    } else { scrollView.contentHeight = scrollView.contentHeight - 300 }
                }
            }
            Image {
                height: exit3.height - 10
                width: height
                anchors.centerIn: parent
                source: "../images/closebutton.png"
                sourceSize.width: 20
                sourceSize.height: 20
            }
        }
    }

    // Dialog Box functions
    function displaydialog(functionnum) {
        dialog_timer.running = false ; time.width = 10
        dialog_small.anchors.bottomMargin = 20
        dialog_timer.running = true
        // 1 insufDialog
        if (functionnum === 1) { information2.text = qsTr("Amount You Entered Exceeds Your Available Balance") }
        // 2 warnDialog
        if (functionnum === 2) { information2.text = qsTr("You Cannot Make Transfer With less than 50 Naira") }
        // 3 warnDialog2
        if (functionnum === 3) { information2.text = qsTr("Oops! Recipient Doesn't exist") }
        // 4 emptyDialog
        if (functionnum === 4) { information2.text = qsTr("Fill the empty fields before clicking proceed") }
    }
    function closebigdialog() { dialog_big.visible = false ; f1_switch.checked = f2_switch.checked = f3_switch.checked = false }

    function displaybigdialog(buttonnum, functionnum) {
        if (buttonnum === 0) { dialog_big.visible = true ; button_number.checked = false ; good_picture.visible = false ; box.radius = 5 }
        if (buttonnum === 1) { dialog_big.visible = true ; button_number.checked = true ; good_picture.visible = true }
        if (buttonnum === 2) { dialog_big.visible = true ; button_number.checked = true ; good_picture.visible = false ; box.radius = 10 }

        // 1 transferDialog
        if (functionnum === 1) {
            information.text = qsTr("You Are About To Make A Total Transfer of " + aTotal + " Naira. Do You Want To Continue?")
            header.text = qsTr("Transfer")
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
        function onIncorrect(num) {
            if (num === 1) { displaydialog(2) }
            else if (num === 2) { displaydialog(3) }
        }
        function onTotalexp(num) {
            aTotal = num
            if (aTotal > aNum) { displaydialog(1)
            } else { displaybigdialog(2,1) }
        }
        function onAccountname(info) {
            accName = info[0]
            code = info[1]
            if (code === 1) { name1.text = qsTr("Recipient:  <b>" + accName + "</b>") ; renderswitch1.checked = true }
            else if (code === 2) { name2.text = qsTr("Recipient 2:  <b>" + accName + "</b>") ; renderswitch2.checked = true }
            else if (code === 3) { name3.text = qsTr("Recipient 3:  <b>" + accName + "</b>") ; renderswitch3.checked = true }
            preparesum() ; determinetotal() ; changecolor(0) ; aftersum()
        }
        function onHidekeyboard() { inputPaneln.showKeyboard = inputPanel.showKeyboard = false }
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

    // Switches for visibility for each purchase text box
    Switch {
        id: multi_switch2
        visible: false
        checked: false
    }
    Switch {
        id: multi_switch3
        visible: false
        checked: false
    }

    Component.onCompleted: {
        image.scale = 0.6
        image.anchors.horizontalCenterOffset = (mainwindow.width / 2) - 45
        image.anchors.topMargin = -25
    }
    function revert() {
        image.scale = 1
        image.anchors.horizontalCenterOffset = image.anchors.topMargin = 0
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
            height: 40
            color: menu.color
            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                onEntered: second_menu.color = "#e8e8e8"
                onExited: second_menu.color = menu.color
                onClicked: { backend.feature("Deposit") ; stack.replace("Deposit.ui.qml") ; backend.switchfeature() }
            }
            Text {
                id: deposit_menu
                anchors.left: parent.left
                anchors.verticalCenter: second_menu.verticalCenter
                verticalAlignment: Text.AlignVCenter
                height: 30
                font.family: "Verdana"
                width: parent.width
                font.pixelSize: logout.font.pixelSize
                text: qsTr("Switch to Deposit Mode")
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
                onClicked: { revert() ; stack.push('Success.ui.qml') ; click.running = true }
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
                    font.pixelSize: 16
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    color: "black"
                    text: qsTr("No")
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
        Switch {
            id: f2_switch
            visible: false
            checked: false
        }
        Switch {
            id: f3_switch
            visible: false
            checked: false
        }
        Switch {
            id: switch1
            checked: true
            visible: false
        }
        Switch {
            id: switch2
            checked: true
            visible: false
        }
        Switch {
            id: switch3
            checked: true
            visible: false
        }
        Switch {
            id: renderswitch1
            checked: false
            visible: false
        }
        Switch {
            id: renderswitch2
            checked: false
            visible: false
        }
        Switch {
            id: renderswitch3
            checked: false
            visible: false
        }

    }

    function switchoff(num, code) {
        amount_field2.text = amount_field3.text
        username_field2.text = username_field3.text
        amount_field3.text = username_field3.text = ''
        if (code === 1) {
            multi_switch3.checked = false
            if (renderswitch2.checked === true) {
                if (renderswitch3.checked === true) { renderswitch3.checked = false ; rendered3.height = 90 }
                else { renderswitch2.checked = false ; rendered2.height = 360 ; rendered3.height = 90 }
            } else {
                scrollView.contentHeight = scrollView.contentHeight - 300
                rendered3.height = 90
                if (renderswitch3.checked === true) { rendered2.height = 75 ; renderswitch2.checked = true ; renderswitch3.checked = false }
            }
        }
    }
    function checkamount(amount) {
        if (amount < 50.0) { displaydialog(2) ; return 0 }
        // else if (amount + parseFloat(aTotal) > aNum) { displaydialog(1) ; return 0 }
    }
    function preparesum() {
        for (let i = 1; i<=3; i++){ if (amountmap[i].text === "") { amountmap[i].text = 0 } }
    }
    function aftersum() {
        for (let i = 1; i<=3; i++){ if (amountmap[i].text === '0') { amountmap[i].text = "" } }
    }
    function changecolor(code) {
        if (code === 0){
            if (aTotal > aNum) { total.color = "red" }
            else { total.color = "black" }
        } else if (code === 1) {
            if (parseFloat(amount_field.text) > aNum) { renderamt1.color = "red" }
            else { renderamt1.color = "black" }
        } else if (code === 2) {
            if (parseFloat(amount_field2.text) > aNum) { renderamt2.color = "red" }
            else { renderamt2.color = "black" }
        } else if (code === 3) {
            if (parseFloat(amount_field3.text) > aNum) { renderamt3.color = "red" }
            else { renderamt3.color = "black" }
        }
    }
    function writeoff() {        
        if (renderswitch1.checked === true) {
            if (switch1.checked === true) { backend.transferfeature([amount_field.text, username_field.text, "Typed"]) }
            else { backend.transferfeature([amount_field.text, "Bio-ID" , "Fingerprint"]) }
            backend.transactiondone(1)
        }
        if (renderswitch2.checked === true) {
            if (switch2.checked === true) { backend.transferfeature([amount_field2.text, username_field2.text, "Typed"]) }
            else { backend.transferfeature([amount_field2.text, "Bio-ID" , "Fingerprint"]) }
            backend.transactiondone(1)
        }
        if (renderswitch3.checked === true) {
            if (switch3.checked === true) { backend.transferfeature([amount_field3.text, username_field3.text, "Typed"]) }
            else { backend.transferfeature([amount_field3.text, "Bio-ID" , "Fingerprint"]) }
            backend.transactiondone(1)
        }
    }
    function animatefingerprint(code) {
        if (code === 1) { if (use_username_button.visible === true) { fingerprint.opacity = 1 }
        else { fingerprint.opacity = 0 } }

        else if (code === 2) { if (use_username_button2.visible === true) { fingerprint2.opacity = 1 }
        else { fingerprint2.opacity = 0 } }

        else if (code === 3) { if (use_username_button3.visible === true) { fingerprint3.opacity = 1 }
        else { fingerprint3.opacity = 0 } }
    }
    function determinetotal() {
        aTotal = 0
        if (renderswitch1.checked === true) { aTotal = aTotal + parseFloat(amount_field.text) }
        if (renderswitch2.checked === true) { aTotal = aTotal + parseFloat(amount_field2.text) }
        if (renderswitch3.checked === true) { aTotal = aTotal + parseFloat(amount_field3.text) }
    }
}
