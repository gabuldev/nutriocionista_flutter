import 'dart:async';

import 'package:app_nutriocionista/src/pages/home/home_module.dart';
import 'package:app_nutriocionista/src/shared/models/consulta_model.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:hasura_connect/hasura_connect.dart';
import 'package:rxdart/rxdart.dart';

import '../../cliente_repository.dart';

class DetailsClienteBloc extends BlocBase {
     //? Constructor
  DetailsClienteBloc() {
    consultasOut = consultas.stream;
    consultasIn = consultas.sink;

    repo = HomeModule.to.getDependency<ClienteRepository>();
   // getCardapio();
  }

  ClienteRepository repo;
  Snapshot snapshot;

//! Subscritpion

  StreamSubscription consultasubscription;


//! LISTEN

  void listen(int idCliente){
    snapshot = repo.subscriptionConsulta(idCliente);
   consultasubscription = snapshot.stream.listen((data){
      if(data!=null){
       createCategoria(data['data']['consulta']);
      }
    });

  }

//!STREAMS
  var consultas = BehaviorSubject<List<ConsultaModel>>();
  Observable<List<ConsultaModel>> consultasOut;
  Sink<List<ConsultaModel>> consultasIn;

  //? FUNCTIONS

  void createCategoria(List data) async {
    try{
    List<ConsultaModel> list;
    list = data
        .map(
            (item) => ConsultaModel.fromJson(item))
        .toList();
     if(list.isNotEmpty)   
    consultasIn.add(list);
    else
    throw "Nenhum consulta encontrado";
    }catch(e){
      consultas.addError(e);
    }
  }

  @override
  void dispose() {
    consultasIn.close();
    consultas.close();
    consultasubscription.cancel();
    snapshot.close();
    super.dispose();
  }
}
