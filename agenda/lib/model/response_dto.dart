import 'package:agenda/model/toke_dto.dart';

class ResponseDto {
  final TokenDto? token;
  final error;
  final List<dynamic>? data;

  ResponseDto(this.token, this.error, this.data);
}
