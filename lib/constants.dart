import 'package:flutter/material.dart';

const primaryColor = Colors.cyan;
const notesBox = 'notes_box';


// Steps of creating a bloc:
// 1. Write States, abstract class and a child class for each state
// 2. Create a Cubit with modification methods
// 3. Create BlocProvider & BlocBuilder
// 4. Call BlocBuilding 