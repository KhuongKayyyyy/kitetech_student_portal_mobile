import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:kitetech_student_portal/core/constant/app_color.dart';
import 'package:kitetech_student_portal/core/router/app_router.dart';
import 'package:kitetech_student_portal/data/model/name_recognition.dart';
import 'package:kitetech_student_portal/data/model/student.dart';
import 'package:kitetech_student_portal/presentation/bloc/name_recognition/name_recognition_bloc.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';
import 'package:qr_flutter/qr_flutter.dart';

class NameRecognitionQrScanner extends StatefulWidget {
  final Student student;
  const NameRecognitionQrScanner({super.key, required this.student});

  @override
  State<NameRecognitionQrScanner> createState() =>
      _NameRecognitionQrScannerState();
}

class _NameRecognitionQrScannerState extends State<NameRecognitionQrScanner> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;
  Timer? _timer;
  int _countdown = 60;
  String _qrData = '';

  @override
  void initState() {
    super.initState();
    _generateQRData();
    _startCountdown();
  }

  @override
  void dispose() {
    _timer?.cancel();
    // ignore: deprecated_member_use
    controller?.dispose();
    super.dispose();
  }

  void _generateQRData() {
    // Generate QR data with timestamp to make it unique
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    _qrData = '${widget.student.studentId}_$timestamp';
  }

  void _startCountdown() {
    _timer?.cancel();
    _countdown = 60;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _countdown--;
      });

      if (_countdown <= 0) {
        _refreshQR();
      }
    });
  }

  void _refreshQR() {
    setState(() {
      _generateQRData();
    });
    _startCountdown();
  }

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          // QR Scanner View on top
          QRView(
            key: qrKey,
            onQRViewCreated: _onQRViewCreated,
            overlay: QrScannerOverlayShape(
              borderColor: Colors.red,
              borderRadius: 10,
              borderLength: 30,
              borderWidth: 10,
            ),
          ),
          // Draggable bottom sheet for student QR display
          _buildStudentQR(),
          Positioned(
            top: 40,
            left: 20,
            child: InkWell(
              onTap: () {
                context.pop();
              },
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black.withOpacity(0.3)),
                child: const Icon(CupertinoIcons.chevron_back),
              ),
            ),
          ),
        ],
      ),
    );
  }

  DraggableScrollableSheet _buildStudentQR() {
    return DraggableScrollableSheet(
      initialChildSize: 0.1,
      minChildSize: 0.1,
      maxChildSize: 0.8,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                offset: Offset(0, -2),
              ),
            ],
          ),
          child: _buildStudentQRContent(),
        );
      },
    );
  }

  Widget _buildStudentQRContent() {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Drag handle
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[400],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          // Content
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const Text(
                  'Mã QR của bạn',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 24),

                // QR Code Container with border and shadow
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.grey.shade300, width: 2),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 2,
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: QrImageView(
                    data: _qrData,
                    version: 5,
                    size: 200.0,
                    backgroundColor: Colors.white,
                  ),
                ),

                const SizedBox(height: 16),

                // Countdown and refresh section
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: _countdown <= 10
                        ? Colors.red.shade50
                        : Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: _countdown <= 10
                          ? Colors.red.shade200
                          : Colors.blue.shade200,
                      width: 1,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.timer,
                        size: 18,
                        color: _countdown <= 10 ? Colors.red : Colors.blue,
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        "Mã tự động đổi sau ",
                        style: TextStyle(fontSize: 14, color: Colors.black87),
                      ),
                      Text(
                        "${_countdown}s",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: _countdown <= 10 ? Colors.red : Colors.blue,
                        ),
                      ),
                      const Text(
                        " giây",
                        style: TextStyle(fontSize: 14, color: Colors.black87),
                      ),
                      const SizedBox(width: 12),
                      GestureDetector(
                        onTap: _refreshQR,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const Icon(
                            Icons.refresh,
                            size: 18,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Student information card
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.primary.withOpacity(0.1),
                        AppColors.primary.withOpacity(0.05)
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(12),
                    border:
                        Border.all(color: AppColors.primary.withOpacity(0.2)),
                  ),
                  child: Column(
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.badge, color: AppColors.primary, size: 20),
                          SizedBox(width: 8),
                          Text(
                            "Mã sinh viên:",
                            style:
                                TextStyle(fontSize: 14, color: Colors.black54),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        widget.student.studentId,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Row(
                        children: [
                          Icon(Icons.person,
                              color: AppColors.primary, size: 20),
                          SizedBox(width: 8),
                          Text(
                            "Họ và tên:",
                            style:
                                TextStyle(fontSize: 14, color: Colors.black54),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        widget.student.name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Scan result display
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: result != null
                        ? Colors.green.shade50
                        : Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: result != null
                          ? Colors.green.shade200
                          : Colors.grey.shade300,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        result != null
                            ? Icons.check_circle
                            : Icons.qr_code_scanner,
                        color: result != null
                            ? Colors.green
                            : Colors.grey.shade600,
                        size: 24,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: result != null
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Đã quét thành công:',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.green,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    result!.code ?? '',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ],
                              )
                            : const Text(
                                'Quét mã QR để điểm danh',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black54,
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  bool _isNavigating = false;

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });

      // Create name recognition event when QR code is scanned
      if (scanData.code != null &&
          scanData.code!.isNotEmpty &&
          !_isNavigating) {
        try {
          // Parse the JSON to extract classSessionID
          final Map<String, dynamic> qrData = jsonDecode(scanData.code!);
          final String classSessionID = qrData['classSessionID'] ?? '';
          final String name = qrData['name'] ?? '';

          if (classSessionID.isNotEmpty && name.isNotEmpty) {
            _isNavigating = true;
            // Pause the camera to prevent further scans
            controller.pauseCamera();

            // ignore: use_build_context_synchronously
            context
                .pushNamed(
              AppRouter.nameRecognitionConfirmPage,
              extra: NameRecognition(
                classSessionID: classSessionID,
                studentID: widget.student.studentId,
                time: DateTime.now(),
                name: name,
                id: '0',
              ),
            )
                .then((_) {
              // Reset navigation flag when returning
              _isNavigating = false;
              // Resume camera if user comes back
              controller.resumeCamera();
            });
          } else {
            debugPrint('❌ No classSessionID found in QR code');
          }
        } catch (e) {
          debugPrint('❌ Failed to parse QR code JSON: $e');
          debugPrint('Raw QR code: ${scanData.code}');
        }
      }
    });
  }
}
