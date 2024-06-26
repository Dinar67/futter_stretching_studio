import 'package:flutter/material.dart';
import 'package:flutter_stretching_studio/colors.dart';
import 'package:flutter_stretching_studio/database/collections/ProfileCollection';
import 'package:flutter_stretching_studio/navigation_bar.dart';

final ProfileCollection profile = ProfileCollection();

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: const Navbar(),
      appBar: AppBar(
        leadingWidth: 180,
        leading: Row(
          children: [
            const SizedBox(width: 10),
            Image.asset('assets/images/logo.png')
          ],
        ),
        iconTheme: const IconThemeData(
          color: Colors.white
        ),
        backgroundColor: appBarBackground,
      ),
    );
  }
}