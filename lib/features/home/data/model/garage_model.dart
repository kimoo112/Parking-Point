class Garage {
  final int id;
  final String name;
  final String pictureUrl;
  final String locationUrl;
  final bool state;
  final double hourPrice;

  Garage({
    required this.id,
    required this.name,
    required this.pictureUrl,
    required this.locationUrl,
    required this.state,
    required this.hourPrice,
  });

  // Implement factory method to parse JSON
  factory Garage.fromJson(Map<String, dynamic> json) {
    return Garage(
      id: json['id'],
      name: json['name'],
      pictureUrl: json['pictureUrl'],
      locationUrl: json['locationUrl'],
      state: json['state'],
      hourPrice: json['hourPrice'].toDouble(),
    );
  }
}