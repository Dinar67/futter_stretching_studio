library globals;

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

File? selectImage;
UploadTask? uploadTask;
String? typeItem;
String? typeAction;
DocumentSnapshot? selectedTeacher;
Image? currentUserImage;

String? imageUrl;
DocumentSnapshot? selectedTeacherDrop;

DocumentSnapshot? selectedLesson;

List<String>? myLessons;
String? action;
DocumentSnapshot? currentUser;
