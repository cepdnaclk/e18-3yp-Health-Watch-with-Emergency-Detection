// ignore_for_file: avoid_print, unused_local_variable

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_app_01/NetworkHandler.dart';
import 'package:my_app_01/navigation.dart';
import 'package:my_app_01/view_all_reminders.dart';

class Reminders extends StatefulWidget {
  const Reminders({super.key});

  @override
  State<Reminders> createState() => _RemindersState();
}

class _RemindersState extends State<Reminders> {
  NetworkHandler networkHandler = NetworkHandler();
  TextEditingController remind = TextEditingController();
  String frequency = 'Daily';
  String time = '12';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Reminders'),
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(Icons.message_rounded),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CircularMenu()));
                },
              );
            },
          )),
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/addReminder.png"),
                fit: BoxFit.cover)),
        child: ListView(
          children: <Widget>[
            const Padding(padding: EdgeInsets.only(top: 100)),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: TextField(
                controller: remind,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Remind me to...',
                ),
              ),
            ),
            Center(
              child: DropdownButton(
                value: frequency,
                items: const [
                  DropdownMenuItem(
                    value: 'Daily',
                    child: Text('Daily'),
                  ),
                  DropdownMenuItem(
                    value: 'Weekly',
                    child: Text('Weekly'),
                  ),
                  DropdownMenuItem(
                    value: 'Monthly',
                    child: Text('Monthly'),
                  ),
                ],
                onChanged: (String? value) {
                  setState(() {
                    frequency = value!;
                  });
                },
              ),
            ),
            Center(
              child: DropdownButton(
                value: time,
                items: const [
                  DropdownMenuItem(
                    value: '0',
                    child: Text('00:00'),
                  ),
                  DropdownMenuItem(
                    value: '1',
                    child: Text('01:00'),
                  ),
                  DropdownMenuItem(
                    value: '2',
                    child: Text('02:00'),
                  ),
                  DropdownMenuItem(
                    value: '3',
                    child: Text('03:00'),
                  ),
                  DropdownMenuItem(
                    value: '4',
                    child: Text('04:00'),
                  ),
                  DropdownMenuItem(
                    value: '5',
                    child: Text('05:00'),
                  ),
                  DropdownMenuItem(
                    value: '6',
                    child: Text('06:00'),
                  ),
                  DropdownMenuItem(
                    value: '7',
                    child: Text('07:00'),
                  ),
                  DropdownMenuItem(
                    value: '8',
                    child: Text('08:00'),
                  ),
                  DropdownMenuItem(
                    value: '9',
                    child: Text('09:00'),
                  ),
                  DropdownMenuItem(
                    value: '10',
                    child: Text('10:00'),
                  ),
                  DropdownMenuItem(
                    value: '11',
                    child: Text('11:00'),
                  ),
                  DropdownMenuItem(
                    value: '12',
                    child: Text('12:00'),
                  ),
                  DropdownMenuItem(
                    value: '13',
                    child: Text('13:00'),
                  ),
                  DropdownMenuItem(
                    value: '14',
                    child: Text('14:00'),
                  ),
                  DropdownMenuItem(
                    value: '15',
                    child: Text('15:00'),
                  ),
                  DropdownMenuItem(
                    value: '16',
                    child: Text('16:00'),
                  ),
                  DropdownMenuItem(
                    value: '17',
                    child: Text('17:00'),
                  ),
                  DropdownMenuItem(
                    value: '18',
                    child: Text('18:00'),
                  ),
                  DropdownMenuItem(
                    value: '19',
                    child: Text('19:00'),
                  ),
                  DropdownMenuItem(
                    value: '20',
                    child: Text('20:00'),
                  ),
                  DropdownMenuItem(
                    value: '21',
                    child: Text('21:00'),
                  ),
                  DropdownMenuItem(
                    value: '22',
                    child: Text('22:00'),
                  ),
                  DropdownMenuItem(
                    value: '23',
                    child: Text('23:00'),
                  ),
                ],
                onChanged: (String? value) {
                  setState(() {
                    time = value!;
                  });
                },
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: ElevatedButton(
                onPressed: () async {
                  showDialog(
                      context: context,
                      builder: (builder) {
                        return const Center(child: CircularProgressIndicator());
                      });
                  print(remind.text);
                  print(frequency);
                  print(time);
                  Map<String, String> data = {
                    "title": remind.text,
                    "frequency": frequency,
                    "time": time,
                  };
                  Map<String, Map<String, String>> data1 = {"reminders": data};
                  String username = "jaya123"; // ignore: unused_local_variable
                  print(data1);
                  var tokenKeeper = await networkHandler.updateReminders(
                      'user/update/reminders/$username', data1);
                  // ignore: use_build_context_synchronously
                  Navigator.of(context).pop();
                  print(tokenKeeper);
                  remind.text = "";
                },
                child: const Text('ADD REMINDER'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                    )),
                onPressed: () async {
                  showDialog(
                            context: context,
                            builder: (builder) {
                              return const Center(child: CircularProgressIndicator());
                  });
                  String response = await networkHandler
                      .getReminders("user/view/reminders/jaya123");
                  // ignore: use_build_context_synchronously
                  Navigator.of(context).pop();
                  // ignore: use_build_context_synchronously
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ViewAllReminders(response)));
                },
                child: const Text('VIEW REMINDERS'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
