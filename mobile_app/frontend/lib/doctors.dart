import 'dart:convert';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:medicare1/NetworkHandler.dart';
// import 'package:settings/login.dart';
// import 'package:settings/models/contactitem.dart';
// import 'package:settings/splash.dart';

import 'Profile.dart';
import 'addDoctors.dart';
import 'main.dart';
import 'models/contactitem.dart';
import 'navigation.dart';

class Doctors extends StatefulWidget {
  String username;
  Doctors(this.username, {super.key});
  @override
  _Doctors createState() => _Doctors(username);
}

class _Doctors extends State<Doctors> {
  String username;
    _Doctors(this.username);

  NetworkHandler networkHandler = NetworkHandler();
  List<contactItem> contactList = [];


  String txt1 = "";
  String txt2 = "";
  String txt3 = "";

  final namecontroller = TextEditingController();
  final mailcontroller = TextEditingController();
  final phonecontroller = TextEditingController();
  
 
  // ignore: unused_element
  void _setText() {
    setState(() {
      txt1 = namecontroller.text;
      txt2 = mailcontroller.text;
      txt3 = phonecontroller.text;
    });
  }

  // ignore: unnecessary_new
  final contactItem c = new contactItem('contactName', 'email', 'phoneNo');

  @override
  Widget build(BuildContext context) {
    void addContactData(contactItem contactitem) {
      setState(() {
        contactList.add(contactitem);
      });
    }

    // void editContactData(contactItem contactitem) {
    //   setState(() {
    //     contactList[0].contactName = "Sam";
    //   });
    // }

    void showContactDialog() {
      showDialog(
          context: context,
          builder: (_) {
            return AlertDialog(
              content: addDoctors(username,addContactData),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            );
          });
    }

    // Widget cancelButton = ElevatedButton(
    //   child: Text("Cancel"),
    //   onPressed: () {
    //     Navigator.pop(context);
    //   },
    // );
    // Widget okButton = ElevatedButton(
    //   child: Text("Delete"),
    //   onPressed: () {
    //     setState(() {
    //       contactList.removeAt(index);
    //     });
    //   },
    // );

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: showContactDialog,
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text("Medical Contacts"),
        leading: IconButton(
          icon: const Icon(Icons.health_and_safety_rounded),
          onPressed: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => CircularMenu(username)));
          },
        ),
      ),
      body: Container(),
    );
  }
}
