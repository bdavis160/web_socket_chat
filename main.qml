import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12

Window {
    width:640
    height: 480
    visible: true
    title: qsTr("socket_chat")


    ColumnLayout
    {
        anchors.fill: parent

        /*ListModel {
            ListElement
            {
                message: "hi"
            }
            ListElement
            {
                message: "oh hey"
            }
        }

        ListView
        {
            Layout.fillHeight: true
            Layout.fillWidth: true
            clip: true
            delegate: Text
            {
                text: message
            }
        }

        */
        ListModel
        {
              id: messageList
              ListElement
              {
                  message: ""
              }
        }

        ListView
        {
            Layout.fillHeight: true
            Layout.fillWidth: true
            clip: true
            model: messageList
            delegate:ItemDelegate
            {
                text:message
            }
            ScrollBar.vertical: ScrollBar{}
        }

        Text
        {
            id: t
            //anchors.left: parent
            text:""
        }



        RowLayout
        {
            TextField
            {
                id: textMessage
                placeholderText: qsTr("socket_chat")
                Layout.fillWidth: true
                onAccepted: send.clicked()
            }
            Button
            {
                id: send
                text: qsTr("Send")
                onClicked:
                {
                    console.log("Sent") //send to server
                    //sentMessage.insert(textMessage.text)
                    messageList.append({"message": textMessage.text})
                    //messageList.remove()
                    textMessage.text=""
                }
            }
        }


    }
}

