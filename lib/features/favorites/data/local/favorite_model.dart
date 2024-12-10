class FavoriteModel{
  final String id;
  final String name;
  final String origin;
  final int energyLevel;
  final String description;
  final String referenceImageId;
  final String temperament;
  final int intelligence;

  FavoriteModel({
    required this.id,
    required this.name,
    required this.origin,
    required this.energyLevel,
    required this.description,
    required this.referenceImageId,
    required this.temperament,
    required this.intelligence,
  });

  factory FavoriteModel.fromMap(Map<String,dynamic>json){
    return FavoriteModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      origin: json['origin'] ?? '',
      energyLevel: json['energy_level'] ?? 0,
      description: json['description'] ?? '',
      referenceImageId: json['reference_image_id'] ?? '',
      temperament: json['temperament'] ?? '',
      intelligence: json['intelligence'] ?? 0,
    );
  }

  Map<String,dynamic>toMap(){
    return{
      'id':id,
      'name':name,
      'origin':origin,
      'energy_level':energyLevel,
      'description':description,
      'reference_image_id':referenceImageId,
      'temperament':temperament,
      'intelligence':intelligence,
    };
  }


}