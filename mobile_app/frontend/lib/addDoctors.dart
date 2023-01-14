import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:medicare1/NetworkHandler.dart';
import 'package:medicare1/viewAllDoctors.dart';
// import 'package:settings/models/contactitem.dart';

import 'main.dart';
import 'models/contactitem.dart';

class addDoctors extends StatefulWidget {
  
  final Function(contactItem) addcontact;

  addDoctors(this.addcontact);

  @override
  _addDoctorstate createState() => _addDoctorstate();
}

class _addDoctorstate extends State<addDoctors> {
  NetworkHandler networkHandler = NetworkHandler();
  final contactItem c = new contactItem('Name', 'Email', 'Phone Number');

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
              'Add your doctor',
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
                    "doctor_name": contactNameController.text,
                    "email": emailController.text,
                    "phone_number": phoneNoController.text,
                  };

                  Map<String, Map<String, String>> data1 = {"doctors": data};
                  String username = "jaya123"; // ignore: unused_local_variable
                  print(data1);
                  var tokenKeeper = await networkHandler.addDoctors('user/add/doctors/$username', data1);
                  String response = await networkHandler
                      .getReminders("user/view/doctors/jaya123");
                    print(response);
                  final contactitem = contactItem(contactNameController.text,
                      emailController.text, phoneNoController.text);

                  widget.addcontact(contactitem);
                  Navigator.of(context).pop();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ViewAllDoctors(response)));
                
                },
                style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        shape:const StadiumBorder(),
                      ),
                child: Text('  Add  '))
          ],
        ),
      ),
    );
  }
}
