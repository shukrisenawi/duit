import 'package:dropdown_search2/dropdown_search2.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kirim Duit Malaysia'),
        centerTitle: true,
      ),
      body: ListView(padding: EdgeInsets.all(20), children: [
        DropdownSearch<String>(
            mode: Mode.DIALOG,
            items: ["Brazil", "Italia (Disabled)", "Tunisia", 'Canada'],
            label: "Menu mode",
            hint: "country in menu mode",
            onChanged: print,
            showSearchBox: true,
            selectedItem: "Brazil"),
      ]),
    );
  }
}
