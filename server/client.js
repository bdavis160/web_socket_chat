
(function() {
let ws;

function showMessage(message, messages, messageBox) {
    messages += '\n\n' + message;
    messageBox = ''
}

function init() {
    if (ws) {
        ws.onerror = ws.onopen = ws.onclose = null;
        ws.close()
    }

    ws = new WebSocket('ws://localhost:5500');
    ws.onopen = () => {
        console.log('connection open');
    }

    ws.onmessage = ({data}) => showMessage(data)
    ws.onclose = function() {
        ws = null;
    }

    function sendClick() {
        if (!ws) {
            showMessage("No webSocket connection :( ");
            return;
        }
    }

    ws.send(message)
}
})();