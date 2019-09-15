import 'package:app_nutriocionista/src/shared/constants.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:hasura_connect/hasura_connect.dart';

import 'app_bloc.dart';
import 'app_widget.dart';


class AppModule extends ModuleWidget {
  @override
  List<Bloc> get blocs => [
        Bloc((i) => AppBloc()),
      ];

  @override
  List<Dependency> get dependencies => [
    Dependency((i) => HasuraConnect(BASE_URL,
    headers: {}
    )),
  ];
  @override
  Widget get view => AppWidget();

  static Inject get to => Inject<AppModule>.of();
}
