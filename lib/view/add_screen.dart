import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zoza_phone/controller/accessory_controller.dart';
import 'package:zoza_phone/model/model.dart';
import 'package:zoza_phone/view/widget/global_text_form.dart';

class AddScreen extends StatelessWidget {
  static const String addScreen = "addScreen";
  final formKey = GlobalKey<FormState>();
  TextEditingController id = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController price = TextEditingController();

  @override
  Widget build(BuildContext context) {
    id.text = ModalRoute.of(context)?.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        title: Text("محمد الساحر"),
        centerTitle: true,
      ),
      body: Form(
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
      ),
    );
  }
}
