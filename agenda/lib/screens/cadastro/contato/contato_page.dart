import 'package:agenda/model/Contato.dart';
import 'package:agenda/model/use.dart';
import 'package:agenda/screens/home/home_page.dart';
import 'package:flutter/material.dart';

import 'contato_controller.dart';

class ContatoPage extends StatefulWidget {
  final String? nome;
  final String? telefone;
  final String? endereco;
  const ContatoPage({this.nome = "", this.telefone = "", this.endereco = ""});

  @override
  State<ContatoPage> createState() => _ContatoPageState();
}

class _ContatoPageState extends State<ContatoPage> {
  final _formKey = GlobalKey<FormState>();
  final _nome_controller = TextEditingController();
  final _telefone_controller = TextEditingController();
  final _address_controller = TextEditingController();

  _ContatoPageState();

  final _cadastroContatoController = ContatoController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("nome ${widget.nome}");
    _nome_controller.text = widget.nome!;
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
                const Text("Cadastro contato"),
                const SizedBox(height: 10),
                TextFormField(
                  // initialValue: (widget.nome == null) ? "" : widget.nome,
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
                  // initialValue: (widget.telefone == null) ? "" : widget.telefone,

                  controller: _telefone_controller,
                  validator: ((value) {
                    if (value == null || value.isEmpty) {
                      return "Digite seu telefone";
                    }
                    return null;
                  }),
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), hintText: "telefone"),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  // initialValue:(widget.endereco == null) ? "" : widget.endereco,

                  controller: _address_controller,
                  validator: ((value) {
                    if (value == null || value.isEmpty) {
                      return "Digite seu endereco";
                    }
                    return null;
                  }),
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), hintText: "address"),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: ElevatedButton(
                      child: Text("Cadastrar"),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          final contato = Contato(
                              name: _nome_controller.value.text,
                              address: _address_controller.value.text,
                              phone: _telefone_controller.value.text);
                          _cadastroContatoController
                              .cadastroContato(contato: contato)
                              .then((value) {
                            if (value.error) {
                              return "Error ao cadastrar";
                            }
                            // return Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => HomePage()));

                            Navigator.pop(context, contato);
                          });
                        }
                      }),
                )
              ],
            ),
          )),
    );
  }
}
