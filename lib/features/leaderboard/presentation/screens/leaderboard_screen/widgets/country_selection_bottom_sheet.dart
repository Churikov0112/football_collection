import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../di/di.dart';
import '../../../../../../features/football_players/presentation/blocs/all_countries_bloc/all_countries_bloc.dart';
import '../../../../../../services/localization/translator.dart';
import '../../../../../countries/domain/models/national_team.dart';

class CountrySelectionBottomSheet extends StatefulWidget {
  const CountrySelectionBottomSheet({super.key});

  @override
  State<CountrySelectionBottomSheet> createState() => _CountrySelectionBottomSheetState();
}

class _CountrySelectionBottomSheetState extends State<CountrySelectionBottomSheet> {
  final TextEditingController _searchController = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFF101010),
      borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Translator(
                termin: AppGlossary.selectCountry,
                builder: (value) => Text(
                  value,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white),
                ),
              ),
              const SizedBox(height: 12),
              Translator(
                termin: AppGlossary.search,
                builder: (value) => TextField(
                  controller: _searchController,
                  onChanged: (value) => setState(() => _query = value.trim().toLowerCase()),
                  decoration: InputDecoration(prefixIcon: const Icon(Icons.search, color: Colors.white70)),
                ),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: BlocBuilder<AllCountriesBloc, AllCountriesState>(
                  bloc: getIt.get<AllCountriesBloc>(),
                  builder: (context, state) {
                    final countries =
                        (state.countries ?? <FootballNationalTeamModel>[])
                            .where((country) => country.name.toLowerCase().contains(_query))
                            .toList()
                          ..sort((a, b) => a.name.compareTo(b.name));

                    return ListView.separated(
                      itemCount: countries.length,
                      separatorBuilder: (_, _) => const Divider(color: Colors.white12, height: 1),
                      itemBuilder: (context, index) {
                        final country = countries[index];
                        return ListTile(
                          onTap: () => Navigator.of(context).pop(country.name),
                          title: Text(
                            '${emojiFlagByCountryName(country.name) ?? ''} ${country.name}',
                            style: const TextStyle(color: Colors.white),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
