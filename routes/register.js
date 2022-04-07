const express = require("express");
const mysql = require("mysql");
const bcrypt = require("bcryptjs");
const router = express.Router();

const connectionBD = mysql.createConnection({
  host: process.env.HOST,
  user: process.env.USER,
  password: "",
  database: process.env.DATABASE,
  multipleStatements: true,
  
});

router.get("/", function (req, res, next) {
  res.send("Bienvenido, ingrese su usuario y contraseña");
});

router.post("/client", async function (req, res, next) {
  let {
    id,
    email,
    tipoDoc,
    nombres,
    apellidos,
    fechaNacimiento,
    password,
    puntuacion,
    phone
  } = req.body;
  password = bcrypt.hashSync(password, 10);

  let sql = `SELECT id,email FROM clientes WHERE id='${id}' OR email='${email}'`;
  await connectionBD.query(sql, function (error, results) {
    if (error) {
      throw error;
    } else {
      if (results[0] == null) {
        band = 1;
        let sql = `INSERT INTO clientes (id,email,tipo_documento,nombres,apellidos,fecha_nacimiento,password,puntuacion,telefono)
        VALUES ('${id}','${email}','${tipoDoc}','${nombres}','${apellidos}','${fechaNacimiento}',
        '${password}',${puntuacion}, ${phone})`;
        connectionBD.query(sql, function (error, results) {
          if (error) {
            console.log(error);
          } else {
            res.send({res: "Registro exitoso", success: true});
          }
        });
      } else if (results[0].email == email) {
        res.send({res: "Usario ya registrado", success: false});
      } else if (results[0].id == id) {
        console.log("test01");
        res.send({res: "Usario ya registrado", success: false});
      } else if (results[0].id == id && results[0].email == email) {
        res.send({res: "Usario ya registrado", success: false});
      }
    }
  });
  
});

router.post("/worker", async function (req, res, next) {
  let {
    id,
    email,
    tipoDoc,
    nombres,
    apellidos,
    fechaNacimiento,
    password,
    tipoServicio,
    detalleServicio,
    tarifaHora,
    puntuacion,
    phone
  } = req.body;
  password = bcrypt.hashSync(password, 10);

  let sql = `SELECT id,email FROM trabajadores WHERE id='${id}' OR email='${email}'`;
  await connectionBD.query(sql, function (error, results) {
    if (error) {
      throw error;
    } else {
      if (results[0] == null) {
        band = 1;
        let sql = `INSERT INTO trabajadores (id,email,tipo_documento,nombres,apellidos,fecha_nacimiento,password,tipo_servicio,tarifa_hora,puntuacion,telefono, detalle_servicio)
        VALUES ('${id}','${email}','${tipoDoc}','${nombres}','${apellidos}','${fechaNacimiento}',
        '${password}','${tipoServicio}',${tarifaHora}, ${puntuacion}, ${phone}, '${detalleServicio}')`;
        connectionBD.query(sql, function (error, results) {
          if (error) {
            console.log(error);
          } else {
            res.send({res: "Registro exitoso", success: true});
          }
        });
      } else if (results[0].email == email) {
        res.send({res: "Usario ya registrado", success: false});
      } else if (results[0].id == id) {
        res.send({res: "Usario ya registrado", success: false});
      } else if (results[0].id == id && results[0].email == email) {
        res.send({res: "Usario ya registrado", success: false});
      }
    }
  });
  
});


module.exports = router;
