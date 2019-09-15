import 'package:app_nutriocionista/src/pages/cliente/widgets/details_cliente/details_cliente_widget.dart';
import 'package:app_nutriocionista/src/shared/models/client_model.dart';
import 'package:flutter/material.dart';

class TileClienteWidget extends StatelessWidget {
  final ClientModel snapshot;

  const TileClienteWidget({Key key, this.snapshot}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Hero(
          tag: "name_${snapshot.id}",
                  child: Material(
                    color: Colors.transparent,
            child: Text(snapshot.nome),
          ),
        ),
        subtitle: Text(snapshot.email),
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(
                builder: (context) => DetailsClienteWidget(
                  snapshot: snapshot,
                ),
                ));
        },
      ),
    );
  }
}
