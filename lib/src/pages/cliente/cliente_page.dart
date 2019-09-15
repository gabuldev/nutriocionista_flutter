import 'package:app_nutriocionista/src/pages/cliente/cliente_bloc.dart';
import 'package:app_nutriocionista/src/pages/cliente/widgets/tile_cliente/tile_cliente_widget.dart';
import 'package:app_nutriocionista/src/pages/home/home_module.dart';
import 'package:app_nutriocionista/src/shared/models/client_model.dart';
import 'package:flutter/material.dart';

class ClientePage extends StatefulWidget {
  @override
  _ClientePageState createState() => _ClientePageState();
}

class _ClientePageState extends State<ClientePage> {
     ClienteBloc bloc = HomeModule.to.getBloc<ClienteBloc>();

  @override
  Widget build(BuildContext context) {

    return StreamBuilder<List<ClientModel>>(
        stream: bloc.clientesOut,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          } else if (snapshot.hasData) {
            List<ClientModel> list = snapshot.data;
            return SingleChildScrollView(
                child: Column(
                    children: list
                        .map((item) => TileClienteWidget(
                              snapshot: item,
                            ))
                        .toList()));
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
