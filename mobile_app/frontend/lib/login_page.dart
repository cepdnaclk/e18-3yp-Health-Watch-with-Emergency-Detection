import 'package:flutter/material.dart';
import 'package:my_app_01/forgot_password.dart';
import 'package:my_app_01/navigation.dart';
import 'package:my_app_01/sign_up.dart';
import 'package:my_app_01/sign_up.dart';
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
  NetworkHandler networkHandler = NetworkHandler();
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

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
                  image: AssetImage("images/login.png"), fit: BoxFit.cover)),
          child: Center(
            child: ListView(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.only(top: 20, left: 23, right: 20),
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
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
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
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
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
                  padding: const EdgeInsets.symmetric(horizontal: 40),
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
                                builder: (context) => const CircularMenu()),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                      ),
                      child: const Text('Sign In')),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
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
}
