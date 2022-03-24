import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_reader_app/providers/db_provider.dart';

class ScanListProvider extends ChangeNotifier {
  List<ScanModel?> scans = [];
  String typeSelect = 'http';

  Future<ScanModel> newScan(String valor) async {
    final newScan = new ScanModel(valor: valor);
    final id = await DBProvider.db.newScan(newScan);
    //Asignar el id de la base de datos al modelo
    newScan.id = id;
    if (this.typeSelect == newScan.tipo) {
      this.scans.add(newScan);
      notifyListeners();
    }

    return newScan;
  }

  loadScans() async {
    final scans = await DBProvider.db.getScanAll();
    this.scans = [...scans];
  }

  loadScansByType(String type) async {
    final scans = await DBProvider.db.getScanByType(type);
    this.scans = [...scans];
    this.typeSelect = type;
    notifyListeners();
  }

  deleteAll() async {
    await DBProvider.db.deleteAllScans();
    this.scans = [];
    notifyListeners();
  }

  deleteScanById(int? id) async {
    await DBProvider.db.deleteScan(id!);
  }
}
