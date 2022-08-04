class PokemonModel {
  String id;
  String name;
  String height;
  String weight;
  String imageUrl;

  PokemonModel({
    required this.id,
    required this.name,
    required this.height,
    required this.weight,
    required this.imageUrl,
  });

  factory PokemonModel.fromJson(Map<String, dynamic> json) {
    return PokemonModel(
      id: json['id'] as String,
      name: json['name'] as String,
      height: json['height'] as String,
      weight: json['weight'] as String,
      imageUrl: json['imageurl'] as String,
    );
  }

  getId(){
    return int.parse(id.substring(1,id.length));
  }
}
