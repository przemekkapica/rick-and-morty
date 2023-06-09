import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:rick_and_morty/domain/characters/model/character.f.dart';
import 'package:rick_and_morty/domain/characters/model/status.dart';
import 'package:rick_and_morty/presentation/router/go_router.dart';

class CharacterTile extends StatelessWidget {
  const CharacterTile({
    required this.onFavoritesTap,
    required this.character,
    super.key,
  });

  final Character character;
  final Function(Character) onFavoritesTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _onCharacterTileTap(context),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _CharacterAvatar(character: character),
          const Gap(16),
          _CharacterInfo(character: character),
          const Gap(16),
          IconButton(
            onPressed: () => onFavoritesTap(character),
            icon: const Icon(Icons.favorite_border_outlined),
          ),
        ],
      ),
    );
  }

  Future<Object?> _onCharacterTileTap(BuildContext context) {
    return context.pushNamed(
      characterDetailsPageRoute.name!,
      pathParameters: {'id': character.id.toString()},
      extra: character,
    );
  }
}

class _CharacterAvatar extends StatelessWidget {
  const _CharacterAvatar({required this.character});

  final Character character;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'character-image${character.id.toString()}',
      child: Image.network(
        character.image.toString(),
        width: 64,
        height: 64,
      ),
    );
  }
}

class _CharacterInfo extends StatelessWidget {
  const _CharacterInfo({required this.character});

  final Character character;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            character.name,
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(fontWeight: FontWeight.bold),
            softWrap: true,
          ),
          const Gap(4),
          Text(
            'Status: ${character.status.value}',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          Text(
            'Species: ${character.species}',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}
