import 'package:mysupercatapp/features/cats/domain/cat.dart';

class CatDto{
  final String id;
  final String name;
  final String origin;
  final int energyLevel;
  final String description;
  final String referenceImageId;
  final String temperament;
  final int intelligence;

  CatDto({
    required this.id,
    required this.name,
    required this.origin,
    required this.energyLevel,
    required this.description,
    required this.referenceImageId,
    required this.temperament,
    required this.intelligence,
  });

  factory CatDto.fromJson(Map<String, dynamic> json) {
    return CatDto(
      id: json['id']??'',
      name: json['name']??'',
      origin: json['origin']??'',
      energyLevel: json['energy_level']??0,
      description: json['description']??'',
      referenceImageId: json['reference_image_id']??'',
      temperament: json['temperament']??'',
      intelligence: json['intelligence']??0,
    );
  }

  Cat toCat(){
    return Cat(
      id: id,
      name: name,
      origin: origin,
      energyLevel: energyLevel,
      description: description,
      referenceImageId: referenceImageId,
      temperament: temperament,
      intelligence: intelligence,
    );
  }

}

class CatImageDto {
  final String id;
  final String url;
  final int width;
  final int height;

  CatImageDto({
    required this.id,
    required this.url,
    required this.width,
    required this.height,
  });

  factory CatImageDto.fromJson(Map<String, dynamic> json) {
    return CatImageDto(
      id: json['id'] as String,
      url: json['url'] as String,
      width: json['width'] as int,
      height: json['height'] as int,
    );
  }

  CatImage toCatImage() {
    return CatImage(
      id: id,
      url: url,
      width: width,
      height: height,
    );
  }
}
