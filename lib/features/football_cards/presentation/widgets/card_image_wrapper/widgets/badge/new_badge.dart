part of "../../card_image_wrapper.dart";

class _NewBadge extends StatelessWidget {
  const _NewBadge();

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.deepPurple,
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(12)),
      ),
      child: RotatedBox(
        quarterTurns: 3,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),

          child: Text(
            "NEW",
            style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
