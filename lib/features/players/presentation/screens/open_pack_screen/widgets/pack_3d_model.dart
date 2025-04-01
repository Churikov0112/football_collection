import 'package:flutter/material.dart';
import 'package:football_collection/features/players/domain/models/pack.dart';
import 'package:o3d/o3d.dart';

import '../open_pack_screen.dart';

class Pack3dModel extends StatelessWidget {
  const Pack3dModel({
    required this.selectedPack,
    super.key,
  });

  final PackModel selectedPack;

  @override
  Widget build(BuildContext context) {
    final presenter = OpenPackScreenPresenter.of(context);

    return SizedBox(
      height: 2 * packHeight,
      width: 2 * packWidth,
      child: Stack(
        children: [
          O3D.asset(
            src: selectedPack.glbAssetPath,
            controller: presenter.o3dController,
            autoPlay: false,
            disableTap: true,
            disableZoom: true,
            disablePan: true,
            cameraControls: false,
          ),
        ],
      ),
    );
  }
}
