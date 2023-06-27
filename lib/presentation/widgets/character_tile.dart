import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:rick_and_morty/domain/characters/model/base_character.dart';
import 'package:rick_and_morty/domain/characters/model/status.dart';
import 'package:rick_and_morty/presentation/router/go_router.dart';

class CharacterTile extends StatelessWidget {
  const CharacterTile({
    required this.onFavoritesTap,
    required this.character,
    super.key,
  });

  final BaseCharacter character;
  final Function(BaseCharacter) onFavoritesTap;

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
            key: ValueKey(character.id),
            onPressed: () => onFavoritesTap(character),
            icon: Icon(
              character.isFavorite
                  ? Icons.favorite
                  : Icons.favorite_border_outlined,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _onCharacterTileTap(BuildContext context) {
    return context.pushNamed(
      characterDetailsPageRoute.name!,
      pathParameters: {'id': character.id.toString()},
      extra: character,
    );
  }
}

class _CharacterAvatar extends StatelessWidget {
  const _CharacterAvatar({required this.character});

  final BaseCharacter character;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'character-image${character.id.toString()}',
      child: CachedNetworkImage(
        imageUrl: character.image.toString(),
        imageBuilder: (_, imageProvider) => Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
          ),
        ),
        placeholder: (context, url) => const CircularProgressIndicator(),
        errorWidget: (context, url, error) => const SizedBox(
          width: 64,
          height: 64,
          child: Center(
            child: Icon(
              Icons.error,
              size: 30,
            ),
          ),
        ),
      ),
    );
  }
}

class _CharacterInfo extends StatelessWidget {
  const _CharacterInfo({required this.character});

  final BaseCharacter character;

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
          _CharacterStatusInfo(character: character),
          _CharacterSpeciesInfo(character: character),
        ],
      ),
    );
  }
}

class _CharacterSpeciesInfo extends StatelessWidget {
  const _CharacterSpeciesInfo({
    required this.character,
  });

  final BaseCharacter character;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: 'Species: ',
        style:
            Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey),
        children: [
          TextSpan(
            text: character.species,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}

class _CharacterStatusInfo extends StatelessWidget {
  const _CharacterStatusInfo({
    required this.character,
  });

  final BaseCharacter character;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: 'Status: ',
        style:
            Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey),
        children: [
          TextSpan(
            text: character.status.value,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}
