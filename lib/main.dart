import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tic_tac_toi/view_models/game_cubit.dart';
import 'package:tic_tac_toi/views/game_view.dart';
import 'models/game_model.dart';


void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(GameModelAdapter());
  var gameBox = await Hive.openBox<GameModel>('gameBox');

  runApp(MyApp(gameBox: gameBox));
}

class MyApp extends StatelessWidget {
  final Box<GameModel> gameBox;

  MyApp({required this.gameBox});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (context) => GameCubit(gameBox),
        child: GameView(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
