import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:todo_application/models/photo.dart';
import 'package:todo_application/models/user.dart';

class Autentification {
  static String? token;
  static Map? tokenDecoded;
  static User? loggedUser;
}

Photo? profilePhoto;

dynamic dateEncode(dynamic item) {
  if (item is DateTime) {
    return item.toIso8601String();
  }
  return item;
}

Image imageFromBase64String(String base64Image) {
  return Image.memory(
    base64Decode(base64Image),
    height: 250,
    width: 250,
  );
}

const String mfield = "Field is mandatory";

ButtonStyle buttonStyleSecondary = ElevatedButton.styleFrom(
  backgroundColor: Colors.lightBlue[100], // For the background color
  foregroundColor: Colors.white,
);

int calculateAge(DateTime birthDate) {
  final currentYear = DateTime.now().year;
  final birthYear = birthDate.year;
  return currentYear - birthYear;
}
