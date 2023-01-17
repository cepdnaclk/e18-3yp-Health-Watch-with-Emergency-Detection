// ignore_for_file: no_logic_in_create_state, avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:medicare1/NetworkHandler.dart';
import 'package:medicare1/doctors.dart';

// ignore: must_be_immutable
class ViewAllDoctors1 extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  var response;
  String username;
  ViewAllDoctors1(this.username,this.response, {super.key});

  @override
  State<ViewAllDoctors1> createState() => _ViewAllDoctorsState(username,response);
}

class _ViewAllDoctorsState extends State<ViewAllDoctors1> {
  NetworkHandler networkHandler = NetworkHandler();
  List<List<String>> doctors= new List.generate(3, (i) => []);
  late List<String> doctordata = [];
  // ignore: prefer_typing_uninitialized_variables
  var response;
  String username;
  _ViewAllDoctorsState(this.username,this.response);

  @override
  void initState() {
    super.initState();
    var r = json.decode(response);
    final length = r["data"].length;
    for (int i = 0; i < length; i++) {
      for(int j = 0; i < 3; j++){
        doctordata.add(r["data"][i]["doctors"]["doctor_name"]);
        doctordata.add(r["data"][i]["doctors"]["email"]);
        doctordata.add(r["data"][i]["doctors"]["phone_number"]);
      }
      doctors.add(doctordata);
    }
  }

  Widget showList() {
    return ListView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: doctors.length,
      itemBuilder: (context, index) {
        return rowItem(context, index);
      },
    );
  }

  Widget rowItem(context, index) {
    return Dismissible(
      key: Key(doctors[index][0]),
      direction: DismissDirection.endToStart,
      onDismissed: ((direction) {
        // ignore: unused_local_variable
        var item = response[index];
        var r = json.decode(response);
        String userName = r["username"];
        print("username: $userName");
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) => AlertDialog(
                  title: const Text("confirmation"),
                  content: const Text("Are you sure?"),
                  actions: [
                    TextButton(
                      // ignore: duplicate_ignore
                      onPressed: () async {
                        showDialog(
                            context: context,
                            builder: (builder) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            });
                        Map<String, String> data = {"title": item};
                        
                        String response = await networkHandler
                            .getContacts("user/view/doctors/$username");
                        // ignore: use_build_context_synchronously
                        Navigator.of(context).pop();
                        // ignore: avoid_print
                        print("confirmation yes");
                        // ignore: use_build_context_synchronously
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ViewAllDoctors1(username,response)));
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),

                        child: const Text("yes"),
                        // code to change content in the server side
                      ),
                    ),
                    TextButton(
                      onPressed: () async {
                        showDialog(
                            context: context,
                            builder: (builder) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            });
                        // code to delete item
                        String response = await networkHandler
                            .getContacts("user/view/doctors/$username");
                        // ignore: use_build_context_synchronously
                        Navigator.of(context).pop();
                        print("confirmation no");
                        // ignore: use_build_context_synchronously
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ViewAllDoctors1(username,response)));
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: const Text("no"),
                      ),
                    ),
                  ],
                ));
        var reminder = doctors[index];
        // ignore: avoid_print
        print("$reminder deleted\n");
      }),
      background: deleteBgItem(),
      child: Card(
        child: ListTile(
          trailing:
              const Icon(Icons.delete, color: Color.fromARGB(255, 255, 77, 77)),
          leading: const Icon(Icons.verified,
              color: Color.fromARGB(255, 0, 216, 22)),
          title: Text(doctors[index][0]),
        ),
      ),
    );
  }

  Widget deleteBgItem() {
    return Container(
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.only(right: 20),
      color: Colors.red,
      child: const Icon(
        Icons.delete,
        color: Colors.white,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("doctors"),
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(Icons.message),
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Doctors('')));
                },
              );
            },
          )),
      body: Container(
        color: const Color.fromARGB(255, 167, 204, 255),
        child: showList(),
      ),
    );
  }
}
