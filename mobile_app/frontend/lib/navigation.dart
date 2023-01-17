import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:medicare1/NetworkHandler.dart';
//import 'package:medicare1/doctors.dart';
import 'package:medicare1/login_page.dart';
import 'package:medicare1/monitordDashboard.dart';
import 'package:medicare1/preview.dart';
import 'package:medicare1/reminders.dart';
import 'package:medicare1/viewAllContacts.dart';
import 'package:medicare1/viewAllDoctors.dart';
import 'package:medicare1/monitordDashboard.dart';

import 'new_contact.dart';

class CircularMenu extends StatelessWidget {
  String username;
  CircularMenu(this.username,{super.key});
  NetworkHandler networkHandler = NetworkHandler();
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: null,
        body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("images/title2.png"), fit: BoxFit.cover)),
          child: const Center(
            child: Text(""),
          ),
        ),
        floatingActionButton: FabCircularMenu(
          fabOpenColor: Color.fromARGB(255, 7, 204, 211),
          fabCloseColor: Color.fromARGB(255, 2, 224, 224),
          ringColor: Color.fromARGB(255, 28, 204, 189).withOpacity(0.3),
          children: [
            InkWell(
                child: const Icon(
                  Icons.preview,
                  size: 50,
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Preview(username)));
                }),
            InkWell(
                child: const Icon(
                  Icons.message,
                  size: 50,
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Reminders(username)));
                }),
            InkWell(
                child: const Icon(
                  Icons.contact_phone,
                  size: 50,
                ),
                onTap: () async {
                  String response = await networkHandler
                      .getReminders("user/view/contacts/$username");
                    print(response);
                  
                  
                  Navigator.of(context).pop();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ViewAllContacts(username,response)));
                  }),
            InkWell(
                child: const Icon(
                  Icons.health_and_safety,
                  size: 50,
                ),
                onTap: () async {
                  String response = await networkHandler
                      .getReminders("user/view/doctors/$username");
                    print(response);
                  
                  
                  Navigator.of(context).pop();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ViewAllDoctors(username,response)));
                  }),
          ],
        ),
      ),
    );
  }
}
