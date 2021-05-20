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


        ListView
        {
            Layout.fillHeight: true
            Layout.fillWidth: true
            clip: true
            model:
                ListModel //add some styling
                {
                      id: messageList

                      ListElement
                      {
                          message: ""
                      }
                }
            delegate:
                ItemDelegate
            {
                id:messageDelegate
                Rectangle
                {
                    color: "green"
                    Text
                    {
                        text:message
                    }
                    width: childrenRect.width
                    height: childrenRect.height
                }
            }
            ScrollBar.vertical: ScrollBar{}
        }

        Text
        {
            id: t
            //anchors.left: parent
            text:""//textMessage.text
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
                    messageList.append({"message": textMessage.text})
                    //t.text += textMessage.text
                    //textMessage.text="Oops"
                    textMessage.clear()

                }
            }
        }


    }
}

