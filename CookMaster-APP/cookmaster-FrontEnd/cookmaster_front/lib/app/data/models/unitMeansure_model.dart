// ignore_for_file: file_names

class UnitMeansureModel {
  final String value;
  final String descricao;
  UnitMeansureModel({
    required this.descricao,
    required this.value,
  });

  factory UnitMeansureModel.fromMap(Map<String, dynamic> map) {
    return UnitMeansureModel(
      descricao: map['descricao'],
      value: map['value'],
    );
  }
}
