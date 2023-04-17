import 'package:bbm_tracking/app.dart';
import 'package:bbm_tracking/simple_bloc_observer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

void main() {
  Bloc.observer = const SimpleBlocObserver();
  runApp(const App());
}
