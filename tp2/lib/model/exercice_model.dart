import 'package:flutter/material.dart';
import 'package:tp2/screens/exercice5a_screen.dart';
import 'package:tp2/screens/exercice5b_screen.dart';

class ExerciceModel {
  final String title;
  final String description;
  final Widget page;

  const ExerciceModel(
      {required this.title, required this.description, required this.page});
}

const exercices = [
  ExerciceModel(
    title: "Exercice 1",
    description: 'Display image',
    page: Scaffold(body: Text("Exercice 1")),
  ),
  ExerciceModel(
    title: "Exercice 2a",
    description: 'Rotate and scale image',
    page: Scaffold(body: Text("Exercice 2a")),
  ),
  ExerciceModel(
    title: "Exercice 2b",
    description: 'Animated rotate and scale image',
    page: Scaffold(body: Text("Exercice 2b")),
  ),
  ExerciceModel(
    title: "Exercice 5a",
    description: 'GridView from count example',
    page: Exercice5aScreen(),
  ),
  ExerciceModel(
    title: "Exercice 5b",
    description: 'GridView from builder example',
    page: Exercice5bScreen(),
  ),
];