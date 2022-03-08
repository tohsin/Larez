import QtQuick 2.14
import QtQuick.Controls 6.2
import Qt.labs.platform 1.1

Item {
    id: window

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

    FocusScope {
        id: features
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
                    onClicked: {
                        stack.push("P4Form.ui.qml");
                        backend.feature(pur.text);
                    }
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
                    onClicked: {
                        stack.push("P4Form.ui.qml");
                        backend.feature(trans.text);
                    }
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
                    onClicked: {
                        stack.push("Register.ui.qml");
                        backend.feature(reg.text);
                    }
                    onEntered: regi.scale = 1.2
                    onExited: regi.scale = 1
                }
            }
        }
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
                anchors.fill: parent
                onClicked: menu.open()
            }
            Menu {
                id: menu
                Menu {
                    title: qsTr("Manage Admins")
                    MenuItem {
                        text: qsTr("Register Admin") ;
                        onTriggered: page_loader.source = "RegistersuperP3.ui.qml"
                    }
                    MenuItem {
                        text: qsTr("Remove Admin") ;
                        onTriggered: page_loader.source = "RemovesuperP3.ui.qml"
                    }
                }
                MenuSeparator { }
                MenuItem {
                    text: qsTr("Logout Admin") ;
                    onTriggered: adminlogoutDialog.open()
                }
                MenuItem {
                    text: qsTr("Logout Super Admin")
                    onTriggered: superadminlogoutDialog.open()
                }
            }
        }
        MessageDialog {
            title: "Logout Admin"
            id: adminlogoutDialog
            text: "You Are About To Logout Admin"
            informativeText: "Do You Want To Continue?"
            buttons: MessageDialog.Yes | MessageDialog.No
            onYesClicked: { backend.adminlogout() ; page_loader.source = "P2Form.ui.qml"}
        }
        MessageDialog {
            title: "Logout Super Admin"
            id: superadminlogoutDialog
            text: "Logging out Super Admin also logs out current Admin"
            informativeText: "Do You Want To Continue?"
            buttons: MessageDialog.Yes | MessageDialog.No
            onYesClicked: { backend.superadminlogout(1) ; page_loader.source = "P1Form.ui.qml"}
        }
    }
}
