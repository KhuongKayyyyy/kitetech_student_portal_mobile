import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kitetech_student_portal/data/respository/student_card_data.dart';
import 'package:kitetech_student_portal/presentation/view/authentication/login.dart';
import 'package:kitetech_student_portal/presentation/widget/student/student_card.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:http/http.dart' as http;

import 'package:nfc_manager/platform_tags.dart';

class NFCPage extends StatefulWidget {
  const NFCPage({super.key});

  @override
  State<NFCPage> createState() => _NFCPageState();
}

class _NFCPageState extends State<NFCPage> {
  late FToast fToast;
  bool isAvailable = false;
  String? tagData;
  String? errorMessage;
  String? studentRFID;
  Map<String, dynamic>? studentInfo;

  @override
  void initState() {
    super.initState();
    _checkNfcAvailability();
    fToast = FToast();
    fToast.init(context);
  }

  void _showToast(StudentCardData studentCardData) {
    Widget toast = StudentCard(
      studentCardData: studentCardData,
      onTap: () => fToast.removeCustomToast(),
    );

    // Show the toast with a dismiss button and swipe up to dismiss
    fToast.showToast(
      child: GestureDetector(
        onTap: () {
          fToast.removeCustomToast();
        },
        onVerticalDragEnd: (details) {
          // Check if the swipe was upward
          if (details.primaryVelocity != null && details.primaryVelocity! < 0) {
            fToast.removeCustomToast();
          }
        },
        child: Stack(
          children: [
            toast,
            Positioned(
              right: 5,
              top: 5,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.7),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.close,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          ],
        ),
      ),
      gravity: ToastGravity.TOP,
      toastDuration: const Duration(seconds: 5),
    );
  }

  Future<void> _checkNfcAvailability() async {
    isAvailable = await NfcManager.instance.isAvailable();
    setState(() {
      isAvailable = isAvailable;
    });
  }

  Future<void> _fetchStudentInfo(String rfid) async {
    try {
      final response = await http.post(
        Uri.parse('http://192.168.0.226:5001/api/student'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'rfid': rfid}),
      );

      if (response.statusCode == 200) {
        setState(() {
          studentInfo = json.decode(response.body);
          if (kDebugMode) {
            print('Student Info: $studentInfo');
          }
          _showToast(StudentCardData(
            studentName: "Nguyen Dat Khuong",
            studentId: "52100973",
            imageUrl:
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQXXckRlC33zt7zHBLpEEEeqY_MGIn89LOdGw&s",
            classId: "52100973",
            major: "CNTT",
            department: "CNTT",
            birthDate: "2002-01-01",
            gender: "Male",
            address: "123 Main St",
          ));
        });
      } else {
        setState(() {
          errorMessage = 'Failed to fetch student information';
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Error: ${e.toString()}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Homepage"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              isAvailable ? "NFC is available" : "NFC is not available",
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            if (errorMessage != null) ...[
              const SizedBox(height: 10),
              Text(
                "Error: $errorMessage",
                style: const TextStyle(color: Colors.red),
              ),
            ],
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  tagData = null;
                  errorMessage = null;
                  studentInfo = null;
                });
                NfcManager.instance.startSession(
                  onDiscovered: (NfcTag tag) async {
                    final NfcA? nfca = NfcA.from(tag);
                    if (nfca == null) {
                      NfcManager.instance
                          .stopSession(errorMessage: 'Not an NFC-A tag');
                      return;
                    }
                    Uint8List uidBytes = nfca.identifier;

                    String uidHex = uidBytes
                        .map((b) => b.toRadixString(16).padLeft(2, '0'))
                        .join('')
                        .toUpperCase();
                    await _fetchStudentInfo(uidHex);

                    setState(() {
                      tagData = tag.data.toString();
                      studentRFID = uidHex;
                    });

                    NfcManager.instance.stopSession();
                  },
                  onError: (error) async {
                    setState(() {
                      errorMessage = error.toString();
                    });
                    NfcManager.instance
                        .stopSession(errorMessage: error.toString());
                  },
                );
              },
              child: const Text("Start NFC Session"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              },
              child: const Text("Login"),
            ),
          ],
        ),
      ),
    );
  }
}
