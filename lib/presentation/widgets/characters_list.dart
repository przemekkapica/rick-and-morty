import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:rick_and_morty/domain/characters/model/base_character.dart';
import 'package:rick_and_morty/presentation/widgets/character_tile.dart';

class CharactersList extends StatelessWidget {
  const CharactersList({
    required this.characters,
    required this.onFavoritesTap,
    super.key,
  });

  final List<BaseCharacter> characters;
  final Function(BaseCharacter) onFavoritesTap;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return CharacterTile(
          onFavoritesTap: onFavoritesTap,
          character: characters[index],
        );
      },
      itemCount: characters.length,
      separatorBuilder: (BuildContext context, int index) {
        return const Column(
          children: [Gap(4), Divider(), Gap(4)],
        );
      },
    );
  }
}
