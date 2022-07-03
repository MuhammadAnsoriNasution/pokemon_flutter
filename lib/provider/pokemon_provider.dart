import 'package:flutter/material.dart';
import 'package:pokemon_flutter/models/pokemon_model.dart';
import 'package:pokemon_flutter/services/pokemon_services.dart';

class PokemonProvider with ChangeNotifier {
  List<PokemonModel> _pokemons = [];
  List<PokemonModel> get pokemons => _pokemons;

  set pokemons(List<PokemonModel> pokemons) {
    _pokemons = pokemons;
    notifyListeners();
  }

  Future<void> getPokemons() async {
    try {
      List<PokemonModel> data = await PokemonServices().getPokemons();
      pokemons = data;
    } catch (e) {
      print(e);
    }
  }

  PokemonModel _pokemon = PokemonModel(id: 0, url: '', name: '');
  PokemonModel get pokemon => _pokemon;
  set pokemon(PokemonModel pokemon) {
    _pokemon = pokemon;
    notifyListeners();
  }

  Future<void> getPokemon(int id) async {
    try {
      PokemonModel data = await PokemonServices().getPokemon(id);
      // data.favorite =
      //     _pokemons.singleWhere((element) => element.id == id).favorite;
      pokemon = data;
    } catch (e) {
      print(e);
    }
  }

  addOrRemoveFavorite(int id) {
    pokemons = _pokemons.map((e) {
      if (id == e.id) {
        e.favorite = !e.favorite;
        return e;
      }
      return e;
    }).toList();
    notifyListeners();
  }
}
