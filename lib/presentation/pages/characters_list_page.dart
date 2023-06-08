import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:rick_and_morty/core/di/di_config.dart';
import 'package:rick_and_morty/domain/characters/model/character.f.dart';
import 'package:rick_and_morty/domain/characters/model/characters_filter.f.dart';
import 'package:rick_and_morty/domain/characters/model/status.dart';
import 'package:rick_and_morty/presentation/router/go_router.dart';
import 'package:rick_and_morty/presentation/stores/characters_list_store.dart';

class CharactersListPage extends StatefulWidget {
  const CharactersListPage({super.key});

  @override
  State<CharactersListPage> createState() => _CharactersListPageState();
}

class _CharactersListPageState extends State<CharactersListPage> {
  late CharactersListStore _charactersListStore;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _charactersListStore = getIt<CharactersListStore>();

    _charactersListStore.fetchCharacters(1, null);
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(
          Icons.filter_alt,
        ),
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
