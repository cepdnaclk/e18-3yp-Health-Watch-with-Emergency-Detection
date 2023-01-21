const {EMAIL_CONFIG} = require("../config/email.config");
var nodemailer = require('nodemailer');

async function SendNotification(emailsCon,emailsDoc, full_name, age, url, pulse, oxy) {
  var location = "328 Prof. E.O.E. Pereira Mawatha, Udunuwara, Kandy,";
  console.log(`in email: ${emailsCon}`);
  for(i = 0; i < emailsCon.length; i++){
    console.log(`emails getting or not: ${emailsCon[i]}`);
    writeEmails(emailsCon[i], full_name, age, url, pulse, oxy, location);
  }

  for(i = 0; i < emailsDoc.length; i++){
    console.log(`emails getting or not: ${emailsDoc[i]}`);
    writeEmailsDoc(emailsDoc[i], full_name, age, url, pulse, oxy, location);
  }
    
      
}

function writeEmails(email, full_name, age, url, pulse, oxy, location){
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
      subject: 'MediCare Emergency',
      html: '<h3>'+ full_name +' is detected with abnormal situation through medicare watch. Please watch on her.</h3><p>Account details:<br>Name: '+ full_name +'<br>Average heart rate: '+ pulse +'<br>Average blood oxygen level: '+ oxy+'<br>Location: '+ location+'</p>'
    };
    
    transporter.sendMail(mailOptions, function(error, info){
      if (error) {
        console.log(error);
      } else {
        console.log('Email sent: ' + info.response);
      }
    });
}

function writeEmailsDoc(email, full_name, age, url, pulse, oxy, location){
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
    html: '<h3>Your patient: '+ full_name +' is detected with abnormal situation through medicare watch </h3><p>Account details:<br>Name: '+ full_name +'<br>Age: '+ age +'<br>Avarage heart rate: '+ pulse +'<br>Avarage blood oxygen level: '+ oxy +'<br>Location: '+ location+'"></a>.</p>'
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