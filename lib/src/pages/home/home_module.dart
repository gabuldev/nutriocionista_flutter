
import 'package:app_nutriocionista/src/pages/cliente/cliente_bloc.dart';
import 'package:app_nutriocionista/src/pages/cliente/cliente_repository.dart';
import 'package:app_nutriocionista/src/pages/cliente/widgets/tile_cliente/tile_cliente_bloc.dart';
import 'package:app_nutriocionista/src/pages/consulta/consulta_bloc.dart';
import 'package:app_nutriocionista/src/pages/consulta/consulta_repository.dart';
import 'package:app_nutriocionista/src/pages/consulta/widgets/create_cliente/create_cliente_bloc.dart';
import 'package:app_nutriocionista/src/pages/consulta/widgets/create_consulta/create_consulta_bloc.dart';
import 'package:app_nutriocionista/src/pages/consulta/widgets/tile_consulta/tile_consulta_bloc.dart';
import 'package:app_nutriocionista/src/pages/home/widgets/drawer/drawer_bloc.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'home_bloc.dart';
import 'home_page.dart';

class HomeModule extends ModuleWidget {
  @override
  List<Bloc> get blocs => [
        Bloc((i) => DrawerBloc()),
        Bloc((i) => HomeBloc()),
        Bloc((i) => CreateConsultaBloc(),singleton: false),
        Bloc((i) => TileConsultaBloc()),
        Bloc((i) => ConsultaBloc()),
        Bloc((i) => TileClienteBloc()),
        Bloc((i) => ClienteBloc()),
        Bloc((i) => CreateClienteBloc(),singleton: false)
      ];

  @override
  List<Dependency> get dependencies => [
    Dependency((i) => ConsultaRepository()),
    Dependency((i) => ClienteRepository())
  ];

  @override
  Widget get view => HomePage();

  static Inject get to => Inject<HomeModule>.of();
}
