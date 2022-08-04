import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:ex_unit_testing_bloc/model/pokemon_listing_response.dart';

class PokemonRepository {
  final Dio dio = Dio();

  /// ---
  Future<PokemonListingResponse> getListPokemonGenI() async {
    try {
      var url = 'https://raw.githubusercontent.com/azkals47/pokedex/main/pokemons_gen_i.json';
      var response = await dio.get(url);
      await Future.delayed(const Duration(seconds: 2));
      final listPokemon = json.decode(response.data);
      return PokemonListingResponse.fromJson(listPokemon);
    } catch (e) {
      throw Exception('Failed to get data');
    }
  }
}