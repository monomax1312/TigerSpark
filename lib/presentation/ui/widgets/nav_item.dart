import 'package:flutter/material.dart';

class NavItem {
  const NavItem({
    required this.icon,
    required this.label,
    required this.path,
  });
  final IconData icon;
  final String label;
  final String path;
}
