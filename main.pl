:- [lib/game].
:- [lib/visualize].
:- [lib/utils].

main :-
  Game = wagon_game,
  load_game(Game),
  create_expanded_game(Game, 5).
