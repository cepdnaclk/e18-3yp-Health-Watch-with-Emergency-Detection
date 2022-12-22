// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_app_01/navigation.dart';

import 'NetworkHandler.dart';

class Preview extends StatefulWidget {
  const Preview({super.key});
  @override
  State<Preview> createState() => _PreviewState();
}

class _PreviewState extends State<Preview> {
  late Timer timer;
  NetworkHandler networkHandler = NetworkHandler();

  String heartRate = "";
  String oxygenLevel = "";
  String bodyTemperature = "";

  void refreshData() async {
    String response =
        await networkHandler.getReminders("user/userTemp/jaya123");
    var r = json.decode(response);
    r = r["temp"];
    r = r.toString();
    r = r[0] + r[1] + r[2] + r[3] + r[4];
    print("response: $r");
    setState(() {
      oxygenLevel = r;
      bodyTemperature = r;
      heartRate = r;
    });
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 1), () {
      refreshData();
    });
    return SafeArea(
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
              title: const Text('Preview'),
              leading: Builder(
                builder: (BuildContext context) {
                  return IconButton(
                    icon: const Icon(Icons.preview),
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const CircularMenu()));
                    },
                  );
                },
              )),
          body: Center(
              child: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("images/preview.png"),
                    fit: BoxFit.cover)),
            child: ListView(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Padding(),
                    Container(
                      padding: const EdgeInsets.only(left: 150, top: 350),
                      child: Text('$heartRate BPM',
                          style: const TextStyle(
                              fontSize: 30.0,
                              color: Color.fromARGB(255, 0, 0, 0))),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 150, top: 120),
                      child: Text('$bodyTemperature C',
                          style: const TextStyle(
                              fontSize: 30.0,
                              color: Color.fromARGB(255, 0, 0, 0))),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 150, top: 100),
                      child: Text('$oxygenLevel HbO\u2082',
                          style: const TextStyle(
                              fontSize: 30.0,
                              color: Color.fromARGB(255, 0, 0, 0))),
                    ),
                  ],
                ),
              ],
            ),
          )),
        ),
      ),
    );
  }
}
