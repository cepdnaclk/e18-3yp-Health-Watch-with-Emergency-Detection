// ignore: file_names
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class NetworkHandler {
  
  String baseurl = "https://3yp-new-app.azurewebsites.net/";

  Future<String> get(String url, String token) async {
    url = formater(url);

    var response = await http.get(Uri.parse(url), headers: {
      "Content-type": "application/json",
      "Authorization": 'Bearer $token'
    });

    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.body;
    }
    return "";
  }


  Future<int> updateReminders(String url, Map<String, Map<String, String>> body) async {
    url = formater(url);
    
    var response = await http.post(Uri.parse(url),headers: {"Content-type":"application/json"} ,body:json.encode(body));
    
    if(response.statusCode == 200 || response.statusCode ==201){
      // ignore: avoid_print
      print("testing:$body");
      // ignore: avoid_print
      print(json.decode(response.body));
      return response.statusCode;
    } return response.statusCode;
    
  }


  Future<String> getReminders(String url) async {

    url = formater(url);
    
    var response = await http.get(Uri.parse(url),headers: {"Content-type":"application/json"});
    
   if(response.statusCode == 200 || response.statusCode ==201){
      return response.body;
    }return "";
  }


  Future<String> post(String url, Map<String, String> body) async {
    url = formater(url);

    var response = await http.post(Uri.parse(url),
        headers: {"Content-type": "application/json"}, body: json.encode(body));

    if (response.statusCode == 200 || response.statusCode == 201) {
      // ignore: avoid_print
      print("testing:$body");
      // ignore: avoid_print
      print(json.decode(response.body));
      return response.body;
    }
    return "";
  }

  String formater(String url) {
    return baseurl + url;
  }
}

