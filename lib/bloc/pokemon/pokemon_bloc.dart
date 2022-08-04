import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:ex_unit_testing_bloc/model/pokemon_listing_response.dart';
import 'package:ex_unit_testing_bloc/repository/repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'pokemon_event.dart';

part 'pokemon_state.dart';

class PokemonBloc extends Bloc<PokemonEvent, PokemonState> {
  final PokemonRepository pokemonRepository;

  PokemonBloc({required this.pokemonRepository}) : super(PokemonInitial()) {
    on<PokemonInitEvent>(_onPokemonInitEvent);
    on<PokemonRefreshEvent>(_onPokemonRefreshEvent);
  }

  Future<void> _onPokemonInitEvent(PokemonInitEvent event, emit) async {
    try {
      emit(PokemonLoading());
      final pokemonResponse = await pokemonRepository.getListPokemonGenI();
      final listPokemon = pokemonResponse.listPokemon;

      if (listPokemon.isEmpty) {
        return emit(PokemonEmpty());
      }

      return emit(PokemonData(pokemonResponse: pokemonResponse));
    } catch (e) {
      return emit(PokemonError(error: e.toString()));
    }
  }

  Future<void> _onPokemonRefreshEvent(PokemonRefreshEvent event, emit) async {
    final currentState = state;
    if (currentState is PokemonData) {
      try {
        emit(PokemonLoading());
        final pokemonResponse = await pokemonRepository.getListPokemonGenI();
        final listPokemon = pokemonResponse.listPokemon;

        if (listPokemon.isEmpty) {
          return emit(PokemonEmpty());
        }

        return emit(PokemonData(pokemonResponse: pokemonResponse));
      } catch (_) {
        return emit(PokemonData(pokemonResponse: currentState.pokemonResponse));
      }
    }
  }
}
