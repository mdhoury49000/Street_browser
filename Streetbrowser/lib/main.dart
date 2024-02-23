import 'package:flutter/material.dart';
import 'package:flutterinitiation/repositories/preferences_repository.dart';
import 'ui/screen/home.dart';
import "blocs/company_cubit.dart";
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
    final preferencesRepository = PreferencesRepository(); // Créez une instance de PreferencesRepository

  @override
  Widget build(BuildContext context) {
    // Envelopper MaterialApp avec BlocProvider pour fournir CompanyCubit
    return BlocProvider(
      create: (context) => CompanyCubit(preferencesRepository),
      child: MaterialApp(
        title: 'Gestion des Entreprises',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Home(), // Utiliser Home comme page d'accueil
      ),
    );
  }
}




