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

router.get("/", function (req, res, next) {});

router.post("/", auth, async function (req, res, next) {
  const {
    idCliente,
    idTrabajador,
    direccion,
    fechaProgramada,
    horas,
    estado,
  } = req.body;
  let fechaAsiganada = Date.now();
  let total=0;

  let sqlPrecioHora = `SELECT tarifa_hora FROM trabajadores WHERE id=${idTrabajador}`;
  await connectionBD.query(sqlPrecioHora, function (error, results) {
    if (error) {
      console.log(error);
      res.send({
          message:"Cameyador no encontrado",
          success:false
      })
    } else {
      console.log(results[0].tarifa_hora);
      total = parseInt(results[0].tarifa_hora) * horas;
      console.log(total);
    }
  });

  console.log('Precio'+total);

  let sql = `INSERT INTO servicios(fecha_asignacion,direccion,fecha_programada,horas,total,estado,cliente_id,trabajador_id) 
  VALUES('${fechaAsiganada}','${direccion}','${fechaProgramada}','${horas}',${total},'${estado}','${idCliente}','${idTrabajador}')`;

  await connectionBD.query(sql,function(error,results){
      if(error){
          console.log(error);
          res.send({
              success:false
          })
      }else{
          res.send({
              success:true
          })
      }
  })

});

module.exports = router;
