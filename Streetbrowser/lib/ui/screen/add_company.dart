import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../model/company.dart';
import '../../model/address.dart';
import 'search_address.dart';
import '../../blocs/company_cubit.dart'; // Assurez-vous que le chemin d'accès est correct

class AddCompany extends StatefulWidget {
  const AddCompany({Key? key}) : super(key: key);

  @override
  _AddCompanyState createState() => _AddCompanyState();
}

class _AddCompanyState extends State<AddCompany> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  Address? _selectedAddress; // Ajout de l'attribut pour stocker l'adresse sélectionnée

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ajouter une Entreprise'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Nom de l\'entreprise'),
            ),
            GestureDetector(
              onTap: () async {
                final Address? selectedAddress = await Navigator.push<Address?>(
                  context,
                  MaterialPageRoute(builder: (context) => const SearchAddress()),
                );

                if (selectedAddress != null) {
                  setState(() {
                    _selectedAddress = selectedAddress;
                    _addressController.text = "${selectedAddress.street}, ${selectedAddress.city}, ${selectedAddress.postcode}";
                  });
                }
              },
              child: AbsorbPointer(
                child: TextField(
                  controller: _addressController,
                  decoration: const InputDecoration(
                    labelText: 'Adresse',
                    hintText: 'Cliquez pour sélectionner une adresse',
                  ),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: _addCompany, // Corrigé: Utilisation directe sans contexte
              child: const Text('Ajouter'),
            ),
          ],
        ),
      ),
    );
  }

  void _addCompany() {
    if (_nameController.text.isNotEmpty && _selectedAddress != null) {
      final company = Company(name: _nameController.text, address: _selectedAddress!);
      context.read<CompanyCubit>().addCompany(company);
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    super.dispose();
  }
}
