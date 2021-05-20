const http = require('http');
const webSocket = require('ws');
const express = require ('express')
const port = 5500
const server = http.createServer(express)
const wss = new webSocket.Server( {server})

wss.on('connection', function connection(ws) {
    ws.on('message', function incoming(data) {
        wss.clients.forEach(function each(client) {
            if (client != ws && client.readyState == webSocket.OPEN)
                client.send(data);
        })
    })
})

server.listen(port, function() {
    console.log(`server is lisening on ${port}`)
})