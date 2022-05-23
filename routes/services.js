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
  const role = req.headers.role;

  if (role === "clientes") {
    if (tipo === "todos") {
      let sql = `SELECT servicios.id, servicios.estado_solicitud, servicios.fecha_programada, servicios.total, servicios.direccion, trabajadores.tipo_servicio, trabajadores.tipo_servicio, trabajadores.detalle_servicio FROM servicios, trabajadores 
    WHERE servicios.cliente_id = '${id}' AND servicios.trabajador_id = trabajadores.id`;

      await connectionBD.query(sql, function (error, results) {
        if (error) {
          console.log(error);
        } else {
          if (results[0] == null) {
            console.log(`No hay servicios`);
            res.send({
              succes: false,
            });
          } else {
            console.log(`Enviando servicios`);
            results.forEach((element) => {
              let fecha = element.fecha_programada;
              let hora = fecha.getHours();
              element.fecha_programada.setHours(hora - 5);
            });
            res.send({
              variable: "Array",
              data: results,
              succes: true,
            });
          }
        }
      });
    } else {
      let sql = `SELECT servicios.id, servicios.estado_solicitud, servicios.fecha_programada, servicios.total, servicios.direccion, trabajadores.tipo_servicio, trabajadores.tipo_servicio, trabajadores.detalle_servicio, servicio.estado_servicio FROM servicios, trabajadores 
      WHERE servicios.cliente_id = '${id}' AND servicios.trabajador_id = trabajadores.id AND trabajadores.tipo_servicio = '${tipo}'`;

      await connectionBD.query(sql, function (error, results) {
        if (error) {
          console.log(error);
        } else {
          if (results[0] == null) {
            console.log(`No hay servicios`);
            res.send({
              succes: false,
            });
          } else {
            console.log(`Enviando servicios`);
            results.forEach((element) => {
              let fecha = element.fecha_programada;
              let hora = fecha.getHours();
              element.fecha_programada.setHours(hora - 5);
            });
            res.send({
              variable: "Array",
              data: results,
              succes: true,
            });
          }
        }
      });
    }
  } else {
    let sql = `SELECT servicios.id, servicios.estado_solicitud, servicios.fecha_programada, servicios.total, servicios.direccion, clientes.nombres, clientes.apellidos, clientes.telefono, servicios.estado_servicio 
               FROM servicios, clientes 
               WHERE servicios.trabajador_id = '${id}' AND clientes.id = servicios.cliente_id`;

    await connectionBD.query(sql, function (error, results) {
      if (error) {
        console.log(error);
      } else {
        if (results[0] == null) {
          console.log(`No hay servicios`);
          res.send({
            succes: false,
          });
        } else {
          console.log(`Enviando servicios`);
          results.forEach((element) => {
            let fecha = element.fecha_programada;
            let hora = fecha.getHours();
            element.fecha_programada.setHours(hora - 5);
          });
          res.send({
            variable: "Array",
            data: results,
            succes: true,
          });
        }
      }
    });
  }
});

router.post("/", auth, async function (req, res, next) {
  const { idCliente, idTrabajador, direccion, fechaProgramada, horas, descripcion } = req.body;
  console.log(req.body);
  const dat = new Date();

  let ano = dat.getFullYear();
  let mes = dat.getMonth() + 1;
  let dia = dat.getDate();
  let hora = dat.getHours();
  let minuto = dat.getMinutes();
  let segundo = dat.getSeconds();

  let fechaAsiganada = `${ano}-${mes}-${dia} ${hora}:${minuto}:${segundo}`;

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

      let sql = `INSERT INTO servicios(fecha_asignacion,direccion,fecha_programada,horas,total,cliente_id,trabajador_id,descripcion_servicio) 
      VALUES('${fechaAsiganada}','${direccion}','${fechaProgramada}','${horas}',${total},'${idCliente}','${idTrabajador}', '${descripcion}')`;

      connectionBD.query(sql, function (error, results) {
        if (error) {
          console.log(error);
          res.send({
            message: "Error al crear el servicio",
            success: false,
          });
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

router.put("/complete/:id", auth, async function (req, res, next) {
  const id = req.params.id;
  const fechaServer = new Date();
  let sql = `SELECT fecha_programada, horas FROM servicios WHERE id='${id}'`;
  await connectionBD.query(sql, function (error, results) {
    if (error) {
      console.log(error);
      res.send({
        success: false
      });
    } else {

      let fechaServicio = results[0].fecha_programada;
      let horas = results[0].horas;
      let hora = fechaServicio.getHours();
      fechaServicio.setHours(hora - 5 + horas);
      fechaServer.setHours(fechaServer.getHours() - 5);

      console.log(fechaServicio, fechaServer)

      if (fechaServer > fechaServicio) {

        let sql2 = `UPDATE servicios SET estado_servicio = 1 WHERE id='${id}'`;
        connectionBD.query(sql2, function (error, results) {
          if (error) {
            console.log(error);
            res.send({
              succes: false
            });
          } else {
            res.send({
              message: "Servicio completado",
              succes: true
            });
          }
        });
        
      }else{
        res.send({
          message: "Servicio no completado",
          succes: false
        });
      }
    }
  });
});

router.put("/approval", auth, async function (req, res, next) {

  let { id, estado } = req.body;

  let sql = `UPDATE servicios SET estado_solicitud='${estado}' WHERE id=${id}`;

  await connectionBD.query(sql, function (error, results) {
    if (error) {
      console.log(error);
      res.send({
        success: false
      });
    } else {
      res.send({
        message: "Estado cambiado",
        success: true
      })
    }
  });

})

router.put("/rating", auth, async function (req, res, next) {
  let { id, puntuacion, role } = req.body;
  if (role == 'trabajadores') {
    let sql = `UPDATE servicios SET puntuacion_cliente=${puntuacion} WHERE id=${id}`;
    await connectionBD.query(sql, function (error, results) {
      if (error) {
        console.log(error);
        res.send({
          success: false
        });
      } else {
        res.send({
          message: "Puntuacion asignada",
          success: true
        })
      }
    })
  } else {
    let sql = `UPDATE servicios SET puntuacion_trabajador=${puntuacion} WHERE id=${id}`;
    await connectionBD.query(sql, function (error, results) {
      if (error) {
        console.log(error);
        res.send({
          success: false
        });
      } else {
        res.send({
          message: "Puntuacion asignada",
          success: true
        })
      }
    })
  }

});

module.exports = router;
