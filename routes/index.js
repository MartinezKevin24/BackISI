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
  
});

router.post('/', function(req,res,next){
     
});

module.exports = router;
