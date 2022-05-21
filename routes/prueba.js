var express = require("express");
var mysql = require("mysql");
const app = require("../app");
var router = express.Router();

/* GET home page. */
router.get("/", function (req, res, next) {
    const dat= new Date(); //Obtienes la fecha
    let dat2 = dat.getUTCMonth()+1;
    res.send(`${dat2} fecha del servidor`);
});

router.post('/', function(req,res,next){
     
});

module.exports = router;
