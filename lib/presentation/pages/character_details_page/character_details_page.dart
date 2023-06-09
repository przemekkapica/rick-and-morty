import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:rick_and_morty/domain/characters/model/character.f.dart';
import 'package:rick_and_morty/domain/characters/model/gender.dart';
import 'package:rick_and_morty/domain/characters/model/status.dart';
import 'package:rick_and_morty/presentation/extensions/string_extension.dart';

class CharacterDetailsPage extends StatefulWidget {
  const CharacterDetailsPage({
    required this.character,
    super.key,
  });

  final Character character;

  @override
  State<CharacterDetailsPage> createState() => _CharacterDetailsPageState();
}

class _CharacterDetailsPageState extends State<CharacterDetailsPage> {
  @override
  Widget build(BuildContext context) {
    final Character character = widget.character;

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Hero(
                tag: 'character-image${character.id.toString()}',
                child: Image.network(
                  character.image.toString(),
                  width: 260,
                  height: 260,
                ),
              ),
            ),
            const Gap(16),
            Text(
              character.name,
              style: Theme.of(context)
                  .textTheme
                  .displaySmall
                  ?.copyWith(fontWeight: FontWeight.bold),
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
        ),
      ),
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
