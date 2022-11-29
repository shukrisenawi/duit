// ignore_for_file: deprecated_member_use

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:dropdown_search2/dropdown_search2.dart';
import 'package:get/get.dart';
import '../../city_model.dart';
import 'package:http/http.dart' as http;

import '../../controllers/home_controller.dart';

class Kota extends GetView<HomeController> {
  const Kota({Key? key, required this.provId, required this.tipe})
      : super(key: key);

  final int provId;
  final String tipe;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(bottom: 20),
        child: DropdownSearch<City>(
          label: tipe == 'asal' ? "Kota Asal" : "Kota Tujuan",
          showSearchBox: true,
          showClearButton: true,
          onFind: (filter) async {
            Uri url = Uri.parse(
                "https://api.rajaongkir.com/starter/city?province=$provId");
            try {
              final response = await http.get(url, headers: {
                "key": "0ae702200724a396a933fa0ca4171a7e",
              });

              var data = jsonDecode(response.body) as Map<String, dynamic>;

              var statusCode = data['rajaongkir']['status']['code'];
              if (statusCode != 200) {
                throw data['rajaongkir']['status']['description'];
              }

              var listAllCity = data['rajaongkir']['results'] as List<dynamic>;
              var models = City.fromJsonList(listAllCity);
              return models;
            } catch (err) {
              return List<City>.empty();
            }
          },
          onChanged: (cityValue) {
            if (cityValue != null) {
              if (tipe == 'asal') {
                controller.kotaAsalId.value = int.parse(cityValue.cityId!);
              } else {
                controller.kotaTujuanId.value = int.parse(cityValue.cityId!);
              }
            } else {
              if (tipe == 'asal') {
                print('Tidak pilih kota asal');
                controller.kotaAsalId.value = 0;
              } else {
                print('Tidak pilih kota tujuan');
                controller.kotaTujuanId.value = 0;
              }
            }
            controller.showButton();
          },
          popupItemBuilder: (context, item, isSelected) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: Text(
                "${item.cityName}",
                style: TextStyle(fontSize: 18),
              ),
            );
          },
          itemAsString: (item) => item!.cityName!,
        ));
  }
}
