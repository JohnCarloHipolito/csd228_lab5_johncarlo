import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'pokemon_provider.dart';
import 'splash_page.dart';
import 'home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PokemonProvider(),
      child: MaterialApp(
        title: 'Pokemon',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
          primaryColor: Colors.grey[900],
          scaffoldBackgroundColor: Colors.grey[850],
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.grey[900],
          ),
          colorScheme: ColorScheme.dark(
            primary: Colors.grey[900]!,
            onPrimary: Colors.white,
            surface: Colors.grey[850]!,
            onSurface: Colors.white,
          ),
        ),
        home: const SplashScreen(
          nextPage: HomePage(title: 'Pokemon Battle'),
        ),
      ),
    );
  }
}