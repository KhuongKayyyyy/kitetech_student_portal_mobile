import 'package:flutter/material.dart';
import 'package:kitetech_student_portal/core/constant/app_color.dart';
import 'package:kitetech_student_portal/core/constant/app_text_style.dart';
import 'package:kitetech_student_portal/core/util/fake_data.dart';
import 'package:kitetech_student_portal/data/model/score_data.dart';

class ScoreboardPage extends StatefulWidget {
  const ScoreboardPage({super.key});

  @override
  State<ScoreboardPage> createState() => _ScoreboardPageState();
}

class _ScoreboardPageState extends State<ScoreboardPage> {
  String selectedSemester = "Học kỳ 1";

  @override
  Widget build(BuildContext context) {
    final allScores = FakeData.scores;
    final semesters = allScores.map((score) => score.semester).toSet().toList();
    final filteredScores =
        allScores.where((score) => score.semester == selectedSemester).toList();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Bảng điểm",
          style: AppTextStyle.title,
        ),
        backgroundColor: AppColors.primaryColor.withOpacity(0.2),
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                const Text(
                  "Học kỳ: ",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                _buildSemesterSelector(semesters),
              ],
            ),
          ),
          _buildScoreBoard(filteredScores),
        ],
      ),
    );
  }

  Expanded _buildScoreBoard(List<ScoreData> filteredScores) {
    return Expanded(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
          child: DataTable(
            headingRowColor: WidgetStateProperty.all(Colors.blue.shade100),
            dataRowColor: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.selected)) {
                return Colors.blue.shade50;
              }
              return Colors.white;
            }),
            border: TableBorder.all(
              color: Colors.grey.shade300,
              width: 1,
            ),
            columnSpacing: 20,
            headingTextStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
              color: Colors.black87,
            ),
            dataTextStyle: const TextStyle(
              fontSize: 11,
              color: Colors.black87,
            ),
            columns: const [
              DataColumn(
                label: SizedBox(
                  width: 40,
                  child: Text(
                    'STT\nNo.',
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              DataColumn(
                label: SizedBox(
                  width: 120,
                  child: Text(
                    'Môn học\nCourse',
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              DataColumn(
                label: SizedBox(
                  width: 80,
                  child: Text(
                    'Mã môn\nCode',
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              DataColumn(
                label: SizedBox(
                  width: 60,
                  child: Text(
                    'Số TC\nCredits',
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              DataColumn(
                label: SizedBox(
                  width: 60,
                  child: Text(
                    'Nhóm\nGroup',
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              DataColumn(
                label: SizedBox(
                  width: 100,
                  child: Text(
                    'Điểm TK\n(Ngày cập nhật)\nTotal score',
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              DataColumn(
                label: SizedBox(
                  width: 100,
                  child: Text(
                    'Điểm kiểm tra\n(Ngày cập nhật)\nProgress test',
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              DataColumn(
                label: SizedBox(
                  width: 100,
                  child: Text(
                    'Điểm kiểm tra 2\n(Ngày cập nhật)\nProgress test 2',
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              DataColumn(
                label: SizedBox(
                  width: 100,
                  child: Text(
                    'Điểm giữa kỳ\n(Ngày cập nhật)\nMidterm score',
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              DataColumn(
                label: SizedBox(
                  width: 100,
                  child: Text(
                    'Điểm cuối kỳ\n(Ngày cập nhật)\nFinal score',
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              DataColumn(
                label: SizedBox(
                  width: 100,
                  child: Text(
                    'Điểm thi lại\n(Ngày cập nhật)\nRe-test score',
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              DataColumn(
                label: SizedBox(
                  width: 80,
                  child: Text(
                    'Ghi chú\nNote',
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
            rows: filteredScores.map((score) {
              return DataRow(
                cells: [
                  DataCell(
                    SizedBox(
                      width: 40,
                      child: Text(
                        score.stt.toString(),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  DataCell(
                    SizedBox(
                      width: 120,
                      child: Text(
                        score.courseName,
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                  DataCell(
                    SizedBox(
                      width: 80,
                      child: Text(
                        score.courseCode,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  DataCell(
                    SizedBox(
                      width: 60,
                      child: Text(
                        score.credits.toString(),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  DataCell(
                    SizedBox(
                      width: 60,
                      child: Text(
                        score.group,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  DataCell(
                    SizedBox(
                      width: 100,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            score.totalScore,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            '(${score.totalScoreDate})',
                            style: const TextStyle(
                                fontSize: 9, color: Colors.grey),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                  DataCell(
                    SizedBox(
                      width: 100,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            score.progressTest1,
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            '(${score.progressTest1Date})',
                            style: const TextStyle(
                                fontSize: 9, color: Colors.grey),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                  DataCell(
                    SizedBox(
                      width: 100,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            score.progressTest2,
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            '(${score.progressTest2Date})',
                            style: const TextStyle(
                                fontSize: 9, color: Colors.grey),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                  DataCell(
                    SizedBox(
                      width: 100,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            score.midtermScore,
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            '(${score.midtermScoreDate})',
                            style: const TextStyle(
                                fontSize: 9, color: Colors.grey),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                  DataCell(
                    SizedBox(
                      width: 100,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            score.finalScore,
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            '(${score.finalScoreDate})',
                            style: const TextStyle(
                                fontSize: 9, color: Colors.grey),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                  DataCell(
                    SizedBox(
                      width: 100,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            score.retestScore,
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            '(${score.retestScoreDate})',
                            style: const TextStyle(
                                fontSize: 9, color: Colors.grey),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                  DataCell(
                    SizedBox(
                      width: 80,
                      child: Text(
                        score.note,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  Expanded _buildSemesterSelector(List<String> semesters) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.blue.shade300),
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
        ),
        child: DropdownButton<String>(
          value: selectedSemester,
          isExpanded: true,
          underline: const SizedBox(),
          icon: Icon(
            Icons.keyboard_arrow_down,
            color: Colors.blue.shade600,
          ),
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black87,
            fontWeight: FontWeight.w500,
          ),
          items: semesters.map((semester) {
            return DropdownMenuItem<String>(
              value: semester,
              child: Text(
                semester,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              selectedSemester = value!;
            });
          },
        ),
      ),
    );
  }
}
