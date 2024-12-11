import 'package:barcode/barcode.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive/hive.dart';
import 'package:pdf/pdf.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';
import 'package:uuid/uuid.dart';
import 'package:zoza_phone/model/model.dart';
import 'package:zoza_phone/view/add_screen.dart';
import 'package:zoza_phone/view/update_screen.dart';
import 'package:zoza_phone/view/view_item.dart';
import 'dart:typed_data';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/material.dart';

class AccessoryController with ChangeNotifier {
  final String _accessoryKey = "accessory";
  final String _qrCode = "qrCode";

  final box = Hive.box("data");
  final barcode = Barcode.pdf417();

  void scannerQr(String nav, BuildContext context) async {
    String? res = await SimpleBarcodeScanner.scanBarcode(
      context,
      barcodeAppBar: const BarcodeAppBar(
        appBarTitle: 'Test',
        centerTitle: false,
        enableBackButton: true,
      ),
      isShowFlashIcon: true,
      delayMillis: 2000,
      cameraFace: CameraFace.back,
    );

    if (res != null && res != -1) {
      if (nav == AddScreen.addScreen) {
        if (getData(res).price == -1) {
          Navigator.pushNamed(context, nav, arguments: res);
        }
      }

      if (nav == UpdateScreen.updateScreen) {
        if (getData(res).price != -1) {
          Navigator.pushNamed(context, nav, arguments: getData(res));
        }
      }
      if (nav == ViewItem.viewItem) {
        if (getData(res).price != -1) {
          Navigator.pushNamed(context, nav, arguments: getData(res));
        }
      }
    }
  }

  void deleteById(String id) {
    List list = box.get(_accessoryKey, defaultValue: []);
    list.removeWhere((e) => e['id'] == id);
    box.put(_accessoryKey, list);
    notifyListeners();
  }

  void deleteWithQr(BuildContext context) async {
    String? res = await SimpleBarcodeScanner.scanBarcode(
      context,
      barcodeAppBar: const BarcodeAppBar(
        appBarTitle: 'Test',
        centerTitle: false,
        enableBackButton: true,
      ),
      isShowFlashIcon: true,
      delayMillis: 2000,
      cameraFace: CameraFace.back,
    );
    if (res != null && res != -1) {
      deleteById(res);
    }
  }

  void searchLissener() {
    notifyListeners();
  }

  void addAccessory(AccessoryModel accessory) {
    List list = box.get(_accessoryKey, defaultValue: []);
    list.add(accessory.toJson());
    box.put(_accessoryKey, list);
    notifyListeners();
  }

  void updateAccessory(AccessoryModel accessory) {
    List list = box.get(_accessoryKey, defaultValue: []);
    list.removeWhere((e) => AccessoryModel.fromJson(e).id == accessory.id);
    list.add(accessory.toJson());
    box.put(_accessoryKey, list);
    notifyListeners();
  }

  AccessoryModel getData(String id) {
    List list = box.get(_accessoryKey, defaultValue: []);
    return list
        .map((e) => AccessoryModel.fromJson(e))
        .firstWhere((e) => e.id == id, orElse: () {
      return AccessoryModel(name: "name", id: "id", price: -1);
    });
  }

  List<AccessoryModel> getAllData() {
    List list = box.get(_accessoryKey, defaultValue: []);
    return list.map((e) => AccessoryModel.fromJson(e)).toList();
  }

  String generateUniqueCode() {
    final Uuid uuid = Uuid();
    List list = box.get(_qrCode, defaultValue: []);
    String newCode;
    do {
      newCode = uuid.v4(); // Generate a random unique identifier
    } while (list.contains(newCode)); // Ensure no duplicates
    list.add(newCode); // Add to the set of generated codes
    box.put(_qrCode, list);
    notifyListeners();
    return newCode;
  }

  Future<Uint8List> generateReceiptPdf() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.roll80,
        build: (context) {
          List list = (box.get(_qrCode, defaultValue: []) as List)
              .where((e) => getData(e).price != -1)
              .toList();
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              // Header Section
              pw.Text(
                'Mohamed EL Magic',
                style:
                    pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
              ),
              // pw.Text('1234 Flutter Street'),
              // pw.Text('City, Country'),
              // pw.SizedBox(height: 10),
              pw.Text('Barcodes:',
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
              pw.Divider(),

              // Items Section

              pw.ListView.separated(
                itemCount: list.length, // Replace with your items count
                itemBuilder: (context, index) {
                  String svg =
                      barcode.toSvg(list[index], width: 100, height: 20);

                  return pw.Column(children: [
                    pw.Text(
                      getData(list[index]).name,
                      style: pw.TextStyle(
                        fontSize: 12,
                      ),
                    ),
                    pw.SizedBox(height: 8),
                    pw.Container(
                      width: 100,
                      height: 20,
                      child: pw.SvgImage.new(
                        svg: svg as String,
                        fit: pw.BoxFit.fill,
                      ),
                    ),
                    pw.SizedBox(height: 8),
                  ]);
                }, separatorBuilder: ( context,  index) { return pw.Divider(); },
              ),
              // pw.Divider(),

              // Total Section
              // pw.Row(
              //   mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              //   children: [
              //     pw.Text('Total:',
              //         style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
              //     pw.Text('\$30.00'),
              //   ],
              // ),
              // pw.SizedBox(height: 10),
              //
              // // Footer Section
              // pw.Text('Thank you for your visit!',
              //     textAlign: pw.TextAlign.center),
              // pw.SizedBox(height: 5),
              // pw.Text('Visit us again!', textAlign: pw.TextAlign.center),
            ],
          );
        },
      ),
    );

    return pdf.save();
  }
}
