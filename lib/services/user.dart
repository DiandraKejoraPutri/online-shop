import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:epicup/models/data_map.dart';
import 'package:epicup/models/login.dart';
import 'package:epicup/services/url.dart' as url;

class UserService {
  Future<DataMap> registerUser(Map<String, dynamic> data) async {
    var uri = Uri.parse("${url.BaseUrl}/auth/register");

    try {
      var response = await http.post(
        uri,
        headers: {
          "Content-Type": "application/json", 
          "Accept": "application/json",
        },
        body: jsonEncode(data), 
      );

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        if (jsonData["status"] == true) {
          return DataMap(status: true, message: "Sukses menambah user", data: jsonData);
        } else {
          return DataMap(status: false, message: jsonData["message"].toString());
        }
      } else {
        return DataMap(status: false, message: "Gagal menambah user. Error: ${response.statusCode}");
      }
    } catch (e) {
      return DataMap(status: false, message: "Terjadi kesalahan: $e");
    }
  }
}

  Future login(datas) async {
    var uri = Uri.parse(url.BaseUrl + "/auth/login");
    var register = await http.post(uri, body: datas);

var data = json.decode(register.body);
print(data);
    if (register.statusCode == 200) {
      
      if (data["status"] == true) {
        Login login = Login(
            status: data["status"],
            token: data["token"],
            message: data["message"],
            id: data["user"]["id"],
            name: data["user"]["name"],
            email: data["user"]["email"],
            role: data["user"]["role"]);
        await login.prefs();
        DataMap response = DataMap(
            status: true, message: "Sukses login", data: data);
        return response;
      } else {
        DataMap response =
            DataMap(status: false, message: 'Email dan password salah');
        return response;
      }
    } else {
      DataMap response = DataMap(
          status: false,
          message:
              "gagal menambah user dengan code error ${register.statusCode}");
      return response;
    }
  }