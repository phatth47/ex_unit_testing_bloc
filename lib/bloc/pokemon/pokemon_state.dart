part of 'pokemon_bloc.dart';

abstract class PokemonState extends Equatable {
  const PokemonState();

  @override
  List<Object> get props => [];
}

class PokemonInitial extends PokemonState {}

class PokemonLoading extends PokemonState {}

class PokemonEmpty extends PokemonState {}

class PokemonData extends PokemonState {
  final PokemonListingResponse pokemonResponse;

  const PokemonData({
    required this.pokemonResponse,
  });
}

class PokemonError extends PokemonState {
  final String error;

  const PokemonError({
    required this.error,
  });
}
