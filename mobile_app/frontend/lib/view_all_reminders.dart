// ignore_for_file: no_logic_in_create_state, avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_app_01/NetworkHandler.dart';
import 'package:my_app_01/reminders.dart';

// ignore: must_be_immutable
class ViewAllReminders extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  var response;
  ViewAllReminders(this.response, {super.key});

  @override
  State<ViewAllReminders> createState() => _ViewAllRemindersState(response);
}

class _ViewAllRemindersState extends State<ViewAllReminders> {
  NetworkHandler networkHandler = NetworkHandler();
  late List<String> reminders = [];
  // ignore: prefer_typing_uninitialized_variables
  var response;
  _ViewAllRemindersState(this.response);

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
                        int deleteResponse = await networkHandler
                            .deleteReminders("user/delete/reminders/jaya123",data);
                        String response = await networkHandler
                            .getReminders("user/view/reminders/jaya123");
                        // ignore: use_build_context_synchronously
                        Navigator.of(context).pop();
                        // ignore: avoid_print
                        print("confirmation yes");
                        // ignore: use_build_context_synchronously
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ViewAllReminders(response)));
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
                            .getReminders("user/view/reminders/jaya123");
                        // ignore: use_build_context_synchronously
                        Navigator.of(context).pop();
                        print("confirmation no");
                        // ignore: use_build_context_synchronously
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ViewAllReminders(response)));
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
          trailing:
              const Icon(Icons.delete, color: Color.fromARGB(255, 255, 77, 77)),
          leading: const Icon(Icons.verified,
              color: Color.fromARGB(255, 0, 216, 22)),
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
          title: const Text("Reminders"),
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(Icons.message),
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Reminders()));
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
