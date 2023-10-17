import 'package:url_launcher/url_launcher.dart';

Future<void> moveToUrl(String url) async {
  final Uri url0 = Uri.parse(url);

  await canLaunchUrl(url0)
      ? await launchUrl(url0)
      : throw Exception('Could not launch $url0');
}
