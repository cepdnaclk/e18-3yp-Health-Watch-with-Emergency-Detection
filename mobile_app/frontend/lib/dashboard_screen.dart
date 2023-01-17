// import 'package:dashboard/screens/components/chart_container.dart';
// import 'package:dashboard/widgets/activity_header.dart';
// import 'package:dashboard/widgets/bar_chart.dart';
import 'dart:convert';

import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:medicare1/NetworkHandler.dart';
import 'package:medicare1/location_page.dart';
import 'package:medicare1/overview_grid.dart';
// import 'package:dashboard/widgets/planing_grid.dart';
// import 'package:dashboard/widgets/statistics_grid.dart';
import 'package:flutter/material.dart';
import 'package:medicare1/preview.dart';
import 'package:medicare1/reminders.dart';
import 'package:medicare1/viewAllContacts.dart';
import 'package:medicare1/viewAllDoctors.dart';

// import '../constant.dart';
// import '../widgets/planing_header.dart';
//import 'components/side_menu.dart';


// class MainScreen extends StatelessWidget {
//   MainScreen(this.username,{Key? key}) : super(key: key);
//   String username;
//   String heartRateCheck = "In range";
  
//   String oxygenLevelCheck = "In range";
//   //getReadings();
//   NetworkHandler networkHandler = NetworkHandler();
//   LocationPage locationPage = new LocationPage();
//   var userLocation;

class MainScreen extends StatefulWidget {
  //MainScreen({Key? key}) : super(key: key);
  MainScreen(this.username,{Key? key}) : super(key: key);
  String username;
  
  //getReadings();
  
  LocationPage locationPage = new LocationPage();
  
  @override
  State<MainScreen> createState() => _MainScreenState(username);
}

class _MainScreenState extends State<MainScreen> {

NetworkHandler networkHandler = NetworkHandler();
String heartRateCheck = "In range";
  
  String oxygenLevelCheck = "In range";
  var userLocation;
String username;

  _MainScreenState( this.username);

Future<void> getReadings() async {
  String response1Temp =
        await networkHandler.getPreview("https://api.thingspeak.com/channels/2005890/feeds.json?api_key=HBYZ9SP8D7EB5QSI&results=1");
    
    var r = json.decode(response1Temp);
    var r1 = r["feeds"][0]["field1"];
    var r2 = r["feeds"][0]["field5"]; //heart rate
    var r3 = r["feeds"][0]["field6"]; //oxygen level

    r1 = double.parse(r1);
    r2 = double.parse(r2);
    r3 = double.parse(r3);
    print(r2);
    if(r2 > 100 && r2 < 60){
      heartRateCheck = "out of range";
    }
    if(r3 > 100 && r3 < 95){
      oxygenLevelCheck = "out of range";
    }
    
}
    showAlertDialog(BuildContext context) {

  // set up the button
  Widget okButton = TextButton(
    child: Text("OK"),
    onPressed: () { 
      Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>  MainScreen(username)),
                    );
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Location Permission!"),
    content: Text("Please turn on your mobile location service."),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
String? _currentAddress;
  Position? _currentPosition;

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      //     content: Text(
      //         'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // ScaffoldMessenger.of(context).showSnackBar(
        //     const SnackBar(content: Text('Location permissions are denied')));
        // return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      //     content: Text(
      //         'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() => _currentPosition = position);
      _getAddressFromLatLng(_currentPosition!);
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
            _currentPosition!.latitude, _currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        _currentAddress =
            '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }

  @override
  Widget build(BuildContext context) {
     getReadings();
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.grey, size: 30),
        actions: [
          
          
          Container(
            margin: const EdgeInsets.only(top: 5, right: 16, bottom: 5),
            child: const CircleAvatar(
              backgroundImage: AssetImage("images/title.png"),
            ),
          )
        ],
      ),
      //drawer: const SideMenu(),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              
          
          // Text('LAT: ${_currentPosition?.latitude ?? ""}'),
          //     Text('LNG: ${_currentPosition?.longitude ?? ""}'),
          //     Text('ADDRESS: ${_currentAddress ?? ""}'),
          //     const SizedBox(height: 32),
          //     ElevatedButton(
          //       onPressed: _getCurrentPosition,
          //       child: const Text("Get Current Location"),
          //     ),
        
              RichText(
                text: TextSpan(
                  text: "Hi, ",
                  style: TextStyle(color: Color.fromARGB(255, 5, 156, 136), fontSize: 20),
                  children: [
                    TextSpan(
                      text: username,
                      style: TextStyle(
                          color: Color.fromARGB(255, 5, 156, 136), fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: "👋",
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "",
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  ),
                  ElevatedButton.icon(
                    onPressed:  
                        //userLocation = await locationPage.getUserCurrentPosition();
                       _getCurrentPosition
                        ,
                        style: ElevatedButton.styleFrom(
                          primary: Color.fromARGB(255, 8, 88, 112),
                          
                        ),
                    label: Text('Set location'),
                    icon: Icon(Icons.person_pin_circle),
                 
                  ),
              //     ElevatedButton.icon(
              //   onPressed: _getCurrentPosition,
              //   child: const Text("Get Current Location"),
              // ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
               
            decoration: BoxDecoration(
                gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Color.fromARGB(255, 90, 216, 174),
                  Color.fromARGB(255, 255, 255, 255),
                ],
              ),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20)
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 3,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "Quick overview 🩺",
                        style: const TextStyle(color: Color.fromARGB(255, 0, 143, 64), fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      const SizedBox(
                height: 20,
              ),
                      Text(
                        "Abnormal readings",
                        style: const TextStyle(color: Color.fromARGB(255, 7, 4, 2)),
                      ),
                      const SizedBox(
                height: 15,
              ),
                      Text(
                        "Heart rate: $heartRateCheck",
                        style: const TextStyle(color: Color.fromARGB(255, 0, 45, 128), fontWeight: FontWeight.bold,  fontSize: 15),
                      ),
                      Text(
                        "Oxygen level: $oxygenLevelCheck",
                        style: const TextStyle(color: Color.fromARGB(255, 0, 45, 128),fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      
                    ],
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
                height: 20,
              ),
              
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Color.fromARGB(255, 90, 216, 174),
                  Color.fromARGB(255, 255, 255, 255),
                ],
              ),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20)
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 3,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row( 
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    
                    children: <Widget>[
                      Text(
                        "Your current location",
                        style: const TextStyle(color: Color.fromARGB(255, 0, 143, 64), fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Click \"Set location\" if the location is different",
                        style: const TextStyle(color: Color.fromARGB(255, 7, 4, 2)),
                      ),
                      const SizedBox(
                        width: 20,
                        height:20,
                      ),
                      // Text('LAT: ${_currentPosition?.latitude ?? ""}'),
                      //Text('LNG: ${_currentPosition?.longitude ?? ""}'),
                     
                     
                      Text('${_currentAddress ?? ""}',
                              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
                             overflow: TextOverflow.fade,
                                    ),


                      const SizedBox(
                          width: 20,
                      ),
                      
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      
                    ],
                  )
                ],
              ),
            ),
          ),
              const SizedBox(
                height: 20,
              ),
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomLeft,
                colors: [
                  Color.fromARGB(255, 179, 247, 229),
                  Color.fromARGB(255, 255, 255, 255),
                ],
              ),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20)
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 3,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "Click ", style: TextStyle(color: Color.fromARGB(255, 0, 143, 64), fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              WidgetSpan(
                                child: Icon(Icons.menu, size: 14),alignment:PlaceholderAlignment.middle,style: TextStyle(color: Color.fromARGB(255, 0, 143, 64), fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              TextSpan(
                                text: " to menu",style: TextStyle(color: Color.fromARGB(255, 0, 143, 64), fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                      const SizedBox(
                height: 20,
              ),
                      RichText(
                          text: TextSpan(
                            children: [
                              
                              WidgetSpan(
                                child: Icon(Icons.health_and_safety, size: 20),alignment:PlaceholderAlignment.middle,style: TextStyle(color: Color.fromARGB(255, 0, 143, 64), fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              TextSpan(
                                text: "  Add your personal doctors",style: TextStyle(color: Color.fromARGB(255, 42, 70, 54), fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      const SizedBox(
                height: 15,
              ),
               RichText(
                          text: TextSpan(
                            children: [
                              
                              WidgetSpan(
                                child: Icon(Icons.contact_phone, size: 20),alignment:PlaceholderAlignment.middle,style: TextStyle(color: Color.fromARGB(255, 0, 143, 64), fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              TextSpan(
                                text: "  Add your emergency contacts",style: TextStyle(color: Color.fromARGB(255, 42, 70, 54), fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      const SizedBox(
                height: 15,
              ),
              RichText(
                          text: TextSpan(
                            children: [
                              
                              WidgetSpan(
                                child: Icon(Icons.today, size: 20),alignment:PlaceholderAlignment.middle,style: TextStyle(color: Color.fromARGB(255, 0, 143, 64), fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              TextSpan(
                                text: "  Add your reminders",style: TextStyle(color: Color.fromARGB(255, 42, 70, 54), fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      const SizedBox(
                height: 15,
              ),
                      RichText(
                          text: TextSpan(
                            children: [
                              
                              WidgetSpan(
                                child: Icon(Icons.preview, size: 20),alignment:PlaceholderAlignment.middle,style: TextStyle(color: Color.fromARGB(255, 0, 143, 64), fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              TextSpan(
                                text: "  Real-time monitoring",style: TextStyle(color: Color.fromARGB(255, 42, 70, 54), fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      const SizedBox(
                height: 15,
              ),
                      
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      
                    ],
                  )
                ],
              ),
            ),
          ),
              const SizedBox(
                height: 20,
              ),
              //const PlaningHeader(),
              const SizedBox(
                height: 15,
              ),
              //const PlaningGrid(),
              const SizedBox(
                height: 15,
              ),
              
            ],
          ),
        ),
      ),

              floatingActionButton: FabCircularMenu(
          fabOpenColor: Color.fromARGB(255, 1, 92, 69),
          fabCloseColor: Color.fromARGB(255, 45, 218, 160),
          ringColor: Color.fromARGB(255, 57, 231, 179).withOpacity(0.5),
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
                  Icons.today,
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

    );
  }
}