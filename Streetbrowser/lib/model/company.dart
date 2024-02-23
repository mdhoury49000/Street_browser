import 'address.dart'; // Importation de la classe Address

class Company {
  final String name;
  final Address address; // Ajout de l'attribut address

  Company({required this.name, required this.address});

    Map<String, dynamic> toJson() {
  return {
    'name': name,
    'address': address,
  };
}
  factory Company.fromJson(Map<String, dynamic> json) {
  return Company(
     name :  json['name'],
     address : json['address'],
  );
  }

}
