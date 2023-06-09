import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:rick_and_morty/core/di/di_config.dart';
import 'package:rick_and_morty/domain/characters/model/character.f.dart';
import 'package:rick_and_morty/domain/characters/model/status.dart';
import 'package:rick_and_morty/presentation/pages/characters_list_page/widgets/filter_characters_bottom_sheet.dart';
import 'package:rick_and_morty/presentation/router/go_router.dart';
import 'package:rick_and_morty/presentation/stores/characters_list_store.dart';
import 'package:rick_and_morty/presentation/stores/filter_characters_store.dart';

class CharactersListPage extends StatefulWidget {
  const CharactersListPage({super.key});

  @override
  State<CharactersListPage> createState() => _CharactersListPageState();
}

class _CharactersListPageState extends State<CharactersListPage> {
  final CharactersListStore _charactersListStore = getIt<CharactersListStore>();
  final FilterCharactersStore _filterCharactersStore =
      getIt<FilterCharactersStore>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _charactersListStore.fetchCharacters(null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Rick and Morty characters library',
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(color: Colors.white),
        ),
        centerTitle: false,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      floatingActionButton: _FloatingActionButton(
        charactersListStore: _charactersListStore,
        filterCharactersStore: _filterCharactersStore,
      ),
      body: Center(
        child: Observer(
          builder: (context) {
            switch (_charactersListStore.state) {
              case CharactersListState.empty:
                return const Text('The library is empty');
              case CharactersListState.loading:
                return const CircularProgressIndicator();
              case CharactersListState.idle:
                return _Idle(
                  characters: _charactersListStore.characters,
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

class _Idle extends StatelessWidget {
  const _Idle({required this.characters});

  final List<Character> characters;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          return _CharacterTile(
            character: characters[index],
          );
        },
        itemCount: characters.length,
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
      pathParameters: {'id': character.id},
      extra: character,
    );
  }
}
