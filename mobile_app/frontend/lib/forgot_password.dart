import 'package:flutter/material.dart';

import 'login_page.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  @override
  Widget build(BuildContext context) {
    TextEditingController username = TextEditingController();
    TextEditingController email = TextEditingController();
    return SafeArea(
      child: Scaffold(
        appBar: null,
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(image: AssetImage("images/password.png"),
            fit: BoxFit.cover
            )
          ),
          child: Center(
            child: ListView(
              shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  children: <Widget>[
                      const SizedBox(height: 100,),
                      const Padding(
                        padding: EdgeInsets.only(top: 20, left: 23, right: 20),
                        child: Text("please enter username and email to continue...", style: TextStyle(fontSize: 16, ),),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                        child: TextField(
                          controller: username,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Username',
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                        child: TextField(
                          controller: email,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'email',
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 70),
                      child: ElevatedButton(
                        onPressed: () {
                          // ignore: avoid_print
                          print(username.text);
                          // ignore: avoid_print
                          print(email.text);
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => LoginPage("")),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                        ),
                        child: const Text('send email')
                      ),
                    ),
                  ]
            ),
          ),
        )
      ),
    );
  }
}