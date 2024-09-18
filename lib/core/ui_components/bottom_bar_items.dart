import 'package:f1rst/core/extensions.dart';
import 'package:flutter/material.dart';

class BottomBarItems extends StatefulWidget {
  final VoidCallback onTap;
  final bool isSelected;
  final Widget icon;
  final String label;

  const BottomBarItems({
    super.key,
    required this.onTap,
    required this.isSelected,
    required this.icon,
    required this.label,
  });

  @override
  State<BottomBarItems> createState() => _BottomBarItemsState();
}

class _BottomBarItemsState extends State<BottomBarItems> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: widget.isSelected ? Colors.blueAccent : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        boxShadow: widget.isSelected
            ? [
                BoxShadow(
                  color: Colors.blueAccent.withOpacity(0.4),
                  spreadRadius: 2,
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ]
            : [],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          widget.icon,
          const SizedBox(height: 4),
          Text(
            widget.label,
            style: TextStyle(
              color: widget.isSelected ? Colors.white : Colors.black54,
              fontSize: 12,
              fontWeight:
                  widget.isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    ).withGesture(onTap: widget.onTap);
  }
}
