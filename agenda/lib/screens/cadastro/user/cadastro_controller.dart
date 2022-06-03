import 'dart:convert';

import 'package:agenda/model/response_dto.dart';
import 'package:agenda/model/toke_dto.dart';
import 'package:agenda/model/use.dart';
import 'package:agenda/util/util.dart';
import 'package:http/http.dart' as http;

class CadastroController {
  Future<ResponseDto> cadastroUser({required User user}) async {
    final endpoint = EndPoint();
    var url = Uri.parse(endpoint.createUser());
    var response = await http.post(url,
        body: {'name': user.nome, 'email': user.email, 'password': user.senha});

    if (response.statusCode == 200) {
      var decoder = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      var is_error = decoder['is_error'];

      if (is_error) {
        return ResponseDto(null, true, null);
      }
      final token = TokenDto(token: decoder['data'][0]['token']);

      EndPoint.token = token.token;

      return ResponseDto(token, false, null);
    }

    return ResponseDto(null, true, null);
  }
}
