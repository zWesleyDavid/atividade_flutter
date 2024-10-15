import 'abstract_api.dart';

class Transacao {
  int id;
  String nome;
  double valor;

  Transacao({required this.id, required this.nome, required this.valor});

  factory Transacao.fromJson(Map<String, dynamic> json) {
    return Transacao(
      id: json['id'],
      nome: json['nome'],
      valor: json['valor'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'valor': valor,
    };
  }
}

class TransacaoApi extends AbstractApi<Transacao> {
  TransacaoApi() : super('transacoes');

  @override
  Transacao fromJson(Map<String, dynamic> json) {
    return Transacao.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson(Transacao item) {
    return item.toJson();
  }
}
