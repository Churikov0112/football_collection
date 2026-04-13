import 'package:flutter/material.dart';

class TeamFlagOnPack extends StatelessWidget {
  const TeamFlagOnPack({super.key, required this.size, required this.teamdId});

  final double size;
  final String teamdId;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        // borderRadius: BorderRadius.all(Radius.circular(16)),
        border: Border.all(color: Colors.blueAccent, width: 6, strokeAlign: BorderSide.strokeAlignOutside),
        image: DecorationImage(image: AssetImage("assets/raster/teams_flags/$teamdId.jpg")),
      ),
      child: SizedBox.square(dimension: size),
    );
  }
}
