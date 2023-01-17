import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:medicare1/dashboard_screen.dart';
import 'package:medicare1/forgot_password.dart';
import 'package:medicare1/location_page.dart';
import 'package:medicare1/navigation.dart';
import 'package:medicare1/sign_up.dart';
import 'package:medicare1/sign_up.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'NetworkHandler.dart';

// ignore: must_be_immutable
class LoginPage extends StatefulWidget {
  String s;
  
  

  LoginPage(this.s, {super.key});
  @override
  // ignore: no_logic_in_create_state
  State<LoginPage> createState() => _LoginPageState(s);
}

class _LoginPageState extends State<LoginPage> {

  String heartRateCheck="In the range";
  String oxyRangeCheck ="In the range";
  
  NetworkHandler networkHandler = NetworkHandler();
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  

  @override
  void initState(){
    super.initState();
    initPlatform();
    getReadings();
  }
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
      oxyRangeCheck = "out of range";
    }
    
}
  String message;
  _LoginPageState(this.message);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: null,
        body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("images/title4.png"), fit: BoxFit.cover)),
          child: Center(
            child: ListView(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.only(top: 200, left: 23, right: 20),
                  child: Text(
                    "sign in to continue...",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                  child: TextField(
                    controller: username,
                    decoration:InputDecoration(
                      
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7.0)
                      ),
                      labelText: 'Username',
            
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: TextField(
                    obscureText: true,
                    controller: password,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7.0)
                      ),
                      labelText: 'Password',
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Text(
                    message,
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 100, right: 100),
                  child: ElevatedButton(
                      onPressed: () async {
                        showDialog(
                            context: context,
                            builder: (builder) {
                              return const Center(child: CircularProgressIndicator());
                        });
                        
                        Map<String, String> data = {
                          "username": username.text,
                          "password": password.text
                        };
                        // ignore: unused_local_variable
                        var tokenKeeper =
                            await networkHandler.post("/user/login", data);

                        // ignore: use_build_context_synchronously
                        Navigator.of(context).pop();
                        // ignore: avoid_print
                        print("tokenKeeper: $tokenKeeper");
                        // ignore: avoid_print
                        print(username.text);
                        // ignore: avoid_print
                        print(password.text);
                        // ignore: unrelated_type_equality_checks
                        if (tokenKeeper == "") {
                          // ignore: use_build_context_synchronously
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage(
                                    "Invalid credentials, please try again...")),
                          );
                        } else {
                          
                          // ignore: use_build_context_synchronously
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MainScreen(username.text)),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        shape:const StadiumBorder(),
                      ),
                      child: const Text('Sign In')),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 100, right: 100),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      shape:const StadiumBorder(),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignUpPage("")),
                      );
                    },
                    child: const Text('Sign Up'),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ForgotPassword()),
                    );
                  },
                  child: const Text('Forgot Password'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }



  Future<void> initPlatform() async{
    await OneSignal.shared.setAppId("7602ad5b-32b0-4b91-9ea1-aee39e7a6775");
    await OneSignal.shared.getDeviceState().then(
      (value) => {
        print(value!.userId),
      },
    );
  }
}
