import 'dart:convert';
import 'package:epicup/models/data_map.dart';
import 'package:epicup/models/login.dart';
import 'package:epicup/services/url.dart' as url;
import 'package:http/http.dart' as http;

class UserService {
  Future registerUser(datas) async {
    var uri = Uri.parse(url.BaseUrl + "/auth/register");
    var register = await http.post(uri, body: datas);

    var data = json.decode(register.body);
    print(data);
    if (register.statusCode == 200) {
      if (data["status"] == true) {
        DataMap response = DataMap(
            status: true, message: "Sukses menambah user", data: data);
        return response;
      } else {
        var message = '';
        for (String key in data["message"].keys) {
          message += data["message"][key][0].toString() + '\n';
        }
        DataMap response =
            DataMap(status: false, message: message);
        return response;
      }
    } else {
      DataMap response = DataMap(
          status: false,
          message:
              "gagal menambah user dengan code error ${register.statusCode}");
      return response ;
    }
  }

  Future loginUser(datas) async {
    var uri = Uri.parse(url.BaseUrl + "/login");
    var login = await http.post(uri, body: datas);

    var data = json.decode(login.body);
    print(data);
    if (login.statusCode == 200) {
      if (data["status"] == true) {
        Login login = Login(
            status: data["status"],
            token: data["token"],
            message: data["message"],
            id: data["user"]["id"],
            name: data["user"]["name"],
            email: data["user"]["email"],
            role: data["user"]["role"]);
        // await Login.prefs();
        DataMap response = DataMap(
            status: true, message: "Sukses login user", data: data);
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
              "gagal menambah user dengan code error ${login.statusCode}");
      return response;
    }
  }
}
