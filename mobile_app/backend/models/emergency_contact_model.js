const mongoose = require("mongoose");

const Schema = mongoose.Schema;



const Contact = Schema({
    username: {
        type: String,
        required: true,
    },
    contacts:{
        contact_name: String,
        email: String,
        phone_number: String,
    }
});

//the first argument should be in the singular form--> collection name: users in this case
module.exports = mongoose.model("Contact", Contact); //this is converted into plural and take as the collection name