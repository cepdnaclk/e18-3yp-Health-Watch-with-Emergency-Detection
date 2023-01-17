import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:medicare1/NetworkHandler.dart';
import 'package:medicare1/addContacts.dart';
import 'package:medicare1/models/contactitem.dart';
import 'package:medicare1/navigation.dart';

class ViewAllContacts extends StatefulWidget {
  var response;
  String username;
  //List taskData =[]; 
  ViewAllContacts(this.username,this.response, {super.key});

  @override
  State<ViewAllContacts> createState() => _ViewAllContactsState(username,response);
}

class _ViewAllContactsState extends State<ViewAllContacts> with TickerProviderStateMixin{
  NetworkHandler networkHandler = NetworkHandler();
  String username;
  late List<String> tasks;
  List<contactItem> contactList = [];

  late Map items;
  late List taskDataList =[];
  var response;
  var listLength = 0;
  _ViewAllContactsState(this.username,this.response);



  @override
  void initState() {
    super.initState();
    
    print(response);
    var r = json.decode(response);
    listLength = getBoxLength(r);
    for(int i = 0; i < listLength; i++){
      items = readData(i,r);
      print('test: $items');
      taskDataList.add(items);
    }


  }



  Widget rowItemNormal(context, index, String objectId, String contactName, String email, String phone_number) {
    
    
    return Column(
      //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20,top: 3, bottom: 3),
        ),
        Hero(
          tag: 'ListTile-Hero',
          // Wrap the ListTile in a Material widget so the ListTile has someplace
          // to draw the animated colors during the hero transition.
          child: Material(
            child: ListTile(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10))),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () async {
                  showDialog(
                            context: context,
                            builder: (builder) {
                              return const Center(child: CircularProgressIndicator());
                        });
                  Map<String, String> data = {"title": contactName};
                        
                  int deleteResponse = await networkHandler
                            .deleteWithID("user/delete/contacts/$objectId");
                  String response = await networkHandler
                            .getReminders("user/view/contacts/$username");
                  Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ViewAllContacts(username,response)));
                  //deleteData(index);
                  //Navigator.pushNamed(context, '/view');
                },
              ),
              title: Text('$contactName'),
              subtitle: Text('Email: $email  Tel: $phone_number'),
              tileColor: Color.fromARGB(98, 50, 150, 133),
              iconColor: Color.fromARGB(255, 116, 5, 5),
              
            ),
          ),
        ),
      ],
    );
  }


  Widget showListNormal(int number2, List taskDataList) {
    
    return ListView.builder(
      padding: const EdgeInsets.all(6),
      itemCount: number2,//tasks.length,
      itemBuilder: (context, index) {
        return rowItemNormal(context, index,taskDataList[index]['id'], taskDataList[index]['name'], taskDataList[index]['email'], taskDataList[index]['phone_number']);
      },
    );
  }
  final contactItem c = new contactItem('contactName', 'email', 'phoneNo');

  void addContactData(contactItem contactitem) {
      setState(() {
        contactList.add(contactitem);
      });
    }
  void showContactDialog() {
      showDialog(
          context: context,
          builder: (_) {
            return AlertDialog(
              content: addContacts(username,addContactData),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            );
          });
    }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: showContactDialog,
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
          title: const Text(''),
          backgroundColor: Colors.white, //You can make this transparent
                    elevation: 0.0, //No shadow
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(Icons.navigate_before,color: Color.fromARGB(255, 17, 77, 71)),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CircularMenu(username)));
                },
              );
            },
          )),
      body: Container(padding: const EdgeInsets.only(left: 10, top: 120, right: 10),
        decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("images/emergency.png"),
                    fit: BoxFit.cover)),
        child:Column(
          children:<Widget>[
          Flexible(child: showListNormal(listLength,taskDataList)),])
      ),
    );
  }

  String readDataID(int index, var r){
    var data = '${r["data"][index]["_id"]}';
    return data;
  }
  String readDataName(int index, var r){
    var data = '${r["data"][index]["contacts"]["contact_name"]}';
    return data;
  }

  String readDataEmail(int index, var r){
    var data = '${r["data"][index]["contacts"]["email"]}';
    return data;
  }

  String readDataPhoneNumber(int index, var r){
    var data = '${r["data"][index]["contacts"]["phone_number"]}';
    return data;
  }

  Map<String, String> readData(int index, var r){
    Map<String, String> newData = {
      "id":readDataID(index, r),
      "name":readDataName(index,r),
      "email":readDataEmail(index,r),
      "phone_number":readDataPhoneNumber(index,r),
    };

    return newData;
  }

  int getBoxLength(var r){
    final length = r["data"].length;
    return length;
  }

  // void deleteData(int index){
  //   _myBox.deleteAt(index);
  //   taskDataList.removeAt(index);
  // } 


}