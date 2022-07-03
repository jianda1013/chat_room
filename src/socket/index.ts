import * as socketio from "socket.io";
import { Server } from "http";

function socket(server: Server) {
    const io = new socketio.Server(server);
    // io.on("connection", (...params) => {
    //     console.log(params);
    // })
}

export { socket }
