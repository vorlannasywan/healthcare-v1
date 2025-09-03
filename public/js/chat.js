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
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({ message: msg })
    })
    .then(res => {
        if (!res.ok) {
            throw new Error(`Error server: ${res.status} - ${res.statusText}`);
        }
        return res.json();
    })
    .then(data => {
        messages.innerHTML += `<p>AI: ${data.reply}</p>`;
    })
    .catch(err => {
        console.error('Chat error:', err.message);
        messages.innerHTML += `<p>AI: Error: ${err.message}. Coba lagi nanti.</p>`;
    });
}