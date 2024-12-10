import 'package:flutter/material.dart';
import 'package:zoza_phone/view/widget/global_text_form.dart';

class AddScreen extends StatefulWidget {
  final formKey = GlobalKey<FormState>();
  TextEditingController id = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController price = TextEditingController();

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: widget.formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GlobalTextForm(hint: "id", controller: widget.id),
            GlobalTextForm(hint: "Name", controller:widget.name,),
            GlobalTextForm(hint: "Price", controller: widget.price),
            ElevatedButton(onPressed: () {
              if(widget.formKey.currentState!.validate()){

              }
            }, child: Text("Add"))
          ],
        ),
      ),
    );
  }
}
