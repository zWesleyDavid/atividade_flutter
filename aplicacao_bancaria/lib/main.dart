import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplicação Bancária',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Resumo da Conta'),
      ),
      body: ListView(
        padding: EdgeInsets.all(8.0),
        children: <Widget>[
          Card(
            elevation: 5,
            margin: EdgeInsets.symmetric(vertical: 8.0),
            child: ListTile(
              leading: Icon(Icons.account_balance_wallet, color: Colors.blue),
              title: Text('Saldo Atual'),
              subtitle: Text('R\$ 1.234,56'),
              trailing: Icon(Icons.arrow_forward),
            ),
          ),
          Card(
            elevation: 5,
            margin: EdgeInsets.symmetric(vertical: 8.0),
            child: ListTile(
              leading: Icon(Icons.payment, color: Colors.green),
              title: Text('Última Transação'),
              subtitle: Text('Compra no supermercado'),
              trailing: Text('-R\$ 250,00'),
            ),
          ),
          Card(
            elevation: 5,
            margin: EdgeInsets.symmetric(vertical: 8.0),
            child: ListTile(
              leading: Icon(Icons.receipt, color: Colors.orange),
              title: Text('Histórico de Transações'),
              subtitle: Text('Veja todas as transações'),
              trailing: Icon(Icons.arrow_forward),
            ),
          ),
        ],
      ),
    );
  }
}
