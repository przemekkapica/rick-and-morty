import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:rick_and_morty/core/di/di_config.dart';
import 'package:rick_and_morty/domain/characters/model/character.f.dart';
import 'package:rick_and_morty/presentation/stores/favorites_store.dart';
import 'package:rick_and_morty/presentation/widgets/characters_list.dart';

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
      child: CharactersList(
        characters: favorites,
        onFavoritesTap: favoritesStore.removeFromFavorites,
      ),
    );
  }
}
