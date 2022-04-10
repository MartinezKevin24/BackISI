var express = require("express");
const bcrypt = require("bcryptjs");
const mysql = require("mysql");
var router = express.Router();
const Auth = require("../middleware/auth");

const connectionBD = mysql.createConnection({
  host: process.env.HOST,
  user: process.env.USER,
  password: "",
  database: process.env.DATABASE,
  multipleStatements: true,
});

/* GET users listing. */
router.get('/auth', Auth,(req, res, next)=>{
  res.send("Prueba")
})

router.post("/edit", Auth, async function (req, res, next) {
  if (req.body.role == "clientes") {
    let { id, telefono, password } = req.body;
    password = bcrypt.hashSync(password, 10);
    let sql = `UPDATE clientes SET telefono='${telefono}',password='${password}' WHERE id='${id}'`;
    console.log(sql)
    await connectionBD.query(sql, function (error, results) {
      if (error) {
        console.log(error);
        res.send({
          success: false,
        });
      } else {
        res.send({
          message: "Modificado correctamente",
          success: true,
        });
      }
    });
  } else {
    let { id, password, tipoServicio, detalleServicio, tarifaHora, telefono } = req.body; 
    password = bcrypt.hashSync(password, 10);
    let sql = `UPDATE trabajadores SET 
    password='${password}',tipo_servicio='${tipoServicio}',
    detalle_servicio='${detalleServicio}',tarifa_hora=${tarifaHora},telefono='${telefono}' WHERE id='${id}'`;
    await connectionBD.query(sql, function (error, results) {
      if (error) {
        console.log(error);
        res.send({
          success: false,
        });
      } else {
        res.send({
          message: "Modificado correctamente",
          success: true,
        });
      }
    });
  }
});

module.exports = router;
