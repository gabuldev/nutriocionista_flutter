import 'package:app_nutriocionista/src/shared/helpers/graphql_object.dart';

class ClientModel {
  String nome;
  String endereco;
  String telefones;
  String email;
  String dataNasc;
  int id;

  ClientModel(
      {this.nome, this.endereco, this.telefones, this.email, this.dataNasc,this.id});

  ClientModel.fromJson(Map<String, dynamic> json) {
    nome = json['name'];
    endereco = json['endereco'];
    telefones = json['telefone'];
    email = json['email'];
    dataNasc = json['data_nasc'];
    id = json['id_client'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.nome;
    data['endereco'] = this.endereco;
    data['telefone'] = this.telefones;
    data['email'] = this.email;
    data['data_nasc'] = this.dataNasc;
    return data;
  }

    String toGraphQL() => GraphObject.parse(toJson());  

    @override 
    String toString() => this.nome;

}
