part of '../draft_screen.dart';

class _ChooseCaptainMessage extends StatelessWidget {
  const _ChooseCaptainMessage();

  @override
  Widget build(BuildContext context) {
    return const DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 6, horizontal: 10),
        child: Text(
          "Choose Captain by tap on player",
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 20,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
