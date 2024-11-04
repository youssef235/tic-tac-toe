import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Widgets/WinningLinePainter.dart';
import '../models/game_model.dart';
import '../view_models/game_cubit.dart';


class GameView extends StatefulWidget {
  @override
  _GameViewState createState() => _GameViewState();
}

class _GameViewState extends State<GameView> {
  bool _isWinningLineDrawn = false;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double gridPadding = 8.0;

    return Scaffold(
      backgroundColor: Colors.blue[100],
      appBar: AppBar(
        leading: IconButton(
          color: Colors.white,
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // الرجوع إلى الشاشة السابقة
          },
        ),
        title: Text(
          'Tic Tac Toe',
          style: TextStyle(
            fontSize: 28, // تغيير حجم الخط
            fontWeight: FontWeight.bold, // جعل النص عريض
            color: Colors.white, // لون النص
          ),
        ),
        backgroundColor: Colors.blueAccent, // لون خلفية الـ AppBar
        centerTitle: true, // جعل العنوان في منتصف الـ AppBar
        elevation: 6, // إضافة ارتفاع للظل
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(16), // حواف دائرية في الأسفل فقط
          ),
        ),

      ),

      body: Stack(

        children: [
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BlocBuilder<GameCubit, GameModel>(builder: (context, state) {
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [

                        ],
                      ),
                      SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Container(
                                padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                  gradient: state.currentPlayer == 'X'
                  ? LinearGradient(
                  colors: [
                  Colors.blueAccent,
                  Colors.lightBlueAccent,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  )
                      : LinearGradient(
                  colors: [
                  Colors.blue[100]!,
                  Colors.blue[50]!,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(8),
                  ),
                                child: Image.asset('assets/images/X.png', width: 60, height: 60),
                              ),
                              SizedBox(height: 3,),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5), // إضافة padding لضبط حجم المربع
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                  colors: [
                    Colors.blue[100]!,
                    Colors.blue[50]!,
                  ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                  ),
                                  borderRadius: BorderRadius.circular(12), // الحواف الدائرية
                                ),
                                child: Text(
                                  '${state.xWins}',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    foreground: Paint()
                                      ..shader = LinearGradient(
                                        colors: [
                                          Colors.blueAccent,
                                          Colors.lightBlueAccent,
                                        ],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ).createShader(Rect.fromLTWH(0, 0, 200, 70)), // تحديد حجم المستطيل لخلق التدرج
                                  ), // لون الخط أبيض لجعله مرئيًا مع الخلفية
                                ),

                                //   )

                  )  ],
                          ),

                          SizedBox(width: 60),
                          Column(
                            children: [
                              Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  gradient: state.currentPlayer == 'X'
                                      ?

                                    LinearGradient(
                                    colors: [
                  Colors.blue[100]!,
                  Colors.blue[50]!,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  )
                                      : LinearGradient(
                  colors: [
                  Colors.blueAccent,
                  Colors.lightBlueAccent,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Image.asset('assets/images/O.png', width: 60, height: 60),
                              ),
                              SizedBox(height: 3,),

                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5), // إضافة padding لضبط حجم المربع
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.blue[100]!,
                                      Colors.blue[50]!,
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ), // يمكنك اختيار اللون المناسب للخلفية
                                  borderRadius: BorderRadius.circular(12), // الحواف الدائرية
                                ),

                                child: Text(
                                  '${state.oWins}',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    foreground: Paint()
                                      ..shader = LinearGradient(
                                        colors: [
                                          Colors.blueAccent,
                                          Colors.lightBlueAccent,
                                        ],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ).createShader(Rect.fromLTWH(0, 0, 200, 70)), // تحديد حجم المستطيل لخلق التدرج
                                  ), // لون الخط أبيض لجعله مرئيًا مع الخلفية
                                ),

                              )


                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Card(
                        color: Colors.blueAccent, // لون الخلفية للـ Card

                        child: Padding(
                          padding: EdgeInsets.all(20),
                          child: GridView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              mainAxisSpacing: gridPadding,
                              crossAxisSpacing: gridPadding,
                            ),
                            itemCount: 9,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  context.read<GameCubit>().playMove(index);
                                  if (context.read<GameCubit>().winningCombination != null && !_isWinningLineDrawn) {
                                    _isWinningLineDrawn = true;
                                    Future.delayed(Duration(milliseconds: 700), () {
                                      _showGameOverDialog(context, state.currentPlayer);
                                    });
                                  }
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Center(
                                    child: state.board[index] == 'X'
                                        ? Image.asset('assets/images/X.png', width: 60, height: 60)
                                        : state.board[index] == 'O'
                                        ? Image.asset('assets/images/O.png', width: 60, height: 60)
                                        : Container(),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  );
                }),

                SizedBox(height: 80), // لإضافة مسافة كافية لزر إعادة التشغيل في الأسفل
              ],
            ),
          ),

          BlocBuilder<GameCubit, GameModel>(builder: (context, state) {
            if (context.watch<GameCubit>().winningCombination != null) {
              return Positioned.fill(
                child: WinningLineAnimation(
                  winningCombination: context.watch<GameCubit>().winningCombination!,
                  cellSize: screenWidth / 3 - gridPadding,
                  gridPadding: gridPadding,
                ),
              );
            }
            return SizedBox.shrink();
          }),

          Positioned(
            bottom: 10,
            left: screenWidth / 2 - 75, // لتوسيط الزر
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.blue, // لون النص على الزر
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12), // المسافات داخل الزر
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12), // شكل الحواف
                ),
              ),
              onPressed: () {
                context.read<GameCubit>().resetGame();
                setState(() {
                  _isWinningLineDrawn = false;
                });
              },
              child: Text('Restart Game'),
            ),
          ),
        ],
      ),
    );
  }

  void _showGameOverDialog(BuildContext context, String winner) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Game Over'),
          content: Text('$winner Wins!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}



