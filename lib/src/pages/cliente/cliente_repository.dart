import 'package:app_nutriocionista/src/app/app_module.dart';
import 'package:app_nutriocionista/src/shared/repository/repository.dart';
import 'package:hasura_connect/hasura_connect.dart';

class ClienteRepository implements Repository {
  @override
  HasuraConnect get connect => AppModule.to.getDependency<HasuraConnect>();

  
  Future<bool> create(String data) async {
    var response = await connect.mutation('''
 mutation {
  insert_client(
    objects: $data ) {
    affected_rows
  }
}
     ''');

    if (response['data']['insert_client']['affected_rows'] > 0) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> update({String data, int id}) async {
    var response = await connect.mutation('''
    mutation {
  update_client(
    _set: $data, 
    where: {id_client: {_eq: $id}) {
    affected_rows
  }
}

     ''');

    if (response['data']['update_client']['affected_rows'] > 0) {
      return true;
    } else {
      return false;
    }
  }

  Snapshot subscription() {
    return connect.subscription('''subscription {
  client {
    data_nasc
    email
    endereco
    id_client
    name
  }
}
''');
  }

    Snapshot subscriptionConsulta(int idCliente) {
    return connect.subscription('''subscription {
  consulta(where: {id_cliente: {_eq: $idCliente}}) {
    created_at
    gordura
    id_consulta
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

}
