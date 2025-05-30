import 'package:flutter/material.dart';
class SidebarItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final int? notificationCount;
  final Color? color;
  final Color? textColor;

  const SidebarItem({
    super.key,
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
    this.notificationCount,
    this.color,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(label, style: TextStyle(color: textColor)),
      trailing: notificationCount != null
          ? CircleAvatar(
              radius: 12,
              backgroundColor: Colors.red,
              child: Text(
                '$notificationCount',
                style: const TextStyle(color: Colors.white, fontSize: 12),
              ),
            )
          : null,
      selected: isSelected,
      onTap: onTap,
    );
  }
}
