part of '../football_players_duplicates_screen.dart';

class _SortSheet extends StatelessWidget {
  const _SortSheet({required this.current});

  final _SortOption current;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFF101010),
      borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 16, 0, 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Translator(
                  termin: AppGlossary.sort,
                  builder: (value) => Text(
                    value,
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              ..._items(context),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _items(BuildContext context) {
    final entries = <_SortOption, String>{
      _SortOption.countDesc: 'Cards Count ↓',
      _SortOption.countAsc: 'Cards Count ↑',
      _SortOption.nameAsc: 'Name A-Z',
      _SortOption.nameDesc: 'Name Z-A',
      _SortOption.valueDesc: 'Market Value ↓',
      _SortOption.valueAsc: 'Market Value ↑',
    };

    return entries.entries
        .map(
          (entry) => ListTile(
            onTap: () => Navigator.of(context).pop(entry.key),
            leading: Icon(
              current == entry.key ? Icons.radio_button_checked : Icons.radio_button_off,
              color: Colors.white70,
            ),
            title: Text(entry.value, style: const TextStyle(color: Colors.white)),
          ),
        )
        .toList();
  }
}
