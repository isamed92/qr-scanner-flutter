import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/utils/utils.dart';

import '../providers/providers.dart';

class ScanTiles extends StatelessWidget {
  final String type;
  const ScanTiles({Key? key, required this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scanListProvider = Provider.of<ScanListProvider>(context);
    final scans = scanListProvider.scans;
    return ListView.builder(
      itemCount: scans.length,
      itemBuilder: (context, index) => Dismissible(
        key: Key(scans[index].id.toString()),
        background: Container(
          color: Colors.red,
        ),
        onDismissed: (direction) {
          scanListProvider.deleteScanById(scans[index].id!);
        },
        child: ListTile(
          leading: Icon(
              type == 'http' ? Icons.home_outlined : Icons.map_outlined,
              color: Theme.of(context).primaryColor),
          title: Text(scans[index].value),
          subtitle: Text(scans[index].id.toString()),
          trailing: const Icon(
            Icons.keyboard_arrow_right,
            color: Colors.grey,
          ),
          onTap: () => launch(context, scans[index]),
        ),
      ),
    );
  }
}
