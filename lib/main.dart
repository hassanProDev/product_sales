import 'package:flutter/material.dart';
import 'package:zoza_phone/view/widget/global_text_form.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(),
    );
  }
}

class MainScreen extends StatefulWidget {
  TextEditingController controller=TextEditingController();
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Zoza Phone"),),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          GlobalTextForm(hint: "Search", controller: widget.controller),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: ListView.builder(
                itemCount: 0,
                itemBuilder: (context, index) {
                  return Container();
                }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          
        },
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(items: [
        BottomNavigationBarItem(
            icon: Icon(Icons.change_circle_outlined), label: "Update"),
        BottomNavigationBarItem(
            icon: Icon(Icons.document_scanner_outlined), label: "Scann"),
      ]),
    );
  }
}
