import 'package:barcode/barcode.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:zoza_phone/controller/accessory_controller.dart';
import 'package:zoza_phone/model/model.dart';
import 'package:zoza_phone/view/widget/global_text_form.dart';

class ProductQRGeneratorScreen extends StatelessWidget {
  static const String productQrScreen = "productQrScreen";
  final formKey = GlobalKey<FormState>();
  TextEditingController id = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController price = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final barcode = Barcode.pdf417();
    AccessoryController prov = Provider.of<AccessoryController>(context);
    id.text= prov.generateUniqueCode();
    final svg = barcode.toSvg(id.text, width: 300, height: 80);
    return Scaffold(
      appBar: AppBar(
        title: const Text('محمد الساحر'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 20),
                  Container(
                    width: 300,
                    height: 80,
                    child: SvgPicture.string(
                      svg,
                      fit: BoxFit.fill,
                    ),
                  ),
                  // SizedBox(height: 12),
                  // Text(
                  //   "Code: $uniqueCode",
                  //   textAlign: TextAlign.center,
                  // ),
                  SizedBox(height: 12),
                  Form(
                    key: formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 15,
                          ),
                          GlobalTextForm(
                            hint: "id",
                            controller: id,
                            enabled: false,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          GlobalTextForm(
                            hint: "Name",
                            controller: name,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          GlobalTextForm(
                            hint: "Price",
                            controller: price,
                            textInputType: TextInputType.number,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          ElevatedButton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  Provider.of<AccessoryController>(context, listen: false)
                                      .addAccessory(
                                    AccessoryModel(
                                        name: name.text,
                                        id: id.text,
                                        price: double.parse(price.text)),
                                  );
                                  Navigator.pop(context);
                                }
                              },
                              child: Text("Add"))
                        ],
                      ),
                    ),
                  )
                ],
              ),
      ),
    );
  }
}
