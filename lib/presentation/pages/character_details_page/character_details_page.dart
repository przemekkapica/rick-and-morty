import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:gap/gap.dart';
import 'package:rick_and_morty/core/di/di_config.dart';
import 'package:rick_and_morty/domain/characters/model/base_character.dart';
import 'package:rick_and_morty/domain/characters/model/character.f.dart';
import 'package:rick_and_morty/domain/characters/model/gender.dart';
import 'package:rick_and_morty/domain/characters/model/status.dart';
import 'package:rick_and_morty/presentation/extensions/string_extension.dart';
import 'package:rick_and_morty/presentation/stores/character_details_store.dart';

class CharacterDetailsPage extends StatefulWidget {
  const CharacterDetailsPage({
    required this.character,
    super.key,
  });

  final BaseCharacter character;

  @override
  State<CharacterDetailsPage> createState() => _CharacterDetailsPageState();
}

class _CharacterDetailsPageState extends State<CharacterDetailsPage> {
  final CharacterDetailsStore characterDetailsStore =
      getIt<CharacterDetailsStore>();

  @override
  Widget build(BuildContext context) {
    final BaseCharacter character = widget.character;

    return Scaffold(
      appBar: const _AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Observer(
          builder: (context) {
            switch (characterDetailsStore.state) {
              case CharacterDetailsState.error:
                return const Text('Something went wrong');
              case CharacterDetailsState.idle:
                return _CharacterDetails(
                  characterDetailsStore: characterDetailsStore,
                  character: character,
                );
            }
          },
        ),
      ),
    );
  }
}

class _CharacterDetails extends StatelessWidget {
  const _CharacterDetails({
    required this.characterDetailsStore,
    required this.character,
  });

  final CharacterDetailsStore characterDetailsStore;
  final BaseCharacter character;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Hero(
            tag: 'character-image${character.id.toString()}',
            child: CachedNetworkImage(
              imageUrl: character.image.toString(),
              imageBuilder: (_, imageProvider) => Container(
                width: 260,
                height: 260,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),
        ),
        const Gap(16),
        _CharacterNameRow(
          character: character,
          characterDetailsStore: characterDetailsStore,
        ),
        const Gap(16),
        _DataRow(
          firstLabel: 'Status',
          firstValue: character.status.value,
          secondLabel: 'Species',
          secondValue: character.species,
        ),
        const Gap(16),
        _DataRow(
          firstLabel: 'Type',
          firstValue: character.type,
          secondLabel: 'Gender',
          secondValue: character.gender.value,
        ),
        const Gap(32),
        _DataField(
          label: 'Last seen in',
          value: character.location,
        ),
        const Gap(16),
        _DataField(
          label: 'Origin',
          value: character.origin,
        ),
      ],
    );
  }
}

class _CharacterNameRow extends StatelessWidget {
  const _CharacterNameRow({
    required this.character,
    required this.characterDetailsStore,
  });

  final BaseCharacter character;
  final CharacterDetailsStore characterDetailsStore;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            character.name,
            style: Theme.of(context)
                .textTheme
                .displaySmall
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        const Gap(8),
        IconButton(
          onPressed: () => characterDetailsStore.addToFavorites(character),
          icon: const Icon(Icons.favorite_border_outlined, size: 30),
        ),
      ],
    );
  }
}

class _DataRow extends StatelessWidget {
  const _DataRow({
    required this.firstLabel,
    required this.firstValue,
    required this.secondLabel,
    required this.secondValue,
  });

  final String firstLabel;
  final String firstValue;
  final String secondLabel;
  final String secondValue;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _DataField(
            label: firstLabel,
            value: firstValue,
          ),
        ),
        const Gap(8),
        Expanded(
          child: _DataField(
            label: secondLabel,
            value: secondValue,
          ),
        ),
      ],
    );
  }
}

class _DataField extends StatelessWidget {
  const _DataField({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context)
              .textTheme
              .labelMedium
              ?.copyWith(color: Colors.grey),
        ),
        Text(value.capitalize(),
            style: Theme.of(context).textTheme.titleMedium),
      ],
    );
  }
}

class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  const _AppBar();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: const IconThemeData(color: Colors.white),
      backgroundColor: Theme.of(context).primaryColor,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
