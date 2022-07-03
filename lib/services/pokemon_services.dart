import 'package:pokemon_flutter/models/pokemon_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PokemonServices {
  String baseUrl = 'https://pokeapi.co/api/v2';

  Future<List<PokemonModel>> getPokemons() async {
    var url = Uri.parse('$baseUrl/pokemon');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      List data = jsonDecode(response.body)['results'];
      List<PokemonModel> pokemons = [];
      for (var item in data) {
        pokemons.add(PokemonModel.fromJson(item));
      }
      print('${pokemons} ini pokemons');
      return pokemons;
    }
    throw Exception("Gagal mengambil data pokemons");
  }

  Future<PokemonModel> getPokemon(int id) async {
    var url = Uri.parse('$baseUrl/pokemon/${id.toString()}');
    print(url);
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      PokemonModel pokemon = PokemonModel.fromJsonSingle(data);
      return pokemon;
    }
    throw Exception("Gagal mengambil data pokemon");
  }
}
