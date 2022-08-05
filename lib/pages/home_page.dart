import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/pages/pages.dart';
import 'package:qr_reader/providers/providers.dart';
import 'package:qr_reader/widgets/scan_button.dart';
import 'package:qr_reader/widgets/widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Historial'),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {},
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
    DBProvider.db.deleteAllScans();

    switch (currentIndex) {
      case 0:
        return const MapsPage();
      case 1:
        return const DirectionsPage();
      default:
        return const MapsPage();
    }
  }
}
