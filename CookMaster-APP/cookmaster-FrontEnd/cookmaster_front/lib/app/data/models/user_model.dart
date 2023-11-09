class UserModel {
  final int id;
  final String nome;
  final String email;

  UserModel({
    required this.id,
    required this.email,
    required this.nome,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      email: map['email'],
      nome: map['nome'],
    );
  }
}
