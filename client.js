const { Manager, io } = require('socket.io-client');

const sk = io("http://localhost:1337");

sk.on("connect", () => {
    console.log(sk.id);
    // socket.emit("hello", "world");
})

