class RecipeModel {
  final int id;
  final String descricao;
  final bool? ativo;
  final String image;

  RecipeModel({
    required this.descricao,
    required this.image,
    required this.id,
    required this.ativo,
  });

  factory RecipeModel.fromMap(Map<String, dynamic> map) {
    return RecipeModel(
      descricao: map['descricao'],
      image: map['imagem'],
      id: map['id'],
      ativo: map['ativo'],
    );
  }
}
