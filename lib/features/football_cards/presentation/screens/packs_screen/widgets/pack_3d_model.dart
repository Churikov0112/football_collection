import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_collection/features/abstract/domain/models/pack.dart';
import 'package:o3d/o3d.dart';

import '../../../../../../di/di.dart';
import '../../../../../abstract/presentation/blocs/settings_bloc/settings_bloc.dart';
import '../football_players_packs_screen.dart';
import 'team_flag_on_pack.dart';

const double _k3dPackHeightFactor = 2.0;

class Pack3dModel extends StatelessWidget {
  const Pack3dModel({required this.selectedPack, super.key});

  final PackModel selectedPack;

  @override
  Widget build(BuildContext context) {
    final presenter = FootballPlayersPacksScreenPresenter.of(context);

    const packSize3d = Size(_k3dPackHeightFactor * packWidth, _k3dPackHeightFactor * packHeight);

    return BlocBuilder<SettingsBloc, SettingsState>(
      bloc: getIt(),
      builder: (context, settingsState) {
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
                cameraControls: settingsState.enablePackManualRotate,
                orbitSensitivity: settingsState.packManualRotateSensitivity,
                minCameraOrbit: "-15deg 80deg auto",
                maxCameraOrbit: "15deg 100deg auto",
                autoRotate: settingsState.enablePackAutoRotate,
                autoRotateDelay: 1000,
                rotationPerSecond: "${settingsState.packAutoRotatePerSecond}deg",
                cameraTarget: CameraTarget(
                  0,
                  1.4,
                  0,
                ),
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
      },
    );
  }
}
