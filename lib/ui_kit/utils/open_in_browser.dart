import 'package:url_launcher/url_launcher.dart';

Future<void> openInBrowser(String link) async {
  final url = Uri.parse(link);
  final canLaunch = await canLaunchUrl(url);
  if (canLaunch) {
    await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    );
  }
}
