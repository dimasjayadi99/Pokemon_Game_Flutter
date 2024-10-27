import 'package:flutter/material.dart';
import 'package:pokemon_game/common/app_const.dart';

class SplashScreenPage extends StatefulWidget{
  const SplashScreenPage({super.key});

  @override
  SplashScreenPageState createState() => SplashScreenPageState();
}

class SplashScreenPageState extends State<SplashScreenPage>{

  // time load in second
  int timeLoad = 2;

  @override
  void initState() {
    redirectPage();
    super.initState();
  }

  // direct page splash screen to home page
  void redirectPage() async {
    await Future.delayed(Duration(seconds: timeLoad));
    if(mounted) Navigator.of(context).pushNamedAndRemoveUntil("/home", (context) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Stack(
            children: [
              const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("POKEMON GAME", style: AppConst.logoStyle),
                      Text("by Dimas Jayadi"),
                    ],
                  )
              ),

              // poke api logo
              Positioned(
                  bottom: 20,
                  right: 0,
                  left: 0,
                  child: Image.asset("assets/pokeapi_logo.png", width: 32, height: 32)
              )

            ]
          )
      ),
    );
  }
}