part of '../football_legend_screen.dart';

class _TmLegendBio extends StatelessWidget {
  const _TmLegendBio({
    required this.legend,
    this.hideAge = false,
    this.hideClub = false,
    this.hideFoot = false,
    this.hideHeight = false,
    this.hidePosition = false,
    this.hideOutfitter = false,
    this.hideBirthDate = false,
    this.hideCitizenship = false,
    this.hideNationality = false,
    this.hidePrimeTransferValue = false,
    this.hideCurrentTransferValue = false,
  });

  final FootballLegendCardModel legend;

  final bool hideAge;
  final bool hideClub;
  final bool hideFoot;
  final bool hideHeight;
  final bool hidePosition;
  final bool hideOutfitter;
  final bool hideBirthDate;
  final bool hideCitizenship;
  final bool hideNationality;
  final bool hidePrimeTransferValue;
  final bool hideCurrentTransferValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 8,
      children: [
        // const _Separator(),
        if (legend.height != null) ...[
          Translator(
            termin: AppGlossary.height,
            builder: (value) => _BioTile(title: value, value: hideHeight ? '?' : legend.height!.toString()),
          ),
          const _Separator(),
        ],

        if (legend.position != null) ...[
          Translator(
            termin: AppGlossary.position,
            builder: (value) => _BioTile(title: value, value: hidePosition ? '?' : legend.position!.toString()),
          ),
          const _Separator(),
        ],

        if (legend.birthDate != null) ...[
          Translator(
            termin: AppGlossary.birthDate,
            builder: (value) => _BioTile(title: value, value: hideBirthDate ? '?' : legend.birthDate!.toString()),
          ),
          const _Separator(),
        ],

        if (legend.foot?.isNotEmpty == true) ...[
          Translator(
            termin: AppGlossary.foot,
            builder: (value) => _BioTile(title: value, value: hideFoot ? '?' : legend.foot!.toString()),
          ),
          const _Separator(),
        ],

        if (legend.marketValue != null) ...[
          Translator(
            termin: AppGlossary.currentValue,
            builder: (value) => _BioTile(
              title: value,
              value: hideCurrentTransferValue ? '?' : beautifyTransferValue(legend.marketValue!),
            ),
          ),
          const _Separator(),
        ],
        if (legend.maxMarketValue != null) ...[
          Translator(
            termin: AppGlossary.primeValue,
            builder: (value) => _BioTile(
              title: value,
              value: hidePrimeTransferValue ? '?' : beautifyTransferValue(legend.maxMarketValue!),
            ),
          ),
          const _Separator(),
        ],

        if (legend.clubName != null) ...[
          Translator(
            termin: AppGlossary.club,
            builder: (value) => _BioTile(title: value, value: hideClub ? '?' : legend.clubName!),
          ),
          const _Separator(),
        ],

        if (legend.outfitter != null) ...[
          Translator(
            termin: AppGlossary.outfitter,
            builder: (value) => _BioTile(title: value, value: hideOutfitter ? '?' : legend.outfitter!),
          ),
          const _Separator(),
        ],

        if (legend.citizenship is List) ...[
          Translator(
            termin: AppGlossary.citizenship,
            builder: (value) => Column(
              spacing: 8,
              children: [
                for (int i = 0; i < (legend.citizenship ?? []).length; i++) ...[
                  _BioTile(
                    title: i > 0 ? '$value ${i + 1}' : value,
                    value: hideCitizenship
                        ? '?'
                        : "${emojiFlagByCountryName(legend.citizenship![i]) ?? ""} ${legend.citizenship![i]}",
                  ),
                  const _Separator(),
                ],
              ],
            ),
          ),
        ],

        // if (tmData.teamId?.isNotEmpty == true)
        //   Translator(
        //     termin: AppGlossary.nationality,
        //     builder: (value) => _BioTile(
        //       title: value,
        //       value: hideNationality ? '?' : "${emojiFlagByCountryName(countryName) ?? ""}  $countryName",
        //     ),
        //   ),
        // const _Separator(),
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
        Text(title.toLowerCase(), style: const TextStyle(fontSize: 16)),
        // const SizedBox(width: 8),
        const Spacer(),
        Text(value, style: const TextStyle(fontSize: 18)),
      ],
      //   ),
      // ],
    );
  }
}
