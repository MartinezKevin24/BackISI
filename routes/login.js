const express = require("express");
const mysql = require("mysql");
const bcrypt = require("bcryptjs");
const jwt = require("jsonwebtoken");
require("dotenv").config();

const router = express.Router();

const connectionBD = mysql.createConnection({
  host: process.env.HOST,
  user: process.env.USER,
  password: "",
  database: process.env.DATABASE,
});

router.post("/", function (req, res, next) {
  const { email, password, table } = req.body;

  let sql = `SELECT * FROM ${table} WHERE email='${email}'`;
  connectionBD.query(sql, function (error, results) {
    if (error) {
      throw error;
    } else {
      if (results[0] == null) {
        console.log("Correo o contraseña incorrecta2");
        res.send({
          message: "Not logged, email or password incorrect",
          data: {},
          token: null,
          success: false,
        });
      } else if (results[0].email == email) {
        if (bcrypt.compareSync(password, results[0].password) == false) {
          console.log("Correo o contraseña incorrecta1");
          res.send({
            message: "Not Logged, email or password incorrect",
            data: {},
            token: null,
            success: false,
          });
        } else {
          console.log({ message: "Logged correctamente", success: true });
          const accessToken = generateAccesToken(results[0].email);
          const token = jwt.verify(accessToken, process.env.TOKEN);
          console.log(token);
          let ano = results[0].fecha_nacimiento.getFullYear();
          let mes = results[0].fecha_nacimiento.getMonth() + 1;
          let dia = results[0].fecha_nacimiento.getDay();
          let fecha = `${ano}-${mes}-${dia}`;
          console.log(fecha, "test");
          if (table == "trabajadores") {
            let sqlProm = `SELECT AVG(puntuacion_trabajador) AS promedio FROM servicios WHERE trabajador_id=${results[0].id}`;
            connectionBD.query(sqlProm, function (error, resultados) {
              res
                .cookie("token", accessToken, {
                  httpOnly: true,
                  secure: false,
                })
                .json({
                  message: "Usuario autenticado",
                  data: {
                    cedula: results[0].id,
                    email: results[0].email,
                    tipoDocumento: results[0].tipo_documento,
                    nombres: results[0].nombres,
                    apellidos: results[0].apellidos,
                    fechaNacimiento: fecha,
                    detalleServicio: results[0].detalle_servicio,
                    tipoServicio: results[0].tipo_servicio,
                    tarifaHora: results[0].tarifa_hora,
                    puntuacion: results[0].puntuacion,
                    telefono: results[0].telefono,
                    fotoPerfil: results[0].foto_perfil,
                    puntuacion: resultados[0].promedio,
                    role: "trabajadores",
                  },
                  token: accessToken,
                  success: true,
                });
            });
          } else {
            let sqlProm = `SELECT AVG(puntuacion_cliente) AS promedio FROM servicios WHERE cliente_id=${results[0].id}`;
            connectionBD.query(sqlProm, function (error, resultados) {
              res
                .cookie("token", accessToken, {
                  httpOnly: true,
                })
                .json({
                  message: "Usuario autenticado",
                  data: {
                    cedula: results[0].id,
                    email: results[0].email,
                    tipoDocumento: results[0].tipo_documento,
                    nombres: results[0].nombres,
                    apellidos: results[0].apellidos,
                    fechaNacimiento: fecha,
                    telefono: results[0].telefono,
                    fotoPerfil: results[0].foto_perfil,
                    puntuacion: resultados[0].promedio,
                    role: "clientes",
                  },
                  token: accessToken,
                  success: true,
                });
            });
          }
        }
      }
    }
  });
});

function generateAccesToken(email) {
  return jwt.sign(email, process.env.TOKEN);
}

module.exports = router;
