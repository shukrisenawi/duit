import 'package:http/http.dart' as http;

void main() async {
  Uri url = Uri.parse('https://api.rajaongkir.com/starter/cost');
  final response = await http.post(
    url,
    headers: {
      'content-type': 'application/x-www-form-urlencoded',
      "key": "0ae702200724a396a933fa0ca4171a7e",
    },
    body: {
      "origin": "501",
      'destination': '114',
      'weight': '1700',
      'courier': 'jne',
    },
  );
  print(response.body);
}
