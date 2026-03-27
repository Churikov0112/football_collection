part of '../football_players_duplicates_screen.dart';

class _TopControlsRow extends StatelessWidget {
  const _TopControlsRow({
    required this.controller,
    required this.filtersDirty,
    required this.onOpenFilters,
    required this.onOpenSort,
  });

  final TextEditingController controller;
  final bool filtersDirty;
  final VoidCallback onOpenFilters;
  final VoidCallback onOpenSort;

  @override
  Widget build(BuildContext context) {
    return FrostedGlassContainer(
      blupColor: Colors.black26,
      borderRadius: const BorderRadius.all(Radius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: 48,
          child: Row(
            spacing: 8,
            children: [
              GestureDetector(
                onTap: onOpenFilters,
                child: Padding(padding: const EdgeInsets.all(8.0), child: Icon(Icons.tune)),
              ),
              Expanded(
                child: TextField(
                  onTapUpOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
                  controller: controller,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: AppGlossary.search.translate(),
                    hintStyle: const TextStyle(color: Colors.white),
                    // filled: true,
                    // fillColor: Colors.black54,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                    contentPadding: const EdgeInsets.symmetric(vertical: 10),
                  ),
                ),
              ),
              GestureDetector(
                onTap: onOpenSort,
                child: Padding(padding: const EdgeInsets.all(8.0), child: Icon(Icons.swap_vert)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
