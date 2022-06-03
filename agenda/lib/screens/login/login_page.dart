import 'package:agenda/model/use.dart';
import 'package:agenda/screens/cadastro/user/cadastro_page.dart';
import 'package:agenda/screens/home/home_page.dart';
import 'package:agenda/screens/login/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _loginController = LoginController();
  var messagem = "teste";
  final _formKey = GlobalKey<FormState>();
  final _nome_controller = TextEditingController();
  final _login_controller = TextEditingController();
  final _senha_controller = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

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
                const Text("Login"),
                const SizedBox(
                  height: 10,
                ),
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
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    child: const Text("Login"),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final user = User(
                            nome: "",
                            email: _login_controller.value.text,
                            senha: _senha_controller.value.text);

                        _loginController.login(user).then((value) => {
                              if (value.error)
                                print("error ao logar")
                              else
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HomePage()))
                            });
                      }
                    },
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CadastroPage()));
                    },
                    child: Text("Cadastrar conta"))
              ],
            ),
          )),
    );
  }
}
