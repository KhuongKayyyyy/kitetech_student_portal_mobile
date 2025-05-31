// import 'package:flutter/material.dart';
// import 'package:qr/qr.dart';

// class QrGeneratorWidget extends StatelessWidget {
//   final String data;
//   final double size;

//   const QrGeneratorWidget({
//     super.key,
//     required this.data,
//     this.size = 200,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final qrCode = QrCode(4, QrErrorCorrectLevel.L);
//     qrCode.addData(data);
//     qrCode.make();

//     final int moduleCount = qrCode.moduleCount;
//     final double pixelSize = size / moduleCount;

//     return CustomPaint(
//       size: Size(size, size),
//       painter: _QrPainter(qrCode, pixelSize),
//     );
//   }
// }

// class _QrPainter extends CustomPainter {
//   final QrCode qrCode;
//   final double pixelSize;

//   _QrPainter(this.qrCode, this.pixelSize);

//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()..color = Colors.black;

//     for (int x = 0; x < qrCode.moduleCount; x++) {
//       for (int y = 0; y < qrCode.moduleCount; y++) {
//         if (qrCode.isDark(y, x)) {
//           canvas.drawRect(
//             Rect.fromLTWH(
//               x * pixelSize,
//               y * pixelSize,
//               pixelSize,
//               pixelSize,
//             ),
//             paint,
//           );
//         }
//       }
//     }
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
// }
