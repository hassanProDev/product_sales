import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:provider/provider.dart';
import 'package:zoza_phone/controller/accessory_controller.dart';
import 'package:zoza_phone/view/generate_qr.dart';
import 'package:zoza_phone/view/main_screen/widget/bottom_nav_button.dart';
import 'package:zoza_phone/view/update_screen.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    AccessoryController prov = Provider.of<AccessoryController>(context);
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BottomNavButton(
            onPressed: () {
              Navigator.pop(context);
              Printing.layoutPdf(onLayout: (PdfPageFormat format) async {
                return await prov.generateReceiptPdf();
              });
            },
            label: "print all Qr",
            icon: Icons.qr_code,
          ),
          SizedBox(
            height: 4,
          ),
          BottomNavButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushNamed(
                  context, ProductQRGeneratorScreen.productQrScreen);
            },
            label: "Add",
            icon: Icons.qr_code,
          ),
          SizedBox(
            height: 4,
          ),
          BottomNavButton(
            onPressed: () {
              Navigator.pop(context);
              prov.scannerQr(UpdateScreen.updateScreen, context);
            },
            label: "Update",
            icon: Icons.change_circle_outlined,
          ),
          SizedBox(
            height: 4,
          ),
          BottomNavButton(
            color: Colors.white,
            backgroundColor: Colors.red,
            label: "Delete",
            icon: Icons.delete,
            onPressed: () {
              Navigator.pop(context);
              prov.deleteWithQr(context);
            },
          )
        ],
      ),
    );
  }
}
