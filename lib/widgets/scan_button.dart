import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader_app/providers/scan_list_provider.dart';
import 'package:qr_reader_app/utils/utils.dart';

class ScanButton extends StatelessWidget {
  const ScanButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 0,
      onPressed: () async {
        String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
            '#ff6666', 'Cancel', false, ScanMode.QR);

        // final barcodeScanRes = 'https://fernando-herrera.com';

        if (barcodeScanRes == '-1') {
          return;
        }

        final scanListProvider =
            Provider.of<ScanListProvider>(context, listen: false);

        // scanListProvider.newScan(barcodeScanRes);
        // await scanListProvider.newScan('geo:26.902116,-101.417080');

        final newScan = await scanListProvider.newScan(barcodeScanRes);
        launchURL(context, newScan);
      },
      child: const Icon(Icons.filter_center_focus),
    );
  }
}
