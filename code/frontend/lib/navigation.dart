import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:my_app_01/doctors.dart';
import 'package:my_app_01/login_page.dart';
import 'package:my_app_01/preview.dart';
import 'package:my_app_01/reminders.dart';

import 'new_contact.dart';

class CircularMenu extends StatelessWidget {
  const CircularMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: null,
        body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("images/nav2.png"), fit: BoxFit.cover)),
          child: const Center(
            child: Text(""),
          ),
        ),
        floatingActionButton: FabCircularMenu(
          fabOpenColor: const Color.fromARGB(255, 69, 106, 255),
          fabCloseColor: const Color.fromARGB(255, 151, 153, 255),
          ringColor: const Color.fromARGB(255, 116, 197, 255),
          children: [
            InkWell(
                child: const Icon(
                  Icons.preview,
                  size: 50,
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Preview()));
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
                          builder: (context) => const Reminders()));
                }),
            InkWell(
                child: const Icon(
                  Icons.contact_phone,
                  size: 50,
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (contex) => newcontacts()));
                }),
            InkWell(
                child: const Icon(
                  Icons.health_and_safety,
                  size: 50,
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (contex) => Doctors()));
                }),
          ],
        ),
      ),
    );
  }
}
