import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_collection/features/countries/domain/models/national_team.dart';
import 'package:football_collection/features/football_cards/presentation/blocs/all_countries_bloc/all_countries_bloc.dart';
import 'package:football_collection/services/navigation/bottom_sheet_controller/bottom_sheet_controller.dart';
import 'package:football_collection/ui_kit/widgets/background_image/background_image.dart';
import 'package:football_collection/ui_kit/widgets/frosted_glass_container/frosted_glass_container.dart';
import 'package:football_collection/ui_kit/widgets/glass_button/glass_button.dart';
import 'package:football_collection/ui_kit/widgets/transparent_appbar/transparent_appbar.dart';

import '../../../../../di/di.dart';
import '../../../../../services/localization/translator.dart';
import '../../blocs/leaderboard_bloc/leaderboard_bloc.dart';
import '../../blocs/leaderboard_country_bloc/leaderboard_country_bloc.dart';
import 'widgets/country_selection_bottom_sheet.dart';

class LeaderboardScreen extends StatefulWidget {
  const LeaderboardScreen({super.key});

  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
  @override
  void initState() {
    super.initState();

    getIt.get<LeaderboardBloc>().add(LeaderboardEventLoad());

    final countriesState = getIt.get<AllCountriesBloc>().state;
    if (countriesState.countries?.isEmpty != false) {
      getIt.get<AllCountriesBloc>().add(AllCountriesEventGet());
    }
  }

  Future<void> _onRefresh() async {
    getIt.get<LeaderboardBloc>().add(LeaderboardEventRefresh());
    await getIt.get<LeaderboardBloc>().stream.firstWhere(
      (state) => state is LeaderboardStateLoadSucceeded || state is LeaderboardStateFailed,
    );
  }

  Future<void> _openCountryPicker() async {
    final countryName = await BottomSheetController.showBottomSheet<String>(
      context,
      (context) => const CountrySelectionBottomSheet(),
    );
    if (countryName == null || countryName.isEmpty) return;
    getIt.get<LeaderboardCountryBloc>().add(LeaderboardCountryEventSelect(countryName: countryName));
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    return Scaffold(
      body: Stack(
        children: [
          const BackgroundImage(),
          RefreshIndicator(
            onRefresh: _onRefresh,
            child: BlocBuilder<LeaderboardBloc, LeaderboardState>(
              bloc: getIt.get<LeaderboardBloc>(),
              builder: (context, leaderboardState) {
                if (leaderboardState is LeaderboardStatePending) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (leaderboardState is LeaderboardStateFailed) {
                  return ListView(
                    children: [
                      const SizedBox(height: 150),
                      Center(
                        child: Text(
                          leaderboardState.reason,
                          style: const TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  );
                }

                final entries = leaderboardState.entries ?? const [];

                return BlocBuilder<LeaderboardCountryBloc, LeaderboardCountryState>(
                  bloc: getIt.get<LeaderboardCountryBloc>(),
                  builder: (context, selectedCountryState) {
                    final selectedCountryName = selectedCountryState.countryName;
                    final selectedCountryFlag = emojiFlagByCountryName(selectedCountryName) ?? '';

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: mq.padding.top + 80),
                        if (selectedCountryName != null) ...[
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Translator(
                              termin: AppGlossary.yourTeam,
                              builder: (value) => Text(
                                '$value - $selectedCountryName $selectedCountryFlag',
                                style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                        ],
                        Expanded(
                          child: ListView(
                            padding: EdgeInsets.only(left: 16, right: 16, bottom: mq.padding.bottom + 100),
                            children: [
                              LayoutBuilder(
                                builder: (context, constraints) {
                                  return FrostedGlassContainer(
                                    blupColor: Colors.black45,
                                    borderRadius: BorderRadius.circular(16),
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: ConstrainedBox(
                                        constraints: BoxConstraints(minWidth: constraints.maxWidth),
                                        child: DataTable(
                                          dividerThickness: 0,
                                          horizontalMargin: 10,
                                          columnSpacing: 12,
                                          headingRowColor: WidgetStateProperty.all(Colors.white12),
                                          dataTextStyle: const TextStyle(color: Colors.white),
                                          headingTextStyle: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          border: TableBorder(
                                            horizontalInside: BorderSide(color: Colors.white12, width: 1),
                                            verticalInside: BorderSide(color: Colors.white54, width: 1),
                                          ),
                                          columns: [
                                            DataColumn(
                                              label: const Center(child: Text('#')),
                                              columnWidth: const IntrinsicColumnWidth(),
                                            ),
                                            DataColumn(
                                              label: Text(AppGlossary.nationality.translate()),
                                              columnWidth: const FlexColumnWidth(),
                                            ),
                                            DataColumn(
                                              label: Text(AppGlossary.cardsReceived.translate()),
                                              columnWidth: const IntrinsicColumnWidth(),
                                              numeric: true,
                                            ),
                                          ],
                                          rows: [
                                            for (int i = 0; i < entries.length; i++)
                                              DataRow(
                                                cells: [
                                                  DataCell(
                                                    Center(
                                                      child: Text(switch (i) {
                                                        0 => '🥇',
                                                        1 => '🥈',
                                                        2 => '🥉',
                                                        _ => '${i + 1}',
                                                      }, maxLines: 1),
                                                    ),
                                                  ),
                                                  DataCell(
                                                    Text(
                                                      '${emojiFlagByCountryName(entries[i].country) ?? ''}  ${entries[i].country}',
                                                    ),
                                                  ),
                                                  DataCell(Text(entries[i].totalCards.toString())),
                                                ],
                                              ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: mq.padding.bottom),
                      ],
                    );
                  },
                );
              },
            ),
          ),
          Positioned(
            bottom: mq.padding.bottom + 16,
            right: 16,
            left: 16,
            child: BlocBuilder<LeaderboardCountryBloc, LeaderboardCountryState>(
              bloc: getIt.get<LeaderboardCountryBloc>(),
              builder: (context, selectedCountryState) {
                if (selectedCountryState.countryName != null) {
                  return Translator(
                    termin: AppGlossary.changeTeam,
                    builder: (value) => GlassButton(onPressed: _openCountryPicker, text: value),
                  );
                }

                return Translator(
                  termin: AppGlossary.participate,
                  builder: (value) => GlassButton(onPressed: _openCountryPicker, text: value),
                );
              },
            ),
          ),
          Translator(
            termin: AppGlossary.rating,
            builder: (value) => TransparentAppbar(title: value),
          ),
        ],
      ),
    );
  }
}
