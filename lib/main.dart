import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LIEB - Contador Bicicleta',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const ContadorBicicletaScreen(),
    );
  }
}

//tela principal do contador de rotações

class ContadorBicicletaScreen extends StatefulWidget {
  const ContadorBicicletaScreen({super.key});

  @override
  State<ContadorBicicletaScreen> createState() =>
      _ContadorBicicletaScreenState();
}

class _ContadorBicicletaScreenState extends State<ContadorBicicletaScreen> {
  final List<String> _imagensRoda = [
    'assets/images/roda_1.png',
    'assets/images/roda_2.png',
    'assets/images/roda_3.png',
    'assets/images/roda_4.png',
    'assets/images/roda_5.png',
    'assets/images/roda_6.png',
    'assets/images/roda_7.png',
    'assets/images/roda_8.png',
    'assets/images/roda_9.png',
    'assets/images/roda_10.png',
    'assets/images/roda_11.png',
    'assets/images/roda_12.png',
    'assets/images/roda_13.png',
    'assets/images/roda_14.png',
    'assets/images/roda_15.png',
    'assets/images/roda_16.png',
    'assets/images/roda_17.png',
    'assets/images/roda_18.png',
    'assets/images/roda_19.png',
    'assets/images/roda_20.png',
  ];

  int _indiceImagemAtual = 0;
  int _contadorRotacoes = 0;
  Timer? _timer;

  void _girarRoda() {
    setState(() {
      _contadorRotacoes++;
      _indiceImagemAtual = (_indiceImagemAtual + 1) % _imagensRoda.length;
    });
  }

  void _startAutoSpin() {
    _stopAutoSpin();
    _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      _girarRoda();
    });
  }

  void _stopAutoSpin() {
    if (_timer != null && _timer!.isActive) {
      _timer!.cancel();
      _timer = null;
    }
  }

  @override
  void dispose() {
    _stopAutoSpin();
    super.dispose();
  }

  void _resetarContador() {
    setState(() {
      _contadorRotacoes = 0;
      _indiceImagemAtual = 0;
    });
    _stopAutoSpin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Minha Bicicleta',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              _imagensRoda[_indiceImagemAtual],
              width: 250,
              height: 250,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) => const Icon(
                Icons.error,
                size: 100,
                color: Colors.red,
              ),
            ),
            const SizedBox(height: 30),

            Text(
              'Rotações: $_contadorRotacoes',
              style: const TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),

            const SizedBox(height: 50),

            ElevatedButton(
              onPressed: _girarRoda,
              onLongPress: _startAutoSpin,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple.shade700,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 60,
                  vertical: 25,
                ),
                textStyle: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text('GIRAR RODA'),
            ),
            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: _resetarContador,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey.shade600,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 15,
                ),
                textStyle: const TextStyle(fontSize: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: const Text('RESETAR'),
            ),
          ],
        ),
      ),
    );
  }
}
