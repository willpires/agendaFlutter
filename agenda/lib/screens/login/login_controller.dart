import 'dart:convert';

import 'package:agenda/model/response_dto.dart';
import 'package:agenda/model/toke_dto.dart';
import 'package:agenda/model/use.dart';
import 'package:agenda/util/util.dart';
import 'package:http/http.dart' as http;

class LoginController {
  var endpoint = EndPoint();
  Future<String> getStatusApi() async {
    var url = Uri.parse('${endpoint.status()}');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      return response.body;
    }
    return "error";
  }

  Future<ResponseDto> login(User user) async {
    var url = Uri.parse('${endpoint.login()}');
    var response = await http
        .post(url, body: {'email': "will@teste1.com", 'password': '1234'});
    var decoder = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
    var is_error = decoder["is_error"];

    if (response.statusCode != 200) {
      return ResponseDto(null, true, null);
    }

    if (is_error) {
      return ResponseDto(null, true, null);
    }

    var token = TokenDto(
      token: decoder["data"][0]["token"],
    );

    EndPoint.token = token.token;

    return ResponseDto(token, false, null);
  }
}
