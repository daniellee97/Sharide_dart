import 'package:http/http.dart' as http;

String authority = "192.168.1.83:3000";

// var url = Uri.https(authority, )
void main() {
  print("Hello world");
  Future sample = logInSample("none", "none");
  

}

// bool isLoggedInSuccessfully(bool asDriver, String Username, String Password) {
//   var url = Uri.https()
//   return true;


// }

Future logInSample(String username, String password) async {
  var url = Uri.http(authority, '/customers/logIn');
  print('dfd ${url}');
  var response = await http.post(url, body: {'sjsu_email':'sampleStudent@sjsu.edu', 'password': 'samplePassword'});
  print('Response status: ${response.statusCode}');
  print('Response body: ${response.body}');

  return true;
}

