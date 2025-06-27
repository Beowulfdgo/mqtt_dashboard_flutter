import 'package:flutter/material.dart';

class MotorControl extends StatelessWidget {
  final String name;
  final bool encendido;
  final int posicion;
  final void Function(bool) onToggle;
  final void Function(int) onSetPosicion;

  const MotorControl({
    super.key,
    required this.name,
    required this.encendido,
    required this.posicion,
    required this.onToggle,
    required this.onSetPosicion,
  });

  @override
  Widget build(BuildContext context) {
    TextEditingController controller =
        TextEditingController(text: posicion.toString());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text("$name: ",
                style: const TextStyle(fontWeight: FontWeight.bold)),
            Switch(
              value: encendido,
              onChanged: onToggle,
              activeColor: Colors.green,
              inactiveThumbColor: Colors.red,
            ),
            Text(encendido ? 'ON' : 'OFF'),
          ],
        ),
        Row(
          children: [
            const Text("Posición: "),
            SizedBox(
              width: 60,
              child: TextField(
                controller: controller,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(vertical: 6, horizontal: 6),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              onPressed: () {
                final valor = int.tryParse(controller.text);
                if (valor != null) onSetPosicion(valor);
              },
              child: const Text("Set"),
            )
          ],
        ),
      ],
    );
  }
}