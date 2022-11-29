// ignore_for_file: deprecated_member_use

import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:dropdown_search2/dropdown_search2.dart';

import '../../controllers/home_controller.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

import '../../province_model.dart';

class Provinsi extends GetView<HomeController> {
  const Provinsi({
    Key? key,
    required this.tipe,
  }) : super(key: key);

  final String tipe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20),
      child: DropdownSearch<Province>(
        label: tipe == "asal" ? "Provinsi Asal" : "Provinsi Tujuan",
        showClearButton: true,
        showSearchBox: true,
        onFind: (filter) async {
          Uri url = Uri.parse('https://api.rajaongkir.com/starter/province');
          try {
            final response = await http.get(url, headers: {
              "key": "0ae702200724a396a933fa0ca4171a7e",
            });

            var data = jsonDecode(response.body) as Map<String, dynamic>;

            var statusCode = data['rajaongkir']['status']['code'];
            if (statusCode != 200) {
              throw data['rajaongkir']['status']['description'];
            }

            var listAllProvince =
                data['rajaongkir']['results'] as List<dynamic>;
            var models = Province.fromJsonList(listAllProvince);
            return models;
          } catch (err) {
            return List<Province>.empty();
          }
        },
        onChanged: (prov) {
          if (prov != null) {
            if (tipe == 'asal') {
              controller.hiddenKotaAsal.value = false;
              controller.provAsalId.value = int.parse(prov.provinceId!);
            } else {
              controller.hiddenKotaTujuan.value = false;
              controller.provTujuanId.value = int.parse(prov.provinceId!);
            }
          } else {
            if (tipe == 'asal') {
              controller.hiddenKotaAsal.value = true;
              controller.provAsalId.value = 0;
            } else {
              controller.hiddenKotaTujuan.value = true;
              controller.provTujuanId.value = 0;
            }
          }
          controller.showButton();
        },
        popupItemBuilder: (context, item, isSelected) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: Text(
              "${item.province}",
              style: TextStyle(fontSize: 18),
            ),
          );
        },
        itemAsString: (item) => item!.province!,
      ),
    );
  }
}
