import 'dart:async';

import 'package:flutter/material.dart';
import 'package:my_app_01/navigation.dart';

class Preview extends StatefulWidget {
  const Preview({super.key});
  @override
  State<Preview> createState() => _PreviewState();
}

class _PreviewState extends State<Preview> {

  late Timer timer;

  int heartRate = 0;
  int oxygenLevel = 0;
  int bodyTemperature = 0;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(
        const Duration(seconds: 2), (Timer t) => changeContent());
  }

  void changeContent() {
    setState(() {
      oxygenLevel++;
      bodyTemperature++;
      heartRate++;
    });
  }

  @override
  Widget build(BuildContext context) {
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
                      Navigator.push(
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
