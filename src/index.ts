import express, { Express } from "express"
import { createServer } from "http";
import { socket } from "./socket";
import { routes } from "./routes";

const app: Express = express();
routes(app);

const server = createServer(app);
socket(server);

server.listen(process.env.PORT || 1337, () => {
    console.log(`Listening Port ${process.env.PORT || 1337}`);
})