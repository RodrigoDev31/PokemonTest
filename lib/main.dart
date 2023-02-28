import 'package:flutter/material.dart';
import 'package:movies_flutter/providers/pokemon_provider.dart';
import 'package:movies_flutter/screens/detail_screen.dart';
import 'package:movies_flutter/screens/screens.dart';
import 'package:provider/provider.dart';

void main() => runApp(const AppState());

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => PokemonProvider(),
          lazy: false,
        ),
      ],
      child: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Peliculas Flutter',
      initialRoute: "home",
      routes: {
        "home": (_) => const HomeScreen(),
        "detail": (_) => const DetailScreen(),
      },
      theme: ThemeData.light()
          .copyWith(appBarTheme: const AppBarTheme(color: Colors.amber)),
    );
  }
}
