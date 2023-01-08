const {EMAIL_CONFIG} = require("../config/email.config");
var nodemailer = require('nodemailer');

async function SendNotification(emails, full_name, age, url) {
  console.log(`in email: ${emails}`);
  for(i = 0; i < emails.length; i++){
    console.log(`emails getting or not: ${emails[i]}`);
    writeEmails(emails[i], full_name, age, url);
  }
    
      
}

function writeEmails(email, full_name, age, url){
    var transporter = nodemailer.createTransport({
      service: 'gmail',
      auth: {
        user: EMAIL_CONFIG.USERNAME,
        pass: EMAIL_CONFIG.PASSWORD
      }
    });
    console.log(`in email: ${full_name}`);
    var mailOptions = {
      from: EMAIL_CONFIG.USERNAME,
      to: email,
      subject: 'Sending Email using Node.js',
      html: '<h3>Patient: Mr/Mrs.'+ full_name +' is detected with abnormal heart rate </h3><p>Patient detail:<br>Name: '+ full_name +'<br>Age: '+ age +'<br>Auto generated report can be downloaded<a href="'+ url +'"> here</a>.</p>'
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