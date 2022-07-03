class PokemonModel {
  late int id;
  late String url;
  late String name;
  late int baseExperience;
  late int height;
  bool favorite = false;

  PokemonModel({
    required this.id,
    required this.url,
    required this.name,
    this.baseExperience = 0,
    this.height = 0,
    this.favorite = false,
  });

  PokemonModel.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['url']
        .split('https://pokeapi.co/api/v2/pokemon/')[1]
        .replaceFirst('/', ''));
    url = json['url'];
    name = json['name'];
  }

  PokemonModel.fromJsonSingle(Map<String, dynamic> json) {
    id = json['id'];
    url = json['sprites']['back_default'];
    name = json['name'];
    baseExperience = json['base_experience'];
    height = json['height'];
  }
}
