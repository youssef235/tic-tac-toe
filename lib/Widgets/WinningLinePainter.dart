import 'package:flutter/material.dart';

class WinningLinePainter extends CustomPainter {
  final List<int> winningCombination;
  final double cellSize;
  final double gridPadding;
  final double progress;

  WinningLinePainter({
    required this.winningCombination,
    required this.cellSize,
    required this.gridPadding,
    required this.progress,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.purple
      ..strokeWidth = 8.0
      ..style = PaintingStyle.stroke;

    Offset start;
    Offset end;

    if (winningCombination[0] % 3 == winningCombination[1] % 3) {
      double x = gridPadding + (winningCombination[0] % 3) * (cellSize + gridPadding) + cellSize / 2.3;
      double startY = gridPadding + (2.22 * cellSize) - cellSize;
      double endY = gridPadding + (2.1 * cellSize * 2);
      start = Offset(x, startY);
      end = Offset(x, startY + (endY - startY) * progress);
    } else if (winningCombination[0] ~/ 3 == winningCombination[1] ~/ 3) {
      double y = gridPadding + (winningCombination[0] ~/ 3) * (cellSize + gridPadding) + cellSize / 1.7;
      double startX = gridPadding;
      double endX = gridPadding + (3 * cellSize) + (gridPadding);
      start = Offset(startX, y + cellSize);
      end = Offset(startX + (endX - startX) * progress, y + cellSize);
    } else if (winningCombination[0] == 0 && winningCombination[2] == 8) {
      double startX = gridPadding;
      double startY = gridPadding + cellSize;
      double endX = gridPadding + (3 * cellSize);
      double endY = gridPadding + (3 * cellSize) + cellSize;
      start = Offset(startX, startY);
      end = Offset(startX + (endX - startX) * progress, startY + (endY - startY) * progress);
    } else {
      double startX = gridPadding + (3.2 * cellSize);
      double startY = gridPadding + cellSize;
      double endX = gridPadding;
      double endY = gridPadding + (3.2 * cellSize) + cellSize;
      start = Offset(startX, startY);
      end = Offset(startX + (endX - startX) * progress, startY + (endY - startY) * progress);
    }

    canvas.drawLine(start, end, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class WinningLineAnimation extends StatefulWidget {
  final List<int> winningCombination;
  final double cellSize;
  final double gridPadding;

  WinningLineAnimation({
    required this.winningCombination,
    required this.cellSize,
    required this.gridPadding,
  });

  @override
  _WinningLineAnimationState createState() => _WinningLineAnimationState();
}

class _WinningLineAnimationState extends State<WinningLineAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1), // مدة الأنيميشن
    )..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          painter: WinningLinePainter(
            winningCombination: widget.winningCombination,
            cellSize: widget.cellSize,
            gridPadding: widget.gridPadding,
            progress: _controller.value,
          ),
        );
      },
    );
  }
}
