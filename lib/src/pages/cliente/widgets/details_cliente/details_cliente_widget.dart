
import 'package:app_nutriocionista/src/pages/consulta/widgets/tile_consulta/tile_consulta_widget.dart';
import 'package:app_nutriocionista/src/shared/models/client_model.dart';
import 'package:app_nutriocionista/src/shared/models/consulta_model.dart';
import 'package:flutter/material.dart';

import 'details_cliente_bloc.dart';

class DetailsClienteWidget extends StatefulWidget {
  final ClientModel snapshot;

  const DetailsClienteWidget({Key key, @required this.snapshot})
      : super(key: key);
  @override
  _DetailsClienteWidgetState createState() => _DetailsClienteWidgetState();
}

class _DetailsClienteWidgetState extends State<DetailsClienteWidget> {

  var bloc = DetailsClienteBloc();

  @override
  void initState() {
    bloc.listen(widget.snapshot.id);
    super.initState();
  }  
  @override
  void dispose() {
   bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Hero(
          tag: "name_${widget.snapshot.id}",
          child: Material(
            color: Colors.transparent,
            child: Text(
              widget.snapshot.nome,
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        ),
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
                    children: list
                        .map((item) => TileConsultaWidget(
                              snapshot: item,
                            ))
                        .toList()));
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        }),
    );
  }
}
