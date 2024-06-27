import 'package:flutter/material.dart';
import 'package:flutter_stretching_studio/colors.dart';

AppBar appBar(BuildContext context){
  return AppBar(
    leadingWidth: 180,
        leading: Row(
          children: [
            const SizedBox(width: 10),
            Image.asset('assets/images/logo.png')
          ],
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: appBarBackground,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.popAndPushNamed(context, '/');
              },
              icon: const Icon(Icons.arrow_forward_ios_rounded,
                  color: Colors.white))
        ],
  );
}