import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/models.dart';

class PokemonProvider extends ChangeNotifier {
  final String _baseUrl = "pokeapi.co";

  List<Result> PokemonsOnList = [];

  PokemonProvider() {
    getPokemonsOnList();
  }

  final StreamController<PokemonDetailResponse> _suggestionStreamContoller =
      new StreamController.broadcast();
  Stream<PokemonDetailResponse> get suggestionStream =>
      this._suggestionStreamContoller.stream;

  getPokemonsOnList() async {
    final response = await http
        .get(Uri.parse("https://pokeapi.co/api/v2/pokemon/?offset=0&limit=30"));
    print(response.statusCode);
    final pokemonResultList = PokemonResponse.fromJson(response.body);

    pokemonResultList.results.forEach((element) {
      final split = element.url.split("/");
      final pokeId = split.getRange(0, 7);
      element.id = pokeId.last;

      print(element.id);
    });

    PokemonsOnList = pokemonResultList.results;

    print(PokemonsOnList);

    notifyListeners();
  }

  Future<PokemonDetailResponse> getPokemon(String movieId) async {
    final response =
        await http.get(Uri.parse("https://pokeapi.co/api/v2/pokemon/$movieId"));
    final pokemonResponse = PokemonDetailResponse.fromJson(response.body);

    return pokemonResponse;
  }

  Future<PokemonDetailResponse?> searchPokemon(String query) async {
    final response =
        await http.get(Uri.parse("https://pokeapi.co/api/v2/pokemon/$query"));

    try {
      final pokemonResponse = PokemonDetailResponse.fromJson(response.body);

      print(response.statusCode);

      return pokemonResponse;
    } catch (e) {
      return null;
    }
  }
}
