import 'package:flutter/material.dart';

class HeartLoader extends StatefulWidget {
  const HeartLoader({
    super.key,
    this.size = 22.0,
    this.color = Colors.red,
    required this.isFavorite,
  });

  final double size;
  final Color color;
  final bool isFavorite;

  @override
  _HeartLoaderState createState() => _HeartLoaderState();
}

class _HeartLoaderState extends State<HeartLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 550),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: Tween(begin: 0.8, end: 1.2).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
      ),
      child: Icon(
        widget.isFavorite
            ? Icons.favorite_rounded
            : Icons.favorite_border_rounded,
        color: widget.color,
        size: widget.size,
      ),
    );
  }
}
