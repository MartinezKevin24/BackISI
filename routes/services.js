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

router.get("/:id/:tipo", async function (req, res, next) { 
  const id = req.params.id;
  const tipo = req.params.tipo.toLowerCase();
  const role  = req.headers.role;
  
  if(role==="clientes"){
    if(tipo==="todos"){
      let sql = `SELECT servicios.id, servicios.fecha_programada, servicios.total, servicios.direccion, trabajadores.tipo_servicio, trabajadores.tipo_servicio, trabajadores.detalle_servicio FROM servicios, trabajadores 
    WHERE servicios.cliente_id = "${id}" AND servicios.trabajador_id = trabajadores.id`;
  
      await connectionBD.query(sql, function (error, results) {
        if (error) {
          console.log(error);
        } else {
          if (results[0] == null) {
            console.log(`No hay servicios`);
            res.send({
              succes:false
            })
          }else{
              console.log(`Enviando servicios`);
              results.forEach(element => {
                console.log(element.nombres);
              });
              res.send({
                variable:'Array',
                data: results,
                succes:true
              })
          }
        }
      });
    }else{
      let sql = `SELECT servicios.id, servicios.fecha_programada, servicios.total, servicios.direccion, trabajadores.tipo_servicio, trabajadores.tipo_servicio, trabajadores.detalle_servicio FROM servicios, trabajadores 
      WHERE servicios.cliente_id = "${id}" AND servicios.trabajador_id = trabajadores.id AND trabajadores.tipo_servicio = "${tipo}"`;
  
        await connectionBD.query(sql, function (error, results) {
          if (error) {
            console.log(error);
          } else {
            if (results[0] == null) {
              console.log(`No hay servicios`);
              res.send({
                succes:false
              })
            }else{
                console.log(`Enviando servicios`);
                results.forEach(element => {
                  console.log(element.nombres);
                });
                res.send({
                  variable:'Array',
                  data: results,
                  succes:true
                })
            }
          }
        });
    }
  }else{
    let sql = `SELECT servicios.id, servicios.fecha_programada, servicios.total, servicios.direccion, clientes.nombres, clientes.apellidos, clientes.telefono 
               FROM servicios, clientes 
               WHERE servicios.trabajador_id = "${id}"`;
  
        await connectionBD.query(sql, function (error, results) {
          if (error) {
            console.log(error);
          } else {
            if (results[0] == null) {
              console.log(`No hay servicios`);
              res.send({
                succes:false
              })
            }else{
                console.log(`Enviando servicios`);
                results.forEach(element => {
                  console.log(element.nombres);
                });
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

router.post("/", auth, async function (req, res, next) {
  const {
    idCliente,
    idTrabajador,
    direccion,
    fechaProgramada,
    horas,
    estado,
  } = req.body;
  console.log(req.body)
  let date = new Date();
  const fechaAsiganada = date.toISOString();

  console.log(fechaAsiganada)

  let sqlPrecioHora = `SELECT tarifa_hora FROM trabajadores WHERE id=${idTrabajador}`;
  await connectionBD.query(sqlPrecioHora, function (error, results) {
    if (error) {
      console.log(error);
      res.send({
        message: "Cameyador no encontrado",
        success: false,
      });
    } else {
      console.log(results[0].tarifa_hora);
      let total = parseInt(results[0].tarifa_hora) * horas;
      console.log(total);

      let sql = `INSERT INTO servicios(fecha_asignacion,direccion,fecha_programada,horas,total,estado,cliente_id,trabajador_id) 
      VALUES('${fechaAsiganada}','${direccion}','${fechaProgramada}','${horas}',${total},'${estado}','${idCliente}','${idTrabajador}')`;

      connectionBD.query(sql, function (error, results) {
        if (error) {
          console.log(error);
          res.send({
            message:'Error al crear el servicio',
            success: false
          })
        } else {
          res.send({
            message: "Servicio creado correctamente",
            success: true,
          });
        }
      });
    }
  });
});

router.delete("/:id", auth, async function (req, res, next) {
  const id = req.params.id;

  let sql = `DELETE FROM servicios WHERE id='${id}' `;
  await connectionBD.query(sql, function (error, results) {
    if (error) {
      console.log(error);
      res.send({
        success: false,
      });
    } else {
      res.send({
        message: "Servicio eliminado correctamente",
        success: true,
      });
    }
  });
});

module.exports = router;
