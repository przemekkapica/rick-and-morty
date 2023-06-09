import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:rick_and_morty/core/di/di_config.dart';
import 'package:rick_and_morty/domain/characters/model/character.f.dart';
import 'package:rick_and_morty/domain/characters/model/status.dart';
import 'package:rick_and_morty/presentation/router/go_router.dart';
import 'package:rick_and_morty/presentation/stores/favorites_store.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  final FavoritesStore favoritesStore = getIt<FavoritesStore>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    favoritesStore.fetchFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          'Favorites',
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(color: Colors.white),
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Center(
        child: Observer(
          builder: (context) {
            return _Idle(
              favorites: favoritesStore.favorites,
              favoritesStore: favoritesStore,
            );
          },
        ),
      ),
    );
  }
}

class _Idle extends StatelessWidget {
  const _Idle({
    required this.favoritesStore,
    required this.favorites,
  });

  final FavoritesStore favoritesStore;
  final List<Character> favorites;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          return _CharacterTile(
            character: favorites[index],
          );
        },
        itemCount: favorites.length,
        separatorBuilder: (BuildContext context, int index) {
          return const Column(
            children: [Gap(4), Divider(), Gap(4)],
          );
        },
      ),
    );
  }
}

class _CharacterTile extends StatelessWidget {
  const _CharacterTile({
    required this.character,
  });

  final Character character;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _onCharacterTileTap(context),
      child: Row(
        children: [
          Hero(
            tag: 'character-image${character.id}',
            child: Image.network(
              character.image.toString(),
              width: 64,
              height: 64,
            ),
          ),
          const Gap(16),
          Flexible(
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
          )
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
