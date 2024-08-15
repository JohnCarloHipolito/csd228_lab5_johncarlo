import 'package:flutter/material.dart';

import 'pokemon_service.dart';

class PokemonProvider with ChangeNotifier {
  List<PokemonCard> _pokemonCards = [];

  List<PokemonCard> get pokemonCards => _pokemonCards;

  Future<void> fetchPokemonIds() async {
    _pokemonCards = await fetchPokemonCards();
    notifyListeners();
  }
}