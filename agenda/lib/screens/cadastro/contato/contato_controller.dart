import 'dart:convert';

import 'package:agenda/model/Contato.dart';
import 'package:agenda/model/response_dto.dart';
import 'package:agenda/util/util.dart';
import 'package:http/http.dart' as http;

class ContatoController {
  final endpoint = EndPoint();

  Future<ResponseDto> cadastroContato({required Contato contato}) async {
    var url = Uri.parse(endpoint.createContato());

    Map<String, String> header = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'x-access-token': '${EndPoint.token}',
    };

    final parans = jsonEncode({
      'name': contato.name,
      'phone': contato.phone,
      'address': contato.address
    });

    var response = await http.post(url, headers: header, body: parans);

    if (response.statusCode == 200) {
      var decoder = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      var is_error = decoder['is_error'];

      if (is_error) {
        return ResponseDto(null, true, null);
      }

      return ResponseDto(null, false, null);
    }

    return ResponseDto(null, true, null);
  }

  Future<ResponseDto> removeContato({required int id}) async {
    var url = Uri.parse(endpoint.delete(id));

    Map<String, String> header = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'x-access-token': '${EndPoint.token}',
    };

    var response = await http.delete(url, headers: header);

    if (response.statusCode == 200) {
      var decoder = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      var is_error = decoder['is_error'];

      if (is_error) {
        return ResponseDto(null, true, null);
      }

      return ResponseDto(null, false, null);
    }

    return ResponseDto(null, true, null);
  }
}
