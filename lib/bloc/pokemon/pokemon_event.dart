part of 'pokemon_bloc.dart';

abstract class PokemonEvent {
  const PokemonEvent();
}

class PokemonInitEvent extends PokemonEvent {}