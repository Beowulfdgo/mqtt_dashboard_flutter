import 'dart:async';
import 'package:flutter/material.dart';
import '../models/sensor_data.dart';
import '../widgets/sensor_card.dart';
import '../widgets/motor_control.dart';
import 'package:intl/intl.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String connectionStatus = 'connecting';
  late SensorData data;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    data = SensorData.simulada();
    Future.delayed(const Duration(seconds: 2), () {
      setState(() => connectionStatus = 'connected');
      timer = Timer.periodic(const Duration(seconds: 2), (_) {
        setState(() => data.actualizarSimulada());
      });
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void setMotorX(bool encendido) =>
      setState(() => data.motorX.encendido = encendido);

  void setMotorY(bool encendido) =>
      setState(() => data.motorY.encendido = encendido);

  void setMotorXPos(int pos) => setState(() => data.motorX.posicion = pos);

  void setMotorYPos(int pos) => setState(() => data.motorY.posicion = pos);

  @override
  Widget build(BuildContext context) {
    Color statusColor = connectionStatus == 'connected'
        ? Colors.green
        : (connectionStatus == 'connecting' ? Colors.orange : Colors.red);

    return Scaffold(
      appBar: AppBar(title: const Text("Evaporador Solar Dashboard")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Card(
              color: statusColor.withOpacity(0.2),
              child: ListTile(
                leading: Icon(
                  connectionStatus == 'connected' ? Icons.wifi : Icons.wifi_off,
                  color: statusColor,
                ),
                title: Text(
                  "Estado de conexión: $connectionStatus",
                  style: TextStyle(color: statusColor),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                SizedBox(
                  width: 260,
                  child: SensorCard(
                    title: "DHT11",
                    icon: Icons.thermostat,
                    borderColor: Colors.orange,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Temperatura: ${data.dht11.temperatura.toStringAsFixed(1)} °C",
                        ),
                        Text(
                          "Humedad: ${data.dht11.humedad.toStringAsFixed(1)} %",
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 260,
                  child: SensorCard(
                    title: "Giroscopio",
                    icon: Icons.threed_rotation,
                    borderColor: Colors.purple,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("X: ${data.giroscopio.x.toStringAsFixed(2)}"),
                        Text("Y: ${data.giroscopio.y.toStringAsFixed(2)}"),
                        Text("Z: ${data.giroscopio.z.toStringAsFixed(2)}"),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 260,
                  child: SensorCard(
                    title: "Luminosidad",
                    icon: Icons.light_mode,
                    borderColor: Colors.yellow.shade700,
                    child: Text(
                      "Luminosidad: ${data.luminosidad.valor.toStringAsFixed(1)} lx",
                    ),
                  ),
                ),
                SizedBox(
                  width: 260,
                  child: SensorCard(
                    title: "Báscula",
                    icon: Icons.monitor_weight,
                    borderColor: Colors.brown,
                    child: Text(
                      "Peso: ${data.bascula.peso.toStringAsFixed(2)} kg",
                    ),
                  ),
                ),
                SizedBox(
  width: 260,
  child: SensorCard(
    title: "GPS",
    icon: Icons.location_on,
    borderColor: Colors.green,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Latitud: ${data.gps.lat.toStringAsFixed(5)}"),
        Text("Longitud: ${data.gps.lng.toStringAsFixed(5)}"),
        Text("Fecha: ${DateFormat('dd/MM/yyyy').format(data.gps.fechaHora)}"),
        Text("Hora: ${DateFormat('HH:mm:ss').format(data.gps.fechaHora)}"),
      ],
    ),
  ),
),
                SizedBox(
                  width: 260,
                  child: SensorCard(
                    title: "Motor X",
                    icon: Icons.settings,
                    borderColor: Colors.blue,
                    child: MotorControl(
                      name: "Motor X",
                      encendido: data.motorX.encendido,
                      posicion: data.motorX.posicion,
                      onToggle: setMotorX,
                      onSetPosicion: setMotorXPos,
                    ),
                  ),
                ),
                SizedBox(
                  width: 260,
                  child: SensorCard(
                    title: "Motor Y",
                    icon: Icons.settings_applications,
                    borderColor: Colors.teal,
                    child: MotorControl(
                      name: "Motor Y",
                      encendido: data.motorY.encendido,
                      posicion: data.motorY.posicion,
                      onToggle: setMotorY,
                      onSetPosicion: setMotorYPos,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "Instrucciones:\n"
                  "• Simula datos de sensores y controla motores.\n"
                  "• El estado de conexión es simulado.\n"
                  "• Puedes modificar la lógica en sensor_data.dart para datos reales.",
                  style: const TextStyle(fontSize: 15),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
