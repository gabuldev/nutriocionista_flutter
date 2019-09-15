import 'package:app_nutriocionista/src/shared/helpers/graphql_object.dart';
import 'package:app_nutriocionista/src/shared/models/client_model.dart';

class ConsultaModel {
  String data;
  String hora;
  double gordura;
  int idConsulta;
  int caloria;
  double peso;
  String restrict;
  String description;
  ClientModel client;

  ConsultaModel(
      {
      this.gordura,
      this.idConsulta,
      this.peso,
      this.restrict});

  ConsultaModel.fromJson(Map<String, dynamic> json) {
    DateTime date = DateTime.parse(json['created_at']);
    date.timeZoneOffset;
    data = "${date.day}/${date.month}";
    hora = "${date.hour}:${date.minute}";
    gordura = json['gordura'] is int ?  json['gordura'].toDouble() :  json['gordura'] ;
    idConsulta = json['id_consulta'];
    peso = json['peso'] is int ? json['peso'].toDouble() :  json['peso'] ;
    restrict = json['restrict'];
    description = json['description'];
    client = ClientModel.fromJson(json['client']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['gordura'] = this.gordura;
    data['peso'] = this.peso;
    data['restrict'] = this.restrict;
    data['id_cliente'] = this.client.id;
    data['description'] = this.description;
    return data;
  }

  String toGraphQL() => GraphObject.parse(toJson());  

}
