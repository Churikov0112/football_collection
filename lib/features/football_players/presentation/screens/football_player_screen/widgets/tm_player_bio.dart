part of '../football_player_screen.dart';

class _TmPlayerBio extends StatelessWidget {
  const _TmPlayerBio({
    required this.player,
    this.hideAge = false,
    this.hideClub = false,
    this.hideFoot = false,
    this.hideHeight = false,
    this.hidePosition = false,
    this.hideBirthDate = false,
    this.hideNationality = false,
    this.hidePrimeTransferValue = false,
    this.hideCurrentTransferValue = false,
  });

  final FootballPlayerCardModel player;

  final bool hideAge;
  final bool hideClub;
  final bool hideFoot;
  final bool hideHeight;
  final bool hidePosition;
  final bool hideBirthDate;
  final bool hideNationality;
  final bool hidePrimeTransferValue;
  final bool hideCurrentTransferValue;

  @override
  Widget build(BuildContext context) {
    final tmData = player;
    final allCountries = getIt.get<AllCountriesBloc>().state.countries ?? [];
    final countryName = allCountries.firstWhereOrNull((c) => c.id == tmData.teamId)?.name ?? '?';

    return Column(
      spacing: 8,
      children: [
        // const _Separator(),
        if (tmData.height != null) ...[
          Translator(
            termin: AppGlossary.height,
            builder: (value) => _BioTile(title: value, value: hideHeight ? '?' : tmData.height!.toString()),
          ),
          const _Separator(),
        ],

        if (tmData.position != null) ...[
          Translator(
            termin: AppGlossary.position,
            builder: (value) => _BioTile(title: value, value: hidePosition ? '?' : tmData.position!.toString()),
          ),
          const _Separator(),
        ],

        if (tmData.birthDate != null) ...[
          Translator(
            termin: AppGlossary.birthDate,
            builder: (value) => _BioTile(title: value, value: hideBirthDate ? '?' : tmData.birthDate!.toString()),
          ),
          const _Separator(),
        ],

        if (tmData.foot?.isNotEmpty == true) ...[
          Translator(
            termin: AppGlossary.foot,
            builder: (value) => _BioTile(title: value, value: hideFoot ? '?' : tmData.foot!.toString()),
          ),
          const _Separator(),
        ],

        if (tmData.currentMarketValue != null) ...[
          Translator(
            termin: AppGlossary.currentValue,
            builder: (value) => _BioTile(
              title: value,
              value: hideCurrentTransferValue ? '?' : beautifyTransferValue(tmData.currentMarketValue!),
            ),
          ),
          const _Separator(),
        ],
        if (player.maxMarketValue != null) ...[
          Translator(
            termin: AppGlossary.primeValue,
            builder: (value) => _BioTile(
              title: value,
              value: hidePrimeTransferValue ? '?' : beautifyTransferValue(player.maxMarketValue!),
            ),
          ),
          const _Separator(),
        ],

        if (player.clubName != null) ...[
          Translator(
            termin: AppGlossary.club,
            builder: (value) => _BioTile(title: value, value: hideClub ? '?' : player.clubName!),
          ),
          const _Separator(),
        ],

        if (tmData.teamId?.isNotEmpty == true)
          Translator(
            termin: AppGlossary.nationality,
            builder: (value) => _BioTile(
              title: value,
              value: hideNationality ? '?' : "${emojiFlagByCountryName(countryName) ?? ""}  $countryName",
            ),
          ),
        const _Separator(),
      ],
    );
  }
}

class _BioTile extends StatelessWidget {
  const _BioTile({required this.title, required this.value});

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return
    // Column(
    //   children: [
    // const _Separator(),
    // const SizedBox(height: 8),
    Row(
      children: [
        Text(title, style: const TextStyle(fontSize: 18)),
        // const SizedBox(width: 8),
        const Spacer(),
        Text(value),
      ],
      //   ),
      // ],
    );
  }
}
