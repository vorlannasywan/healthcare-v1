document.getElementById('chat-bubble').onclick = () => {
    document.getElementById('chat-window').style.display = 'block';
};
function sendChat() {
    const input = document.getElementById('chat-input');
    const msg = input.value;
    input.value = '';
    const messages = document.getElementById('chat-messages');
    messages.innerHTML += `<p>User: ${msg}</p>`;
    fetch('/chat', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json', 'Authorization': 'Bearer ' + localStorage.token },
        body: JSON.stringify({ message: msg })
    }).then(res => res.json()).then(data => {
        messages.innerHTML += `<p>AI: ${data.reply}</p>`;
    });
}