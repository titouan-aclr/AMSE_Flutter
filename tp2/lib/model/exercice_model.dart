import 'package:flutter/material.dart';
import 'package:tp2/screens/exercice4a_screen.dart';

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
    title: "Exercice 4a",
    description: 'Display a tile',
    page: Exercice4a(),
  ),
];
