const { request, response } = require("express");
const jwt = require("jsonwebtoken");
const config = require("./config");

//the token is taken through the header file and printing in the console

const checkToken = (request, response, next)=>{
    let token = request.headers["authorization"];
    console.log(token);
    token = token.slice(7,token.length);
    if(token){
        jwt.verify(token, config.key,(err, decoded)=>{
            if(err){
                return response.json({
                    status:false,
                    msg:"token is invalid"
                });
            }else{
                request.decoded = decoded;
                next();
            }
        });
    }else{
        return response.json({
            status: false,
            msg: "Token is not provided",
        });
    }
};
module.exports = {
    checkToken: checkToken
};