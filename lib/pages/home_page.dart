import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/pages/pages.dart';
import 'package:qr_reader/providers/providers.dart';
import 'package:qr_reader/widgets/widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scanListProvider =
        Provider.of<ScanListProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Historial'),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () => scanListProvider.deleteAll(),
            icon: const Icon(Icons.delete_forever),
          )
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
    //! obtener el selected menu opt
    final uiProvider = Provider.of<UiProvider>(context);

    final int currentIndex = uiProvider.selectedMenuOpt;

    //! ESCRIBIR EN la base de datos
    // final tempScan = ScanModel(value: 'https://www.LALAL.com');
    // DBProvider.db.nuevoScanRaw(tempScan);
    //! LEER EN LA DB
    // DBProvider.db.getScanById(2).then((val) => print(val!.value),);
    // DBProvider.db.getScans().then(print);

    //! BORRAR REGISTRO/S
    // DBProvider.db.deleteAllScans();

    //? usar el scan list provider
    final scanListProvider = Provider.of<ScanListProvider>(context);
    switch (currentIndex) {
      case 0:
        scanListProvider.loadScansByType('geo');
        return const MapsPage();
      case 1:
        scanListProvider.loadScansByType('http');
        return const DirectionsPage();
      default:
        return const MapsPage();
    }
  }
}
