const { request, response } = require("express");
const express = require("express");
const User = require("../models/user_model");
const config = require("../config");
const jwt = require("jsonwebtoken");
const middleware = require("../middleware");

const router = express.Router();

router.route("/:username/").get((request, response) => { //getting userdata through get request from the username
    
    
});


module.exports = router;