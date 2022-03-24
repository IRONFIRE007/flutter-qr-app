import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader_app/providers/scan_list_provider.dart';
import 'package:qr_reader_app/utils/utils.dart';

class ScanTiles extends StatelessWidget {
  const ScanTiles({Key? key, required this.type}) : super(key: key);

  final String type;
  @override
  Widget build(BuildContext context) {
    final scanListProvider = Provider.of<ScanListProvider>(context);
    final scans = scanListProvider.scans;
    return ListView.builder(
        itemCount: scanListProvider.scans.length,
        itemBuilder: (_, i) => Dismissible(
              key: UniqueKey(),
              background: Container(color: Colors.indigo[800]),
              onDismissed: (dismissDirection) {
                Provider.of<ScanListProvider>(context, listen: false)
                    .deleteScanById(scans[i]!.id);
              },
              child: ListTile(
                leading: Icon(type == 'http' ? Icons.home_outlined : Icons.map,
                    color: Theme.of(context).primaryColor),
                title: Text(scans[i]!.valor),
                subtitle: Text(scans[i]!.id.toString()),
                trailing:
                    const Icon(Icons.keyboard_arrow_right, color: Colors.grey),
                onTap: () => launchURL(context, scans[i]!),
              ),
            ));
  }
}
