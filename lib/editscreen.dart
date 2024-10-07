import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:practies/model/function/db_function.dart';
import 'package:practies/model/model.dart';

class Editscreen extends StatefulWidget {
  final int index;
  final String name;
  final String clas;
  final String addres;
  Editscreen(
      {super.key,
      required this.index,
      required this.name,
      required this.clas,
      required this.addres});

  @override
  State<Editscreen> createState() => _EditscreenState();
}

class _EditscreenState extends State<Editscreen> {
  File? _image;
  TextEditingController nameCtrl = TextEditingController();
  TextEditingController classCtrl = TextEditingController();
  TextEditingController addressCtrl = TextEditingController();

  Future _pickImageFromGallery() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (returnImage == null) {
      return;
    }

    setState(() {
      _image = File(returnImage.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    nameCtrl = TextEditingController(text: widget.name);
    classCtrl = TextEditingController(text: widget.clas);
    addressCtrl = TextEditingController(text: widget.addres);

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
          child: Card(
            margin: EdgeInsets.all(30),
            color: const Color.fromARGB(255, 165, 120, 104),
            elevation: 10,
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _image != null
                        ? CircleAvatar(
                            backgroundImage: FileImage(_image!),
                            radius: 75,
                          )
                        : CircleAvatar(
                            backgroundImage: AssetImage("assets/download.jpeg")
                                as ImageProvider,
                            radius: 75,
                          ),
                    ElevatedButton(
                      onPressed: _pickImageFromGallery,
                      child: const Text("Edit Image"),
                    ),
                    const Gap(15),
                    TextFormField(
                      controller: nameCtrl,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Name',
                      ),
                    ),
                    const Gap(10),
                    TextFormField(
                      controller: classCtrl,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Class',
                      ),
                    ),
                    const Gap(10),
                    TextFormField(
                      controller: addressCtrl,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Address',
                      ),
                    ),
                    const Gap(10),
                    ElevatedButton(
                      onPressed: () {
                        addStudentBtn();
                      },
                      child: const Text('Submit'),
                    ),
                    const Gap(10),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  void addStudentBtn() {
    if (nameCtrl.text.isEmpty ||
        classCtrl.text.isEmpty ||
        addressCtrl.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields.')),
      );
      return;
    }

    final data = StudentModel(
      name: nameCtrl.text,
      cls: classCtrl.text,
      address: addressCtrl.text,
      imagePath: _image?.path ?? '',
    );

    editStudent(widget.index, data);
    Navigator.pop(context);
  }
}
