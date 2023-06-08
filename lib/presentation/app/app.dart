import 'package:flutter/material.dart';
import 'package:rick_and_morty/presentation/pages/characters_list_page.dart';

class App extends StatefulWidget {
  const App({super.key, required this.title});

  final String title;

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return CharactersListPage();
  }
}
