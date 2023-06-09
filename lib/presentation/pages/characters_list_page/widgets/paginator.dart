import 'package:flutter/material.dart';
import 'package:rick_and_morty/presentation/stores/characters_list_store.dart';
import 'package:rick_and_morty/presentation/stores/filter_characters_store.dart';

class Paginator extends StatelessWidget {
  const Paginator({
    required this.charactersListStore,
    required this.filterCharactersStore,
    super.key,
  });

  final CharactersListStore charactersListStore;
  final FilterCharactersStore filterCharactersStore;

  @override
  Widget build(BuildContext context) {
    final paginationInfo = charactersListStore.paginationInfo;

    final paginationLabel =
        'Page ${paginationInfo.currentPage}/${paginationInfo.totalPages}';
    final hasNextPage = paginationInfo.hasNext;
    final hasPreviousPage = paginationInfo.hasPrevious;
    final filter = filterCharactersStore.filter;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: hasPreviousPage
              ? () => charactersListStore.fetchCharacters(null, -1, filter)
              : null,
          icon: const Icon(Icons.chevron_left_rounded),
        ),
        Text(paginationLabel),
        IconButton(
          onPressed: hasNextPage
              ? () => charactersListStore.fetchCharacters(null, 1, filter)
              : null,
          icon: const Icon(Icons.chevron_right_rounded),
        ),
      ],
    );
  }
}
