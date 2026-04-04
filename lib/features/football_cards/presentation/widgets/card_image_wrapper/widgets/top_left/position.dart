part of '../../card_image_wrapper.dart';

class _PositionTopLeft extends StatelessWidget {
  const _PositionTopLeft({required this.position});

  final String position;

  @override
  Widget build(BuildContext context) {
    final short = footballPlayerPositionToShort(position);
    final color = footballPlayerPositionToColor(position);

    if (short == null || color == null) {
      return const SizedBox.shrink();
    }

    return DecoratedBox(
      decoration: BoxDecoration(color: Colors.lightGreenAccent),
      child: SizedBox.square(
        dimension: 20,
        child: Center(
          child: Text(
            short,
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 10),
          ),
        ),
      ),
    );
  }
}
