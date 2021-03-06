var express = require("express");
const bcrypt = require("bcryptjs");
const mysql = require("mysql");
var router = express.Router();
const Auth = require("../middleware/auth");
const cloudinary = require("../middleware/cloudinary");
const upload = require("../middleware/multer");

const connectionBD = mysql.createConnection({
  host: process.env.HOST,
  user: process.env.USER,
  password: "",
  database: process.env.DATABASE,
  multipleStatements: true,
});

/* GET users listing. */
router.get("/auth", Auth, (req, res, next) => {
  res.send("Prueba");
});

router.post("/edit", Auth, upload.single("image"), async function (req, res, next) {

    console.log(req.file)

    let imagePath = null;

    if(req.file){
        const image = await cloudinary.uploader.upload(req.file.path);
        imagePath = image.secure_url;
    }
      
    if (req.body.role == "clientes") {
      let { id, telefono, password } = req.body;
      password = bcrypt.hashSync(password, 10);

      let sql;

      if(req.file){
        sql = `UPDATE clientes SET telefono='${telefono}',password='${password}',foto_perfil='${imagePath}' WHERE id='${id}'`;
      }else{
        sql = `UPDATE clientes SET telefono='${telefono}',password='${password}' WHERE id='${id}'`;
      }
      
      
      await connectionBD.query(sql, function (error, results) {
        if (error) {
          console.log(error);
          res.send({
            success: false,
          });
        } else {
          res.send({
            message: "Modificado correctamente",
            success: true,
          });
        }
      });

    } else {

      let {
        id,
        password,
        tipoServicio,
        detalleServicio,
        tarifaHora,
        telefono,
      } = req.body;
      let sql;
      password = bcrypt.hashSync(password, 10);

      if(req.file){
        sql = `UPDATE trabajadores SET 
        password='${password}',tipo_servicio='${tipoServicio}',
        detalle_servicio='${detalleServicio}',tarifa_hora=${tarifaHora},telefono='${telefono}',foto_perfil='${imagePath}' WHERE id='${id}'`;
      }else{
        sql = `UPDATE trabajadores SET 
        password='${password}',tipo_servicio='${tipoServicio}',
        detalle_servicio='${detalleServicio}',tarifa_hora=${tarifaHora},telefono='${telefono}' WHERE id='${id}'`;
      }

      await connectionBD.query(sql, function (error, results) {
        if (error) {
          console.log(error);
          res.send({
            success: false,
          });
        } else {
          res.send({
            message: "Modificado correctamente",
            success: true,
          });
        }
      });
    }
  }
);

module.exports = router;
