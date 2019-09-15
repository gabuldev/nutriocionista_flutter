

import 'package:app_nutriocionista/src/pages/cliente/cliente_bloc.dart';
import 'package:app_nutriocionista/src/pages/consulta/widgets/create_cliente/create_cliente_widget.dart';
import 'package:app_nutriocionista/src/pages/consulta/widgets/create_consulta/create_consulta_widget.dart';
import 'package:app_nutriocionista/src/pages/home/home_module.dart';
import 'package:flutter/material.dart';
import 'package:app_nutriocionista/src/shared/models/client_model.dart';

class Selected {
  final List<ClientModel> list;
  final int current;

  Selected(this.list, this.current);
}

class SelectClienteWidget extends StatefulWidget {
  final Function(int catId) onTap;

  const SelectClienteWidget({Key key, this.onTap}) : super(key: key);
  @override
  _SelectClienteWidgetState createState() => _SelectClienteWidgetState();
}

class _SelectClienteWidgetState extends State<SelectClienteWidget> {
  var bloc = HomeModule.to.getBloc<ClienteBloc>();

  int current;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ClientModel>>(
        stream: bloc.clientesOut,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          } else if (snapshot.hasData) {
            Set<ClientModel> list = snapshot.data.toSet();
            list.add(ClientModel(nome: "Cadastrar novo cliente",id: 0));
            return DropdownButtonFormField(
              hint: Text("Selecione um cliente"),
              value: current,
              onChanged: (value) {
                if(value != 0){
                widget.onTap(value);
                setState(() {
                  current = value;
                });
              }else{
                Navigator.push(context, MaterialPageRoute(builder: (context) => CreateClienteWidget()));
              }


              },
              items: list
                  .map((item) => DropdownMenuItem(
                        child: item.id == 0 ?
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Icon(Icons.add_circle,color: Colors.purple,),
                            SizedBox(width: 10,),
                            Text(item.nome),
                          
                          ],
                        ):

                         Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Icon(Icons.perm_identity,color: Colors.purple,),
                            SizedBox(width: 10,),
                            Text(item.nome),
                          
                          ],
                        ),
                        value: item.id,
                      ))
                  .toList(),
            );
          } else {
            return Text("Carregando os clientes...");
          }
        });
  }
}
