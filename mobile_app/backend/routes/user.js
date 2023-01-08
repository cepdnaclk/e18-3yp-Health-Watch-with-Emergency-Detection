const { request, response } = require("express");
const express = require("express");
const User = require("../models/user_model");
const Reminder = require("../models/reminders_model.js");
const Contact = require("../models/emergency_contact_model.js");
const Doctor = require("../models/doctor_model.js");
const config = require("../config");
const jwt = require("jsonwebtoken");
const middleware = require("../middleware");

const router = express.Router();


//user login here the response is containing JWT token for authentication purposes
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
//user registeration only requirments here are: username, email and a password which are going to be required for the next log in

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
    
});

//entering the data to the userprofile after the registering

router.route("/enter/:username").patch((request,response) => {

    User.findOneAndUpdate({username: request.params.username},
        {$set:{
            fullname:request.body.fullname,
            age:request.body.age,
            phonenumber:request.body.phonenumber,
            area:request.body.area,
            medical:request.body.medical,
        }}, //as a parameter
         //once the username is found password is sending in the body
        (err, result) => {
            if(err) return response.status(500).json({msg: err});
            const msg = {
                msg: "new data entered successfully!",
                username:request.params.username,
            };
            return response.json(msg);
        }
    );

});

//in the deleting and updating middleware token checking is used since it is better to authenticate the user before doing any operations


//**************************************************Reminder handelling part**************************************************** */

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

router.route("/delete/reminders/:objectID").post((request,response)=>{ 
   
    // Reminder.findByIdAndRemove( request.params.objectID, (err, result) => {
    //         if(err) return response.status(500).json({msg: err});
    //         const msg = {
    //             msg: "reminder deleted successfully",
    //             username:request.params.username,
    //         };
    //         return response.json(msg);
    //     });

        Reminder.findByIdAndRemove(request.params.objectID, function (err, docs) {
            if (err){
                response.json({
                    error: err,
                });
            }
            else{
                //print("Removed User : ", docs);
                response.json({
                    "Removed User : ": docs
                });
            }
        });
});

//adding contacts under a particular username

router.route("/add/contacts/:username").post((request, response)=>{
    console.log("inside **contacts");
    const contact = new Contact({

        username: request.params.username,
        contacts: request.body.contacts,
    });
    contact
        .save()
        .then(() =>{
            console.log("contact inserted");
            response.status(200).json("ok");
        })
        .catch((err) => {
            response.status(403).json({msg:err});
        });
});

router.route("/view/contacts/:username").get((request, response) => { //getting userdata through get request from the username
    Contact.find({username: request.params.username}, (err, result)=>{
        if(err) response.status(500).json({msg:err});
        response.json({
            data: result,
            username: request.params.username,
        });
    });
});

router.route("/delete/contacts/:objectID").post((request,response)=>{ 
   
    Contact.findByIdAndRemove(request.params.objectID, function (err, docs) {
        if (err){
            response.json({
                error: err,
            });
        }
        else{
            //print("Removed User : ", docs);
            response.json({
                "Removed User : ": docs
            });
        }
    });
});

//adding doctors and viewing doctors
router.route("/add/doctors/:username").post((request, response)=>{
    console.log("inside **doctors");
    const doctor = new Doctor({

        username: request.params.username,
        doctors: request.body.doctors,
    });
    doctor
        .save()
        .then(() =>{
            console.log("reminder inserted");
            response.status(200).json("ok");
        })
        .catch((err) => {
            response.status(403).json({msg:err});
        });
});

router.route("/view/doctors/:username").get((request, response) => { //getting userdata through get request from the username
    Doctor.find({username: request.params.username}, (err, result)=>{
        if(err) response.status(500).json({msg:err});
        response.json({
            data: result,
            username: request.params.username,
        });
    });
});

router.route("/delete/doctors/:objectID").post((request,response)=>{ 
   
    Doctor.findByIdAndRemove(request.params.objectID, function (err, docs) {
        if (err){
            response.json({
                error: err,
            });
        }
        else{
            //print("Removed User : ", docs);
            response.json({
                "Removed User : ": docs
            });
        }
    });
});
//get contacts and delete contacts and edit contacts


// router.route("/delete/:username").patch(middleware.checkToken,(request,response)=>{ 
//     User.findOneAndDelete(
//         {username: request.params.username, }, //as a parameter
//         (err, result) => {
//             if(err) return response.status(500).json({msg: err});
//             const msg = {
//                 msg: "username deleted",
//                 username:request.params.username,
//             };
//             return response.json(msg);
//         }
//     );
// });

//for now
router.route("/resetcheck/password/:username").patch((request,response)=>{ 
   
    Reminder.findOneAndUpdate( {username:request.params.username, email:request.body.emain},
        {$set:{password:request.body.password}},
        (err, result) => {
            if(err) return response.status(500).json({msg: err});
            const msg = {
                code: "123456",
                username:request.params.username,
            };
            return response.json(msg);
        }
    );
});

router.route("/reset/password/:username").patch((request,response)=>{ 
   
    Reminder.findOneAndUpdate( {code:request.body.code},
        {$set:{password:request.body.password}},
        (err, result) => {
            if(err) return response.status(500).json({msg: err});
            const msg = {
                msg: "password updated successfully",
                username:request.params.username,
            };
            return response.json(msg);
        }
    );
});

//*************************************************For testing purposes******************************************** */
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

router.route("/:username").get((request, response) => { //getting userdata through get request from the username
    User.findOne({username: request.params.username}, (err, result)=>{
        if(err) response.status(500).json({msg:err});
        response.json({
            data: result,
            username: request.params.username,
        });
    });
});

module.exports = router;
