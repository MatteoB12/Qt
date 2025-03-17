/*
This is a UI file (.ui.qml) that is intended to be edited in Qt Design Studio only.
It is supposed to be strictly declarative and only uses a subset of QML. If you edit
this file manually, you might introduce QML code that is not supported by Qt Design Studio.
Check out https://doc.qt.io/qtcreator/creator-quick-ui-forms.html for details on .ui.qml files.
*/

import QtQuick
import QtQuick.Controls
import PrimaProva

Rectangle {
    width: Constants.width
    height: Constants.height
    color: "#665f5b"


    Text {
        width: 52
        height: 30
        color: "#ff0000"
        text: qsTr("Salve a tutti!")
        scale: 1.7
        anchors.verticalCenterOffset: -55
        anchors.horizontalCenterOffset: -24
        anchors.centerIn: parent
        font.family: Constants.font.family
    }
}
