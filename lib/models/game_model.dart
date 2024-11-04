import 'package:hive/hive.dart';
part 'game_model.g.dart';

@HiveType(typeId: 0)
class GameModel {
  @HiveField(0)
  List<String> board;

  @HiveField(1)
  String currentPlayer;

  @HiveField(2)
  int xWins; // عدد انتصارات اللاعب X

  @HiveField(3)
  int oWins; // عدد انتصارات اللاعب O

  GameModel({
    required this.board,
    required this.currentPlayer,
    this.xWins = 0,
    this.oWins = 0,
  });

  void resetGame() {
    board = List.generate(9, (_) => '');
    currentPlayer = 'X';
    xWins = 0; // إعادة تعيين نقاط الفوز
    oWins = 0; // إعادة تعيين نقاط الفوز
  }
}
