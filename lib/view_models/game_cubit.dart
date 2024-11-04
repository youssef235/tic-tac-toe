import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import '../models/game_model.dart';

class GameCubit extends Cubit<GameModel> {
  final Box<GameModel> gameBox;
  List<int>? winningCombination;

  GameCubit(this.gameBox)
      : super(GameModel(
    board: List.generate(9, (_) => ''),
    currentPlayer: 'X',
    xWins: 0,
    oWins: 0,
  ));

  void playMove(int index) {
    if (state.board[index] == '' && winningCombination == null) {
      List<String> updatedBoard = List.from(state.board);
      updatedBoard[index] = state.currentPlayer;

      winningCombination = findWinningCombination(updatedBoard);
      if (winningCombination != null) {
        int xWins = state.xWins;
        int oWins = state.oWins;

        if (state.currentPlayer == 'X') {
          xWins++;
        } else {
          oWins++;
        }

        emit(GameModel(
          board: updatedBoard,
          currentPlayer: state.currentPlayer == 'X' ? 'O' : 'X',
          xWins: xWins,
          oWins: oWins,
        ));
      } else {
        emit(GameModel(
          board: updatedBoard,
          currentPlayer: state.currentPlayer == 'X' ? 'O' : 'X',
          xWins: state.xWins,
          oWins: state.oWins,
        ));
      }

      gameBox.put('gameState', state);
    }
  }

  List<int>? findWinningCombination(List<String> board) {
    List<List<int>> winningCombinations = [
      [0, 1, 2], [3, 4, 5], [6, 7, 8],
      [0, 3, 6], [1, 4, 7], [2, 5, 8],
      [0, 4, 8], [2, 4, 6]
    ];

    for (var combo in winningCombinations) {
      if (board[combo[0]] == board[combo[1]] &&
          board[combo[1]] == board[combo[2]] &&
          board[combo[0]] != '') {
        return combo;
      }
    }
    return null;
  }

  void resetGame() {
    List<String> newBoard = List.generate(9, (_) => '');
    winningCombination = null;

    emit(GameModel(board: newBoard, currentPlayer: 'X', xWins: state.xWins, oWins: state.oWins));

    gameBox.put('gameState', GameModel(board: newBoard, currentPlayer: 'X', xWins: state.xWins, oWins: state.oWins));
  }
}
