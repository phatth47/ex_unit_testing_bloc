import 'package:ex_unit_testing_bloc/model/pokemon.dart';

class PokemonListingResponse {
  String id;
  String name;
  List<PokemonModel> listPokemon;

  PokemonListingResponse({
    required this.id,
    required this.name,
    required this.listPokemon,
  });

  factory PokemonListingResponse.fromJson(Map<String, dynamic> json) {
    return PokemonListingResponse(
      id: json['id'],
      name: json['name'],
      listPokemon: (json['pokemons'] as List)
          .map((e) => PokemonModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
