import 'dart:convert';

import 'package:agenda/model/response_dto.dart';
import 'package:agenda/util/util.dart';
import 'package:http/http.dart' as http;

class HomeController {
  final endpoint = EndPoint();

  Future<ResponseDto> getContato() async {
    var url = Uri.parse(endpoint.getContato());

    var response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'x-access-token': '${EndPoint.token}',
    });
    var decode = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
    var is_error = decode['is_error'];
    if (response.statusCode != 200) {
      return ResponseDto(null, true, null);
    }

    if (is_error) {
      return ResponseDto(null, true, null);
    }

    return ResponseDto(null, false, decode['data']);
  }
}
