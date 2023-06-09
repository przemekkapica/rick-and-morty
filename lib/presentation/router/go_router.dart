import 'package:go_router/go_router.dart';
import 'package:rick_and_morty/domain/characters/model/character.f.dart';
import 'package:rick_and_morty/presentation/pages/character_details_page.dart';
import 'package:rick_and_morty/presentation/pages/characters_list_page/characters_list_page.dart';

GoRouter goRouter() {
  return GoRouter(
    routes: [
      charactersListPageRoute,
      characterDetailsPageRoute,
    ],
  );
}

final charactersListPageRoute = GoRoute(
  path: '/',
  builder: (_, __) => const CharactersListPage(),
);

final characterDetailsPageRoute = GoRoute(
  path: '/details/:id',
  name: 'characterDetails',
  builder: (_, state) => CharacterDetailsPage(
    character: state.extra as Character,
  ),
);
