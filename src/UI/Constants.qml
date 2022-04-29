import QtQuick 2.15

QtObject {
    readonly property int fontsize1: 26
    readonly property int fontsize2: 20
    readonly property int fontsize3: 18
    readonly property int fontsize4: 16

    readonly property int smalldialogbuttonwidth: 18
    readonly property int smalldialogbuttonheight: 18
    readonly property int smalldialogbuttonleftmargin: 18
    readonly property int smalldialogbuttonbottommargin: 20

    readonly property int smalldialogwidth: 700
    readonly property int smalldialogradius: 15
    readonly property int smalldialogbottommargin: 20

    readonly property int menuwidth: 190
    readonly property int menu1height: 40 // bigger
    readonly property int menu2height: 40 // smaller
    readonly property int menu2width: 200

    readonly property int bigdialogbuttonwidth: 18
    readonly property int bigdialogbuttonheight: 18
    readonly property int bigdialogbuttonleftmargin: 18
    readonly property int bigdialogbuttonbottommargin: 18

    readonly property int button1width: 230 // use fingerprint
    readonly property int button1height: 53
    readonly property int button2width: 150 // submit, login, use pin
    readonly property int button2height: 53
    readonly property int button2bottommargin: 120
    readonly property int button2radius: 8

    readonly property int keyboardtime: 100 // time to open and close
    readonly property int dialogtime: 4000 // time it display a pop up


    /* Edit this comment to add your custom font */
    readonly property font font: Qt.font({
                                             family: Qt.application.font.family,
                                             pixelSize: Qt.application.font.pixelSize
                                         })
    readonly property font largeFont: Qt.font({
                                                  family: Qt.application.font.family,
                                                  pixelSize: Qt.application.font.pixelSize * 1.6
                                              })

    readonly property color backgroundColor: "#c2c2c2"

}
