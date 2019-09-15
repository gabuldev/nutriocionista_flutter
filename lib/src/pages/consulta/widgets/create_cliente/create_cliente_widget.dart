import 'dart:async';

import 'package:app_nutriocionista/src/pages/home/home_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

import 'create_cliente_bloc.dart';

class CreateClienteWidget extends StatefulWidget {
  @override
  _CreateClienteWidgetState createState() => _CreateClienteWidgetState();
}

class _CreateClienteWidgetState extends State<CreateClienteWidget> {
  var bloc = HomeModule.to.getBloc<CreateClienteBloc>();
  var controller = Controller();
  var dateMask =
     MaskedTextController(mask: "00/00/00");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastrar Cliente"),
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 60.0),
        child: StreamBuilder<States>(
            stream: bloc.responseOut,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              } else if (snapshot.hasData) {
                switch (snapshot.data) {
                  case States.done:
                    {
                      Timer(Duration(seconds: 1), () {
                        Navigator.pop(context);
                      });
                      return Center(
                        child: Text("Cliente adicionado com sucesso!"),
                      );
                    }

                    break;
                  default:
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                }
              } else {
                return SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 20,
                      ),
                      Form(
                        key: controller.formkey,
                        child: Column(
                          children: <Widget>[
                            TextFormField(
                              onSaved: (value) => bloc.model.nome = value,
                              validator: (value) => value.isEmpty
                                  ? "O nome não pode ser nulo!"
                                  : null,
                              decoration: InputDecoration(labelText: "Nome"),
                            ),
                            TextFormField(
                              onSaved: (value) => bloc.model.email = value,
                              validator: (value) => value.isEmpty
                                  ? "O email não pode ser nulo!"
                                  : null,
                              decoration: InputDecoration(labelText: "Email"),
                            ),
                            TextFormField(
                              onSaved: (value) => bloc.model.telefones = value,
                              validator: (value) => value.isEmpty
                                  ? "O telefone não pode ser nulo!"
                                  : null,
                              decoration: InputDecoration(labelText: "Telefone"),
                            ),
                             TextFormField(

                              controller: dateMask,
                              onSaved: (value) => bloc.model.dataNasc = value,
                              validator: (value) => value.isEmpty
                                  ? "A data de nascimento não pode ser nula!"
                                  : null,
                              decoration: InputDecoration(labelText: "Data Nascimento"),
                              keyboardType: TextInputType.number,
                            ),
                             TextFormField(
                              onSaved: (value) => bloc.model.endereco = value,
                              validator: (value) => value.isEmpty
                                  ? "O email não pode ser nulo!"
                                  : null,
                              decoration: InputDecoration(labelText: "Endereço"),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: FlatButton(
                              color: Colors.red,
                              colorBrightness: Brightness.dark,
                              child: Text(
                                "Criar",
                              ),
                              onPressed: () {
                                if (controller.validate()) {
                                  bloc.create();
                                }
                              },
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                );
              }
            }),
      ),
    );
  }
}

class Controller {
  var formkey = GlobalKey<FormState>();

  bool validate() {
    var form = formkey.currentState;

    if (form.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }
}
