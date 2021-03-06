"use strict" ;

const port = process.env.DBWEBB_PORT || 1337;
const express = require ( "express" );
const app = express();
const routeBank = require( "./route/bank.js" );
const path = require ( "path" );

app.use(express.static(path.join(__dirname, "public")));

app.set("view engine", "ejs");

app.use("/bank", routeBank);
app.use((req, res, next) => {
    console.info(`Got request on ${req.path} ( ${req.method} ) .`);
    next();
});

app.listen(port, () => {
    console.info(`Server is listening on port ${port} .`);
});