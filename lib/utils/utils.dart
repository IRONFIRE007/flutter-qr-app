import 'package:flutter/cupertino.dart';
import 'package:qr_reader_app/models/scan_model.dart';
import 'package:url_launcher/url_launcher.dart';

void launchURL(BuildContext context, ScanModel scan) async {
  final String _url = scan.valor;

  if (scan.tipo == 'http') {
    //Open Website
    if (!await launch(_url))
      await launch(_url);
    else {
      'Could not launch $_url';
    }
  } else {
    Navigator.pushNamed(context, 'map', arguments: scan);
  }
}
