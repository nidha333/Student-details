import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:practies/model/model.dart';

ValueNotifier<List<StudentModel>> studentListNotifier = ValueNotifier([]);

Future<void> addStudent(StudentModel value) async {
  final studentDB = await Hive.openBox<StudentModel>("database");

  await studentDB.add(value);
  print("Added student: $value");

  getAllStudents();
}

Future<void> getAllStudents() async {
  final studentDB = await Hive.openBox<StudentModel>('database');

  studentListNotifier.value.clear();
  studentListNotifier.value.addAll(studentDB.values);
  print("All students: ${studentListNotifier.value}");

  studentListNotifier.notifyListeners();
}

Future<void> deleteStudent(int index) async {
  final studentDB = await Hive.openBox<StudentModel>('database');

  await studentDB.deleteAt(index);
  print("Deleted student at index: $index");

  getAllStudents();
}

Future<void> editStudent(int index, StudentModel value) async {
  final studentDB = await Hive.openBox<StudentModel>('database');

  await studentDB.putAt(index, value);
  print("Edited student at index: $index with value: $value");

  getAllStudents();
}
