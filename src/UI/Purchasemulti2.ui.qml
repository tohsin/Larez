import QtQuick 2.14
import QtQuick.Controls 2.5
import "keyboard"

Item {
    id: window

    property var switchmap: {
        2: multi_switch2,
        3: multi_switch3,
        4: multi_switch4,
        5: multi_switch5
    }
    property var textmap: {
        2: enter_amount2,
        3: enter_amount3,
        4: enter_amount4,
        5: enter_amount5
    }

    Rectangle {
        id: time ; width: 10 ; height: 10 ; visible: false
    }
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

    // Navigation Buttons -- Submit button, Menu bar
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
        anchors.bottomMargin: 120
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
            onClicked: createsum()
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

    // Body of Code -- scroll view, 5 text boxes,
    ScrollView {
        id: scrollView
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: profilebox.bottom
        anchors.topMargin: 25
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 180
        /*ScrollBar.vertical.interactive: true*/
        contentHeight: 300
        clip: true
        width: 200
        height: 200

        Text {
            id: amount
            anchors.top: parent.top
            height: 35
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
                id: enter_amount
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
                placeholderText: qsTr("Enter Amount")
                validator: IntValidator {
                    bottom: 1
                    top: 100000
                }
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
                    id: clamt
                    anchors.fill: parent
                    onClicked: enter_amount.text = ""
                }
            }
        }

        Rectangle {
            id: entry2
            visible: !multi_switch2.checked
            anchors.top: amount.bottom
            anchors.topMargin: 80
            anchors.left: amount.left
            width: 55
            height: width
            radius: width / 2
            color: "dimgray"
            Text {
                id: add_purch2
                anchors.left: parent.right
                anchors.leftMargin: 20
                anchors.verticalCenter: parent.verticalCenter
                text: qsTr("Additional Purchase")
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
                onClicked: multi_switch2.checked = !multi_switch2.checked
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

        Text {
            id: amount2
            visible: multi_switch2.checked
            anchors.top: amount.bottom
            anchors.topMargin: 70
            height: 41
            anchors.left: amount.left
            anchors.right: parent.right
            text: qsTr("Amount")
            font.pixelSize: amount.font.pixelSize
            verticalAlignment: Text.AlignVCenter
            font.bold: true
            font.capitalization: Font.AllUppercase
            font.family: "Verdana"
            font.styleName: "Regular"
            TextField {
                id: enter_amount2
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
                placeholderText: qsTr("Enter Amount 2")
                validator: IntValidator {
                    bottom: 1
                    top: 100000
                }
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
                id: clearamount2
                height: 14
                width: height
                anchors.verticalCenter: amount_box2.verticalCenter
                anchors.right: amount_box2.right
                anchors.rightMargin: 10
                source: "../images/closebutton.png"
                sourceSize.width: 20
                sourceSize.height: 20
                MouseArea {
                    id: clamt2
                    anchors.fill: parent
                    onClicked: enter_amount2.text = ""
                }
            }
            Rectangle {
                id: exit2
                visible: multi_switch2.checked
                color: "#e1e1e0"
                height: 20
                width: height
                radius: height / 2
                anchors.verticalCenter: amount_box2.verticalCenter
                anchors.left: amount_box2.right
                anchors.leftMargin: 20
                MouseArea {
                    onEntered: exit2.color = "dimgray"
                    onExited: exit2.color = "#e1e1e0"
                    hoverEnabled: true
                    anchors.fill: parent
                    onClicked: {
                        submit_button.anchors.bottomMargin = 90
                        scrollView.anchors.bottomMargin = 150
                        scrollView.contentHeight = 400
                        if (multi_switch3.checked === false) {
                            enter_amount2.text = ''
                            multi_switch2.checked = !multi_switch2.checked
                            switchoff(2,0)
                        } else {
                            switchoff(2,1)
                        }
                    }
                }
                Image {
                    height: 12
                    width: height
                    anchors.centerIn: parent
                    source: "../images/closebutton.png"
                    sourceSize.width: 20
                    sourceSize.height: 20
                }
            }
        }

        Rectangle {
            id: entry3
            visible: !multi_switch3.checked & multi_switch2.checked
            anchors.top: amount2.bottom
            anchors.topMargin: 80
            anchors.left: amount.left
            width: entry2.width
            height: width
            radius: width / 2
            color: "dimgray"
            Text {
                anchors.left: parent.right
                anchors.leftMargin: 20
                anchors.verticalCenter: parent.verticalCenter
                text: qsTr("Additional Purchase")
                font.pixelSize: add_purch2.font.pixelSize
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
                    submit_button.anchors.bottomMargin = 90
                    scrollView.anchors.bottomMargin = 150
                    scrollView.contentHeight = 400
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
        Text {
            id: amount3
            visible: multi_switch3.checked
            anchors.top: amount2.bottom
            anchors.topMargin: 75
            height: 35
            anchors.left: amount.left
            anchors.right: parent.right
            text: qsTr("Amount")
            font.pixelSize: amount.font.pixelSize
            verticalAlignment: Text.AlignVCenter
            font.capitalization: Font.AllUppercase
            font.family: "Verdana"
            font.styleName: "Regular"
            font.bold: true
            TextField {
                id: enter_amount3
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
                placeholderText: qsTr("Enter Amount 3")
                validator: IntValidator {
                    bottom: 1
                    top: 100000
                }
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
                id: clearamount3
                height: 14
                width: height
                anchors.verticalCenter: amount_box3.verticalCenter
                anchors.right: amount_box3.right
                anchors.rightMargin: 10
                source: "../images/closebutton.png"
                sourceSize.width: 20
                sourceSize.height: 20
                MouseArea {
                    id: clamt3
                    anchors.fill: parent
                    onClicked: enter_amount3.text = ""
                }
            }
            Rectangle {
                id: exit3
                color: "#e1e1e0"
                height: 20
                width: height
                radius: height / 2
                anchors.verticalCenter: amount_box3.verticalCenter
                anchors.left: amount_box3.right
                anchors.leftMargin: 20
                MouseArea {
                    onEntered: exit3.color = "dimgray"
                    onExited: exit3.color = "#e1e1e0"
                    hoverEnabled: true
                    anchors.fill: parent
                    onClicked: {
                        submit_button.anchors.bottomMargin = 90
                        scrollView.anchors.bottomMargin = 150
                        scrollView.contentHeight = 400
                        if (multi_switch4.checked === false) {
                            enter_amount3.text = ''
                            multi_switch3.checked = !multi_switch3.checked
                            switchoff(3,0)
                        } else {
                            switchoff(3,1)
                        }
                    }
                }
                Image {
                    height: 12
                    width: height
                    anchors.centerIn: parent
                    source: "../images/closebutton.png"
                    sourceSize.width: 20
                    sourceSize.height: 20
                }
            }
        }

        Rectangle {
            id: entry4
            visible: !multi_switch4.checked & multi_switch3.checked
            anchors.top: amount3.bottom
            anchors.topMargin: 80
            anchors.left: amount.left
            width: entry2.width
            height: width
            radius: width / 2
            color: "dimgray"
            Text {
                anchors.left: parent.right
                anchors.leftMargin: 20
                anchors.verticalCenter: parent.verticalCenter
                text: qsTr("Additional Purchase")
                font.pixelSize: add_purch2.font.pixelSize
                verticalAlignment: Text.AlignVCenter
                font.bold: true
                font.family: "Verdana"
                height: 30
                width: 180
            }
            MouseArea {
                hoverEnabled: true
                anchors.fill: parent
                onEntered: entry4.color = "#e1e1e0"
                onExited: entry4.color = "dimgray"
                onClicked: {
                    multi_switch4.checked = !multi_switch4.checked
                    submit_button.anchors.bottomMargin = 60
                    scrollView.anchors.bottomMargin = 120
                    scrollView.contentHeight = 600
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
        Text {
            id: amount4
            visible: multi_switch4.checked
            anchors.top: amount3.bottom
            anchors.topMargin: 75
            height: 35
            anchors.left: amount.left
            anchors.right: parent.right
            text: qsTr("Amount")
            font.pixelSize: amount.font.pixelSize
            verticalAlignment: Text.AlignVCenter
            font.capitalization: Font.AllUppercase
            font.family: "Verdana"
            font.styleName: "Regular"
            font.bold: true
            TextField {
                id: enter_amount4
                font.family: "Calibri"
                height: amount_box4.height - 2
                anchors.verticalCenter: amount_box4.verticalCenter
                anchors.left: amount_box4.left
                anchors.right: amount_box4.right
                anchors.rightMargin: 1
                anchors.leftMargin: 1
                baselineOffset: 15
                font.pointSize: 12
                topPadding: 7
                //leftPadding: 9
                rightPadding: 35
                placeholderText: qsTr("Enter Amount 4")
                validator: IntValidator {
                    bottom: 1
                    top: 100000
                }
                inputMethodHints: Qt.ImhDigitsOnly
                onPressed: inputPaneln.showKeyboard = true
                Rectangle {
                    anchors.fill: parent ; color: "transparent" ; border.width: 1 ; border.color: "white"
                }
            }
            Rectangle {
                id: amount_box4
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
                id: clearamount4
                height: 14
                width: height
                anchors.verticalCenter: amount_box4.verticalCenter
                anchors.right: amount_box4.right
                anchors.rightMargin: 10
                source: "../images/closebutton.png"
                sourceSize.width: 20
                sourceSize.height: 20
                MouseArea {
                    id: clamt4
                    anchors.fill: parent
                    onClicked: enter_amount4.text = ""
                }
            }
            Rectangle {
                id: exit4
                color: "#e1e1e0"
                height: 20
                width: height
                radius: height / 2
                anchors.verticalCenter: amount_box4.verticalCenter
                anchors.left: amount_box4.right
                anchors.leftMargin: 20
                MouseArea {
                    onEntered: exit4.color = "dimgray"
                    onExited: exit4.color = "#e1e1e0"
                    hoverEnabled: true
                    anchors.fill: parent
                    onClicked: {                        
                        if (multi_switch5.checked === false) {
                            submit_button.anchors.bottomMargin = 90
                            scrollView.anchors.bottomMargin = 150
                            scrollView.contentHeight = 400
                            enter_amount4.text = ''
                            multi_switch4.checked = !multi_switch4.checked
                            switchoff(4,0)
                        } else {
                            switchoff(4,1)
                        }
                    }
                }
                Image {
                    height: 12
                    width: height
                    anchors.centerIn: parent
                    source: "../images/closebutton.png"
                    sourceSize.width: 20
                    sourceSize.height: 20
                }
            }
        }

        Rectangle {
            id: entry5
            visible: !multi_switch5.checked & multi_switch4.checked
            anchors.top: amount4.bottom
            anchors.topMargin: 80
            anchors.left: amount.left
            width: entry2.width
            height: width
            radius: width / 2
            color: "dimgray"
            Text {
                anchors.left: parent.right
                anchors.leftMargin: 20
                anchors.verticalCenter: parent.verticalCenter
                text: qsTr("Additional Purchase")
                font.pixelSize: add_purch2.font.pixelSize
                verticalAlignment: Text.AlignVCenter
                font.bold: true
                font.family: "Verdana"
                height: 30
                width: 180
            }
            MouseArea {
                hoverEnabled: true
                anchors.fill: parent
                onEntered: entry5.color = "#e1e1e0"
                onExited: entry5.color = "dimgray"
                onClicked: multi_switch5.checked = !multi_switch5.checked
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
        Text {
            id: amount5
            visible: multi_switch5.checked
            anchors.top: amount4.bottom
            anchors.topMargin: 75
            height: 35
            anchors.left: amount.left
            anchors.right: parent.right
            text: qsTr("Amount")
            font.pixelSize: amount.font.pixelSize
            verticalAlignment: Text.AlignVCenter
            font.capitalization: Font.AllUppercase
            font.family: "Verdana"
            font.styleName: "Regular"
            font.bold: true
            TextField {
                id: enter_amount5
                font.family: "Calibri"
                height: amount_box5.height - 2
                anchors.verticalCenter: amount_box5.verticalCenter
                anchors.left: amount_box5.left
                anchors.right: amount_box5.right
                anchors.rightMargin: 1
                anchors.leftMargin: 1
                baselineOffset: 15
                font.pointSize: 12
                topPadding: 7
                //leftPadding: 9
                rightPadding: 35
                placeholderText: qsTr("Enter Amount 5")
                validator: IntValidator {
                    bottom: 1
                    top: 100000
                }
                inputMethodHints: Qt.ImhDigitsOnly
                onPressed: inputPaneln.showKeyboard = true
                Rectangle {
                    anchors.fill: parent ; color: "transparent" ; border.width: 1 ; border.color: "white"
                }
            }
            Rectangle {
                id: amount_box5
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
                id: clearamount5
                height: 14
                width: height
                anchors.verticalCenter: amount_box5.verticalCenter
                anchors.right: amount_box5.right
                anchors.rightMargin: 10
                source: "../images/closebutton.png"
                sourceSize.width: 20
                sourceSize.height: 20
                MouseArea {
                    id: clamt5
                    anchors.fill: parent
                    onClicked: enter_amount5.text = ""
                }
            }
            Rectangle {
                id: exit5
                color: "#e1e1e0"
                height: 20
                width: height
                radius: height / 2
                anchors.verticalCenter: amount_box5.verticalCenter
                anchors.left: amount_box5.right
                anchors.leftMargin: 20
                MouseArea {
                    onEntered: exit5.color = "dimgray"
                    onExited: exit5.color = "#e1e1e0"
                    hoverEnabled: true
                    anchors.fill: parent
                    onClicked: { multi_switch5.checked = !multi_switch5.checked ; enter_amount5.text = '' }
                }
                Image {
                    height: 12
                    width: height
                    anchors.centerIn: parent
                    source: "../images/closebutton.png"
                    sourceSize.width: 20
                    sourceSize.height: 20
                }
            }
        }
    }

    // Dialog Box functions
    function displaydialog(functionnum) {
        dialog_timer.running = false ; time.width = 10
        dialog_small.anchors.bottomMargin = 20
        dialog_timer.running = true
        // 1 InsufDialog
        if (functionnum === 1) { information2.text = qsTr("Amount You Entered Exceeds Your Available Balance") }
        // 2 warnDialog
        if (functionnum === 2) { information2.text = qsTr("You Cannot Make Purchase With less than 50 Naira") }
    }
    function closebigdialog() { dialog_big.visible = false ; f1_switch.checked = f2_switch.checked = f3_switch.checked = false }

    function displaybigdialog(buttonnum, functionnum) {
        if (buttonnum === 0) { dialog_big.visible = true ; button_number.checked = false ; good_picture.visible = false ; box.radius = 5 }
        if (buttonnum === 1) { dialog_big.visible = true ; button_number.checked = true ; good_picture.visible = true }
        if (buttonnum === 2) { dialog_big.visible = true ; button_number.checked = true ; good_picture.visible = false ; box.radius = 10 }

        // 1 PurchaseDialog
        if (functionnum === 1) {
            information.text = qsTr("You Are About To Make A Purchase with " + aTotal + " Naira. Do You Want To Continue?")
            header.text = qsTr("Purchase")
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
        }
        function onTotalexp(num) {
            aTotal = num
            if (aTotal > aNum) { displaydialog(1)
            } else { displaybigdialog(2,1) }
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
            height: first_menu.height + menu.radius // 40
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
                onClicked: { backend.feature("Transfer") ; stack.replace("Transfermulti2.ui.qml") ; backend.switchfeature() }
            }
            Text {
                id: transfer_menu
                anchors.left: parent.left
                anchors.verticalCenter: third_menu.verticalCenter
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
            /*Rectangle {
                id: greenslip_horizontal
                anchors.top: box.top ; height: box.radius * 2; width: box.width
                anchors.left: box.left; radius: height/2 ; color: "darkgreen"
            }
            Rectangle {
                anchors.horizontalCenter: greenslip.horizontalCenter ; anchors.bottom: greenslip.bottom; anchors.bottomMargin: -1
                height: greenslip.radius ; width: greenslip.width ; color: "white"
                MouseArea {
                    anchors.fill: parent
                    onClicked: greenslip.visible = !greenslip.visible
                }
            }
            Rectangle {
                id: greenslip_vertical
                anchors.top: box.top ; height: box.height ; width: box.radius * 2
                anchors.left: box.left; radius: box.radius ; color: "darkgreen"
            }
            Rectangle {
                anchors.top: greenslip.top ; anchors.bottom: greenslip.bottom; anchors.right: greenslip.right
                anchors.rightMargin: -1 ; width: greenslip.radius ; color: "white"
                MouseArea {
                    anchors.fill: parent
                    onClicked: greenslip.visible = !greenslip.visible
                }
            }*/
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

        // Switches for Logic, Visibility for each purchase text box
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
            id: multi_switch2
            visible: false
            checked: false
        }
        Switch {
            id: multi_switch3
            visible: false
            checked: false
        }
        Switch {
            id: multi_switch4
            visible: false
            checked: false
        }
        Switch {
            id: multi_switch5
            visible: false
            checked: false
        }
    }

    function switchoff(num, code) {
        for (let i = num ; i <= 4 ; i++) {
            textmap[i].text = textmap[i+1].text
            textmap[i+1].text = ""
        }
        if (code === 1) {
            for (let i = 5 ; i > 1 ; i--) {
                if (switchmap[i].checked === true) {
                    switchmap[i].checked = false
                    break
                }
            }
        }
    }
    function writeoff() {
        if (enter_amount.text !== "") { backend.purchasefeature(enter_amount.text) ; backend.transactiondone(0) }
        for (let i = 2 ; i <= 5 ; i++) {
            if (switchmap[i].checked === true & textmap[i].text !== "") { backend.purchasefeature(textmap[i].text) ; backend.transactiondone(0) }
        }
    }
    function createsum() {
        for (let i = 2 ; i <= 5 ; i++) {
            if (switchmap[i].checked !== true) { textmap[i].text = "" }
        }
        backend.purchaseamounts([enter_amount.text, enter_amount2.text, enter_amount3.text, enter_amount4.text, enter_amount5.text])
    }
}
