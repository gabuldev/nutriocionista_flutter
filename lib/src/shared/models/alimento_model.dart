import 'dart:convert';

class AlimentoModel {
  int idGrupo;
  int idAlimento;
  String nome;
  int calorias;
  Grupo grupo;

  AlimentoModel(
      {this.idGrupo, 
      this.idAlimento, 
      this.nome, this.calorias, this.grupo});

  AlimentoModel.fromJson(Map<String, dynamic> json) {
    idGrupo = json['id_grupo'];
    idAlimento = json['id_alimento'];
    nome = json['nome'];
    calorias = json['calorias'];
    grupo = json['grupo'] != null ? new Grupo.fromJson(json['grupo']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_grupo'] = this.idGrupo;
    data['id_alimento'] = this.idAlimento;
    data['nome'] = this.nome;
    data['calorias'] = this.calorias;
    if (this.grupo != null) {
      data['grupo'] = this.grupo.toJson();
    }
    return data;
  }

  @override 
  String toString() => "$idGrupo-$nome-$calorias-${grupo.nome}";
}

class Grupo {
  String nome;
  int idGrupo;

  Grupo({this.nome, this.idGrupo});

  Grupo.fromJson(Map<String, dynamic> json) {
    nome = json['nome'];
    idGrupo = json['id_grupo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nome'] = this.nome;
    data['id_grupo'] = this.idGrupo;
    return data;
  }
}
