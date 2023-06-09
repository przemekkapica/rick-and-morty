import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:rick_and_morty/domain/characters/model/character.f.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.character.name,
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(color: Colors.white),
        ),
        // backgroundColor: Theme.of(context).primaryColorDark,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Hero(
                tag: 'character-image${widget.character.id}',
                child: Image.network(
                  widget.character.image.toString(),
                  width: 260,
                  height: 260,
                ),
              ),
            ),
            const Gap(16),
            Text(widget.character.name)
          ],
        ),
      ),
    );
  }
}
