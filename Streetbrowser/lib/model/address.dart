class Address {
  final String street;
  final String city;
  final String postcode;

  Address({ required this.street, required this.city, required this.postcode});

  factory Address.fromGeoJson(Map<String, dynamic> json) {
    final properties = json['properties'];
    return Address(
      street: properties['name'], // Ou 'street' si votre JSON a cette clé
      city: properties['city'],
      postcode: properties['postcode'],
    );
  }

  Map<String, dynamic> toJson() {
  return {
    'street': street,
    'city': city,
    'postcode': postcode,
  };
}
  factory Address.fromJson(Map<String, dynamic> json) {
  return Address(
     street :  json['street'],
     city : json['city'],
     postcode: json['postcode']
  );
  }

}
