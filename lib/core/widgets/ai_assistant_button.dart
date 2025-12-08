import 'package:flutter/material.dart';


class AIAssistantButton extends StatefulWidget {
  final VoidCallback? onPressed;

  const AIAssistantButton({super.key, this.onPressed});

  @override
  State<AIAssistantButton> createState() => _AIAssistantButtonState();
}

class _AIAssistantButtonState extends State<AIAssistantButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500), // Standard "breathing" pace
    )..repeat(reverse: true);

    // Subtle scale for "breathing" effect, less aggressive shrinking
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // Use a simpler, high-contrast icon color based on theme
    final iconColor = colorScheme.onPrimary;

    return RepaintBoundary(
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: GestureDetector(
          onTap: widget.onPressed,
          child: Container(
            width: 56, // Standard FAB size
            height: 56,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: colorScheme.primary, // Solid color is cheaper/cleaner than gradient
              boxShadow: [
                BoxShadow(
                  color: colorScheme.primary.withValues(alpha: 0.3),
                  blurRadius: 12,
                  spreadRadius: 4,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Center(
              child: Icon(
                Icons.auto_awesome,
                color: iconColor,
                size: 24,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
