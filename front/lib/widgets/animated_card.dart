import 'package:flutter/material.dart';

class AnimatedCard extends StatefulWidget {
  final String movieTitle;
  final Color textColor;

  const AnimatedCard({
    super.key,
    required this.movieTitle,
    required this.textColor,
  });

  @override
  _AnimatedCardState createState() => _AnimatedCardState();
}

class _AnimatedCardState extends State<AnimatedCard> {
  bool _isTapped = false;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return GestureDetector(
      onTapDown: (_) => setState(() => _isTapped = true),
      onTapUp: (_) => setState(() => _isTapped = false),
      onTapCancel: () => setState(() => _isTapped = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        transform:
            _isTapped ? Matrix4.identity().scaled(0.95) : Matrix4.identity(),
        decoration: BoxDecoration(
          color: brightness == Brightness.dark
              ? const Color.fromARGB(221, 66, 66, 66)
              : Colors.cyan,
          borderRadius: BorderRadius.circular(8),
          boxShadow: _isTapped
              ? [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 8,
                  ),
                ]
              : [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 4,
                    blurRadius: 12,
                  ),
                ],
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.movieTitle,
              style: TextStyle(
                color: widget.textColor,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
