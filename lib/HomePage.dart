import 'dart:io';

import 'package:flutter/material.dart';
import 'package:practies/addscreen.dart';
import 'package:practies/editscreen.dart';
import 'package:practies/loginPage.dart';
import 'package:practies/model/function/db_function.dart';
import 'package:practies/model/model.dart';
import 'package:practies/viewProfile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String search = '';
  List<StudentModel> searchedList = [];
  void searchListUpdate() {
    getAllStudents();
    searchedList = studentListNotifier.value
        .where((stdModel) =>
            stdModel.name.toLowerCase().contains(search.toLowerCase()))
        .toList();
  }

  Future<void> _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool("isLoggedIn", false);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const Loginpage()));
  }

  @override
  Widget build(BuildContext context) {
    searchListUpdate();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 145, 106, 91),
        title: RichText(
          text: const TextSpan(children: [
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
                    color: Color.fromARGB(255, 106, 40, 15),
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                    fontSize: 25))
          ]),
        ),
        actions: [
          IconButton(
              onPressed: () {
                _logout();
              },
              icon: const Icon(Icons.logout))
        ],
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 128, 90, 77),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const Addscreen(),
          ));
        },
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextFormField(
              style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
              onChanged: (value) {
                setState(() {
                  search = value;
                  searchListUpdate();
                });
              },
              decoration: const InputDecoration(
                labelText: 'Search',
                labelStyle: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                suffixIcon: Icon(
                  Icons.search,
                  color: Color.fromARGB(255, 17, 14, 14),
                ),
              ),
            ),
          ),
          Expanded(
            child: ValueListenableBuilder<List<StudentModel>>(
              valueListenable: studentListNotifier,
              builder: (context, studentList, child) {
                return search.isNotEmpty
                    ? searchedList.isEmpty
                        ? const Center(
                            child: Text("No Results Found"),
                          )
                        : buildStudentList(searchedList, context)
                    : buildStudentList(studentList, context);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildStudentList(List<StudentModel> students, BuildContext context) {
    return students.isEmpty
        ? const Center(
            child: Text(
              'No students available.',
              style: TextStyle(color: Colors.white),
            ),
          )
        : Padding(
            padding: const EdgeInsets.all(15),
            child: ListView.separated(
              itemCount: students.length,
              itemBuilder: (context, index) {
                final data = students[index];
                return ListTile(
                  tileColor: const Color.fromARGB(255, 150, 116, 103),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ViewProfile(
                          name: data.name,
                          cls: data.cls,
                          address: data.address,
                          imagePath: data.imagePath,
                        ),
                      ),
                    );
                  },
                  title: Text(
                    data.name,
                    style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                  ),
                  subtitle: Text(
                    data.cls,
                    style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                  ),
                  leading: CircleAvatar(
                    backgroundImage:
                        data.imagePath != null && data.imagePath!.isNotEmpty
                            ? FileImage(File(data.imagePath!))
                            : const AssetImage("assets/unknown.png"),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => Editscreen(
                                index: index,
                                name: data.name,
                                clas: data.cls,
                                addres: data.address,
                              ),
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.black,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Confirm Deletion'),
                                content: const Text(
                                    'Are you sure you want to delete this student?'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      deleteStudent(index);
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('Delete'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Divider(
                    color: Colors.white,
                  ),
                );
              },
            ),
          );
  }
}
