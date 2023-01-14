// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:medicare1/navigation.dart';

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
  int countRefresh = 0;
  late List<String> heartRates = [];
  
  void refreshData() async {
    if(countRefresh==59){
      //checkAbnormal(); //check for abnomalaties
      countRefresh = 0;
      heartRates.clear();
    }
    String response =
        await networkHandler.getPreview("https://api.thingspeak.com/channels/2005890/fields/1.json?api_key=HBYZ9SP8D7EB5QSI&results=1");
    var r = json.decode(response);
    r = r["feeds"][0]["field1"];
    print("$countRefresh : $r");
    
    heartRates.add(r);
    r = r.toString();
    r = r[0] + r[1] + r[2] + r[3];
    print("response: $r");
    setState(() {
      oxygenLevel = r;
      bodyTemperature = r;
      heartRate = r;
    });
    countRefresh++;
  }
  double average = 0;

  // Future<int> checkAbnormal() async {
  //   for (var i = 0; i < heartRates.length; i++) {
  //     average += heartRates[i];

  //   }

  //   average = average/60;
  //   int finalValue = average.round();
  //   print(finalValue);
  //   if(finalValue > 15){
  //     String response =
  //       await networkHandler.getReminders("notify/SendNotification");
    
  //     return 1; //abnormal behaviour detected
  //   }else{
  //     return 0; // everything is normal
  //   }

  // }

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 1), () {
      refreshData();
    });
    return SafeArea(
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
          title: const Text(''),
          backgroundColor: Colors.white, //You can make this transparent
                    elevation: 0.0, //No shadow
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(Icons.navigate_before,color: Color.fromARGB(255, 17, 77, 71)),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CircularMenu()));
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
                      padding: const EdgeInsets.only(left: 150, top: 250),
                      child: Text('$heartRate BPM',
                          style: const TextStyle(
                              fontSize: 30.0,
                              color: Color.fromARGB(255, 2, 77, 73))),
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
