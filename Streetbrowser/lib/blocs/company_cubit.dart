import 'package:flutter_bloc/flutter_bloc.dart';
import '../repositories/preferences_repository.dart'; // Assurez-vous que le chemin d'accès est correct
import '../model/company.dart';

class CompanyCubit extends Cubit<List<Company>> {
  final PreferencesRepository preferencesRepository;

  /// Constructeur + initialisation du Cubit avec un tableau vide d'entreprise

   CompanyCubit(this.preferencesRepository) : super([]) {
    loadCompanies();
  }

  void loadCompanies() async {
    final companies = await preferencesRepository.loadCompanies();
    emit(companies);
  }

  void addCompany(Company company) async {
    final newState = List<Company>.from(state)..add(company);
    emit(newState);
    await preferencesRepository.saveCompanies(newState);
  }
}

