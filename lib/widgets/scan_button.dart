import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/providers/scan_list_provider.dart';

class ScanButton extends StatelessWidget {
  const ScanButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () async {
        // String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        //     '#3d8bef', 'Cancelar', false, ScanMode.QR);
        // print(barcodeScanRes);
        // const barcodeScanRes = 'https://onepiece.fandom.com/es/wiki/Nico_Robin';
        const barcodeScanRes = 'geo:-26.812028,-65.198654';

        final scanListProvider =
            Provider.of<ScanListProvider>(context, listen: false);
        scanListProvider.newScan(barcodeScanRes);
      },
      elevation: 0,
      child: const Icon(Icons.filter_center_focus),
    );
  }
}
