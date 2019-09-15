import 'package:app_nutriocionista/src/app/app_module.dart';
import 'package:app_nutriocionista/src/shared/repository/repository.dart';
import 'package:hasura_connect/hasura_connect.dart';

class ConsultaRepository implements Repository {
  @override
  HasuraConnect get connect => AppModule.to.getDependency<HasuraConnect>();

  
  Future<bool> create(String data) async {
    var response = await connect.mutation('''
     mutation {
  insert_consulta(
    objects: $data) {
    affected_rows
  }
  }
     ''');

    if (response['data']['insert_consulta']['affected_rows'] > 0) {
      return true;
    } else {
      return false;
    }
  }


  Snapshot subscription() {
    return connect.subscription('''subscription {
  consulta {
    created_at
    gordura
    id_consulta
    description
    peso
    restrict
    client {
      name
      data_nasc
    }
  }
}

''');
  }



  Future<List> getAlimentos() async{
    var response = await connect.query('''{
  alimento{
    nome
    calorias
    id_alimento
    id_grupo
    grupo {
      nome
    }
  }
}

''');
    return response['data']['alimento'];
  }




}
