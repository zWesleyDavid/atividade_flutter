import 'package:flutter/material.dart';

class FormularioScreen extends StatefulWidget {
  final Map<String, dynamic>? informacao;

  FormularioScreen({this.informacao});

  @override
  _FormularioScreenState createState() => _FormularioScreenState();
}

class _FormularioScreenState extends State<FormularioScreen> {
  final _tituloController = TextEditingController();
  final _valorController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.informacao != null) {
      _tituloController.text = widget.informacao!['titulo'];
      _valorController.text = widget.informacao!['valor'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.informacao == null ? 'Adicionar Informação' : 'Editar Informação'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _tituloController,
              decoration: InputDecoration(labelText: 'Título'),
            ),
            TextField(
              controller: _valorController,
              decoration: InputDecoration(labelText: 'Valor'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final titulo = _tituloController.text;
                final valor = _valorController.text;

                if (titulo.isNotEmpty && valor.isNotEmpty) {
                  Navigator.pop(context, {'titulo': titulo, 'valor': valor});
                }
              },
              child: Text(widget.informacao == null ? 'Salvar' : 'Atualizar'),
            ),
          ],
        ),
      ),
    );
  }
}
