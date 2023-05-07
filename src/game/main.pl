:- module(game, [
  save_game/1,
  load_saved_game/1,
  num_strategies/3
]).
:- reexport([parse, 'mkbsc/main']).

%% saves all expansions of a game to a file
% in `games/cache`
save_game(G) :-
  format(atom(File), 'games/cache/~a.pl', [G]),
  open(File, write, Stream),
  % game terms
  forall(
    game(G, K, T),
    (
      write(Stream, game(G, K, T)),
      writeln(Stream, '.')
    )
  ),
  % location pointers
  forall(
    location_pointer(G, L, P),
    (
      write(Stream, location_pointer(G, L, P)),
      writeln(Stream, '.')
    )
  ),
  close(Stream).

%% loads a save of a game
load_saved_game(G) :-
  format(atom(File), 'games/cache/~a.pl', [G]),
  see(File),
  repeat,
  read(Term),
  (
    Term == end_of_file -> !;
    assertz(Term),
    fail
  ),
  seen.


% number of strategies possible for a game
% M = memory usage per location
num_strategies(G, K, M) :-
  setofall(
    L-Act,
    game(G, K, transition(L, Act, _)),
    Ls
  ),
  group_pairs_by_keys(Ls, Ls1).




