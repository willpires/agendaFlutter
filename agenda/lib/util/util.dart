class EndPoint {
  final url = "http://tmsolucaotecnologia.dev.br";

  static String token = '';

  String status() {
    return "$url/status";
  }

  String createUser() {
    return "$url/user/create";
  }

  String login() {
    return "$url/user/login";
  }

  String createContato() {
    return "$url/contact/create";
  }

  String updateContato() {
    return "$url/contact/update/{contactid}";
  }

  String getContato() {
    return "$url/contacts";
  }

  String getContatoId(int contacId) {
    return "$url/contact/$contacId";
  }

  String delete(int contacId) {
    return "$url/contact/$contacId";
  }
}
