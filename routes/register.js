var express = require("express");
var mysql = require("mysql");
var bcrypt = require("bcryptjs");
const { NULL } = require("mysql/lib/protocol/constants/types");
var router = express.Router();

var band = 0;

const connectionBD = mysql.createConnection({
  host: "localhost",
  user: "root",
  password: "",
  database: "cameya",
});

router.get("/", function (req, res, next) {
  res.send("Bienvenido, ingrese su usuario y contraseña");
});

router.post("/client", async function (req, res, next) {
  var {
    id,
    email,
    tipoDoc,
    nombres,
    apellidos,
    fechaNacimiento,
    password,
    puntuacion,
  } = req.body;
  sqlVerification(id, email, "clientes");
  if (band == 2) {
    res.send("Usuario ya registrado");
  } else if (band == 1) {
    var sql = `INSERT INTO clientes (id,email,tipo_documento,nombres,apellidos,fecha_nacimiento,password,puntuacion)
    VALUES ('${id}','${email}','${tipoDoc}','${nombres}','${apellidos}','${fechaNacimiento}','${password}',${puntuacion})`;
    await connectionBD.query(sql, function (error, results) {
      if (error) {
        console.log(error);
      } else {
        res.send("Registro exitoso");
        console.log("Registro exitoso");
      }
    });
  }
});

router.post("/worker", async function (req, res, next) {
  var {
    id,
    email,
    tipoDoc,
    nombres,
    apellidos,
    fechaNacimiento,
    password,
    tipoServicio,
    tarifaHora,
    puntuacion,
  } = req.body;
  sqlVerification(id, email, "trabajadores");
  if (band == 2) {
    res.send("Usuario ya registrado");
  } else if (band == 1) {
    password = bcrypt.hashSync(password, 10);
    var sql = `INSERT INTO trabajadores (id,email,tipo_documento,nombres,apellidos,fecha_nacimiento,password,tipo_servicio,tarifa_hora,puntuacion)
    VALUES ('${id}','${email}','${tipoDoc}','${nombres}','${apellidos}','${fechaNacimiento}',
    '${password}','${tipoServicio}',${tarifaHora},${puntuacion})`;
    await connectionBD.query(sql, function (error, results) {
      if (error) {
        console.log(error);
      } else {
        res.send("Registro exitoso");
        console.log("Registro exitoso");
      }
    });
  }
});

var sqlVerification = (id, email, table) => {
  var sql = `SELECT id,email FROM ${table} WHERE id='${id}' OR email='${email}'`;
  connectionBD.query(sql, function (error, results) {
    if (error) {
      throw error;
    } else {
      if (results[0] == null) {
        band = 1;
      } else if (results[0].email == email) {
        band = 2;
        console.log("test");
      } else if (results[0].id == id) {
        band = 2;
        console.log("test01");
      } else if (results[0].id == id && results[0].email == email) {
        band = 2;
      }
    }
  });
};


module.exports = router;
