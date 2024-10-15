import 'package:flutter/material.dart';
import '../service/transacao.dart';
import 'formulario.dart';

class ListaScreen extends StatefulWidget {
  @override
  _ListaScreenState createState() => _ListaScreenState();
}

class _ListaScreenState extends State<ListaScreen> {
  final TransacaoApi _api = TransacaoApi();
  List<Transacao> _transacoes = [];

  @override
  void initState() {
    super.initState();
    _carregarTransacoes();
  }

  void _carregarTransacoes() async {
  try {
    final transacoes = await _api.getAll();
    print(transacoes);
    setState(() {
      _transacoes = transacoes;
    });
  } catch (e) {
    print(e);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Erro ao carregar transações'),
    ));
  }
}


  void _adicionarTransacao(Transacao novaTransacao) async {
    try {
      final transacaoCriada = await _api.create(novaTransacao);
      setState(() {
        _transacoes.add(transacaoCriada);
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Erro ao adicionar transação'),
      ));
    }
  }

  void _editarTransacao(int index, Transacao transacaoEditada) async {
    try {
      await _api.update(transacaoEditada.id, transacaoEditada);
      setState(() {
        _transacoes[index] = transacaoEditada;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Erro ao editar transação'),
      ));
    }
  }

  void _excluirTransacao(int index) async {
    try {
      await _api.delete(_transacoes[index].id);
      setState(() {
        _transacoes.removeAt(index);
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Erro ao excluir transação'),
      ));
    }
  }

  Future<void> _confirmarExclusao(int index) async {
    final resultado = await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Tem certeza que deseja excluir?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop(false);
            },
            child: Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop(true);
            },
            child: Text('Excluir'),
          ),
        ],
      ),
    );

    if (resultado == true) {
      _excluirTransacao(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Transações'),
      ),
      body: _transacoes.isEmpty
          ? Center(
              child: Text('Nenhuma transação adicionada ainda.'),
            )
          : ListView.builder(
              itemCount: _transacoes.length,
              itemBuilder: (context, index) {
                return Dismissible(
                  key: UniqueKey(),
                  background: Container(
                    color: Colors.green,
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Icon(Icons.edit, color: Colors.white),
                  ),
                  secondaryBackground: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Icon(Icons.delete, color: Colors.white),
                  ),
                  confirmDismiss: (direction) async {
                    if (direction == DismissDirection.endToStart) {
                      await _confirmarExclusao(index);
                      return false;
                    } else if (direction == DismissDirection.startToEnd) {
                      final transacaoEditada = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FormularioScreen(
                            informacao: {
                              'id': _transacoes[index].id,
                              'nome': _transacoes[index].nome,
                              'valor': _transacoes[index].valor,
                            },
                          ),
                        ),
                      );
                      if (transacaoEditada != null) {
                        _editarTransacao(index, Transacao(
                          id: _transacoes[index].id,
                          nome: transacaoEditada['nome'],
                          valor: double.parse(transacaoEditada['valor']),
                        ));
                      }
                      return false;
                    }
                    return false;
                  },
                  child: ListTile(
                    title: Text(_transacoes[index].nome),
                    subtitle: Text('Valor: R\$ ${_transacoes[index].valor.toStringAsFixed(2)}'),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final novaTransacao = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => FormularioScreen()),
          );
          if (novaTransacao != null) {
            _adicionarTransacao(Transacao(
              id: DateTime.now().millisecondsSinceEpoch,
              nome: novaTransacao['nome'],
              valor: double.parse(novaTransacao['valor']),
            ));
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
