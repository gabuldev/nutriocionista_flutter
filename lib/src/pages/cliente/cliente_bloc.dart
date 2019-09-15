import 'dart:async';

import 'package:app_nutriocionista/src/pages/home/home_module.dart';
import 'package:app_nutriocionista/src/shared/models/client_model.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:hasura_connect/hasura_connect.dart';
import 'package:rxdart/rxdart.dart';
import 'cliente_repository.dart';

class ClienteBloc extends BlocBase {
    //? Constructor
  ClienteBloc() {
    clientesOut = clientes.stream;
    clientesIn = clientes.sink;

    repo = HomeModule.to.getDependency<ClienteRepository>();
   // getCardapio();
    listen();
  }

  ClienteRepository repo;
  Snapshot snapshot;

//! Subscritpion

  StreamSubscription clientesubscription;


//! LISTEN

  void listen(){
    snapshot = repo.subscription();
   clientesubscription = snapshot.stream.listen((data){
      if(data!=null){
       createCategoria(data['data']['client']);
      }
    });

  }

//!STREAMS
  var clientes = BehaviorSubject<List<ClientModel>>();
  Observable<List<ClientModel>> clientesOut;
  Sink<List<ClientModel>> clientesIn;

  //? FUNCTIONS

  void createCategoria(List data) async {
    try{
    List<ClientModel> list;
    list = data
        .map(
            (item) => ClientModel.fromJson(item))
        .toList();
     if(list.isNotEmpty)   
    clientesIn.add(list);
    else
    throw "Nenhum cliente encontrado";
    }catch(e){
      clientes.addError(e);
    }
  }

  @override
  void dispose() {
    clientesIn.close();
    clientes.close();
    clientesubscription.cancel();
    snapshot.close();
    super.dispose();
  }
}
