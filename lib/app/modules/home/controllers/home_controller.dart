import 'dart:convert';

import 'package:duit/app/modules/home/curier_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController {
  var hiddenKotaAsal = true.obs;
  var provAsalId = 0.obs;
  var kotaAsalId = 0.obs;
  var hiddenKotaTujuan = true.obs;
  var provTujuanId = 0.obs;
  var kotaTujuanId = 0.obs;
  var hiddenButton = true.obs;
  var kurier = "".obs;

  double berat = 0.0;
  String unit = 'gram';

  late TextEditingController beratC;

  void showButton() {
    if (provAsalId != 0 &&
        provTujuanId != 0 &&
        kotaAsalId != 0 &&
        kotaTujuanId != 0 &&
        berat > 0 &&
        kurier != "")
      hiddenButton.value = false;
    else
      hiddenButton.value = true;
  }

  void kirimDuit() async {
    Uri url = Uri.parse('https://api.rajaongkir.com/starter/cost');
    try {
      final response = await http.post(
        url,
        headers: {
          'content-type': 'application/x-www-form-urlencoded',
          "key": "0ae702200724a396a933fa0ca4171a7e",
        },
        body: {
          "origin": "$kotaAsalId",
          'destination': '${kotaTujuanId}',
          'weight': '${berat}',
          'courier': '${kurier}',
        },
      );
      var data = jsonDecode(response.body) as Map<String, dynamic>;
      var result = data['rajaongkir']['results'] as List<dynamic>;

      var listAllCourier = Curier.fromJsonList(result);
      var courier = listAllCourier[0];

      print(result);
      Get.defaultDialog(
          title: courier.name!,
          content: Column(
            children: courier.costs!
                .map((e) => ListTile(
                      title: Text('${e.service}'),
                      subtitle: Text('Rp ${e.cost![0].value}'),
                      trailing: Text(courier.code == 'pos'
                          ? '${e.cost![0].etd}'
                          : '${e.cost![0].etd} HARI'),
                    ))
                .toList(),
          ));
    } catch (err) {
      print(err);
      Get.defaultDialog(
        title: "Terjadi Kesalahan",
        middleText: err.toString(),
      );
    }
  }

  void ubahBerat(String value) {
    berat = double.tryParse(value) ?? 0.0;
    String cekUnit = unit;
    switch (cekUnit) {
      case 'gram':
        berat = berat * 1;
        break;
      case 'kg':
        berat = berat * 1000;
        break;
      default:
        berat = berat;
    }

    showButton();
    print(berat);
  }

  void ubahUnit(String value) {
    berat = double.tryParse(beratC.text) ?? 0.0;
    switch (value) {
      case 'gram':
        berat = berat * 1;
        break;
      case 'kg':
        berat = berat * 1000;
        break;
      default:
        berat = berat;
    }
    unit = value;

    showButton();
    print(berat);
  }

  @override
  void onInit() {
    beratC = TextEditingController(text: "$berat");
    super.onInit();
  }

  @override
  void onClose() {
    beratC.dispose();
    super.onClose();
  }
}
