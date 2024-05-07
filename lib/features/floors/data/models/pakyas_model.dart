class Pakyas {
  int? id;
  String? name;
  String? pictureUrl;
  int? garageId;
  String? garage;

  Pakyas({
    this.id,
    this.name,
    this.pictureUrl,
    this.garageId,
    this.garage,
  });

  factory Pakyas.fromJson(Map<String, dynamic> json) => Pakyas(
        id: json['id'] as int?,
        name: json['name'] as String?,
        pictureUrl: json['pictureUrl'] as String?,
        garageId: json['garageId'] as int?,
        garage: json['garage'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'pictureUrl': pictureUrl,
        'garageId': garageId,
        'garage': garage,
      };
}
