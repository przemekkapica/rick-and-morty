import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:gap/gap.dart';
import 'package:rick_and_morty/core/di/di_config.dart';
import 'package:rick_and_morty/domain/characters/model/character.f.dart';
import 'package:rick_and_morty/domain/characters/model/status.dart';
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

    _charactersListStore.fetchCharacters();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Rick and Morty characters library',
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(color: Colors.white),
        ),
        backgroundColor: Theme.of(context).primaryColor,
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
  const _Idle({
    required this.characters,
  });

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
            children: [Gap(8), Divider(), Gap(8)],
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
    return Row(
      children: [
        Image.network(
          character.image.toString(),
          width: 64,
          height: 64,
        ),
        const Gap(16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              character.name,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
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
        )
      ],
    );
  }
}
