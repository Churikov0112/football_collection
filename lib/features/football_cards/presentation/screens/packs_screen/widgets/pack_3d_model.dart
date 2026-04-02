import 'package:flutter/material.dart';
import 'package:football_collection/features/abstract/domain/models/pack.dart';
import 'package:o3d/o3d.dart';

import '../football_players_packs_screen.dart';
import 'team_flag_on_pack.dart';

const double _k3dPackHeightFactor = 2.0;

class Pack3dModel extends StatelessWidget {
  const Pack3dModel({required this.selectedPack, super.key});

  final PackModel selectedPack;

  @override
  Widget build(BuildContext context) {
    final presenter = FootballPlayersPacksScreenPresenter.of(context);

    final packSize3d = Size(_k3dPackHeightFactor * packWidth, _k3dPackHeightFactor * packHeight);

    return SizedBox(
      height: packSize3d.height,
      width: packSize3d.width,
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
            exposure: 0.75, // уменьшает яркость
          ),
          if (selectedPack.type == .team)
            Positioned(
              top: (packSize3d.height - packSize3d.width * 0.3) / 2,
              left: (packSize3d.width - packSize3d.width * 0.3) / 2,
              right: (packSize3d.width - packSize3d.width * 0.3) / 2,
              bottom: (packSize3d.height - packSize3d.width * 0.3) / 2,
              child: TeamFlagOnPack(
                teamdId: selectedPack.cards?.firstOrNull?.teamId ?? "",
                size: packSize3d.width * 0.3,
              ),
            ),
        ],
      ),
    );
  }
}
