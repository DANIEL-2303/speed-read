// level_screen.dart
import 'package:flutter/material.dart';
import 'dart:async';

class LevelScreen extends StatefulWidget {
  final int level;
  
  const LevelScreen({Key? key, required this.level}) : super(key: key);

  @override
  _LevelScreenState createState() => _LevelScreenState();
}

class _LevelScreenState extends State<LevelScreen> {
  int timeRemaining = 120; // 2:00 en segundos
  int currentWordIndex = 0;
  Timer? timer;
  List<String> words = ['Palabra', 'Texto', 'Lectura', 'Velocidad', 'Comprensión', 
                       'Análisis', 'Rápido', 'Ejercicio', 'Mental', 'Cerebro',
                       'Aprendizaje', 'Concentración', 'Enfoque', 'Memoria', 'Atención',
                       'Párrafo', 'Oración', 'Frase', 'Significado', 'Idea'];
  
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (timeRemaining > 0) {
          timeRemaining--;
        } else {
          timer.cancel();
          // Aquí podrías agregar lógica para finalizar el nivel
        }
      });
    });
  }

  String get formattedTime {
    int minutes = timeRemaining ~/ 60;
    int seconds = timeRemaining % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }

  void nextWord() {
    setState(() {
      if (currentWordIndex < words.length - 1) {
        currentWordIndex++;
      } else {
        // Si llegamos al final de las palabras, podríamos agregar alguna lógica
        // Por ejemplo, mostrar un mensaje de éxito
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.red[700],
        width: double.infinity,
        height: double.infinity,
        child: SafeArea(
          child: Column(
            children: [
              // Header con logo y usuario
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.grid_view, size: 24),
                        SizedBox(width: 8),
                        Text(
                          'SpeedRead',
                          style: TextStyle(
                            color: Colors.red[700],
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          'USUARIO1',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 8),
                        CircleAvatar(
                          backgroundColor: Colors.black,
                          radius: 15,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: 30),
              
              // Reloj
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.black,
                    width: 3,
                  ),
                ),
                child: Center(
                  child: Icon(
                    Icons.access_time,
                    size: 40,
                    color: Colors.black,
                  ),
                ),
              ),
              
              SizedBox(height: 10),
              
              // Tiempo restante
              Text(
                formattedTime,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              
              SizedBox(height: 30),
              
              // Tarjeta con la palabra actual
              Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 40),
                padding: EdgeInsets.symmetric(vertical: 25, horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Stack(
                  children: [
                    // Contador de palabras
                    Positioned(
                      top: 0,
                      right: 0,
                      child: Text(
                        '${currentWordIndex + 1}/${words.length}',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    // Palabra centrada
                    Center(
                      child: Text(
                        words[currentWordIndex],
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: 50),
              
              // Botón Continuar
              GestureDetector(
                onTap: nextWord,
                child: Container(
                  width: 200,
                  padding: EdgeInsets.symmetric(vertical: 15),
                  decoration: BoxDecoration(
                    color: Colors.blue[800],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      'Continuar',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              
              Spacer(),
              
              // Flecha para volver
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                    size: 36,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}