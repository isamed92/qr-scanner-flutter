import 'package:flutter/foundation.dart';
import 'package:qr_reader/models/models.dart';
import 'package:qr_reader/providers/providers.dart';

class ScanListProvider extends ChangeNotifier {
  List<ScanModel> scans = [];

  String selectedType = 'http';

  newScan(String value) async {
    final nScan = ScanModel(value: value);

    final id = await DBProvider.db.newScan(nScan);

    nScan.id = id;

    if (selectedType == nScan.type) {
      scans.add(nScan);
      notifyListeners();
    }
  }

  loadScans() async {
    final scans = await DBProvider.db.getScans();

    this.scans = [...scans];
    notifyListeners();
  }

  loadScansByType(String type) async {
    final scans = await DBProvider.db.getScansByType(type);

    this.scans = [...scans];
    notifyListeners();
  }

  deleteAll() async {
    await DBProvider.db.deleteAllScans();
    scans = [];
    notifyListeners();
  }

  deleteScanById(int id) async {
    await DBProvider.db.deleteScan(id);
    loadScansByType(selectedType);
  }
}
