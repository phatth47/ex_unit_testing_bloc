import 'package:ex_unit_testing_bloc/bloc/pokemon/pokemon_bloc.dart';
import 'package:ex_unit_testing_bloc/model/pokemon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PokemonScreen extends StatefulWidget {
  const PokemonScreen({Key? key}) : super(key: key);

  @override
  State<PokemonScreen> createState() => _PokemonScreenState();
}

class _PokemonScreenState extends State<PokemonScreen> {
  late PokemonBloc pokemonBloc;

  @override
  void initState() {
    super.initState();
    pokemonBloc = PokemonBloc();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => pokemonBloc..add(PokemonInitEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Pokemon'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: BlocBuilder<PokemonBloc, PokemonState>(
            builder: (context, state) {
              if (state is PokemonLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state is PokemonEmpty) {
                return const Center(
                  child: Text('Empty Data'),
                );
              }

              if (state is PokemonError) {
                return const Center(
                  child: Text('Something went wrong'),
                );
              }

              if (state is PokemonData) {
                final listPokemon = state.pokemonResponse.listPokemon;
                return PokemonListingWidget(listPokemon: listPokemon);
              }

              return Container();
            },
          ),
        ),
      ),
    );
  }
}

class PokemonListingWidget extends StatelessWidget {
  final List<PokemonModel> listPokemon;

  const PokemonListingWidget({
    Key? key,
    required this.listPokemon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (_, index) => Text(listPokemon[index].name),
      separatorBuilder: (_, index) => const Divider(),
      itemCount: listPokemon.length,
    );
  }
}
