import 'package:flutter/material.dart';
import 'package:rick_and_morty/core/di/di_config.dart';
import 'package:rick_and_morty/data/database/local_database.dart';
import 'package:rick_and_morty/presentation/app/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  configureDependencies();
  await LocalDatabase.initializeDatabase();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const App();
  }
}
