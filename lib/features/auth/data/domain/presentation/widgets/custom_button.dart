import 'package:flutter/material.dart';

 
class CustomButton extends StatelessWidget { 
  final String label; 
  final VoidCallback? onPressed; 
  final bool isLoading; 
  final ButtonVariant variant; 
  final Widget? icon; 
 
  const CustomButton({ 
    super.key, 
    required this.label, 
    this.onPressed, 
    this.isLoading = false, 
    this.variant = ButtonVariant.primary, 
    this.icon, 
  }); 
 
  @override 
  Widget build(BuildContext context) { 
    final child = isLoading 
        ? const SizedBox( 
            width: 20, height: 20, 
            child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white), 
          ) 
        : Row( 
            mainAxisAlignment: MainAxisAlignment.center, 
            children: [ 
              if (icon != null) ...[icon!, const SizedBox(width: 8)], 
              Text(label, style: const TextStyle(fontSize: 16, fontWeight: 
FontWeight.w600)), 
            ], 
          ); 
 
    return SizedBox( 
      width: double.infinity, 
      height: 52, 
      child: switch (variant) { 
        ButtonVariant.primary => ElevatedButton( 
            onPressed: isLoading ? null : onPressed, 
            style: ElevatedButton.styleFrom(
