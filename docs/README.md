---
layout: home
permalink: index.html

# Please update this with your repository name and project title
repository-name: e18-3yp-Health-Watch-with-Emergency-Detection
title: Health Watch with Emergency Detection - MediCare
---

[comment]: # "This is the standard layout for the project, but you can clean this and use your own template"

# Health Watch with Emergency Detection - MediCare

---

## Team
-  E/18/276, Rajasooriya J.M., [email](mailto:e18276@eng.pdn.ac.lk)
-  E/18/283, Ranasinghe R.D.J.M., [email](mailto:e18283@eng.pdn.ac.lk)
-  E/18/412, De Silva M.S.G.M., [email](mailto:e18412eng.pdn.ac.lk)

<!-- Image (photo/drawing of the final hardware) should be here -->

<!-- This is a sample image, to show how to add images to your page. To learn more options, please refer [this](https://projects.ce.pdn.ac.lk/docs/faq/how-to-add-an-image/) -->

<!-- ![Sample Image](./images/sample.png) -->

#### Table of Contents
1. [Introduction](#introduction)
2. [Solution Architecture](#solution-architecture )
3. [Hardware & Software Designs](#hardware-and-software-designs)
4. [Testing](#testing)
5. [Detailed budget](#detailed-budget)
6. [Conclusion](#conclusion)
7. [Links](#links)

## Introduction

There is a huge increase in the number of people who are getting cardiovascular diseases and sometimes they pass away suddenly and sometimes there is still time to save them if the right medication is given as soon as possible. It is always about the time. Also, even after a surgery there are occasions where things get complicated and regular monitoring is essential.

And not only the sudden accidents that are occuring due to the cardiovascular diseases but day to day activities can be a cause to an accident. Therefore in order to make sure the elderly people’s health and to take care of them by giving proper attention is really required.

Now there is no specific range of age to get sick and to face accidents we all need to look after ourselves. Therefore, it is good to keep track of our heart rate in order to make sure whether we are in good condition or not.There should be a method which does not cost more money or time to keep track of our health without being limited to an age or any specific diseases.


## Solution Architecture

Our system consists of three main components. They are,
- wrist-worn device with sensors
- cloud server
- mobile application

Relevant health parameters such as heart rate, blood oxygen level and temperature are read from the sensors in the wrist-worn device. These data is continuosuly transmitted to the cloud server by 3G signals, using the 3G module included in the device.

In the server, the obtained data is analyzed and if any abnormal behaviour is detected in these health data, it immediately notifies the user and asks for his confirmation. If the user is unable to response to this notification in a given time, emergency notifications are sent to the contacts, which the user added into the system. User can customize this notification system and to whom these notifications are sent.

The mobile application directly connects with the cloud server and it shows a real-time summary of health data of the user, which was obtained from the cloud. User can add, update and remove the contacts which he intends to notify in case of an emergency. Furthermore, he can setup a list of reminders for his medications. The user is supposed to confirm taking this medicine or otherwise it alerts him or his caregivers (the latter is optional).  

## Hardware and Software Designs

Detailed designs with many sub-sections

## Testing

Testing done on hardware and software, detailed + summarized results

## Detailed budget

All items and costs

| Item          | Quantity  | Unit Cost  | Total  |
| ------------- |:---------:|:----------:|-------:|
| MAX30100 Heart rate oxygen pulse sensor   | 1         | 690 LKR     | 690 LKR |
| LM35 TO-92 precision centigrade temperature sensor | 1  | 245 LKR | 245 LKR |
| Accelerometer module gyroscope MPU-6050 | 1 | 695 LKR | 695 LKR |
| Arduino UNO ATMEGA328P development board | 1 | 3880 LKR | 3880 LKR |
| 1.5V Battery (AA) | 4 | 50 LKR | 240 LKR |
| Battery holder storage case | 1 | 230 LKR | 230 LKR |
| 10cm female to female jumper wires | 40 Pcs | 195 LKR | 195 LKR |
| Resistors | 25 Pcs (1kOhm) & 25 Pcs (330Ohm) | 100 LKR | 100 LKR |
| Breadboard 400-Tie-Points | 1 | 295 LKR | 295 LKR |
| SIM5230E Simcom 3G Module | 1 | 7560 LKR |
| 3V mini buzzer | 1 | 80 LKR |

## Conclusion

What was achieved, future developments, commercialization plans

## Links

- [Project Repository](https://github.com/cepdnaclk/{{ page.repository-name }}){:target="_blank"}
- [Project Page](https://cepdnaclk.github.io/{{ page.repository-name}}){:target="_blank"}
- [Department of Computer Engineering](http://www.ce.pdn.ac.lk/)
- [University of Peradeniya](https://eng.pdn.ac.lk/)

[//]: # (Please refer this to learn more about Markdown syntax)
[//]: # (https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet)
