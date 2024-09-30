// Generated by ReScript, PLEASE EDIT WITH CARE

import * as Dotenv from "dotenv";
import * as Express from "express";

Dotenv.config();

var app = Express();

var router = Express.Router();

router.use(function (req, _res, next) {
      console.log(req);
      next();
    });

router.use(function (err, _req, res, _next) {
      console.error(err);
      res.status(500).end("An error occured");
    });

app.use("/someRoute", router);

app.use(Express.json());

app.get("/", (function (_req, res) {
        res.status(200).json({
              ok: true
            });
      }));

app.all("/allRoute", (function (_req, res) {
        res.status(200).json({
              ok: true
            });
      }));

app.use(function (err, _req, res, _next) {
      console.error(err);
      res.status(500).end("An error occured");
    });

app.listen(8081, (function (param) {
        console.log("Listening on http://localhost:" + String(8081));
      }));

export {
  
}
/*  Not a pure module */