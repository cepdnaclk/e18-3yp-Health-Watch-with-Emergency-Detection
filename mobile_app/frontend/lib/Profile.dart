// ignore: file_names
// ignore_for_file: unnecessary_string_interpolations, duplicate_ignore

import 'package:flutter/material.dart';
// import 'package:settings/models/contactitem.dart';

import 'navigation.dart';

// ignore: camel_case_types
class profile extends StatefulWidget {
  const profile({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _profile createState() => _profile();
}

// ignore: camel_case_types
class _profile extends State<profile> {
  //const profile({Key? key}) : super(key: key);
  // final Function(contactItem) addcontact;

  // addContacts(this.addcontact);
  bool isObsPw = true;
  String uName = "HazelGrace";
  String uAge = "16";
  String uEmail = "hazel_gl@gmail.com";
  String uPhoneNo = "215 XXX XXXX";
  String uTown = "24, Main Street, South Bend,";
  String uMed = "Thyroid cancer , Trouble breathing";
  String uWeight = "50";
  String uHeight = "1.5";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   leading: IconButton(onPressed: () {}, icon: const Icon(Icons.home)),
      //   title: const Text("Profile"),
      // ),
      body: Container(
        padding: const EdgeInsets.only(left: 15, top: 50, right: 15),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            // ignore: duplicate_ignore
            children: [
              Center(child: const Icon(
                  Icons.account_circle_outlined,
                  size: 50,
                )),
              // Center(
              //   child: Stack(
              //     children: [
              //       Container(
              //         width: 130,
              //         height: 130,
              //         decoration: BoxDecoration(
              //           border: Border.all(width: 4, color: Colors.white),
              //           boxShadow: [
              //             BoxShadow(
              //                 spreadRadius: 2,
              //                 blurRadius: 10,
              //                 color: Colors.black.withOpacity(0.1))
              //           ],
              //           shape: BoxShape.circle,
              //           image: const DecorationImage(
              //             fit: BoxFit.cover,
              //             image: AssetImage('assets/profile.jpg'),
              //           ),
              //         ),
              //       ),
              //       Positioned(
              //         bottom: 0,
              //         right: 0,
              //         child: Container(
              //           height: 40,
              //           width: 40,
              //           decoration: BoxDecoration(
              //               shape: BoxShape.circle,
              //               border: Border.all(width: 4, color: Colors.white),
              //               color: Colors.green),
              //         ),
              //       )
              //     ],
              //   ),
              // ),
              const SizedBox(
                height: 30,
              ),
              // ignore: unnecessary_string_interpolations
              buildTextField("Full Name:", '$uName', false),
              // ignore: unnecessary_string_interpolations
              buildTextField("Email:", '$uEmail', false),
              // ignore: unnecessary_string_interpolations
              buildTextField("Contact number:", '$uPhoneNo', false),
              // ignore: unnecessary_string_interpolations
              buildTextField("Current town:", '$uTown', false),
              // ignore: unnecessary_string_interpolations
              buildTextField("Age:", '$uAge', false),
              // ignore: unnecessary_string_interpolations
              buildTextField("Weight(kg):", '$uWeight', false),
              // ignore: unnecessary_string_interpolations
              buildTextField("Height(m):", '$uHeight', false),
              
              buildTextField("Medical conditions:", '$uMed', false),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // submit data to the server

                      Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CircularMenu()),
                          );
                    },
                    style: ElevatedButton.styleFrom(
                        // ignore: deprecated_member_use
                        primary: Colors.teal,
                        padding: const EdgeInsets.symmetric(horizontal: 70),
                        shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20))),
                    child: const Text(
                      "Save",
                      style: TextStyle(
                          fontSize: 15, letterSpacing: 2, color: Colors.white),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String labelText, String placeholder, bool ispw) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: TextField(
        obscureText: ispw ? true : false,
        decoration: InputDecoration(
          suffixIcon: ispw
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      isObsPw = !isObsPw;
                    });
                  },
                  icon: const Icon(Icons.remove_red_eye, color: Colors.grey))
              : null,
          contentPadding: const EdgeInsets.only(bottom: 5),
          labelText: labelText,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: placeholder,
          hintStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 201, 201, 201)),
        ),
      ),
    );
  }
}
