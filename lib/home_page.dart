import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'pokemon_provider.dart';
import 'pokemon_service.dart';

class HomePage extends StatefulWidget {
  final String title;

  const HomePage({super.key, required this.title});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late PokemonCard firstPokemon;
  late PokemonCard secondPokemon;

  @override
  void initState() {
    super.initState();
    _loadRandomPokemons();
  }

  void _loadRandomPokemons() {
    final provider = Provider.of<PokemonProvider>(context, listen: false);
    final random = Random();
    setState(() {
      firstPokemon = provider.pokemonCards[random.nextInt(provider.pokemonCards.length)];
      secondPokemon = provider.pokemonCards[random.nextInt(provider.pokemonCards.length)];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          '${firstPokemon.name} (${firstPokemon.hp}) vs ${secondPokemon.name} (${secondPokemon.hp})',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg.png'),
            fit: BoxFit.cover,
            alignment: Alignment.center,
          ),
        ),
        child: Consumer<PokemonProvider>(
          builder: (context, provider, child) {
            if (provider.pokemonCards.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }

            final firstPokemonHp = int.tryParse(firstPokemon.hp) ?? 0;
            final secondPokemonHp = int.tryParse(secondPokemon.hp) ?? 0;
            final isDraw = firstPokemonHp == secondPokemonHp;
            final isFirstPokemonWinner = firstPokemonHp > secondPokemonHp;

            return GestureDetector(
              onDoubleTap: _loadRandomPokemons,
              child: Center(
                child: GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  children: [
                    Image.network(
                      firstPokemon.imageUrl,
                      fit: BoxFit.contain,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Image(
                        image: isDraw
                            ? const AssetImage('assets/images/draw.png')
                            : isFirstPokemonWinner
                            ? const AssetImage('assets/images/winner1.png')
                            : const AssetImage('assets/images/loser1.png'),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Image(
                        image: isDraw
                            ? const AssetImage('assets/images/draw.png')
                            : isFirstPokemonWinner
                            ? const AssetImage('assets/images/loser2.png')
                            : const AssetImage('assets/images/winner2.png'),
                      ),
                    ),
                    Image.network(
                      secondPokemon.imageUrl,
                      fit: BoxFit.contain,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}