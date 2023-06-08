import 'package:flutter/material.dart';
import 'package:rick_and_morty/presentation/router/go_router.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: goRouter(),
      title: 'Rick and Morty characters library',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      builder: (_, child) {
        if (child == null) {
          return const SizedBox.shrink();
        }

        return child;
      },
    );
  }
}
