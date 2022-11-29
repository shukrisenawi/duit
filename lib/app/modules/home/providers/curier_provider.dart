import 'package:get/get.dart';

import '../curier_model.dart';

class CurierProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return Curier.fromJson(map);
      if (map is List) return map.map((item) => Curier.fromJson(item)).toList();
    };
    httpClient.baseUrl = 'YOUR-API-URL';
  }

  Future<Curier?> getCurier(int id) async {
    final response = await get('curier/$id');
    return response.body;
  }

  Future<Response<Curier>> postCurier(Curier curier) async =>
      await post('curier', curier);
  Future<Response> deleteCurier(int id) async => await delete('curier/$id');
}
