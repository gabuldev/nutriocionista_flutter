import 'dart:async';

import 'package:app_nutriocionista/src/pages/home/home_module.dart';
import 'package:app_nutriocionista/src/shared/models/alimento_model.dart';
import 'package:app_nutriocionista/src/shared/models/consulta_model.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';
import '../../consulta_repository.dart';
import 'package:trotter/trotter.dart';

enum States { awainting, done }

class Combines {
  final int index;
  final int total;
  final List alimentos;
  bool selected;

  Combines({
    this.index,
    this.total,
    this.alimentos,
    this.selected = false,
  });
}

class CreateConsultaBloc extends BlocBase {
  CreateConsultaBloc() {
    responseOut = consulta.stream.switchMap(observeConsulta);
    consultaIn = consulta.sink;
    caloriasIn = calorias.sink;
    caloriasOut = calorias.stream.asBroadcastStream();
    subscription = caloriasOut.listen(observeCaloria);
    repo = HomeModule.to.getDependency<ConsultaRepository>();
  }

  ConsultaRepository repo;
  ConsultaModel model = ConsultaModel();

  var consulta = BehaviorSubject<ConsultaModel>();
  Sink<ConsultaModel> consultaIn;
  Observable<States> responseOut;

  var calorias = BehaviorSubject<int>();
  Sink<int> caloriasIn;
  Observable<int> caloriasOut;
  var alimentos = BehaviorSubject<List<Combines>>();
  StreamSubscription subscription;

  void observeCaloria(int data) async {
    try {
      var response = await repo.getAlimentos();
      if (response.isNotEmpty) {
        var res = response.map((item) => AlimentoModel.fromJson(item)).toList();
        var combos = Combinations(3, res.map((i) => i).toList());
        List<Combines> combines = [];
        var delete = false;
        var total = 0;
        var index = 0;
        for (var item in combos()) {
          delete = false;
          total = 0;
          for (var i = 0; i < item.length; i++) {
            total += int.parse(item[i].toString().split("-")[2]);
            for (var j = i + 1; j < item.length; j++) {
              if (item[i].toString().split("-").first ==
                  item[j].toString().split("-").first) {
                delete = true;
                break;
              }
            }
          }

          if (delete == false && total <= data) {
            combines.add(Combines(alimentos: item, total: total, index: index));
            index++;
          }
        }

        if (combines.isNotEmpty)
          alimentos.sink.add(combines);
        else
          alimentos.addError(
              "Nenhum alimento encontrado com calorias menores que $data");
      } else
        alimentos.addError(
            "Nenhum alimento encontrado com calorias menores que $data");
    } catch (e) {
      alimentos.addError(e);
    }
  }

  Stream<States> observeConsulta(ConsultaModel data) async* {
    try {
      yield States.awainting;
      var response = await repo.create(data.toGraphQL());
      if (response) yield States.done;
    } catch (e) {
      throw e;
    }
  }

  void clicked(int index){
    List<Combines> list = alimentos.value;
    list.forEach((i){
          if(i.index == index){
              i.selected = true;
              model.restrict = i.alimentos.map((i) => i.nome).toString();
          }
          else{
            i.selected = false;
          }
    });


    alimentos.sink.add(list);
  }  

  void create() {
    consultaIn.add(model);
  }

  @override
  void dispose() {
    alimentos.close();
    subscription.cancel();
    calorias.close();
    caloriasIn.close();
    consulta.close();
    consultaIn.close();
    super.dispose();
  }
}
