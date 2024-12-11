import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zoza_phone/controller/accessory_controller.dart';
import 'package:zoza_phone/view/update_screen.dart';
import 'package:zoza_phone/view/view_item.dart';

import 'bottom_nav_button.dart';

class MainBottomBar extends StatelessWidget {
  const MainBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    AccessoryController prov = Provider.of<AccessoryController>(context);

    return BottomAppBar(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [

        BottomNavButton(
          onPressed: () {
            prov.scannerQr(ViewItem.viewItem, context);
          },
          label: "Price",
          icon: Icons.document_scanner_outlined,
        ),
      ],
    ));
  }
}
