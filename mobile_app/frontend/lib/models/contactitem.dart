import 'package:flutter/material.dart';

class contactItem {
  String contactName;
  String email;
  String phoneNo;

  contactItem(this.contactName, this.email, this.phoneNo);

  void set(String cName, String cEmail, String cPhoneNo) {
    this.contactName = cName;
    this.email = cEmail;
    this.phoneNo = cPhoneNo;
    
  }
}
