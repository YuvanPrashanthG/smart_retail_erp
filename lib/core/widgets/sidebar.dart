import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_retail_erp/app/theme/theme_provider.dart';
import 'package:smart_retail_erp/core/widgets/sidebar_items.dart';

class Sidebar extends ConsumerWidget {
  final int selectedIndex;
  final Function(int) onItemSelected;

  const Sidebar({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isDarkMode = ref.watch(themeProvider) == ThemeMode.dark;

    final backgroundColor = theme.colorScheme.surface;
    final textColor = theme.colorScheme.onSurface;
    final iconColor = theme.iconTheme.color;

    return Container(
      width: 240,
      color: backgroundColor,
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SidebarItem(
            icon: Icons.dashboard,
            label: 'Dashboard',
            isSelected: selectedIndex == 0,
            onTap: () => onItemSelected(0),
            color: iconColor,
            textColor: textColor,
          ),
          SidebarItem(
            icon: Icons.shopping_bag,
            label: 'Product',
            isSelected: selectedIndex == 1,
            onTap: () => onItemSelected(1),
            notificationCount: 2,
            color: iconColor,
            textColor: textColor,
          ),
          SidebarItem(
            icon: Icons.store,
            label: 'Store',
            isSelected: selectedIndex == 2,
            onTap: () => onItemSelected(2),
            color: iconColor,
            textColor: textColor,
          ),
          SidebarItem(
            icon: Icons.people,
            label: 'Visitor',
            isSelected: selectedIndex == 3,
            onTap: () => onItemSelected(3),
            color: iconColor,
            textColor: textColor,
          ),
          SidebarItem(
            icon: Icons.analytics_outlined,
            label: 'Analytics',
            isSelected: selectedIndex == 4,
            onTap: () => onItemSelected(4),
            color: iconColor,
            textColor: textColor,
          ),
          SidebarItem(
            icon: Icons.notifications,
            label: 'Notification',
            isSelected: selectedIndex == 5,
            onTap: () => onItemSelected(5),
            notificationCount: 11,
            color: iconColor,
            textColor: textColor,
          ),
          SidebarItem(
            icon: Icons.headset_mic,
            label: 'Help Center',
            isSelected: selectedIndex == 6,
            onTap: () => onItemSelected(6),
            color: iconColor,
            textColor: textColor,
          ),
          SidebarItem(
            icon: Icons.settings,
            label: 'Settings',
            isSelected: selectedIndex == 7,
            onTap: () => onItemSelected(7),
            color: iconColor,
            textColor: textColor,
          ),

          const Spacer(),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Icon(Icons.dark_mode_outlined, color: iconColor),
                const SizedBox(width: 10),
                Text('Dark Mode', style: TextStyle(color: textColor)),
                const Spacer(),
                Switch(
                  value: isDarkMode,
                  onChanged: (val) {
                    ref.read(themeProvider.notifier).state =
                        val ? ThemeMode.dark : ThemeMode.light;
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
