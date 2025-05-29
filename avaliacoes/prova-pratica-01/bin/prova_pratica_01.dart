import 'dart:convert';

import 'package:prova_pratica_01/prova_pratica_01.dart' as prova_pratica_01;
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';

class Cliente {
  late int _codigo;
  late String _nome;
  late int _tipoCliente;

  Cliente(
    int codigo,
    String nome,
    int tipoCliente,
  ) {
    _codigo = codigo;
    _nome = nome;
    _tipoCliente = tipoCliente;
  }

  Map toJson() {
    return {
      "codigo": _codigo,
      "nome": _nome,
      "tipoCliente": _tipoCliente,
    };
  }
}

class Vendedor {
  late int _codigo;
  late String _nome;
  late double _comissao;

  Vendedor(
    int codigo,
    String nome,
    double comissao,
  ) {
    _codigo = codigo;
    _nome = nome;
    _comissao = comissao;
  }

  Map toJson() {
    return {
      "codigo": _codigo,
      "nome": _nome,
      "comissao": _comissao,
    };
  }
}

class Veiculo {
  late int _codigo;
  late String _descricao;
  late double _valor;

  Veiculo(
    int codigo,
    String descricao,
    double valor,
  ) {
    _codigo = codigo;
    _descricao = descricao;
    _valor = valor;
  }

  Map toJson() {
    return {
      "codigo": _codigo,
      "descricao": _descricao,
      "valor": _valor,
    };
  }
}

class ItemPedido {
  late int _sequencial;
  late String _descricao;
  late int _quantidade;
  late double _valor;

  ItemPedido(
    int sequencial,
    String descricao,
    int quantidade,
    double valor,
  ) {
    _sequencial = sequencial;
    _descricao = descricao;
    _quantidade = quantidade;
    _valor = valor;
  }

  Map toJson() {
    return {
      "sequencial": _sequencial,
      "descricao": _descricao,
      "quantidade": _quantidade,
      "valor": _valor,
    };
  }
}

class PedidoVenda {
  late String _codigo;
  late DateTime _data;
  late double _valorPedido;
  late List<ItemPedido> _itemsPedidos;
  late Cliente _cliente;
  late Vendedor _vendedor;
  late Veiculo _veiculo;

  PedidoVenda(
    String codigo,
    DateTime data,
    double valorPedido,
    List<ItemPedido> itemsPedidos,
    Cliente cliente,
    Vendedor vendedor,
    Veiculo veiculo,
  ) {
    _codigo = codigo;
    _data = data;
    _valorPedido = valorPedido;
    _itemsPedidos = itemsPedidos;
    _cliente = cliente;
    _vendedor = vendedor;
    _veiculo = veiculo;
  }

  double calcularPedido() {
    double valor = 0;
    for (int i = 0; _itemsPedidos.length > i; i++) {
      valor += _itemsPedidos[i]._valor * _itemsPedidos[i]._quantidade;
    }
    return valor;
  }

  Map toJson() {
    return {
      "codigo": _codigo,
      "data": _data.toIso8601String(),
      "valorPedido": _valorPedido,
      "itemsPedidos": _itemsPedidos,
      "cliente": _cliente,
      "vendedor": _vendedor,
      "veiculo": _veiculo,
    };
  }
}

sendEmail(String subject, String text, String to) async {
  String email = 'ismael.nascimento08@aluno.ifce.edu.br';
  String pass = 'kprp ihcb hvql gpic';

  final smtpServer = gmail(email, pass);

  final message = Message()
    ..from = Address(email, 'Ismael Lira Nascimento')
    ..recipients.add(to)
    ..subject = subject
    ..text = text;

  try {
    final sendReport = await send(message, smtpServer);

    print('E-mail enviado: ${sendReport}');
  } on MailerException catch (e) {
    print('Erro ao enviar e-mail: ${e.toString()}');
  }
}

void main(List<String> arguments) {
  Cliente cliente = Cliente(212472, "Ismael Lira Nascimento", 1);

  Vendedor vendedor = Vendedor(632452, "João da Silva", 12.50);

  Veiculo veiculo = Veiculo(341512, "Toyota SRV", 14.50);

  ItemPedido itemPedido1 = ItemPedido(481058, "Batata Chips", 2, 8.99);
  ItemPedido itemPedido2 = ItemPedido(691859, "Latinha de Coca cola", 2, 5.99);
  ItemPedido itemPedido3 = ItemPedido(174923, "Trident", 3, 2.99);
  ItemPedido itemPedido4 = ItemPedido(602859, "Água Lemon Refresh", 1, 7.99);

  List<ItemPedido> itemsPedidos = [
    itemPedido1,
    itemPedido2,
    itemPedido3,
    itemPedido4
  ];

  PedidoVenda pedidoVenda = PedidoVenda("43B95A4C9G2512VF123", DateTime.now(),
      0, itemsPedidos, cliente, vendedor, veiculo);
  pedidoVenda._valorPedido = pedidoVenda.calcularPedido();

  print('');
  print("Objeto PedidoVenda em JSON:");
  print(jsonEncode(pedidoVenda.toJson()));
  print('');
  sendEmail("Prova prática 01", jsonEncode(pedidoVenda.toJson()),
      "taveira@ifce.edu.br");
}
