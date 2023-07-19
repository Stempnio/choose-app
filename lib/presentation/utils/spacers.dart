import 'package:flutter/material.dart';

class VSpace extends StatelessWidget {
  const VSpace({required this.value, super.key});

  factory VSpace.small() => const VSpace(value: 8);

  factory VSpace.medium() => const VSpace(value: 16);

  factory VSpace.large() => const VSpace(value: 32);

  final double value;

  @override
  Widget build(BuildContext context) => SizedBox(height: value);
}

class HSpace extends StatelessWidget {
  const HSpace({required this.value, super.key});

  factory HSpace.small() => const HSpace(value: 8);

  factory HSpace.medium() => const HSpace(value: 16);

  factory HSpace.large() => const HSpace(value: 32);

  final double value;

  @override
  Widget build(BuildContext context) => SizedBox(width: value);
}
