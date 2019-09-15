import 'dart:async';
import 'package:app_nutriocionista/src/pages/consulta/widgets/select_cliente/select_cliente_widget.dart';
import 'package:app_nutriocionista/src/pages/consulta/widgets/slider_select/slider_select_widget.dart';
import 'package:app_nutriocionista/src/pages/home/home_module.dart';
import 'package:app_nutriocionista/src/shared/models/alimento_model.dart';
import 'package:app_nutriocionista/src/shared/models/client_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'create_consulta_bloc.dart';

class CreateConsultaWidget extends StatefulWidget {
  @override
  _CreateConsultaWidgetState createState() => _CreateConsultaWidgetState();
}

class _CreateConsultaWidgetState extends State<CreateConsultaWidget> {
  var bloc = HomeModule.to.getBloc<CreateConsultaBloc>();
  var controller = Controller();
  var money =
      MoneyMaskedTextController(decimalSeparator: ",", leftSymbol: "R\$");    

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastrar consulta"),
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
                        child: Text("Consulta adicionada com sucesso!"),
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
                      SelectClienteWidget(
                        onTap: (value) {
                          bloc.model.client = ClientModel(id: value);
                        },
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      SliderSelectWidget(
                        title: "Peso",
                        onChanged: (value) {
                          bloc.model.peso = value;
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SliderSelectWidget(
                        title: "Gordura",
                        type: TypeSlider.percent,
                        onChanged: (value) {
                          bloc.model.gordura = value;
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SliderSelectWidget(
                        title: "Calorias",
                        type: TypeSlider.number,
                        onChanged: (value) {
                          bloc.caloriasIn.add(value.toInt());
                        },
                      ),
                      StreamBuilder<List<Combines>>(
                          stream: bloc.alimentos.stream,
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return Text(snapshot.error.toString());
                            } else if (snapshot.hasData) {
                              return Column(
                                mainAxisSize: MainAxisSize.min,
                                children: snapshot.data
                                    .map((item) => ExpansionTile(
                                      trailing: item.selected ? CircleAvatar(child: Icon(Icons.check,color: Colors.white),radius: 13,) : null,
                                      title: Text("Combinação ${item.index}"),
                                      children: <Widget>[]+
                                       item.alimentos.map((i) => ListTile(
                                         title: Text(i.nome),
                                         subtitle: Text(i.calorias.toString() + "calorias"),
                                         trailing: Text(i.grupo.nome),
                                       )).toList() +<Widget>[
                                         FlatButton(
                                           child: Text("Selecionar"),
                                           onPressed: (){
                                             bloc.clicked(item.index); 
                                           },
                                         )
                                       ]
                                      
                                    )).toList(),
                              );
                            } else {
                              return Container();
                            }
                          }),
                      SizedBox(
                        height: 20,
                      ),
                      Form(
                        key: controller.formkey,
                        child: Column(
                          children: <Widget>[
                            Container(
                              child: TextFormField(
                                maxLines: null,
                                onSaved: (value) => bloc.model.description = value,
                                validator: (value) =>
                                    value.isEmpty ? "Por favor descreva" : null,
                                decoration: InputDecoration(
                                    labelText: "Descreva a sensação física"),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: FlatButton(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                              color: Colors.purple,
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
                      ),
                      SizedBox(height: 30,)
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
