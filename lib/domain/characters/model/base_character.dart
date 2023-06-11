import 'package:isar/isar.dart';
import 'package:rick_and_morty/domain/characters/model/gender.dart';
import 'package:rick_and_morty/domain/characters/model/status.dart';

abstract class BaseCharacter {
  BaseCharacter({
    required this.id,
    required this.name,
    required this.status,
    required this.image,
    required this.species,
    required this.type,
    required this.gender,
    required this.origin,
    required this.location,
    required this.created,
    required this.isFavorite,
  });

  final int id;
  final String name;
  @enumerated
  final Status status;
  final String image;
  final String species;
  final String type;
  @enumerated
  final Gender gender;
  final String origin;
  final String location;
  final String created;
  final bool isFavorite;
}
