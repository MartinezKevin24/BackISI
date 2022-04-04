var express = require("express");
var mysql = require("mysql");
const app = require("../app");
var router = express.Router();

const connectionBD = mysql.createConnection({
  host: "localhost",
  user: "root",
  password: "",
  database: "cameya",
});


/* GET home page. */
router.get("/", function (req, res, next) {
  
  connectionBD.connect((err) => {
    if (err) {
      throw err;
    } else {
      console.log("Conectado a la BD/index");
    }
  });

  var name = "users";
  var sql = `SELECT * FROM ${name} WHERE id='m1'`;
  connectionBD.query(sql, function (error, results) {
    if (error) {
      throw error;
    } else {
      const{name, id, role, password}=results[0];
      console.log('Tu nombre es '+name);
    }
  });

  connectionBD.end();

  res.send("");
});

router.post('/', function(req,res,next){
  const {name, id, role, password}=req.body;
  console.log(name);
  res.send('Succes')    
});

module.exports = router;
