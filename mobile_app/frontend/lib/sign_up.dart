import 'package:flutter/material.dart';
import 'package:medicare1/Profile.dart';

import 'NetworkHandler.dart';
import 'login_page.dart';

// ignore: must_be_immutable
class SignUpPage extends StatefulWidget {
  String s;
  SignUpPage(this.s, {super.key});

  @override
  // ignore: no_logic_in_create_state
  State<SignUpPage> createState() => _SignUpPageState(s);
}

class _SignUpPageState extends State<SignUpPage> {
  late String checkUser;
  _SignUpPageState(this.checkUser);

  String? validateEmail(String? value) {
    String pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";
    RegExp regex = RegExp(pattern);
    if (value == null || value.isEmpty || !regex.hasMatch(value)) {
      return 'Enter a valid email address';
    } else {
      return null;
    }
  }

  String? validateUserName(String? value) {
    if (value == null || value.contains(" ")) {
      return "you cant use spaces in your username!";
    } else {
      return null;
    }
  }

  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController email = TextEditingController();
  NetworkHandler networkHandler = NetworkHandler();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: null,
        body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("images/title4.png"), fit: BoxFit.cover)),
          child: Form(
            autovalidateMode: AutovalidateMode.always,
            child: Center(
              child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 150, left: 23, right: 20),
                    // child: Text(
                    //   "Welcome !",
                    //   style: TextStyle(fontSize: 25),
                    // ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 20, left: 23, right: 20),
                    child: Text(
                      "sign up to continue...",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 20, left: 23, right: 20),
                    child: TextFormField(
                      validator: (value) => validateUserName(value),
                      decoration: const InputDecoration(hintText: 'username'),
                      controller: username,
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 20, left: 23, right: 20),
                    child: TextFormField(
                      obscureText: true,
                      validator: (value) => validateUserName(value),
                      decoration: const InputDecoration(hintText: 'password'),
                      controller: password,
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 20, left: 23, right: 20),
                    child: TextFormField(
                      validator: (value) => validateEmail(value),
                      decoration: const InputDecoration(hintText: 'email'),
                      controller: email,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Text(
                      checkUser,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 80),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        shape:const StadiumBorder(),
                      ),
                      onPressed: () async {
                        String? checkValidityUserName = validateUserName(username.text);
                        String? checkValidityPassword = validateUserName(password.text);
                        String? checkValidutyEmail = validateEmail(email.text);

                        showDialog(
                            context: context,
                            builder: (builder) {
                              return const Center(child: CircularProgressIndicator());
                        });

                        Map<String, String> data = {
                          "username": username.text,
                          "password": password.text,
                          "email": email.text
                        };
                        var check =
                            await networkHandler.post("/user/register", data);
                        // ignore: use_build_context_synchronously
                        Navigator.of(context).pop();
                        // ignore: avoid_print
                        print("status code: $check");
                        // ignore: unrelated_type_equality_checks
                        if(checkValidutyEmail!=null || checkValidityPassword!=null || checkValidityUserName!=null){
                          // ignore: use_build_context_synchronously
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      SignUpPage("invalid inputs!")));
                        } else if (check == "") {
                          // ignore: use_build_context_synchronously
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      SignUpPage("user name already exist!")));
                        } else {
                          // ignore: use_build_context_synchronously
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => profile()),
                          );
                        }
                      },
                      child: const Text('Sign Up'),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
