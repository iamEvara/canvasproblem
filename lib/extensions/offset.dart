import 'package:flutter/material.dart';

extension InverseOffsetAxisExtension on Offset {
  Offset get inverse {
    return Offset(dy, dx);
  }
}
