import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import QtWebSockets 1.1

//chat window
Window {
    width:640
    height: 480
    visible: true
    title: qsTr("socket_chat")
    color:"blue"

    WebSocket {
           id: socket
           url: "ws://localhost:8080"
           onTextMessageReceived: {
               messageList.append({"message": message})
           }

           onStatusChanged: if (socket.status == WebSocket.Error)
                            {
                                console.log("Error: " + socket.errorString)
                            } else if (socket.status == WebSocket.Open)
                            {
                               console.log("Socket Open!!")
                            } else if (socket.status == WebSocket.Closed)
                            {
                                console.log("Socket Closed :(")
                            }
           active: true

       }

    //Chatting layout/login layout depending on the state of the app
    ColumnLayout
    {
        id: messageColumn
        anchors.centerIn: parent
        visible: true

        //area to display text message history
        ListView
        {
            Layout.fillHeight: true
            Layout.fillWidth: true
            clip: true

            model:
                ListModel
                {
                      id: messageList

                      ListElement
                      {
                          //the head of the must have a value, so an empty list would be ""
                          message: "Welcome to the chat!"
                      }
                }

            delegate:
                ItemDelegate
            {

                Rectangle
                {
                    color: "green"
                    radius: 3
                    border.width: 1
                    border.color: "black"

                    Text
                    {
                        color: "white"
                        padding: 7
                        text:message
                    }
                    width: childrenRect.width
                    height: childrenRect.height
                }
            }
            ScrollBar.vertical: ScrollBar{}
        }

        //login textbox and button to create username
        RowLayout {
            id: loginLayout
            visible: true
            //Layout.alignment: verticalCenter

            TextField
            {
                id: username
                placeholderText: qsTr("User...")
                onAccepted: createUser.clicked()
            }

            Button
            {
                id: createUser
                text: qsTr("login")
                onClicked:
                {
                    loginLayout.visible = false
                    messageColumn.anchors.fill = messageColumn.parent
                    messageLayout.visible = true
                    console.log(username.text)
                }
            }
        }

        //messaging layout for sending and receiving text messages
        RowLayout
        {
            visible:false
            id:messageLayout
            TextField
            {
                id: messageBox
                placeholderText: qsTr("Your Message...")
                Layout.fillWidth: true
                onAccepted: send.clicked()
            }

            Button
            {
                id: send
                text: qsTr("Send")
                onClicked:
                {
                    messageList.append({"message": "(Me): " + messageBox.text })
                    socket.sendTextMessage("(" + username.text + "): " + messageBox.text)
                    messageBox.clear()
                    console.log(username.text)
                }
            }
        }


    }
}

