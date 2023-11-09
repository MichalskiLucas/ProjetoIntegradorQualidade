class IngredientModel {
  int? id;
  String? descricao;
  int? quantidade;
  String? unMedida;
  String? unMedidaStr;

  IngredientModel(
      {this.id,
      this.descricao,
      this.quantidade,
      this.unMedida,
      this.unMedidaStr});

  factory IngredientModel.fromMap(Map<String, dynamic> map) {
    return IngredientModel(
      id: map['id'],
      descricao: map['descricao'],
      quantidade: map['quantidade'],
      unMedida: map['unMedida'],
      unMedidaStr: map['unMedidaStr'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "qtdIngrediente": quantidade,
      "unMedida": unMedidaStr,
      "ingredientId": id,
    };
  }
}
