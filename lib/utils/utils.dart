import 'package:flutter/material.dart';
import 'package:qr_reader/models/models.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> launch(BuildContext context, ScanModel scan) async {
  final url = Uri.parse(scan.value);
  if (scan.type == 'http') {
    if (!await launchUrl(url, mode: LaunchMode.inAppWebView)) {
      throw 'Could not launch $url';
    }
  } else {
    Navigator.pushNamed(context, 'map', arguments: scan);
  }
}
