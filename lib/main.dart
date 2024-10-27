import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pokemon_game/view/pages/bottom_nav.dart';
import 'package:pokemon_game/view/pages/splash_screen_page.dart';
import 'bloc/list_pokemon_bloc.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(MultiBlocProvider(
      providers: [
        BlocProvider<ListPokemonBloc>(
          create: (context) => ListPokemonBloc()..fetchListPokemon(),
        ),
      ],
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: {
        "/" : (context) => const SplashScreenPage(),
        "/home" : (context) => const BottomNav(),
      },
    );
  }
}