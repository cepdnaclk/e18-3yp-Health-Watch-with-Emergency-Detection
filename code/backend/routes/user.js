const { request, response } = require("express");
const express = require("express");
const User = require("../models/user_model");
const Reminder = require("../models/reminders_model.js");
const config = require("../config");
const jwt = require("jsonwebtoken");
const middleware = require("../middleware");

const router = express.Router();

router.route("/:username").get(middleware.checkToken,(request, response) => { //getting userdata through get request from the username
    User.findOne({username: request.params.username}, (err, result)=>{
        if(err) response.status(500).json({msg:err});
        response.json({
            data: result,
            username: request.params.username,
        });
    });
});
router.route("/login").post((request, response)=>{
    User.findOne({username:request.body.username}, (err, result)=>{
        if(err) response.status(500).json({msg:err});
        if(result===null){
            response.status(403).json("Username is incorrect")
        }
        if(result.password===request.body.password){
            let token = jwt.sign({username:request.body.username}, config.key,{
                expiresIn:"24h", //token is expiring after 24h
            });
            response.json({
                username:request.body.username,
                token:token,
                msg: "success",
            });
        }else{
            response.status(403).json("password is incorrect.");
        }
    });
});

router.route("/register").post((request,response) => {
    console.log("inside the register");
    const user = new User({
        username:request.body.username,
        email:request.body.email,
        password:request.body.password,

    });
    user
        .save()
        .then(() =>{
            console.log("User registered");
            response.status(200).json("ok");
        })
        .catch((err) => {
            response.status(403).json({msg:err});
        });
    //response.json("registered");
});

//in the deleting and updating middleware token checking is used since it is better to authenticate the user before doing any operations

router.route("/update/:username").patch((request, response)=>{ //sending the username to retrieve data
    User.findOneAndUpdate(
        {$set:{username: request.params.username}}, //as a parameter
        {$set:{password:request.body.password}}, //once the username is found password is sending in the body
        (err, result) => {
            if(err) return response.status(500).json({msg: err});
            const msg = {
                msg: "password successfully updated!",
                username:request.params.username,
            };
            return response.json(msg);
        }
    );
});

router.route("/update/reminders/:username").post((request, response)=>{ //sending the username to retrieve data
    console.log("inside **reminders");
    const reminder = new Reminder({
        username:request.params.username,
        reminders:request.body.reminders,
    });
    reminder
        .save()
        .then(() =>{
            console.log("reminder inserted");
            response.status(200).json("ok");
        })
        .catch((err) => {
            response.status(403).json({msg:err});
        });
    //response.json("registered");
});

router.route("/view/reminders/:username").get((request, response) => { //getting userdata through get request from the username
    Reminder.find({username: request.params.username}, (err, result)=>{
        if(err) response.status(500).json({msg:err});
        response.json({
            data: result,
            username: request.params.username,
        });
    });
});

router.route("/delete/:username").patch(middleware.checkToken,(request,response)=>{ 
    User.findOneAndDelete(
        {username: request.params.username}, //as a parameter
        (err, result) => {
            if(err) return response.status(500).json({msg: err});
            const msg = {
                msg: "username deleted",
                username:request.params.username,
            };
            return response.json(msg);
        }
    );
});

module.exports = router;