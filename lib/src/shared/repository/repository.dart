import 'package:hasura_connect/hasura_connect.dart';
abstract class Repository{
 final HasuraConnect connect;

  Repository(this.connect);
}

