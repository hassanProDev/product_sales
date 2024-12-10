

import 'package:flutter/material.dart';
import 'package:zoza_phone/view/widget/global_text_form.dart';

class UpdateScreen extends StatefulWidget {
  final formKey = GlobalKey<FormState>();
  TextEditingController id = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController price = TextEditingController();
  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
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
