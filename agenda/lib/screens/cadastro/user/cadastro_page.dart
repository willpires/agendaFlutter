import 'package:agenda/model/use.dart';
import 'package:agenda/screens/cadastro/user/cadastro_controller.dart';
import 'package:flutter/material.dart';

class CadastroPage extends StatefulWidget {
  const CadastroPage({Key? key}) : super(key: key);

  @override
  State<CadastroPage> createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  final _formKey = GlobalKey<FormState>();
  final _nome_controller = TextEditingController();
  final _login_controller = TextEditingController();
  final _senha_controller = TextEditingController();

  final _cadastroController = CadastroController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Cadastro"),
                TextFormField(
                  controller: _nome_controller,
                  validator: ((value) {
                    if (value == null || value.isEmpty) {
                      return "Digite seu nome";
                    }
                    return null;
                  }),
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), hintText: "Nome"),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _login_controller,
                  validator: ((value) {
                    if (value == null || value.isEmpty) {
                      return "Digite seu email";
                    }
                    return null;
                  }),
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), hintText: "Login"),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _senha_controller,
                  validator: ((value) {
                    if (value == null || value.isEmpty) {
                      return "Digite sua senha";
                    }
                    return null;
                  }),
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), hintText: "Seha"),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    child: Text("Cadastrar"),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final user = User(
                            nome: _nome_controller.value.text,
                            email: _login_controller.value.text,
                            senha: _senha_controller.value.text);
                        _cadastroController
                            .cadastroUser(user: user)
                            .then((value) => {
                                  if (value.error)
                                    print("error ao cadastrar")
                                  else
                                    print("cadastrado com sucesso")
                                });
                      }
                    },
                  ),
                )
              ],
            ),
          )),
    );
  }
}
