part of "../../card_widget_wrapper.dart";

class _NewBadge extends StatelessWidget {
  const _NewBadge();

  @override
  Widget build(BuildContext context) {
    return const DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.deepPurple,
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(12)),
      ),
      child: RotatedBox(
        quarterTurns: 3,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
          child: Text(
            "NEW",
            style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
