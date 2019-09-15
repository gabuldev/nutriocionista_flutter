import 'package:app_nutriocionista/src/pages/cliente/cliente_repository.dart';
import 'package:app_nutriocionista/src/pages/home/home_module.dart';
import 'package:app_nutriocionista/src/shared/models/client_model.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';

enum States{
  awainting,done
}

class CreateClienteBloc extends BlocBase {
   CreateClienteBloc() {
    responseOut = consulta.stream.switchMap(observeProduto).asBroadcastStream();
    consultaIn = consulta.sink;
    repo = HomeModule.to.getDependency<ClienteRepository>();
  }

  ClienteRepository repo;
  ClientModel model = ClientModel();

  var consulta = BehaviorSubject<ClientModel>();
  Sink<ClientModel> consultaIn;
  Observable<States> responseOut;

  Stream<States> observeProduto(ClientModel data) async* {
    try {
      yield States.awainting;
      var response = await repo.create(data.toGraphQL());
      if(response)
      yield States.done;
    } catch (e) {
      throw e;
    }
  }

  void create() {
    consultaIn.add(model);
  }

  @override
  void dispose() {
    consulta.close();
    consultaIn.close();
    super.dispose();
  }
}
