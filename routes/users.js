var express = require('express');
const res = require('express/lib/response');
var router = express.Router();
const jwt = require("jsonwebtoken");

/* GET users listing. */
router.post('/auth', (req, res, next)=>{
  try{

    const vari = jwt.verify(req.body.token, process.env.TOKEN);
    console.log(vari);
    res.sendStatus(200);

  }catch(err){
    console.log(err)
    res.sendStatus(403);
  }
})

router.get('/', function(req, res, next) {
  res.send('respond with a resource');
});

module.exports = router;
