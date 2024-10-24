// lib/fish.dart
import 'dart:math';
import 'package:flutter/material.dart';

class Fish {
  Color color;
  double speed;
  Offset position;
  double directionX;
  double directionY;

  Fish({
    required this.color,
    required this.speed,
    Offset? position,
  })  : this.position = position ?? const Offset(100, 100),
        this.directionX = Random().nextDouble() * 2 - 1,
        this.directionY = Random().nextDouble() * 2 - 1;

  void move() {
    position = Offset(
      position.dx + directionX * speed,
      position.dy + directionY * speed,
    );

    // Bounce off the edges
    if (position.dx < 0 || position.dx > 280) {
      directionX *= -1;
    }
    if (position.dy < 0 || position.dy > 280) {
      directionY *= -1;
    }
  }

  Widget buildFish() {
    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
    );
  }

  // Check for collision with another fish
  bool isColliding(Fish other) {
    double dx = position.dx - other.position.dx;
    double dy = position.dy - other.position.dy;
    double distance = sqrt(dx * dx + dy * dy);

    return distance < 20; // Collision threshold (radius of fish * 2)
  }

  // Change the fish color
  void changeColor() {
    color = Color.fromARGB(
      255,
      Random().nextInt(256),
      Random().nextInt(256),
      Random().nextInt(256),
    );
  }
}
