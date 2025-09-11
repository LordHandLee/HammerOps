import 'package:flutter/material.dart';
import 'dart:io';

// ------------------
// ENTITY (TABLE)
// ------------------
class Users extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 50)();
  IntColumn get age => integer().nullable()();
}

