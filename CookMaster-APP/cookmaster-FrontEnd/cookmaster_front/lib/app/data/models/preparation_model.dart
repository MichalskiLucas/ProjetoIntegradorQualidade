class PreparationModel {
  String? descricao;
  int? id;

  PreparationModel({this.descricao, this.id});

  factory PreparationModel.fromMap(Map<String, dynamic> map) {
    return PreparationModel(
      descricao: map['descricao'],
      id: map['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "dsPreparo": descricao,
    };
  }
}
