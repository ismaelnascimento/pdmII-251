// Agregação e Composição
import 'dart:convert';

class Dependente {
  late String _nome;

  Dependente(String nome) {
    this._nome = nome;
  }

  Map toJson() {
    return {
      "nome": _nome,
    };
  }
}

class Funcionario {
  late String _nome;
  late List<Dependente> _dependentes;

  Funcionario(String nome, List<Dependente> dependentes) {
    this._nome = nome;
    this._dependentes = dependentes;
  }

  Map toJson() {
    return {
      "nome": _nome,
      "dependentes": _dependentes,
    };
  }
}

class EquipeProjeto {
  late String _nomeProjeto;
  late List<Funcionario> _funcionarios;

  EquipeProjeto(String nomeprojeto, List<Funcionario> funcionarios) {
    _nomeProjeto = nomeprojeto;
    _funcionarios = funcionarios;
  }

  Map toJson() {
    return {
      "nomeProjeto": _nomeProjeto,
      "funcionarios": _funcionarios,
    };
  }
}

void main() {
  // 1. Criar varios objetos Dependentes
  Dependente dependente1 = Dependente("João Gabriel");
  Dependente dependente2 = Dependente("Kaua Moura Sarmento");
  Dependente dependente3 = Dependente("Ismael Liro Beuchior");
  Dependente dependente4 = Dependente("Jose Bezerra Rapunzel");
  // 2. Criar varios objetos Funcionario
  // 3. Associar os Dependentes criados aos respectivos
  //    funcionarios
  Funcionario funcionario1 =
      Funcionario("Kiara da Silva", [dependente2, dependente4]);
  Funcionario funcionario2 =
      Funcionario("Francisco Luz", [dependente1, dependente3]);
  Funcionario funcionario3 =
      Funcionario("Fernando João", [dependente3, dependente1]);
  Funcionario funcionario4 =
      Funcionario("Cirilo Marques", [dependente4, dependente1]);
  // 4. Criar uma lista de Funcionarios
  List<Funcionario> funcionarios = [
    funcionario1,
    funcionario2,
    funcionario3,
    funcionario4
  ];
  // 5. criar um objeto Equipe Projeto chamando o metodo
  //    contrutor que da nome ao projeto e insere uma
  //    coleção de funcionario
  EquipeProjeto equipeProjeto = EquipeProjeto("Fematec", funcionarios);
  // 6. Printar no formato JSON o objeto Equipe Projeto.
  print(jsonEncode(equipeProjeto));
}
