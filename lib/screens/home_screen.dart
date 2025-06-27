import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String resultado = "";

  void handleClick() {
    setState(() {
      resultado = "Cálculo realizado!";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Evaporador Solar')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: handleClick,
              child: const Text('Calcular'),
            ),
            const SizedBox(height: 20),
            Text('Resultado: $resultado'),
          ],
        ),
      ),
    );
  }
}
