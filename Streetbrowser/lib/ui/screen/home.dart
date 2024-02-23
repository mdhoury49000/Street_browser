import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../model/address.dart';
import '../../model/company.dart';
import '../../blocs/company_cubit.dart'; // Assurez-vous que le chemin d'accès est correct
import 'add_company.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Liste des entreprises'),
      ),
      body: BlocBuilder<CompanyCubit, List<Company>>(
        builder: (context, companies) {
          return ListView.builder(
            itemCount: companies.length,
            itemBuilder: (context, index) {
              final company = companies[index];
              final address = company.address;
              return ListTile(
                title: Text(company.name),
                subtitle: Text('${address.street}, ${address.city}, ${address.postcode}'),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AddCompany()),
        ),
        tooltip: 'Ajouter une entreprise',
        child: const Icon(Icons.add),
      ),
    );
  }
}
