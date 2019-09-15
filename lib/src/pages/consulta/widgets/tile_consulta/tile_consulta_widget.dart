
import 'package:app_nutriocionista/src/shared/models/consulta_model.dart';
import 'package:flutter/material.dart';

class TileConsultaWidget extends StatelessWidget {
  final ConsultaModel snapshot;

  const TileConsultaWidget({Key key, this.snapshot}) : super(key: key);
  Widget build(BuildContext context) {
    return Card(
          child: ExpansionTile(
        title: Text(" Consulta de  ${snapshot.client.nome} -  ${snapshot.data} às ${snapshot.hora}"),
        children: <Widget>[
          ListTile(
            title: Text("Data nascimento"),
            subtitle: Text("${snapshot.client.dataNasc}"),
          ),
          ListTile(
            title: Text("Gordura"),
            subtitle: Text("${snapshot.gordura} %"),
          ),
          ListTile(
            title: Text("Peso"),
            subtitle: Text("${snapshot.peso} kg"),
          ),
           ListTile(
            title: Text("Restrições"),
            subtitle: Text("${snapshot.restrict}"),
          ),
          ListTile(
            title: Text("Descrição física"),
            subtitle: Text("${snapshot.description}"),
          )
        ],
      ),
    );
  }
}
