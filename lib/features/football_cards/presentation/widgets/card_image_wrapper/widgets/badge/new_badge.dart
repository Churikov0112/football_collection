part of "../../card_image_wrapper.dart";

class _NewBadge extends StatelessWidget {
  const _NewBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      width: 64,
      color: Colors.purpleAccent,
      child: Center(child: Text("NEW!")),
    );
  }
}
