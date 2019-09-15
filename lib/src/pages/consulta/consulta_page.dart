import 'package:app_nutriocionista/src/pages/consulta/widgets/create_consulta/create_consulta_widget.dart';
import 'package:app_nutriocionista/src/pages/home/home_module.dart';
import 'package:app_nutriocionista/src/shared/models/consulta_model.dart';
import 'package:flutter/material.dart';
import 'consulta_bloc.dart';
import 'widgets/tile_consulta/tile_consulta_widget.dart';

class ConsultaPage extends StatefulWidget {
  @override
  _ConsultaPageState createState() => _ConsultaPageState();
}

class _ConsultaPageState extends State<ConsultaPage> {
  ConsultaBloc bloc = HomeModule.to.getBloc<ConsultaBloc>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
          child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton.extended(
          icon: Icon(Icons.add),
          label: Text("Nova Consulta"),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => CreateConsultaWidget()));
          },
        ),
        body: StreamBuilder<List<ConsultaModel>>(
            stream: bloc.consultasOut,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(child: Text(snapshot.error.toString()));
              } else if (snapshot.hasData) {
                List<ConsultaModel> list = snapshot.data;
                return SingleChildScrollView(
                    child: Column(
                        children: <Widget>[] + list
                            .map((item) => TileConsultaWidget(
                                  snapshot: item,
                                ))
                            .toList()+ <Widget>[
                              SizedBox(height: 100,)
                            ]) );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
      ),
    );
  }
}
