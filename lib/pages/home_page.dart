import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader_app/pages/adress_page.dart';
import 'package:qr_reader_app/pages/maps_page.dart';
import 'package:qr_reader_app/providers/scan_list_provider.dart';
import 'package:qr_reader_app/providers/ui_provider.dart';
import 'package:qr_reader_app/widgets/custom_navigatorbar.dart';
import 'package:qr_reader_app/widgets/scan_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Historial')),
        actions: [
          IconButton(
              onPressed: () {
                final scanListProvider =
                    Provider.of<ScanListProvider>(context, listen: false);
                scanListProvider.deleteAll();
              },
              icon: const Icon(Icons.delete_forever))
        ],
      ),
      body: _HomePageBody(),
      bottomNavigationBar: const CustomNavigatorBar(),
      floatingActionButton: const ScanButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class _HomePageBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context);
    final currentIndex = uiProvider.selectedMenuOpt;

    // final tempScan = new ScanModel(valor: 'http/LMA.com');
    //Read Database
    // DBProvider.db.newScan(tempScan);
    // DBProvider.db.getScanById(1).then((scan) => print(scan!.valor));
    // DBProvider.db.getScanAll().then(print);

    //Use ScanListProvider
    final scanListProvider =
        Provider.of<ScanListProvider>(context, listen: false);

    switch (currentIndex) {
      case 0:
        scanListProvider.loadScansByType('geo');
        return const MapsPage();
      case 1:
        scanListProvider.loadScansByType('http');
        return const AdressPage();

      default:
        return const MapsPage();
    }
  }
}
