class VoteModel {
  final int? id;
  final int? voto;
  final int? idUsuario;
  final int? idReceita;

  VoteModel({
    this.id,
    this.idUsuario,
    this.voto,
    this.idReceita,
  });

  factory VoteModel.fromMap(Map<String, dynamic> map) {
    return VoteModel(
        idReceita: map['idReceita'],
        idUsuario: map['idUsuario'],
        voto: map['voto'],
        id: map['id']);
  }
}
