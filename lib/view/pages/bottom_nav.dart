import 'package:flutter/material.dart';
import 'package:pokemon_game/common/app_const.dart';
import 'package:pokemon_game/view/pages/compare_page.dart';
import 'package:pokemon_game/view/pages/home_page.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  BottomNavState createState() => BottomNavState();
}

class BottomNavState extends State<BottomNav> {

  @override
  void initState() {
    super.initState();
  }

  int selectedPage = 0;

  List<Widget> _pageOptions() {
    return [
      const HomePage(),
      const ComparePage(),
    ];
  }
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          scrolledUnderElevation: 0.0,
          backgroundColor: Colors.white,
          centerTitle: true,
          title: const Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("PokeApp", style: AppConst.logoStyle),
              Text("Dimas Jayadi", style: TextStyle(fontSize: 12)),
            ],
          ),
        ),
        body: SafeArea(
          child: _pageOptions()[selectedPage],
        ),
        bottomNavigationBar: BottomNavigationBar(
          enableFeedback: false,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home, size: 30), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.compare, size: 30), label: 'Compare'),
          ],
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey.withOpacity(0.8),
          currentIndex: selectedPage,
          backgroundColor: Colors.white,
          onTap: (index) {
            setState(() {
              selectedPage = index;
            });
          },
        ),
      ),
    );
  }
}