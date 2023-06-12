import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:group_button/group_button.dart';
import 'package:rick_and_morty/domain/characters/model/gender.dart';
import 'package:rick_and_morty/domain/characters/model/status.dart';
import 'package:rick_and_morty/presentation/stores/characters_list_store.dart';
import 'package:rick_and_morty/presentation/stores/filter_characters_store.dart';

class FilterCharactersBottomSheet extends StatelessWidget {
  const FilterCharactersBottomSheet({
    required this.charactersListStore,
    required this.filterCharactersStore,
    super.key,
  });

  final CharactersListStore charactersListStore;
  final FilterCharactersStore filterCharactersStore;

  @override
  Widget build(BuildContext context) {
    final genderController = GroupButtonController();
    final statusController = GroupButtonController();

    _preselectGroupButtons(genderController, statusController);

    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.only(
          top: 24.0,
          left: 24.0,
          right: 24.0,
          bottom: MediaQuery.of(context).viewInsets.bottom + 24.0,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'Filter characters',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontWeight: FontWeight.w500),
              ),
              const Gap(16),
              TextFormField(
                initialValue: filterCharactersStore.name,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  hintText: 'Name',
                ),
                onChanged: (value) => filterCharactersStore.setName(value),
              ),
              const Gap(8),
              TextFormField(
                initialValue: filterCharactersStore.species,
                decoration: const InputDecoration(
                  labelText: 'Species',
                  hintText: 'Species',
                ),
                onChanged: (value) => filterCharactersStore.setSpecies(value),
              ),
              const Gap(24),
              _CharacterStatusSection(
                statusController: statusController,
                filterCharactersStore: filterCharactersStore,
              ),
              const Gap(16),
              _CharacterGenderSection(
                genderController: genderController,
                filterCharactersStore: filterCharactersStore,
              ),
              const Gap(24),
              _SubmitFiltersButton(
                charactersListStore: charactersListStore,
                filterCharactersStore: filterCharactersStore,
              )
            ],
          ),
        ),
      ),
    );
  }

  void _preselectGroupButtons(GroupButtonController genderController,
      GroupButtonController statusController) {
    if (filterCharactersStore.gender != null) {
      genderController
          .selectIndex(Gender.values.indexOf(filterCharactersStore.gender!));
    }
    if (filterCharactersStore.status != null) {
      statusController
          .selectIndex(Status.values.indexOf(filterCharactersStore.status!));
    }
  }
}

class _CharacterGenderSection extends StatelessWidget {
  const _CharacterGenderSection({
    required this.genderController,
    required this.filterCharactersStore,
  });

  final GroupButtonController genderController;
  final FilterCharactersStore filterCharactersStore;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Gender',
          style: Theme.of(context)
              .textTheme
              .labelMedium
              ?.copyWith(color: Colors.grey),
        ),
        GroupButton<Gender>(
          controller: genderController,
          options: const GroupButtonOptions(
            mainGroupAlignment: MainGroupAlignment.start,
          ),
          enableDeselect: true,
          onSelected: (gender, index, selected) =>
              filterCharactersStore.setGender(gender, selected),
          buttons: Gender.values,
          buttonTextBuilder: (selected, value, context) => value.value,
        ),
      ],
    );
  }
}

class _CharacterStatusSection extends StatelessWidget {
  const _CharacterStatusSection({
    required this.statusController,
    required this.filterCharactersStore,
  });

  final GroupButtonController statusController;
  final FilterCharactersStore filterCharactersStore;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Status',
          style: Theme.of(context)
              .textTheme
              .labelMedium
              ?.copyWith(color: Colors.grey),
        ),
        GroupButton<Status>(
          controller: statusController,
          enableDeselect: true,
          onSelected: (status, index, selected) =>
              filterCharactersStore.setStatus(status, selected),
          buttons: Status.values,
          buttonTextBuilder: (selected, value, context) => value.value,
        ),
      ],
    );
  }
}

class _SubmitFiltersButton extends StatelessWidget {
  const _SubmitFiltersButton({
    required this.charactersListStore,
    required this.filterCharactersStore,
  });

  final CharactersListStore charactersListStore;
  final FilterCharactersStore filterCharactersStore;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).primaryColor),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: Text(
            'Filter',
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(color: Colors.white),
          ),
        ),
        onPressed: () {
          charactersListStore.fetchCharacters(
            1,
            null,
            filterCharactersStore.filter,
          );
          Navigator.of(context).pop();
        },
      ),
    );
  }
}
