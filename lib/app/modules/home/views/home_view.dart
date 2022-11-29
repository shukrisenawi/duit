import 'package:dropdown_search2/dropdown_search2.dart';

import 'widgets/city.dart';
import 'widgets/berat.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'widgets/province.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kirim Duit'),
        centerTitle: true,
        backgroundColor: Colors.red[900],
      ),
      body: SafeArea(
        child: ListView(padding: EdgeInsets.all(20), children: [
          Provinsi(tipe: 'asal'),
          Obx(() => controller.hiddenKotaAsal.isTrue
              ? SizedBox()
              : Kota(provId: controller.provAsalId.value, tipe: 'asal')),
          Provinsi(tipe: 'tujuan'),
          Obx(() => controller.hiddenKotaTujuan.isTrue
              ? SizedBox()
              : Kota(provId: controller.provTujuanId.value, tipe: 'tujuan')),
          BeratBarang(),
          Padding(
            padding: const EdgeInsets.only(bottom: 50),
            child: DropdownSearch<Map<String, dynamic>>(
              mode: Mode.BOTTOM_SHEET,
              items: [
                {"code": "jne", "name": "JNE"},
                {"code": "tiki", "name": "Tiki"},
                {"code": "pos", "name": "Pos"},
              ],
              popupItemBuilder: ((context, item, isSelected) => Container(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      "${item['name']}",
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                  )),
              showClearButton: true,
              itemAsString: (item) => "${item!['name']}",
              label: "Tipe Kurier",
              hint: "pilih tipe kurier",
              onChanged: (value) {
                if (value != null) {
                  controller.kurier.value = value['code'];
                  controller.showButton();
                } else {
                  controller.hiddenButton.value = true;
                  controller.kurier.value = "";
                }
                print(value);
              },
            ),
          ),
          Obx(() => controller.hiddenButton.isTrue
              ? SizedBox()
              : ElevatedButton(
                  onPressed: () => controller.kirimDuit(),
                  child: Text("CEK HARGA"),
                  style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      backgroundColor: Colors.red[900]),
                ))
        ]),
      ),
    );
  }
}
