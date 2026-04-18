// ignore_for_file: deprecated_member_use

import 'dart:convert';
import 'dart:io';

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

  @override
  Widget build(BuildContext context) {
    // final mq = MediaQuery.of(context);

    return Scaffold(
      // drawer: MenuDrawer(),
      body: Stack(
        children: [
          // const BackgroundImage(),
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
                                              onPressed: () async {
                                                final savedCardsIds =
                                                    getIt.get<SavedCardsBloc>().state.savedCardsIds ?? <String>[];
                                                final balance = getIt.get<BalanceBloc>().state.balance ?? 0;
                                                final jsonString = jsonEncode({
                                                  'savedCardsIds': savedCardsIds,
                                                  'balance': balance,
                                                });
                                                final base64String = base64Encode(utf8.encode(jsonString));

                                                final directory = await getTemporaryDirectory();
                                                final file = File('${directory.path}/progress.txt');
                                                await file.writeAsString(base64String);

                                                final result = await SharePlus.instance.share(
                                                  ShareParams(files: [XFile(file.path)]),
                                                );
                                                if (result.status == .success) {
                                                  getIt.get<BalanceBloc>().add(BalanceEventSet(amount: 0));
                                                  getIt.get<SavedCardsBloc>().add(SavedCardsEventSetAll(cardIds: []));
                                                  ToastService.showToast(title: AppGlossary.dataExported.translate());
                                                  context.pop();
                                                }
                                              },
                                              icon: Icons.share,
                                            ),
                                            const SizedBox(width: 16),
                                            Button(
                                              onPressed: () async {
                                                final savedCardsIds =
                                                    getIt.get<SavedCardsBloc>().state.savedCardsIds ?? <String>[];
                                                final balance = getIt.get<BalanceBloc>().state.balance ?? 0;
                                                final jsonString = jsonEncode({
                                                  'savedCardsIds': savedCardsIds,
                                                  'balance': balance,
                                                });
                                                final base64String = base64Encode(utf8.encode(jsonString));
                                                final bytes = utf8.encode(base64String);

                                                await FileSaver.instance.saveAs(
                                                  name: "progress",
                                                  bytes: bytes,
                                                  fileExtension: "txt",
                                                  mimeType: MimeType.text,
                                                );

                                                Directory? directory;
                                                try {
                                                  directory = await getDownloadsDirectory();
                                                } catch (e) {
                                                  directory = await getExternalStorageDirectory();
                                                }

                                                if (directory == null) {
                                                  ToastService.showToast(
                                                    title: "Error",
                                                    subtitle:
                                                        "getDownloadsDirectory & getExternalStorageDirectory are both null",
                                                  );
                                                  return;
                                                }

                                                try {
                                                  final file = File('${directory.path}/progress.txt');
                                                  await file.writeAsString(base64String);
                                                  getIt.get<BalanceBloc>().add(BalanceEventSet(amount: 0));
                                                  getIt.get<SavedCardsBloc>().add(SavedCardsEventSetAll(cardIds: []));
                                                  ToastService.showToast(
                                                    title: AppGlossary.dataExported.translate(),
                                                  );
                                                  context.pop();
                                                } catch (e) {
                                                  ToastService.showToast(title: e.toString());
                                                }
                                              },
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
                                                onPressed: () async {
                                                  final result = await FilePicker.pickFiles(
                                                    type: FileType.custom,
                                                    allowedExtensions: ['txt'],
                                                  );
                                                  final files = result?.files.map((f) => File(f.path!)).toList();
                                                  final file = files?.firstOrNull;
                                                  if (file != null) {
                                                    try {
                                                      final base64String = await file.readAsString();
                                                      final bytes = base64Decode(base64String);
                                                      final jsonString = utf8.decode(bytes);
                                                      final data = jsonDecode(jsonString);
                                                      final savedCardsIds = (data['savedCardsIds'] as List?)
                                                          ?.map((e) => e.toString())
                                                          .toList();
                                                      final balance = data['balance'];
                                                      if (savedCardsIds is List<String> && balance is int) {
                                                        getIt.get<BalanceBloc>().add(BalanceEventSet(amount: balance));
                                                        getIt.get<SavedCardsBloc>().add(
                                                          SavedCardsEventSetAll(cardIds: savedCardsIds),
                                                        );
                                                        ToastService.showToast(
                                                          title: AppGlossary.dataImported.translate(),
                                                        );
                                                        context.pop();
                                                      }
                                                    } catch (e) {
                                                      ToastService.showErrorToast(title: e.toString());
                                                    }
                                                  }
                                                },
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
