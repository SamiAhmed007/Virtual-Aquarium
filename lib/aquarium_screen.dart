// lib/aquarium_screen.dart
import 'dart:math';
import 'package:flutter/material.dart';
import 'fish.dart'; // Corrected import path

class AquariumScreen extends StatefulWidget {
  @override
  _AquariumScreenState createState() => _AquariumScreenState();
}

class _AquariumScreenState extends State<AquariumScreen> with TickerProviderStateMixin {
  List<Fish> fishList = [];
  Color selectedColor = Colors.blue;
  double selectedSpeed = 2.0;
  final int maxFish = 10;

  // Animation controller
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: const Duration(seconds: 2), vsync: this)
      ..repeat(); // Keep running the animation
  }

  void _addFish() {
    if (fishList.length < maxFish) {
      setState(() {
        fishList.add(Fish(color: selectedColor, speed: selectedSpeed));
      });
    }
  }

  // Build the fish in the aquarium
  Widget _buildFishList() {
    return Stack(
      children: fishList.map((fish) {
        return AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            fish.move(); // Handle fish movement

            // Check for collisions with other fish
            for (Fish otherFish in fishList) {
              if (fish != otherFish && fish.isColliding(otherFish)) {
                fish.changeColor(); // Change color on collision
                otherFish.changeColor(); // Change color of the other fish on collision
              }
            }

            return Positioned(
              left: fish.position.dx,
              top: fish.position.dy,
              child: fish.buildFish(), // Build the fish widget
            );
          },
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Virtual Aquarium'),
      ),
      body: Column(
        children: [
          // Aquarium container
          Container(
            width: 300,
            height: 300,
            decoration: BoxDecoration(
              color: Colors.lightBlue[100],
              border: Border.all(color: Colors.blueAccent),
            ),
            child: _buildFishList(), // Fish displayed here
          ),
          // Controls for adding fish and customizing settings
          Row(
            children: [
              ElevatedButton(
                onPressed: _addFish,
                child: Text('Add Fish'),
              ),
              SizedBox(width: 10),
              Text('Speed:'),
              Slider(
                value: selectedSpeed,
                min: 1.0,
                max: 5.0,
                divisions: 4,
                onChanged: (value) {
                  setState(() {
                    selectedSpeed = value;
                  });
                },
              ),
            ],
          ),
          Row(
            children: [
              Text('Fish Color:'),
              DropdownButton<Color>(
                value: selectedColor,
                onChanged: (color) {
                  setState(() {
                    selectedColor = color!;
                  });
                },
                items: <Color>[Colors.red, Colors.blue, Colors.yellow, Colors.green]
                    .map((Color value) {
                  return DropdownMenuItem<Color>(
                    value: value,
                    child: Container(width: 24, height: 24, color: value),
                  );
                }).toList(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
