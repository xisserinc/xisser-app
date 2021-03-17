import 'package:http/http.dart' as http;

Future getData(url) async {
  http.Response response = await http.get(url);
  print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> data  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx");
  return response.body;
}