import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:ex_unit_testing_bloc/model/pokemon_listing_response.dart';
import 'package:ex_unit_testing_bloc/repository/repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'pokemon_event.dart';

part 'pokemon_state.dart';

class PokemonBloc extends Bloc<PokemonEvent, PokemonState> {
  final repository = PokemonRepository();

  PokemonBloc() : super(PokemonInitial()) {
    on<PokemonInitEvent>(_onPokemonInitEvent);
  }

  Future<void> _onPokemonInitEvent(PokemonInitEvent event, emit) async {
    try {
      emit(PokemonLoading());
      await Future.delayed(const Duration(seconds: 2));
      final pokemonResponse = await repository.getListPokemonGenI();
      final listPokemon = pokemonResponse.listPokemon;

      if (listPokemon.isEmpty) {
        return emit(PokemonEmpty());
      }

      return emit(PokemonData(pokemonResponse: pokemonResponse));
    } catch (e) {
      return emit(PokemonError(error: e.toString()));
    }
  }
}
