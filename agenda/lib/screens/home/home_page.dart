import 'package:agenda/model/Contato.dart';
import 'package:agenda/screens/cadastro/contato/contato_page.dart';
import 'package:agenda/screens/home/home_controller.dart';
import 'package:flutter/material.dart';

import '../cadastro/contato/contato_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _home_controller = HomeController();
  late final List<Contato> _lista;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _home_controller.getContato().then((value) {
      if (value.error) {
        return print("error ao lista ");
      }

      value.data?.forEach((element) {
        final c = Contato(
            contact_id: element['contact_id'],
            name: element['name'],
            address: element['address'],
            phone: element['phone']);
        _lista.add(c);

        setState(() {});
      });
    });
  }

  teste() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Lista(_lista),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Future result =
              Navigator.push(context, MaterialPageRoute(builder: ((context) {
            return const ContatoPage();
          })));

          result.then((element) {
            final a = Contato(
                name: element['name'],
                address: element['address'],
                phone: element['phone']);

            setState(() {
              _lista.add(a);
            });
          });
        },
      ),
    );
  }
}

class Lista extends StatefulWidget {
  final List<Contato> lista;
  final controller = ContatoController();

  Lista(List<Contato> this.lista);

  @override
  State<Lista> createState() => _ListaState();
}

class _ListaState extends State<Lista> {
  @override
  Widget build(BuildContext context) {
    print("estou aqui ...");
    return ListView.builder(
        itemCount: widget.lista.length,
        itemBuilder: (context, index) {
          return Dismissible(
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              child: const Icon(
                Icons.delete,
                color: Colors.white,
              ),
            ),
            onDismissed: (a) {
              widget.controller
                  .removeContato(id: widget.lista[index].contact_id!);
            },
            key: UniqueKey(),
            direction: DismissDirection.endToStart,
            child: ListTile(
              title: Text("${widget.lista[index].name}"),
              onLongPress: () {
                Future result = Navigator.push(context,
                    MaterialPageRoute(builder: ((context) {
                  return ContatoPage(
                    nome: widget.lista[index].name,
                    telefone: widget.lista[index].phone,
                    endereco: widget.lista[index].address,
                  );
                })));

                result.then((element) {
                  final a = Contato(
                      name: element['name'],
                      address: element['address'],
                      phone: element['phone']);

                  setState(() {
                    widget.lista.add(a);
                  });
                });
              },
            ),
          );
        });
  }
}
