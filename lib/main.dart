import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pokemon_game/ViewModels/home_viewmodel.dart';
import 'package:pokemon_game/Views/pokemon_list_view.dart';
import 'package:provider/provider.dart';

import 'Providers/search_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor:
            Colors
                .yellowAccent
                .shade700, // Make the status bar background transparent (optional)
        statusBarIconBrightness:
            Brightness.dark, // Dark icons in the status bar
      ),
    );
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeViewViewmodel()),
        ChangeNotifierProvider(create: (_) => SearchProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Pokemon App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.yellow),
        ),
        home: const PokemonListView(),
      ),
    );
  }
}
