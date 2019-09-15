class GraphObject{
 static  String parse(Map map) {

    List<String> list = [];
    map.forEach((key, value) {
      if (value != null) {
        list.add('''$key:${verifyType(value) ? '"' +  value + '"'   : value}''');
      }
    });
    return list.toString().replaceAll("[", "{").replaceAll("]", "}");
  }

   static  verifyType(value) {
    if (value is String) {
      return true;
    } else {
      return false;
    }
  }
}