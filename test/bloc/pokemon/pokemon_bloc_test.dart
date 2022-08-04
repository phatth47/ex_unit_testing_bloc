import 'package:bloc_test/bloc_test.dart';
import 'package:ex_unit_testing_bloc/bloc/pokemon/pokemon_bloc.dart';
import 'package:ex_unit_testing_bloc/model/pokemon.dart';
import 'package:ex_unit_testing_bloc/model/pokemon_listing_response.dart';
import 'package:ex_unit_testing_bloc/repository/repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'pokemon_bloc_test.mocks.dart';

@GenerateMocks([PokemonRepository])
void main() {
  final PokemonListingResponse pokemonResponseData = PokemonListingResponse(
    id: '1',
    name: 'Kanto',
    listPokemon: [
      PokemonModel(
        id: '01',
        name: 'Charizard',
        height: '10',
        weight: '10',
        imageUrl: 'imageUrl',
      ),
    ],
  );

  final PokemonListingResponse pokemonResponseEmpty = PokemonListingResponse(
    id: '1',
    name: 'Kanto',
    listPokemon: [],
  );
  group('PokemonBloc', () {
    late MockPokemonRepository pokemonRepository;

    setUp(() {
      pokemonRepository = MockPokemonRepository();
    });

    PokemonBloc buildBloc() {
      return PokemonBloc(pokemonRepository: pokemonRepository);
    }

    group('Constructor', () {
      test('Works properly', () {
        expect(buildBloc, returnsNormally);
      });

      test('Has correct initial state', () {
        expect(
          buildBloc().state,
          equals(PokemonInitial()),
        );
      });
    });

    group('Fetch Pokemon Data Successful', () {
      blocTest<PokemonBloc, PokemonState>(
        'emit [PokemonLoading, PokemonData] when pokemonRepository returns pokemonResponse',
        build: buildBloc,
        setUp: (() {
          when(pokemonRepository.getListPokemonGenI()).thenAnswer(
            (_) {
              return Future.value(pokemonResponseData);
            },
          );
        }),
        act: (bloc) => bloc.add(PokemonInitEvent()),
        expect: () => [
          PokemonLoading(),
          PokemonData(pokemonResponse: pokemonResponseData),
        ],
      );
    });

    group('Fetch Pokemon Data Empty', () {
      blocTest<PokemonBloc, PokemonState>(
        'emit [PokemonLoading, PokemonEmpty] when pokemonRepository returns pokemonResponse.listPokemon is empty',
        build: buildBloc,
        setUp: (() {
          when(pokemonRepository.getListPokemonGenI()).thenAnswer(
            (_) {
              return Future.value(pokemonResponseEmpty);
            },
          );
        }),
        act: (bloc) => bloc.add(PokemonInitEvent()),
        expect: () => [
          PokemonLoading(),
          PokemonEmpty(),
        ],
      );
    });

    group('Fetch Pokemon Error', () {
      blocTest<PokemonBloc, PokemonState>(
        'emit [PokemonLoading, Error] when pokemonRepository returns Error',
        build: buildBloc,
        setUp: (() {
          when(pokemonRepository.getListPokemonGenI())
              .thenThrow(Exception('oops'));
        }),
        act: (bloc) => bloc.add(PokemonInitEvent()),
        expect: () => [
          PokemonLoading(),
          const PokemonError(error: 'oops'),
        ],
      );
    });
  });
}