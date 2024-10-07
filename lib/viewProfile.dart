import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ViewProfile extends StatelessWidget {
  String name;
  String cls;
  String address;
  dynamic imagePath;

  ViewProfile(
      {super.key,
      required this.name,
      required this.cls,
      required this.address,
      required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 145, 106, 91),
        title: RichText(
          text: TextSpan(children: [
            TextSpan(
                text: 'Student ',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold)),
            TextSpan(
                text: 'Details',
                style: TextStyle(
                    color: const Color.fromARGB(255, 106, 40, 15),
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                    fontSize: 25))
          ]),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
            child: Card(
          margin: EdgeInsets.all(50),
          color: Colors.brown,
          child: Padding(
            padding: const EdgeInsets.all(100.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 70,
                  backgroundImage: FileImage(File(imagePath)),
                ),
                Gap(20),
                Title(
                  color: const Color.fromARGB(255, 0, 0, 0),
                  child: Text(
                    'Name:  $name',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
                const SizedBox(
                  height: 6,
                ),
                Title(
                  color: Colors.black,
                  child: Text(
                    'Class: $cls ',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
                const SizedBox(
                  height: 6,
                ),
                Title(
                  color: Colors.black,
                  child: Text(
                    'Address: $address ',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        )),
      ),
    );
  }
}
