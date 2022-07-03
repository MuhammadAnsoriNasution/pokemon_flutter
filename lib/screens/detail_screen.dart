import 'package:flutter/material.dart';
import 'package:pokemon_flutter/models/pokemon_model.dart';
import 'package:pokemon_flutter/provider/pokemon_provider.dart';
import 'package:provider/provider.dart';

class DetailScreen extends StatefulWidget {
  final PokemonModel pokemon;
  const DetailScreen({Key? key, required this.pokemon}) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<PokemonProvider>(
      context,
      listen: false,
    ).getPokemon(
      widget.pokemon.id,
    );
  }

  @override
  Widget build(BuildContext context) {
    PokemonProvider pokemonProvider = Provider.of(context);

    return Scaffold(
        appBar: AppBar(
          title: Text(widget.pokemon.name),
          centerTitle: true,
        ),
        body: Container(
          width: double.infinity,
          child: Column(
            children: [
              Image.network(
                'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/${widget.pokemon.id}.png',
                width: 150,
                height: 150,
                fit: BoxFit.contain,
              ),
              ElevatedButton(
                onPressed: () {
                  pokemonProvider.addOrRemoveFavorite(widget.pokemon.id);
                },
                child: Text(pokemonProvider.pokemons
                        .firstWhere(
                            (element) => element.id == widget.pokemon.id)
                        .favorite
                    ? "Remove Favorite"
                    : "Add Favorite"),
              ),
              Text('Name: ${widget.pokemon.name}'),
              Text(
                  'Base Experience: ${pokemonProvider.pokemon.baseExperience}'),
              Text('Height: ${pokemonProvider.pokemon.height}'),
            ],
          ),
        ));
  }
}
