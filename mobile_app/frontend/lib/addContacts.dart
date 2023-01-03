import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
// import 'package:settings/models/contactitem.dart';

import 'main.dart';
import 'models/contactitem.dart';

class addContacts extends StatefulWidget {
  final Function(contactItem) addcontact;

  addContacts(this.addcontact);

  @override
  _addContactState createState() => _addContactState();
}

class _addContactState extends State<addContacts> {
  final contactItem c =
      new contactItem('Contact Name', 'Email', 'Phone Number');

  @override
  Widget build(BuildContext context) {
    Widget buildTextField(String hint, TextEditingController controller) {
      return Container(
        margin: EdgeInsets.all(4),
        child: TextField(
          decoration: InputDecoration(
              labelText: hint,
              border: OutlineInputBorder(
                  borderSide: BorderSide(
                color: Colors.black54,
              ))),
          controller: controller,
        ),
      );
    }

    var contactNameController = TextEditingController();
    var emailController = TextEditingController();
    var phoneNoController = TextEditingController();

    String contactName = c.contactName;
    String email = c.email;
    String contactNumber = c.phoneNo;

    return Container(
      padding: EdgeInsets.all(8),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Add a Contact',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 28,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 10),
            buildTextField('$contactName', contactNameController),
            buildTextField('$email', emailController),
            buildTextField('$contactNumber', phoneNoController),
            SizedBox(height: 10),
            ElevatedButton(
                onPressed: () {
                  final contactitem = contactItem(contactNameController.text,
                      emailController.text, phoneNoController.text);

                  widget.addcontact(contactitem);
                  Navigator.of(context).pop();
                },
                child: Text('Add Conatct'))
          ],
        ),
      ),
    );
  }
}
