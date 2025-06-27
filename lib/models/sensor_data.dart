class Dht11 {
  double temperatura;
  double humedad;
  Dht11({required this.temperatura, required this.humedad});
}

class Giroscopio {
  double x, y, z;
  Giroscopio({required this.x, required this.y, required this.z});
}

class Gps {
  double lat, lng;
  DateTime fechaHora;
  Gps({required this.lat, required this.lng, required this.fechaHora});
}

class Luminosidad {
  double valor;
  Luminosidad({required this.valor});
}

class Bascula {
  double peso;
  Bascula({required this.peso});
}



class Motor {
  int posicion;
  bool encendido;
  Motor({required this.posicion, required this.encendido});
}

class SensorData {
  Dht11 dht11;
  Giroscopio giroscopio;
  Luminosidad luminosidad;
  Bascula bascula;
  Gps gps;
  Motor motorX;
  Motor motorY;

  SensorData({
    required this.dht11,
    required this.giroscopio,
    required this.luminosidad,
    required this.bascula,
    required this.gps,
    required this.motorX,
    required this.motorY,
  });

  factory SensorData.simulada() {
    return SensorData(
      dht11: Dht11(temperatura: 25.0, humedad: 60.0),
      giroscopio: Giroscopio(x: 0, y: 0, z: 0),
      luminosidad: Luminosidad(valor: 100),
      bascula: Bascula(peso: 2.5),
      gps: Gps(lat: 19.43, lng: -99.13, fechaHora: DateTime.now()),
      motorX: Motor(posicion: 0, encendido: false),
      motorY: Motor(posicion: 0, encendido: false),
    );
  }

  void actualizarSimulada() {
    dht11.temperatura += (0.5 - (1 * (0.5 - _random())));
    dht11.humedad += (0.5 - (1 * (0.5 - _random())));
    giroscopio.x += (0.5 - _random());
    giroscopio.y += (0.5 - _random());
    giroscopio.z += (0.5 - _random());
    luminosidad.valor += (0.5 - _random()) * 10;
    bascula.peso += (0.1 - _random() * 0.2);
    gps.lat += (0.0001 - _random() * 0.0002);
    gps.lng += (0.0001 - _random() * 0.0002);
    gps.fechaHora = DateTime.now(); // Simula actualización de fecha y hora
  }

  // Simple random function
  double _random() => (DateTime.now().microsecond % 100) / 100.0;
}
