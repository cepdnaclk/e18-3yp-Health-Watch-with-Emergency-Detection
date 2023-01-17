// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:medicare1/dashboard_screen.dart';
import 'package:medicare1/navigation.dart';

import 'NetworkHandler.dart';

class Preview extends StatefulWidget { 
  String username;
  Preview(this.username,{super.key});
  @override
  State<Preview> createState() => _PreviewState(username);
}

class _PreviewState extends State<Preview> {
  late Timer timer;
  String username;
  NetworkHandler networkHandler = NetworkHandler();

  String heartRate = "";
  String oxygenLevel = "";
  String bodyTemperature = "";
  int countRefresh = 0;
  late List<String> heartRates = [];
  
  _PreviewState(this.username , );
  
  void refreshData() async {
    if(countRefresh==59){
      //checkAbnormal(); //check for abnomalaties
      countRefresh = 0;
      heartRates.clear();
    }
    String response1_temp =
        await networkHandler.getPreview("https://api.thingspeak.com/channels/2005890/feeds.json?api_key=HBYZ9SP8D7EB5QSI&results=1");
    
    var r = json.decode(response1_temp);
    var r1 = r["feeds"][0]["field1"];
    var r2 = r["feeds"][0]["field5"]; //heart rate
    var r3 = r["feeds"][0]["field6"]; //oxygen level

    print("$countRefresh : $r1");
    print(r1.runtimeType);

    heartRates.add(r1);
    r1 = double.parse(r1);
    r1 = double.parse((r1).toStringAsFixed(1)); //double.parse((r1).toStringAsFixed(1));
    print("response: $r1");


    heartRates.add(r2);
    r2 = double.parse(r2);
    r2 = (r2).round();
    print("response: $r2");

    
    heartRates.add(r3);
    r3 = double.parse(r3);
    r3 = (r3).round();
    print("response: $r3");

    setState(() {
      oxygenLevel = r3.toString();
      bodyTemperature = r1.toString();
      heartRate = r2.toString();
    });
    countRefresh++;
  }
  double average = 0;

    @override
  Widget build(BuildContext context){
    Future.delayed(const Duration(seconds: 1), () {
      refreshData();
    });
    final String message = DateTime.now().hour < 12 ? "Good morning!" : "Good afternoon!"; 
    var size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
          height: size.height,
          width: size.width,
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Scaffold(backgroundColor: Colors.transparent,)
        ),
        Positioned(
        top: -350.0,
        right: -50.0,
        child: Container(
          height: size.height,
          width: size.width+300,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            // borderRadius: BorderRadius.only(
            //   bottomLeft: Radius.circular(100),
            //   bottomRight: Radius.circular(160)),
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
              Color.fromARGB(255, 253, 255, 255),
              Colors.teal,
            ])
          ),
          
        ),
        
    ),
    Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
          title: const Text(''),
          backgroundColor: Colors.transparent, //You can make this transparent
                    elevation: 0.0, //No shadow
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(Icons.navigate_before,color: Colors.white),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MainScreen(username)));
                },
              );
            },
          )),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Hi "+username+" 👋", style: TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.w500),),
                Text(message, style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w500),)
              ],
            ),
          ),
          
          ),
          Container(
            padding: const EdgeInsets.only(top:200),
            child:(
              Column(
                children: [
                  DetailCardLarge(text: 'Heart rate', color: const Color.fromARGB(255, 95, 233, 176).withOpacity(0.8), label: "string", val1: heartRate, val2: "Normal: 60 - 100 BPM", labelColor: const Color.fromARGB(255, 7, 117, 103)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                    DetailCard(text: 'Temperature', color: const Color.fromARGB(255, 43, 214, 109).withOpacity(0.8), label: "string", val1: bodyTemperature, val2: "Normal: 36.1 - 37.2 C", unit: "C" ,labelColor: Color.fromARGB(255, 7, 117, 103)),
                    DetailCard(text: 'Oxygen level', color: Color.fromARGB(255, 36, 187, 142).withOpacity(0.8), label: "string", val1: oxygenLevel, val2: "Normal: 95% - 100%", unit: "%", labelColor: Color.fromARGB(255, 7, 117, 103)),
                  ],)
                ],
              )
              
              
            ),
          )
    ],
    );
  }

}

class DetailCard extends StatelessWidget {
  final Color color;
  final String label;
  final Color labelColor;
  final String val1;
  final String val2;
  final String unit;
  final String text;
  
  const DetailCard({Key? key,required this.text,required this.color,required this.label,required this.val1,required this.val2,required this.unit, required this.labelColor}): super(key: key);


  @override
  Widget build(BuildContext context){
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        height:150,
        width: MediaQuery.of(context).size.width / 2-20,
        decoration: 
          BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            color:color?? Color.fromARGB(255, 46, 37, 11)),
      child: Padding(
        padding: const EdgeInsets.all(8),
      child: Column(
        
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                            Container(
                              alignment: Alignment.center,
                              height: 10.0,
                              width: 10.0,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: labelColor?? Color.fromARGB(255, 7, 126, 106),
                              ),
                            ),

                          const SizedBox(height: 10,),
                          DefaultTextStyle(
                            style: const TextStyle(),
                            child:Text(
                              text,
                              style: const TextStyle(fontSize: 20,
                              fontFamily: "TimesNewRoman",
                              color: Colors.black,
                              fontWeight: FontWeight.w500),
                            )
                          ),
                    ]
                ),
          
          
          SizedBox(height: 10,),
          
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              DefaultTextStyle(
                  style: TextStyle(),
                  child:Text(
                    "                     ",
                    style: TextStyle(fontSize: 10,
                    fontFamily: "TimesNewRoman",
                    color: Colors.transparent,
                    fontWeight: FontWeight.w900),
                  )),
                DefaultTextStyle(
                  style: TextStyle(),
                  child:Text(
                    val1,
                    style: TextStyle(fontSize: 20,
                    fontFamily: "TimesNewRoman",
                    color: Colors.black,
                    fontWeight: FontWeight.w900),
                  )),
                  DefaultTextStyle(
                  style: TextStyle(),
                  child:Text(
                    unit,
                    style: TextStyle(fontSize: 20,
                    fontFamily: "TimesNewRoman",
                    color: Colors.black,
                    fontWeight: FontWeight.w900),
                  )),
              ],),
          
          SizedBox(height: 10,),
          DefaultTextStyle(
          style: TextStyle(),
          child:Text(
            val2,
            style: TextStyle(fontSize: 15,
            fontFamily: "TimesNewRoman",
            color: Colors.black,
            fontWeight: FontWeight.w600),
          )),
        ],
      )
      ),
      
            ),
      
      );
  }
}


  class DetailCardLarge extends StatelessWidget {
   final Color color;
   final String label;
   final Color labelColor;
   final String val1;
   final String val2;
   final String text;

  const DetailCardLarge({super.key, required this.color, required this.label, required this.labelColor, required this.val1, required this.val2, required this.text});
  

    @override
  Widget build(BuildContext context){
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        height:300,
        width: MediaQuery.of(context).size.width - 20,
        decoration: 
          BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            color:color?? Color.fromARGB(255, 46, 37, 11)),
      child: Padding(
        padding: const EdgeInsets.all(8),
      child: Column(
        
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                            Container(
                              alignment: Alignment.center,
                              height: 10.0,
                              width: 10.0,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: labelColor?? Color.fromARGB(255, 7, 126, 106),
                              ),
                            ),

                          const SizedBox(height: 10,),
                          DefaultTextStyle(
                            style: const TextStyle(),
                            child:Text(
                              text,
                              style: const TextStyle(fontSize: 25,
                              fontFamily: "TimesNewRoman",
                              color: Colors.black,
                              fontWeight: FontWeight.w500),
                            )
                          ),
                    ]
                ),
          
          
          SizedBox(height: 10,),
          
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              DefaultTextStyle(
                  style: TextStyle(),
                  child:Text(
                    "         ",
                    style: TextStyle(fontSize: 40,
                    fontFamily: "TimesNewRoman",
                    color: Colors.transparent,
                    fontWeight: FontWeight.w900),
                  )),
                DefaultTextStyle(
                  style: TextStyle(),
                  child:Text(
                    val1,
                    style: TextStyle(fontSize: 40,
                    fontFamily: "TimesNewRoman",
                    color: Colors.black,
                    fontWeight: FontWeight.w900),
                  )),
                  DefaultTextStyle(
                  style: TextStyle(),
                  child:Text(
                    " BPM",
                    style: TextStyle(fontSize: 40,
                    fontFamily: "TimesNewRoman",
                    color: Colors.black,
                    fontWeight: FontWeight.w900),
                  )),
              ],),
          
          SizedBox(height: 10,),
          DefaultTextStyle(
          style: TextStyle(),
          child:Text(
            val2,
            style: TextStyle(fontSize: 25,
            fontFamily: "TimesNewRoman",
            color: Colors.black,
            fontWeight: FontWeight.w500),
          )),
        ],
      )
      ),
      
            ),
      
      );
  }
}
