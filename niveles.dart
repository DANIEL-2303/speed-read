// path_levels.dart
import 'package:flutter/material.dart';
import 'prueba_PAP.dart'; // Importamos la pantalla de nivel
import 'dart:math';

class PathLevelsScreen extends StatelessWidget {
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
              
              // Título del modo
              Container(
                margin: EdgeInsets.symmetric(vertical: 15),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'Palabra a palabra',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),

              // Camino de niveles
              Expanded(
                child: Stack(
                  children: [
                    // Flecha de regreso
                    Positioned(
                      bottom: 20,
                      right: 20,
                      child: GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 36,
                        ),
                      ),
                    ),
                    
                    // Camino de niveles con líneas punteadas
                    CustomPaint(
                      size: Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height),
                      painter: PathPainter(),
                    ),
                    
                    // Nivel 1
                    _buildLevelButton(
                      context,
                      level: 1,
                      top: 80,
                      left: 40,
                    ),
                    
                    // Nivel 2
                    _buildLevelButton(
                      context,
                      level: 2,
                      top: 160,
                      left: 200,
                    ),
                    
                    // Nivel 3  
                    _buildLevelButton(
                      context,
                      level: 3,
                      top: 280,
                      left: 80,
                    ),
                    
                    // Nivel 4
                    _buildLevelButton(
                      context,
                      level: 4,
                      top: 350,
                      left: 220,
                    ),
                    
                    // Nivel 5
                    _buildLevelButton(
                      context,
                      level: 5,
                      top: 480,
                      left: 120,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildLevelButton(BuildContext context, {required int level, required double top, required double left}) {
    return Positioned(
      top: top,
      left: left,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LevelScreen(level: level),
            ),
          );
        },
        child: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.black,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              level.toString(),
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Pintor personalizado para dibujar las líneas punteadas
class PathPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    // Configurar línea punteada
    final dashWidth = 5.0;
    final dashSpace = 5.0;
    
    // Puntos para las conexiones
    final points = [
      Offset(65, 105), // Centro del nivel 1
      Offset(225, 185), // Centro del nivel 2
      Offset(105, 305), // Centro del nivel 3
      Offset(245, 375), // Centro del nivel 4
      Offset(145, 505), // Centro del nivel 5
    ];
    
    // Dibujar líneas punteadas entre los puntos
    _drawDashedLine(canvas, points[0], points[1], dashWidth, dashSpace, paint);
    _drawDashedLine(canvas, points[1], points[2], dashWidth, dashSpace, paint);
    _drawDashedLine(canvas, points[2], points[3], dashWidth, dashSpace, paint);
    _drawDashedLine(canvas, points[3], points[4], dashWidth, dashSpace, paint);
  }
  
  void _drawDashedLine(Canvas canvas, Offset start, Offset end, double dashWidth, double dashSpace, Paint paint) {
    double dx = end.dx - start.dx;
    double dy = end.dy - start.dy;
    double distance = sqrt(dx * dx + dy * dy);
    double dashCount = distance / (dashWidth + dashSpace);
    double dashDx = dx / dashCount;
    double dashDy = dy / dashCount;
    
    bool isDash = true;
    double currentDx = start.dx;
    double currentDy = start.dy;
    
    while (currentDx < end.dx || currentDy < end.dy) {
      Offset p1 = Offset(currentDx, currentDy);
      currentDx += dashDx;
      currentDy += dashDy;
      
      if (isDash) {
        Offset p2 = Offset(currentDx, currentDy);
        canvas.drawLine(p1, p2, paint);
      }
      
      isDash = !isDash;
      currentDx += dashDx;
      currentDy += dashDy;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}