// ignore_for_file: deprecated_member_use

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/material.dart';
import 'package:football_collection/services/localization/translator.dart';
import 'package:football_collection/ui_kit/widgets/transparent_appbar/transparent_appbar.dart';
import 'package:go_router/go_router.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../../di/di.dart';
import '../../../../../services/navigation/bottom_sheet_controller/bottom_sheet_controller.dart';
import '../../../../../services/toast/toast_service.dart';
import '../../../../../ui_kit/widgets/button/button.dart';
import '../../../../abstract/presentation/blocs/saved_cards_bloc/saved_cards_bloc.dart';
import '../../../../mini_games/presentation/blocs/balance_bloc/balance_bloc.dart';

class ExportDataScreen extends StatelessWidget {
  const ExportDataScreen({super.key});

  String _buildExportBase64String() {
    final savedCardsIds = getIt.get<SavedCardsBloc>().state.savedCardsIds ?? <String>[];
    final balance = getIt.get<BalanceBloc>().state.balance ?? 0;

    final jsonString = jsonEncode({
      'savedCardsIds': savedCardsIds,
      'balance': balance,
    });

    return base64Encode(utf8.encode(jsonString));
  }

  Future<void> _clearProgressAfterTransfer() async {
    getIt.get<BalanceBloc>().add(BalanceEventSet(amount: 0));
    getIt.get<SavedCardsBloc>().add(SavedCardsEventSetAll(cardIds: []));
  }

  Future<void> _exportByShare(BuildContext context) async {
    try {
      final base64String = _buildExportBase64String();
      final directory = await getTemporaryDirectory();
      final file = File('${directory.path}/progress.txt');
      await file.writeAsString(base64String);

      final result = await SharePlus.instance.share(
        ShareParams(files: [XFile(file.path)]),
      );

      if (result.status == ShareResultStatus.success) {
        await _clearProgressAfterTransfer();
        ToastService.showToast(title: AppGlossary.dataExported.translate());
        if (context.mounted) {
          context.pop();
        }
      }
    } catch (e) {
      ToastService.showErrorToast(title: e.toString());
    }
  }

  Future<void> _exportBySaveToFile(BuildContext context) async {
    try {
      final base64String = _buildExportBase64String();
      final bytes = Uint8List.fromList(utf8.encode(base64String));

      await FileSaver.instance.saveAs(
        name: 'progress',
        bytes: bytes,
        fileExtension: 'txt',
        mimeType: MimeType.text,
      );

      await _clearProgressAfterTransfer();
      ToastService.showToast(title: AppGlossary.dataExported.translate());
      if (context.mounted) {
        context.pop();
      }
    } catch (e) {
      ToastService.showErrorToast(title: e.toString());
    }
  }

  Future<String?> _readPickedFileAsString(PlatformFile pickedFile) async {
    if (pickedFile.path != null) {
      return File(pickedFile.path!).readAsString();
    }

    final bytes = pickedFile.bytes;
    if (bytes != null) {
      return utf8.decode(bytes);
    }

    return null;
  }

  Future<void> _importFromFile(BuildContext context) async {
    try {
      final result = await FilePicker.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['txt'],
        withData: true,
      );

      final pickedFile = result?.files.firstOrNull;
      if (pickedFile == null) {
        return;
      }

      final raw = await _readPickedFileAsString(pickedFile);
      if (raw == null) {
        ToastService.showErrorToast(title: 'Unable to read selected file');
        return;
      }

      final decodedBytes = base64Decode(raw);
      final jsonString = utf8.decode(decodedBytes);
      final data = jsonDecode(jsonString);

      if (data is! Map<String, dynamic>) {
        ToastService.showErrorToast(title: 'Invalid file format');
        return;
      }

      final savedCardsIds = (data['savedCardsIds'] as List?)?.map((e) => e.toString()).toList() ?? <String>[];
      final balanceRaw = data['balance'];
      final balance = balanceRaw is int ? balanceRaw : int.tryParse(balanceRaw.toString());

      if (balance == null) {
        ToastService.showErrorToast(title: 'Invalid file format');
        return;
      }

      getIt.get<BalanceBloc>().add(BalanceEventSet(amount: balance));
      getIt.get<SavedCardsBloc>().add(SavedCardsEventSetAll(cardIds: savedCardsIds));
      ToastService.showToast(title: AppGlossary.dataImported.translate());
      if (context.mounted) {
        context.pop();
      }
    } catch (e) {
      ToastService.showErrorToast(title: e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const .symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: .center,
              children: [
                DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: .circular(20),
                    border: .all(color: Colors.white),
                  ),
                  child: Padding(
                    padding: const .all(16),
                    child: Column(
                      children: [
                        Text(AppGlossary.exportDataDescription.translate(), textAlign: .center),
                        const SizedBox(height: 16),
                        Button(
                          onPressed: () {
                            BottomSheetController.showBottomSheet(
                              context,
                              (context) {
                                final mq = MediaQuery.of(context);
                                return DecoratedBox(
                                  decoration: const BoxDecoration(
                                    color: Color.fromARGB(255, 34, 34, 34),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Padding(
                                        padding: const .symmetric(vertical: 10, horizontal: 16),
                                        child: Row(
                                          children: [
                                            Text(
                                              AppGlossary.areYouSure.translate(),
                                              textAlign: .center,
                                              style: const TextStyle(fontSize: 20),
                                            ),
                                            const Spacer(),
                                            IconButton(onPressed: context.pop, icon: const Icon(Icons.close)),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const .symmetric(horizontal: 16),
                                        child: Text(AppGlossary.exportDataDescription.translate(), textAlign: .center),
                                      ),
                                      const SizedBox(height: 32),
                                      Padding(
                                        padding: const .symmetric(horizontal: 16),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Button(
                                                onPressed: context.pop,
                                                text: AppGlossary.cancel.translate(),
                                                primary: false,
                                              ),
                                            ),
                                            const SizedBox(width: 16),
                                            Button(
                                              onPressed: () => _exportByShare(context),
                                              icon: Icons.share,
                                            ),
                                            const SizedBox(width: 16),
                                            Button(
                                              onPressed: () => _exportBySaveToFile(context),
                                              icon: Icons.download,
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: mq.padding.bottom + 16),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          text: AppGlossary.export.translate(),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: .circular(20),
                    border: .all(color: Colors.white),
                  ),
                  child: Padding(
                    padding: const .all(16),
                    child: Column(
                      children: [
                        Text(AppGlossary.importDataDescription.translate(), textAlign: .center),
                        const SizedBox(height: 16),
                        Button(
                          onPressed: () {
                            BottomSheetController.showBottomSheet(
                              context,
                              (context) {
                                final mq = MediaQuery.of(context);
                                return DecoratedBox(
                                  decoration: const BoxDecoration(
                                    color: Color.fromARGB(255, 34, 34, 34),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Padding(
                                        padding: const .symmetric(vertical: 10, horizontal: 16),
                                        child: Row(
                                          children: [
                                            Text(
                                              AppGlossary.areYouSure.translate(),
                                              textAlign: .center,
                                              style: const TextStyle(fontSize: 20),
                                            ),
                                            const Spacer(),
                                            IconButton(onPressed: context.pop, icon: const Icon(Icons.close)),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const .symmetric(horizontal: 16),
                                        child: Text(AppGlossary.importDataDescription.translate(), textAlign: .center),
                                      ),
                                      const SizedBox(height: 32),
                                      Padding(
                                        padding: const .symmetric(horizontal: 16),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Button(
                                                onPressed: context.pop,
                                                text: AppGlossary.cancel.translate(),
                                                primary: false,
                                              ),
                                            ),
                                            const SizedBox(width: 16),
                                            Expanded(
                                              child: Button(
                                                onPressed: () => _importFromFile(context),
                                                text: AppGlossary.confirm.translate(),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: mq.padding.bottom + 16),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          text: AppGlossary.import.translate(),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          TransparentAppbar(title: '${AppGlossary.export.translate()}/${AppGlossary.import.translate()}'),
        ],
      ),
    );
  }
}
