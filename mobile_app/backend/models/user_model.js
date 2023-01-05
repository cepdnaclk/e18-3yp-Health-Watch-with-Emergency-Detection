const mongoose = require("mongoose");

const Schema = mongoose.Schema;



const User = Schema({
    username: {
        type: String,
        required: true,
        unique: true,
    },
    email:{
        type: String,
        required: true,
        unique: true,
    },
    password:{
        type:String,
        required:true
    },
    reminders:{
        title: String,
        frequency: String,
        time: String,
    }
,
});

//the first argument should be in the singular form--> collection name: users in this case
module.exports = mongoose.model("User", User); //this is converted into plural and take as the collection name