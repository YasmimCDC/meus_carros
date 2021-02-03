class Car {
  String documentID;
  String anoFabri;
  String anoMod;
  String fot;
  String model;
  String plac;

  Car.fromMap(Map<String, dynamic> map, String id) {
    this.documentID = id;
    this.anoFabri = map["anoFabricacao"];
    this.anoMod = map["anoModelo"];
    this.fot = map["foto"];
    this.model = map["modelo"];
    this.plac = map["placa"];
  }

}