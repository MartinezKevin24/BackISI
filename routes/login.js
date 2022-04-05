var express = require("express");
var mysql = require("mysql");
var bcrypt = require("bcryptjs");

var router = express.Router();

const connectionBD = mysql.createConnection({
  host: "localhost",
  user: "root",
  password: "",
  database: "cameya",
});

router.post("/", function (req, res, next) {
  const { email, password, table } = req.body;

  console.log(req.body);

  var sql = `SELECT * FROM ${table} WHERE email='${email}'`;
  connectionBD.query(sql, function (error, results) {
    if (error) {
      throw error;
    } else {
      if (results[0] == null) {
        console.log("Correo o contraseña incorrecta2");
        res.send({message: 'Not logged, email or password incorrect', success: false})
      } else if (results[0].email == email) {
        if (bcrypt.compareSync(password, results[0].password) == false) {
          console.log("Correo o contraseña incorrecta1");
          res.send({message: 'Not Logged, email or password incorrect', success: false});
        } else {
          console.log({message: "Logged correctamente", success: true});
          res.send({message: "Welcome "+results[0].nombres, success: true});
        }
      }
    }
  });
});

module.exports = router;
