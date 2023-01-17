import 'package:medicare1/data.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class OverviewGrid extends StatelessWidget {
  const OverviewGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: course.length,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 16 / 7, crossAxisCount: 1, mainAxisSpacing: 20),
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Color.fromARGB(255, 90, 216, 174),
                  Color.fromARGB(255, 255, 255, 255),
                ],
              ),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20)
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        course[index].text,
                        style: const TextStyle(color: Color.fromARGB(255, 0, 143, 64), fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      Text(
                        course[index].lessons,
                        style: const TextStyle(color: Color.fromARGB(255, 7, 4, 2)),
                      ),
                      Text(
                        "Heart rate:",
                        style: const TextStyle(color: Color.fromARGB(255, 7, 4, 2)),
                      ),
                      Text(
                        "Oxygen level:",
                        style: const TextStyle(color: Color.fromARGB(255, 7, 4, 2)),
                      ),
                      
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }
}