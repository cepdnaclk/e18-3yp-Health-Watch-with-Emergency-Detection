
import 'package:flutter/material.dart';
import 'package:ternav_icons/ternav_icons.dart';

import 'models/course_model.dart';


final List<Course> course = [
  Course(
      text: "Quick overview",
      lessons: "Abnormal readings:",
      
      percent: 75,
     
      color: Color.fromARGB(255, 30, 60, 112)),
  Course(
      text: "Your current location:",
      lessons: "(if location is different click \"Set location\")",
     
      percent: 50,
      
      color: Colors.blueAccent),
  
];
