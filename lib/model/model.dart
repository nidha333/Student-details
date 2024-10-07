import 'package:hive_flutter/hive_flutter.dart';
part 'model.g.dart';

@HiveType(typeId: 0)
class StudentModel {
  @HiveField(0)
  String name;

  @HiveField(2)
  String cls;

  @HiveField(3)
  String address;

  @HiveField(4)
  String? imagePath;

  StudentModel(
      {required this.name,
      required this.cls,
      required this.address,
      required this.imagePath});
}
