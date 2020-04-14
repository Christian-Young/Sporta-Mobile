import 'package:http/http.dart' as http;

Map<String, String> headers = {'Content-Type': 'application/json'};

void updateCookie(http.Response response) {

  String rawCookie = response.headers['set-cookie'];
  if (rawCookie != null) {
    int index = rawCookie.indexOf(';');
    headers['cookie'] =
    (index == -1) ? rawCookie : rawCookie.substring(0, index);
  }
}