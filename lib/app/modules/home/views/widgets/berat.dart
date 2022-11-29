// ignore_for_file: deprecated_member_use

import 'package:dropdown_search2/dropdown_search2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/home_controller.dart';

class BeratBarang extends GetView<HomeController> {
  const BeratBarang({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          Expanded(
              child: TextField(
            autocorrect: false,
            controller: controller.beratC,
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(
                labelText: "Berat Barang",
                border: OutlineInputBorder(),
                hintText: "Masukkan Berat"),
            onChanged: ((value) {
              controller.ubahBerat(value);
            }),
          )),
          SizedBox(width: 20),
          Container(
            width: 150,
            child: DropdownSearch<String>(
              mode: Mode.BOTTOM_SHEET,
              showSelectedItems: true,
              showSearchBox: true,
              items: ["gram", "kg"],
              label: "Unit",
              onChanged: ((value) => controller.ubahUnit(value!)),
              selectedItem: "gram",
            ),
          )
        ],
      ),
    );
  }
}
