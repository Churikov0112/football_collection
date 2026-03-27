part of '../football_players_duplicates_screen.dart';

class _FiltersSheet extends StatefulWidget {
  const _FiltersSheet({
    required this.positionGroup,
    required this.minCount,
    required this.country,
    required this.countries,
  });

  final _PositionGroup positionGroup;
  final int minCount;
  final FootballNationalTeamModel? country;
  final List<FootballNationalTeamModel> countries;

  @override
  State<_FiltersSheet> createState() => _FiltersSheetState();
}

class _FiltersSheetState extends State<_FiltersSheet> {
  late _PositionGroup _positionGroup;
  late int _minCount;
  FootballNationalTeamModel? _country;

  @override
  void initState() {
    super.initState();
    _positionGroup = widget.positionGroup;
    _minCount = widget.minCount;
    _country = widget.country;
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    return Material(
      color: const Color(0xFF101010),
      borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: mq.padding.bottom + 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Translator(
                termin: AppGlossary.filters,
                builder: (value) => Text(value, style: const TextStyle(color: Colors.white, fontSize: 18)),
              ),
              const SizedBox(height: 12),
              const Text('Country', style: TextStyle(color: Colors.white70)),
              const SizedBox(height: 6),
              Row(
                children: [
                  Expanded(
                    child: _tapSurface(
                      onTap: _pickCountry,
                      child: Text(
                        _country == null ? 'All' : '${emojiFlagByCountryName(_country!.name) ?? ''} ${_country!.name}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  _tapSurface(
                    onTap: () => setState(() => _country = null),
                    padding: const EdgeInsets.all(10),
                    child: const Icon(Icons.close, color: Colors.white70, size: 20),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              const Text('Position', style: TextStyle(color: Colors.white70)),
              const SizedBox(height: 6),
              Wrap(
                spacing: 8,
                children: [
                  _pill(
                    label: 'ALL',
                    selected: _positionGroup == _PositionGroup.all,
                    onTap: () => setState(() => _positionGroup = _PositionGroup.all),
                  ),
                  _pill(
                    label: 'GK',
                    selected: _positionGroup == _PositionGroup.gk,
                    onTap: () => setState(() => _positionGroup = _PositionGroup.gk),
                  ),
                  _pill(
                    label: 'DEF',
                    selected: _positionGroup == _PositionGroup.def,
                    onTap: () => setState(() => _positionGroup = _PositionGroup.def),
                  ),
                  _pill(
                    label: 'MID',
                    selected: _positionGroup == _PositionGroup.mid,
                    onTap: () => setState(() => _positionGroup = _PositionGroup.mid),
                  ),
                  _pill(
                    label: 'ATT',
                    selected: _positionGroup == _PositionGroup.att,
                    onTap: () => setState(() => _positionGroup = _PositionGroup.att),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              const Text('Min copies', style: TextStyle(color: Colors.white70)),
              const SizedBox(height: 6),
              Wrap(
                spacing: 8,
                children: [
                  _pill(label: '2+', selected: _minCount == 2, onTap: () => setState(() => _minCount = 2)),
                  _pill(label: '3+', selected: _minCount == 3, onTap: () => setState(() => _minCount = 3)),
                  _pill(label: '5+', selected: _minCount == 5, onTap: () => setState(() => _minCount = 5)),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: _tapSurface(
                      onTap: () {
                        setState(() {
                          _positionGroup = _PositionGroup.all;
                          _minCount = 2;
                          _country = null;
                        });
                      },
                      child: const Text('Reset', style: TextStyle(color: Colors.white)),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _tapSurface(
                      onTap: () {
                        Navigator.of(
                          context,
                        ).pop(_FiltersResult(positionGroup: _positionGroup, minCount: _minCount, country: _country));
                      },
                      backgroundColor: Colors.white,
                      child: const Text(
                        'Apply',
                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _pickCountry() async {
    final countryName = await BottomSheetController.showBottomSheet<String>(
      context,
      (context) => const CountrySelectionBottomSheet(),
    );
    if (countryName == null || countryName.isEmpty) return;

    FootballNationalTeamModel? selected;
    for (final country in widget.countries) {
      if (country.name == countryName) {
        selected = country;
        break;
      }
    }

    setState(() => _country = selected);
  }

  Widget _pill({required String label, required bool selected, required VoidCallback onTap}) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? Colors.white : Colors.black45,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: selected ? Colors.orangeAccent : Colors.white24),
        ),
        child: Text(label, style: TextStyle(color: selected ? Colors.black : Colors.white)),
      ),
    );
  }

  Widget _tapSurface({
    required VoidCallback onTap,
    required Widget child,
    EdgeInsetsGeometry padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    Color backgroundColor = Colors.black45,
  }) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        padding: padding,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white24),
        ),
        child: Center(child: child),
      ),
    );
  }
}

class _FiltersResult {
  final _PositionGroup positionGroup;
  final int minCount;
  final FootballNationalTeamModel? country;

  const _FiltersResult({required this.positionGroup, required this.minCount, required this.country});
}
