import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:medicare1/NetworkHandler.dart';
import 'package:medicare1/viewAllContacts.dart';
// import 'package:settings/models/contactitem.dart';

import 'main.dart';
import 'models/contactitem.dart';

class addContacts extends StatefulWidget {
  final Function(contactItem) addcontact;
  String username;
  addContacts(this.username,this.addcontact);

  @override
  _addContactState createState() => _addContactState(username);
}

class _addContactState extends State<addContacts> {
    NetworkHandler networkHandler = NetworkHandler();
  String username;
  final contactItem c =
      new contactItem('Contact Name', 'Email', 'Phone Number');
      
        _addContactState(this.username);

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
                color: Color.fromARGB(255, 5, 104, 99),
              ),
            ),
            SizedBox(height: 10),
            buildTextField('$contactName', contactNameController),
            buildTextField('$email', emailController),
            buildTextField('$contactNumber', phoneNoController),
            SizedBox(height: 10),
            ElevatedButton(
                onPressed: () async {
                  showDialog(
                            context: context,
                            builder: (builder) {
                              return const Center(child: CircularProgressIndicator());
                        });
                  Map<String, String> data = {
                    "contact_name": contactNameController.text,
                    "email": emailController.text,
                    "phone_number": phoneNoController.text,
                  };
                  Map<String, Map<String, String>> data1 = {"contacts": data};
                  
                  print(data1);
                  var tokenKeeper = await networkHandler.addContactList('user/add/contacts/$username', data1);
                  
                  final contactitem = contactItem(contactNameController.text,
                      emailController.text, phoneNoController.text);

                  widget.addcontact(contactitem);
                  String response = await networkHandler
                      .getReminders("user/view/contacts/$username");
                  Navigator.of(context).pop();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ViewAllContacts(username,response)));
                },
                style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        shape:const StadiumBorder(),
                      ),
                child: Text('Add Conatct'))
          ],
        ),
      ),
    );
  }
}
