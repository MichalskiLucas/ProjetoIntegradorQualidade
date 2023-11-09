class CategoryModel {
  final int id;
  final String descricao;
  final String image;

  CategoryModel({
    required this.descricao,
    required this.image,
    required this.id,
  });

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      descricao: map['descricao'],
      image: map['imagem'],
      id: map['id'],
    );
  }
}
