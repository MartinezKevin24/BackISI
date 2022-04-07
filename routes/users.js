var express = require('express');
var router = express.Router();
const Auth = require("../middleware/auth");

/* GET users listing. */
router.get('/auth', Auth,(req, res, next)=>{
  res.send("Prueba")
  // try{

  //   const vari = jwt.verify(req.body.token, process.env.TOKEN);
  //   console.log(vari);
  //   res.sendStatus(200);

  // }catch(err){
  //   console.log(err)
  //   res.sendStatus(403);
  // }
})

router.get('/', function(req, res, next) {
  res.send('respond with a resource');
});

module.exports = router;
