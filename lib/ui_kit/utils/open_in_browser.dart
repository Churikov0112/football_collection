import 'package:football_collection/services/toast/toast_service.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> openInBrowser(String link) async {
  final url = Uri.parse(link);
  try {
    await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    );
  } catch (e) {
    ToastService.showToast(title: "Произошла ошибка!", subtitle: e.toString());
  }
  // final canLaunch = await canLaunchUrl(url);
  // if (canLaunch) {
  //   await launchUrl(
  //     url,
  //     mode: LaunchMode.externalApplication,
  //   );
  // }
}
