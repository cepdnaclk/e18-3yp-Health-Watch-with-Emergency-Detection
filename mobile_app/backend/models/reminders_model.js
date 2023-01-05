const mongoose = require("mongoose");

const Schema = mongoose.Schema;



const Reminder = Schema({
    username: {
        type: String,
        required: true,
    },
    reminders:{
        title: {type:String, unique:true},
        frequency: String,
        time: String,
    }
,
});

//the first argument should be in the singular form--> collection name: users in this case
module.exports = mongoose.model("Reminder", Reminder); //this is converted into plural and take as the collection name