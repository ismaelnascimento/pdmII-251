import 'package:flutter/material.dart';

class MenuView extends StatelessWidget {
  const MenuView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Menu"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                MenuCard(icon: Icons.people_outline_rounded, title: "Clientes"),
                MenuCard(icon: Icons.interests_outlined, title: "Produtos"),
              ],
            ),
            Row(
              children: [
                MenuCard(icon: Icons.business_rounded, title: "Fornecedores"),
                MenuCard(icon: Icons.shopping_bag_outlined, title: "Pedidos"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class MenuCard extends StatelessWidget {
  final String title;
  final IconData icon;
  const MenuCard({super.key, required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(children: [Icon(icon), SizedBox(width: 8), Text(title)]),
        ),
      ),
    );
  }
}
