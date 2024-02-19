import 'package:flutter/material.dart';
import 'package:tp2/screens/exercice1_screen.dart';
import 'package:tp2/screens/exercice2_screen.dart';
import 'package:tp2/screens/exercice5a_screen.dart';
import 'package:tp2/screens/exercice5b_screen.dart';
import 'package:tp2/screens/exercice4a_screen.dart';
import 'package:tp2/screens/exercice5c_screen.dart';
import 'package:tp2/screens/exercice5d_screen.dart';
import 'package:tp2/screens/exercice6a_screen.dart';
import 'package:tp2/screens/exercice6b_screen.dart';
import 'package:tp2/screens/exercice6c_screen.dart';
import 'package:tp2/screens/exercice7_screen.dart';

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
    page: Exercice1(),
  ),
  ExerciceModel(
    title: "Exercice 2",
    description: 'Rotate, scale and animate image',
    page: Exercice2(),
  ),
  ExerciceModel(
    title: "Exercice 4a",
    description: 'Display a tile',
    page: Exercice4a(),
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
  ExerciceModel(
    title: "Exercice 5c",
    description: 'GridView from image tile fixed size',
    page: Exercice5cScreen(),
  ),
  ExerciceModel(
    title: "Exercice 5d",
    description: 'GridView from image tile variable size',
    page: Exercice5dScreen(),
  ),
  ExerciceModel(
    title: "Exercice 6a",
    description: 'Invert two tiles',
    page: Exercice6aScreen(),
  ),
  ExerciceModel(
    title: "Exercice 6b",
    description: 'Invert two tiles in a grid',
    page: Exercice6bScreen(),
  ),
  ExerciceModel(
    title: "Exercice 6c",
    description: 'Invert two tiles in a sizable grid',
    page: Exercice6cScreen(),
  ),
  ExerciceModel(
    title: "Exercice 7",
    description: 'Invert two tiles in a sizable grid',
    page: Exercice7Screen(),
  ),
];
