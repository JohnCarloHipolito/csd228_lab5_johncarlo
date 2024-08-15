import 'package:http/http.dart' as http;

import 'dart:convert';

Future<List<PokemonCard>> fetchPokemonCards() async {
  final response = await http.get(
    Uri.parse('https://api.pokemontcg.io/v2/cards?page=1&pageSize=20000'),
    headers: {'X-Api-Key': 'a453cc86-df08-439e-828e-cdebbc1f604f'},
  );

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    return (data['data'] as List).map((json) => PokemonCard.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load Pokémon cards');
  }
}

Future<PokemonCard> fetchPokemonCardById(String id, String size) async {
  final response = await http.get(
    Uri.parse('https://api.pokemontcg.io/v2/cards/$id'),
    headers: {'X-Api-Key': 'YOUR_API_KEY'},
  );

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    return PokemonCard.fromJson(data['data']);
  } else {
    throw Exception('Failed to load Pokémon card');
  }
}

class PokemonCard {
  final String id;
  final String name;
  final String hp;
  final String imageUrl;

  PokemonCard({required this.id, required this.name, required this.hp, required this.imageUrl});

  factory PokemonCard.fromJson(Map<String, dynamic> json) {
    return PokemonCard(
      id: json['id'],
      name: json['name'],
      hp: json['hp'],
      imageUrl: json['images']['small'],
    );
  }
}
