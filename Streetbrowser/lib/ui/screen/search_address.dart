import 'package:flutter/material.dart';
import '../../model/address.dart'; // Assurez-vous que le chemin d'accès est correct
import '../../repositories/address_repository.dart'; // Assurez-vous que le chemin d'accès est correct

class SearchAddress extends StatefulWidget {
  const SearchAddress({Key? key}) : super(key: key);

  @override
  State<SearchAddress> createState() => _SearchAddressState();
}

class _SearchAddressState extends State<SearchAddress> {
  final TextEditingController _searchController = TextEditingController();
  final AddressRepository _addressRepository = AddressRepository();

  List<Address> _addresses = []; // Liste d'adresses pour l'affichage

  void _updateAddressesList(String query) async {
    if (query.isNotEmpty) {
      final addresses = await _addressRepository.fetchAddresses(query);
      setState(() {
        _addresses = addresses;
      });
    } else {
      setState(() {
        _addresses = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rechercher une Adresse'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Recherchez une adresse',
                suffixIcon: Icon(Icons.search),
              ),
              onChanged: _updateAddressesList, // Appelé à chaque changement de texte
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _addresses.length,
              itemBuilder: (context, index) {
                final address = _addresses[index];
                return ListTile(
                  onTap: () {
                    Navigator.pop(context, address);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
