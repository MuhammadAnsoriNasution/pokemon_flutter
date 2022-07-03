import 'package:flutter/material.dart';
import 'package:pokemon_flutter/models/pokemon_model.dart';
import 'package:pokemon_flutter/provider/pokemon_provider.dart';
import 'package:pokemon_flutter/screens/detail_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    getInit();
  }

  getInit() async {
    await Provider.of<PokemonProvider>(context, listen: false).getPokemons();
  }

  @override
  Widget build(BuildContext context) {
    PokemonProvider pokemonProvider = Provider.of<PokemonProvider>(context);

    Widget card(PokemonModel pokemon) {
      return Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailScreen(
                  pokemon: pokemon,
                ),
              ),
            );
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(pokemon.name),
              Image.network(
                'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/${pokemon.id}.png',
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              )
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 5, right: 5, top: 5),
        child: GridView.count(
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
          crossAxisCount: 2,
          children: pokemonProvider.pokemons
              .map((PokemonModel e) => card(e))
              .toList(),
        ),
      ),
    );
  }
}
