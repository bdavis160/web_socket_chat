import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import QtWebSockets 1.1
Window {
    width:640
    height: 480
    visible: true
    title: qsTr("socket_chat")

    WebSocket {
           id: socket
           url: "ws://localhost:8080"
           onTextMessageReceived: {
               messageList.append({"message": "\nNew message: " + message})
           }

           onStatusChanged: if (socket.status == WebSocket.Error) {
                                console.log("Error: " + socket.errorString)
                            } else if (socket.status == WebSocket.Open) {
                               console.log("Socket Open!!")
                                //socket.sendTextMessage("Hello World")
                            } else if (socket.status == WebSocket.Closed) {
                                console.log("Socket Closed :(")
                            }
           active: true

       }
    /*adds message to message display area and clears the textbox
    function showMessage(messageList, messageBox) {
        messageList.append({"message": messageBox.text})
        messageBox.clear()
    }

    //Init connection to node server
    function init(ws) {

        if (ws) {
            ws.onerror = ws.onopen = ws.onclose = null;
            ws.close();
         }

         ws = new WebSocket('ws://localhost:8080');
         ws.onopen = () => {
            console.log('Connection opened');
         }

         ws.onmessage = ({data}) => showMessage(messageList, messageBox);
         ws.onclose = function() {
            ws=null;
         }

        sendButton.onclick = function() {
            if (!ws) {
                console.log("No Connection :(");
                return;
            }

            ws.send(messageBox.text);
            showMessage(messageList, messageBox);
        }
    }

    //creates connection to node server
    function connection() {
        let ws
        init(ws);
    }
*/

    ColumnLayout
    {
        anchors.fill: parent

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
                    radius: 3
                    border.width: 1
                    border.color: "black"

                    Text
                    {
                        color: "white"
                        text:message
                    }
                    width: childrenRect.width
                    height: childrenRect.height
                }
            }
            ScrollBar.vertical: ScrollBar{}
        }



        RowLayout
        {

            TextField
            {
                id: messageBox
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
                    //connection()
                    //socket.active = true //!socket.active
                    console.log(socket.status)
                    console.log("Sent") //send to server
                    messageList.append({"message": messageBox.text})
                    socket.sendTextMessage(messageBox.text)
                    messageBox.clear()
                }
            }
        }


    }
}

