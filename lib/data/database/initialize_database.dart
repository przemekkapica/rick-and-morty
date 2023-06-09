import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rick_and_morty/domain/characters/model/character.f.dart';

Future<Isar> initializeDatabase() async {
  final dir = await getApplicationDocumentsDirectory();

  final isar = await Isar.open(
    [CharacterSchema],
    directory: dir.path,
  );

  return isar;
}
