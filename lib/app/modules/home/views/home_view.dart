import 'dart:convert';

import 'package:dropdown_search2/dropdown_search2.dart';
import 'package:duit/app/modules/home/province_model.dart';
import 'package:http/http.dart' as http;
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
        DropdownSearch<Province>(
          label: "Provinsi",
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
          onChanged: (value) => print(value),
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
      ]),
    );
  }
}
