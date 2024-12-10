class Cat{
  final String id;
  final String name;
  final String origin;
  final int energyLevel;
  final String description;
  final String referenceImageId;
  final String temperament;
  final int intelligence;

  Cat({
    required this.id,
    required this.name,
    required this.origin,
    required this.energyLevel,
    required this.description,
    required this.referenceImageId,
    required this.temperament,
    required this.intelligence,
  });

  Map<String,dynamic>toMap(){
    return {
      'id':id,
      'name':name,
      'origin':origin,
      'energyLevel':energyLevel,
      'description':description,
      'referenceImageId':referenceImageId,
      'temperament':temperament,
      'intelligence':intelligence,
    };
  }

  factory Cat.fromMap(Map<String,dynamic> map){
    return Cat(
      id: map['id'],
      name: map['name'],
      origin: map['origin'],
      energyLevel: map['energyLevel'],
      description: map['description'],
      referenceImageId: map['referenceImageId'],
      temperament: map['temperament'],
      intelligence: map['intelligence'],
    );
  }
}

class CatImage{
  final String id;
  final String url;
  final int width;
  final int height;

  CatImage({
    required this.id,
    required this.url,
    required this.width,
    required this.height,
  });

  Map<String,dynamic>toMap(){
    return {
      'id':id,
      'url':url,
      'width':width,
      'height':height,
    };
  }

  factory CatImage.fromMap(Map<String,dynamic> map){
    return CatImage(
      id: map['id'],
      url: map['url'],
      width: map['width'],
      height: map['height'],
    );
  }
}