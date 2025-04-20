import 'package:flutter/material.dart';

class HoverProfile extends StatefulWidget {
  final String image;
  final String name;
  final Color textColor;
  final VoidCallback onTap;

  const HoverProfile({
    Key? key,
    required this.image,
    required this.name,
    required this.textColor,
    required this.onTap,
  }) : super(key: key);

  @override
  State<HoverProfile> createState() => _HoverProfileState();
}

class _HoverProfileState extends State<HoverProfile>
    with SingleTickerProviderStateMixin {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: MouseRegion(
        onEnter: (_) => setState(() {
          _hovering = true;
        }),
        onExit: (_) => setState(() {
          _hovering = false;
        }),
        child: Column(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: _hovering
                    ? [
                        BoxShadow(
                          color: Colors.red.withOpacity(0.8),
                          blurRadius: 15,
                          offset: const Offset(0, 5),
                        ),
                      ]
                    : [],
              ),
              child: CircleAvatar(
                radius: 40,
                backgroundImage: NetworkImage(widget.image),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              widget.name,
              style: TextStyle(
                color: widget.textColor,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
