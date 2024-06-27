import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stretching_studio/colors.dart';
import 'package:flutter_stretching_studio/database/collections/ProfileCollection';
import 'package:flutter_stretching_studio/navigation_bar.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

final ProfileCollection profile = ProfileCollection();
final FirebaseAuth auth = FirebaseAuth.instance;

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

void initLang() async {
  await initializeDateFormatting('ru_RU');
}

class _MainScreenState extends State<MainScreen> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    initLang();
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

      body: PageView(
        controller: _pageController,
        children: [
          for (int i = 0; i < 14; i++)
            Card(
              child: Center(
                child: Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.75,



                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(onPressed: () async 
                          {
                          _pageController.previousPage(duration: const Duration(milliseconds: 400), curve: Curves.ease);
                          },
                          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: appBarBackground,),
                        ),
                        Column(
                          children: [
                            Text(
                              DateFormat('EEEE', 'ru_RU').format(DateTime.now().add(Duration(days: i))),
                              style: const TextStyle(
                                fontSize: 30,
                                fontFamily: 'bebasregular',
                                color: appBarBackground
                              ),
                            ),
                            Text(
                              DateFormat('dd.MM').format(DateTime.now().add(Duration(days: i))).toString(),
                              style: const TextStyle(
                                fontSize: 22,
                                fontFamily: 'bebasregular',
                                color: appBarBackground
                              ),
                            ),
                          ],
                        ),
                        IconButton(onPressed: () async 
                          {
                          _pageController.nextPage(duration: const Duration(milliseconds: 400), curve: Curves.ease);
                          },
                          icon: const Icon(Icons.arrow_forward_ios_rounded, color: appBarBackground,),
                        ),
                      ],
                    ),
                    

                    
                    
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}