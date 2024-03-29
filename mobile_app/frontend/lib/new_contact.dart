import 'dart:convert';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:medicare1/NetworkHandler.dart';
// import 'package:settings/login.dart';
// import 'package:settings/models/contactitem.dart';
// import 'package:settings/splash.dart';

import 'Profile.dart';
import 'addContacts.dart';
import 'main.dart';
import 'models/contactitem.dart';
import 'navigation.dart';

class newcontacts extends StatefulWidget {

  String username;
  newcontacts(this.username, {super.key});

  @override
  _newcontacts createState() => _newcontacts(username);
}

class _newcontacts extends State<newcontacts> {
  String username;
    _newcontacts(this.username);

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
              content: addContacts(username,addContactData),
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
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text("Your Contacts"),
        leading: IconButton(
          icon: Icon(Icons.home),
          onPressed: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => CircularMenu(username)));
          },
        ),
      ),
      body: Container(
        child: ListView.builder(
          itemBuilder: (context, index) {
            return Card(
              margin: EdgeInsets.all(4),
              elevation: 8,
              child: ListTile(
                title: Text(
                  contactList[index].contactName,
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      contactList[index].email,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black38,
                      ),
                    ),
                    Text(
                      contactList[index].phoneNo,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black45,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                trailing: Container(
                  width: 75,
                  child: Row(
                    children: [
                      Expanded(
                          child: IconButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (context) => SimpleDialog(
                                          title: Text("Update Contact"),
                                          children: [
                                            TextField(
                                              decoration: InputDecoration(
                                                hintText: contactList[index]
                                                    .contactName,
                                              ),
                                              onChanged: (value) {
                                                setState(() {
                                                  txt1 = value;
                                                });
                                              },
                                              controller: namecontroller,
                                            ),
                                            TextField(
                                              decoration: InputDecoration(
                                                hintText:
                                                    contactList[index].email,
                                              ),
                                              onChanged: (value) {
                                                setState(() {
                                                  txt2 = value;
                                                });
                                              },
                                              controller: mailcontroller,
                                            ),
                                            TextField(
                                              decoration: InputDecoration(
                                                hintText:
                                                    contactList[index].phoneNo,
                                              ),
                                              onChanged: (value) {
                                                setState(() {
                                                  txt3 = value;
                                                });
                                              },
                                              controller: phonecontroller,
                                            ),
                                            ElevatedButton(
                                                onPressed: () {
                                                  // Navigator.push(
                                                  //   context,
                                                  //   MaterialPageRoute(
                                                  //     builder: (context) =>
                                                  //         addContacts(
                                                  //                 c: contactList[index]
                                                  //         ),
                                                  //   ),
                                                  // );

                                                  setState(() {
                                                    contactList[index].set(
                                                        namecontroller.text,
                                                        mailcontroller.text,
                                                        phonecontroller.text);
                                                  });
                                                  Navigator.pop(context);
                                                },
                                                child: Text("Update"))
                                          ],
                                        ));
                              },
                              // onPressed: () {
                              //   showDialog(
                              //       context: context,
                              //       builder: (BuildContext context) {
                              //         return AlertDialog(
                              //           content: addContacts(
                              //           contactList[index].contactName, ;

                              //           ),
                              //           shape: RoundedRectangleBorder(
                              //               borderRadius:
                              //                   BorderRadius.circular(10)),
                              //         );
                              //       });
                              // },
                              icon: Icon(Icons.edit))),
                      Expanded(
                          child: IconButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text("Alert"),
                                        content: Text(
                                            "Are you sure you want to delete this item?"),
                                        actions: <Widget>[
                                          ElevatedButton(
                                            child: Text("Cancel"),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                          ),
                                          ElevatedButton(
                                            child: Text("Delete"),
                                            onPressed: () {
                                              setState(() {
                                                contactList.removeAt(index);
                                              });
                                              Navigator.pop(context);
                                            },
                                          ),
                                        ],
                                      );
                                    });
                              },

                              // onPressed: () {
                              //   setState(() {
                              //     contactList.removeAt(index);
                              //   });
                              // },
                              icon: Icon(Icons.delete)))
                    ],
                  ),
                ),
              ),
            );
          },
          itemCount: contactList.length,
        ),
      ),
    );
  }
}
