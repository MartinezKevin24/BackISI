const jwt = require("jsonwebtoken")

module.exports = function Auth(req, res, next){
    const token = req.header("authorization");

    try{

        jwt.verify(token, process.env.TOKEN);
        next();

    }catch(err){

        res.statusCode(403);

    }

}