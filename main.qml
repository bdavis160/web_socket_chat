import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12

Window {
    width:640
    height: 480
    visible: true
    title: qsTr("socket_chat")

    ColumnLayout {
        anchors.fill: parent
        ListView {
            Layout.fillHeight: true
            Layout.fillWidth: true
            clip: true
        }
        RowLayout {
            TextField {
                placeholderText: qsTr("socket_chat")
                Layout.fillWidth: true
                onAccepted: send.clicked()
            }
            Button {
                id: send
                text: qsTr("Send")
                onClicked: console.log("Sent") //send to server
            }
        }
    }
}

