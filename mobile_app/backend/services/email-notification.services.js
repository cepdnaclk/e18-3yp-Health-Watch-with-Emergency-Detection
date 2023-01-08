const {EMAIL_CONFIG} = require("../config/email.config");
var nodemailer = require('nodemailer');

async function SendNotification() {

    var transporter = nodemailer.createTransport({
        service: 'gmail',
        auth: {
          user: EMAIL_CONFIG.USERNAME,
          pass: EMAIL_CONFIG.PASSWORD
        }
      });
      
      var mailOptions = {
        from: EMAIL_CONFIG.USERNAME,
        to: 'jayathrimr@gmail.com',
        subject: 'Sending Email using Node.js',
        html: '<h3>Patient: Mr/Mrs. XXXXX is detected with abnormal heart rate </h3><p>Patient detail:<br>Name: xxxx<br>Age: xxxx<br>Auto generated report can be downloaded here.</p>'
      };
      
      transporter.sendMail(mailOptions, function(error, info){
        if (error) {
          console.log(error);
        } else {
          console.log('Email sent: ' + info.response);
        }
      });
      
}

module.exports = {
    SendNotification
}