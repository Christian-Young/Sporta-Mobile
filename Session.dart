import 'package:http/http.dart' as http;

Map<String, String> headers = {'Content-Type': 'application/json'};

String SessionFirstName;
String SessionLastName;
String SessionEmail;
int SessionAge;
int SessionHeight;
int SessionWeight;

void updateCookie(http.Response response) {

  String rawCookie = response.headers['set-cookie'];
  if (rawCookie != null) {
    int index = rawCookie.indexOf(';');
    headers['cookie'] =
    (index == -1) ? rawCookie : rawCookie.substring(0, index);
  }
}
