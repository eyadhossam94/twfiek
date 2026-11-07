import 'package:flutter/material.dart';

class SmallCard extends StatefulWidget {
  final String image;
  final String title;

  /// Highlights the card (ring + bold title). Drive it from the parent list.
  final bool selected;
  final VoidCallback? onTap;

  /// Position in the list. Used to stagger the entrance animation.
  final int index;

  /// Ring and title color when [selected].
  final Color activeColor;

  const SmallCard({
    super.key,
    required this.image,
    required this.title,
    this.selected = false,
    this.onTap,
    this.index = 0,
    this.activeColor = const Color(0xFF25212B),
  });

  @override
  State<SmallCard> createState() => _SmallCardState();
}

class _SmallCardState extends State<SmallCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _entrance = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 500),
  );

  late final Animation<double> _fade = CurvedAnimation(
    parent: _entrance,
    curve: Curves.easeOut,
  );

  late final Animation<double> _scale = Tween<double>(begin: 0.7, end: 1).animate(
    CurvedAnimation(parent: _entrance, curve: Curves.easeOutBack),
  );

  bool _pressed = false;

  @override
  void initState() {
    super.initState();
    // Each card starts a little after the previous one.
    Future.delayed(Duration(milliseconds: 70 * widget.index), () {
      if (mounted) _entrance.forward();
    });
  }

  @override
  void dispose() {
    _entrance.dispose();
    super.dispose();
  }

  void _setPressed(bool value) {
    if (_pressed != value) setState(() => _pressed = value);
  }

  @override
  Widget build(BuildContext context) {
    final selected = widget.selected;

    return FadeTransition(
      opacity: _fade,
      child: ScaleTransition(
        scale: _scale,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTapDown: (_) => _setPressed(true),
          onTapUp: (_) => _setPressed(false),
          onTapCancel: () => _setPressed(false),
          onTap: widget.onTap,
          child: AnimatedScale(
            scale: _pressed ? 0.92 : 1,
            duration: const Duration(milliseconds: 150),
            curve: Curves.easeOut,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeOut,
                    height: 70,
                    width: 70,
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      border: Border.all(
                        color: selected ? widget.activeColor : Colors.white,
                        width: 2.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, selected ? 0.22 : 0.1),
                          blurRadius: selected ? 18 : 12,
                          offset: Offset(0, selected ? 8 : 5),
                        ),
                      ],
                    ),
                    child: ClipOval(
                      child: Image.asset(widget.image, fit: BoxFit.cover),
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: 74,
                    child: AnimatedDefaultTextStyle(
                      duration: const Duration(milliseconds: 250),
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                        color: selected ? widget.activeColor : Colors.black54,
                      ),
                      child: Text(widget.title),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}