const express = require("express");
const mysql = require("mysql");
const jwt = require("jsonwebtoken");
const auth = require("../middleware/auth");
require("dotenv").config();

const router = express.Router();

const connectionBD = mysql.createConnection({
  host: process.env.HOST,
  user: process.env.USER,
  password: "",
  database: process.env.DATABASE,
});

router.get("/", async function (req, res, next) {});

router.post("/", auth, async function (req, res, next) {
  const { tipoServicio } = req.body;
  if(tipoServicio !== null){
    
    let sql = `SELECT * FROM trabajadores WHERE tipo_servicio='${tipoServicio}'`;

    await connectionBD.query(sql, function (error, results) {
      
      if (error) {
        console.log(error);
      } else {
        if (results[0] == null) {
          console.log(`No hay cameyadores para ${tipoServicio}`);
          res.send({
            succes:false
          })
        }else{
          res.send({
            variable:'Array',
            data: results,
            succes:true
          })
        }
      }
    });
  }else{
    let sql = `SELECT * FROM trabajadores`;
    await connectionBD.query(sql, function (error, results) {
      if (error) {
        console.log(error);
      } else {
        if (results[0] == null) {
          console.log(`No hay cameyadores`);
          res.send({
            succes:false
          })
        }else{
            res.send({
              variable:'Array',
              data: results,
              succes:true
            })
        }
      }
    });
  }
});

module.exports = router;
