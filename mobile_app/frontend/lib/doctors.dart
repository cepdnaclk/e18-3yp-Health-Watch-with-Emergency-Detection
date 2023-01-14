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
  @override
  _Doctors createState() => _Doctors();
}

class _Doctors extends State<Doctors> {
  NetworkHandler networkHandler = NetworkHandler();
  List<contactItem> contactList = [];

  // @override
  // Future<void> initState() async {
  //   super.initState();
  //   var response =
  //       await networkHandler.getContacts("user/view/contacts/jaya123");
  //   print(response);
  //   var r = json.decode(response);
  //   final length = r["data"].length;
  //   for (int i = 0; i < length; i++) {
  //     // ignore: unnecessary_new
  //     contactList.add(new contactItem(
  //         r["data"][i]["contacts"]["contact_name"],
  //         r["data"][i]["contacts"]["email"],
  //         r["data"][i]["contacts"]["phone_number"]));
  //   }
  // }

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
              content: addDoctors(addContactData),
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
                MaterialPageRoute(builder: (context) => CircularMenu()));
          },
        ),
      ),
      body: Container(),
    );
  }
}
