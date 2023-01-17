// ignore_for_file: no_logic_in_create_state, avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:medicare1/NetworkHandler.dart';
import 'package:medicare1/reminders.dart';

// ignore: must_be_immutable
class ViewAllReminders extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  var response;
  String username;
  ViewAllReminders(this.username,this.response, {super.key});

  @override
  State<ViewAllReminders> createState() => _ViewAllRemindersState(username, response);
}

class _ViewAllRemindersState extends State<ViewAllReminders> {
  NetworkHandler networkHandler = NetworkHandler();
  late List<String> reminders = [];
  String username;
  // ignore: prefer_typing_uninitialized_variables
  var response;
  _ViewAllRemindersState(this.username,this.response);

  @override
  void initState() {
    super.initState();
    var r = json.decode(response);
    final length = r["data"].length;
    for (int i = 0; i < length; i++) {
      reminders.add(r["data"][i]["reminders"]["title"]);
    }
  }

  Widget showList() {
    return ListView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: reminders.length,
      itemBuilder: (context, index) {
        return rowItem(context, index);
      },
    );
  }

  Widget rowItem(context, index) {
    return Dismissible(
      key: Key(reminders[index]),
      direction: DismissDirection.endToStart,
      onDismissed: ((direction) {
        // ignore: unused_local_variable
        var item = response[index];
        var r = json.decode(response);
        print("test : $r");
        String objectId= r["data"][index]["_id"];
        print("objectId: $objectId");
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
                        int deleteResponse = await networkHandler
                            .deleteWithID("user/delete/reminders/$objectId");
                        String response = await networkHandler
                            .getReminders("user/view/reminders/$username");
                        // ignore: use_build_context_synchronously
                        Navigator.of(context).pop();
                        // ignore: avoid_print
                        print("confirmation yes");
                        // ignore: use_build_context_synchronously
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ViewAllReminders(username,response)));
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
                            .getReminders("user/view/reminders/$username");
                        // ignore: use_build_context_synchronously
                        Navigator.of(context).pop();
                        print("confirmation no");
                        // ignore: use_build_context_synchronously
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ViewAllReminders(username,response)));
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: const Text("no"),
                      ),
                    ),
                  ],
                ));
        var reminder = reminders[index];
        // ignore: avoid_print
        print("$reminder deleted\n");
      }),
      background: deleteBgItem(),
      child: Card(
        child: ListTile(
          shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10))),
          tileColor: Color.fromARGB(98, 50, 150, 133),
          trailing:
              const Icon(Icons.delete, color: Color.fromARGB(255, 116, 5, 5)),
          leading: const Icon(Icons.verified,
              color: Color.fromARGB(255, 17, 77, 71)),
          title: Text(reminders[index]),
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
          title: const Text(''),
          backgroundColor: Color.fromARGB(255, 255, 255, 255), //You can make this transparent
                    elevation: 0.0, //No shadow
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(Icons.navigate_before,color: Color.fromARGB(255, 17, 77, 71)),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Reminders(username)));
                },
              );
            },
          )),
      body: Container(padding: const EdgeInsets.only(left: 10, top: 120, right: 10),
        decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("images/reminders2.png"),
                    fit: BoxFit.cover)),
        child: showList(),
      ),
    );
  }
}