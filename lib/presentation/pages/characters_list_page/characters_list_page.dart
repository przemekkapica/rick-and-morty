import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';
import 'package:rick_and_morty/core/di/di_config.dart';
import 'package:rick_and_morty/domain/characters/model/character.f.dart';
import 'package:rick_and_morty/presentation/pages/characters_list_page/widgets/filter_characters_bottom_sheet.dart';
import 'package:rick_and_morty/presentation/router/go_router.dart';
import 'package:rick_and_morty/presentation/stores/characters_list_store.dart';
import 'package:rick_and_morty/presentation/stores/filter_characters_store.dart';
import 'package:rick_and_morty/presentation/widgets/characters_list.dart';

import 'widgets/paginator.dart';

class CharactersListPage extends StatefulWidget {
  const CharactersListPage({super.key});

  @override
  State<CharactersListPage> createState() => _CharactersListPageState();
}

class _CharactersListPageState extends State<CharactersListPage> {
  final CharactersListStore charactersListStore = getIt<CharactersListStore>();
  final FilterCharactersStore filterCharactersStore =
      getIt<FilterCharactersStore>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    charactersListStore.fetchCharacters(
      null,
      null,
      filterCharactersStore.filter,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const _AppBar(),
      floatingActionButton: _FloatingActionButton(
        charactersListStore: charactersListStore,
        filterCharactersStore: filterCharactersStore,
      ),
      body: Center(
        child: Observer(
          builder: (context) {
            switch (charactersListStore.state) {
              case CharactersListState.empty:
                return const Text('The library is empty');
              case CharactersListState.loading:
                return const CircularProgressIndicator();
              case CharactersListState.idle:
                return _Idle(
                  charactersListStore: charactersListStore,
                  filterCharactersStore: filterCharactersStore,
                  characters: charactersListStore.characters,
                );
              case CharactersListState.error:
                return const Text('Something went wrong');
            }
          },
        ),
      ),
    );
  }
}

class _Idle extends StatelessWidget {
  const _Idle({
    required this.charactersListStore,
    required this.filterCharactersStore,
    required this.characters,
  });

  final CharactersListStore charactersListStore;
  final FilterCharactersStore filterCharactersStore;
  final List<Character> characters;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Expanded(
            child: CharactersList(
              characters: characters,
              onFavoritesTap: charactersListStore.addToFavorites,
            ),
          ),
          Center(
            child: Paginator(
              charactersListStore: charactersListStore,
              filterCharactersStore: filterCharactersStore,
            ),
          ),
        ],
      ),
    );
  }
}

class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  const _AppBar();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Image.asset(
        'assets/images/rick_and_morty_logo.png',
        height: 80,
      ),
      backgroundColor: Theme.of(context).primaryColor,
      actions: [
        IconButton(
          onPressed: () => context.push(favoritesPageRoute.path),
          icon: const Icon(
            Icons.favorite,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _FloatingActionButton extends StatelessWidget {
  const _FloatingActionButton({
    required this.charactersListStore,
    required this.filterCharactersStore,
  });

  final CharactersListStore charactersListStore;
  final FilterCharactersStore filterCharactersStore;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showModalBottomSheet<void>(
          context: context,
          isScrollControlled: true,
          builder: (BuildContext context) {
            return FilterCharactersBottomSheet(
              charactersListStore: charactersListStore,
              filterCharactersStore: filterCharactersStore,
            );
          },
        );
      },
      child: const Icon(Icons.filter_alt),
    );
  }
}
