import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kitetech_student_portal/core/constant/app_color.dart';
import 'package:kitetech_student_portal/core/util/fake_data.dart';
import 'package:kitetech_student_portal/data/model/ElearningClass.dart';
import 'package:kitetech_student_portal/data/model/student.dart';
import 'package:kitetech_student_portal/presentation/bloc/authentication/authentication_bloc.dart';
import 'package:kitetech_student_portal/presentation/view/main/e-learning/elearnin_class_item.dart';
import 'package:kitetech_student_portal/presentation/widget/student/student_header.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ELearningHomePage extends StatefulWidget {
  const ELearningHomePage({super.key});

  @override
  State<ELearningHomePage> createState() => _ELearningHomePageState();
}

class _ELearningHomePageState extends State<ELearningHomePage> {
  String? selectedSemester;
  List<String> selectedClassTypes = [];
  List<ElearningClassModel> filteredCourses = [];

  @override
  void initState() {
    super.initState();
    selectedSemester = 'semester_1_2024';
    _filterCourses();
  }

  void _filterCourses() {
    setState(() {
      filteredCourses = MockData.courses.where((course) {
        bool semesterMatch =
            selectedSemester == null || course.semester == selectedSemester;
        bool typeMatch = selectedClassTypes.isEmpty ||
            selectedClassTypes.contains(course.type);
        return semesterMatch && typeMatch;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        _buildAppBar(),
        _buildSemesterSelection(),
        _buildClassTypeSelection(),
        _buildELearningClassList(),
      ],
    );
  }

  Widget _buildSemesterSelection() {
    return SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 4, bottom: 12),
              child: Text(
                'Select Semester',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.08),
                    spreadRadius: 0,
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey.shade200),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey.shade200),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                        color: AppColors.primaryColor, width: 2),
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade50,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  prefixIcon: const Icon(
                    Icons.school,
                    color: AppColors.primaryColor,
                  ),
                ),
                hint: const Text(
                  'Choose semester',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                ),
                value: selectedSemester,
                icon: const Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: AppColors.primaryColor,
                  size: 28,
                ),
                items: const [
                  DropdownMenuItem(
                    value: 'semester_1_2024',
                    child: Text(
                      'Semester 1, 2024',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  DropdownMenuItem(
                    value: 'semester_2_2024',
                    child: Text(
                      'Semester 2, 2024',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  DropdownMenuItem(
                    value: 'semester_3_2024',
                    child: Text(
                      'Semester 3, 2024',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  DropdownMenuItem(
                    value: 'semester_1_2023',
                    child: Text(
                      'Semester 1, 2023',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  DropdownMenuItem(
                    value: 'semester_2_2023',
                    child: Text(
                      'Semester 2, 2023',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  DropdownMenuItem(
                    value: 'semester_3_2023',
                    child: Text(
                      'Semester 3, 2023',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
                onChanged: (String? newValue) {
                  setState(() {
                    selectedSemester = newValue;
                  });
                  _filterCourses();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildELearningClassList() {
    return SliverList.builder(
      itemCount: filteredCourses.length,
      itemBuilder: (context, index) {
        return ELearningClassItem(course: filteredCourses[index]);
      },
    );
  }

  Widget _buildClassTypeSelection() {
    final List<String> availableTypes = [
      'Core',
      'Elective',
      'General Education'
    ];

    return SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 0,
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Filter by Type',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                if (selectedClassTypes.isNotEmpty)
                  TextButton(
                    onPressed: () {
                      setState(() {
                        selectedClassTypes.clear();
                      });
                      _filterCourses();
                    },
                    child: const Text(
                      'Clear All',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 12,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: availableTypes.map((type) {
                final isSelected = selectedClassTypes.contains(type);
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      if (isSelected) {
                        selectedClassTypes.remove(type);
                      } else {
                        selectedClassTypes.add(type);
                      }
                    });
                    _filterCourses();
                    print('Selected class types: $selectedClassTypes');
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.primaryColor
                          : Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: isSelected
                            ? AppColors.primaryColor
                            : Colors.grey.shade300,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (isSelected)
                          const Icon(
                            Icons.check,
                            size: 16,
                            color: Colors.white,
                          ),
                        if (isSelected) const SizedBox(width: 4),
                        Text(
                          type,
                          style: TextStyle(
                            fontSize: 14,
                            color: isSelected
                                ? Colors.white
                                : Colors.grey.shade700,
                            fontWeight: isSelected
                                ? FontWeight.w600
                                : FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
            if (selectedClassTypes.isNotEmpty) ...[
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: AppColors.primaryColor.withOpacity(0.3),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      size: 16,
                      color: AppColors.primaryColor,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Showing ${selectedClassTypes.length} selected type(s): ${selectedClassTypes.join(', ')}',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  SliverAppBar _buildAppBar() {
    return SliverAppBar(
      centerTitle: true,
      expandedHeight: 150,
      pinned: true,
      flexibleSpace: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final top = constraints.biggest.height;
          final expanded = top > 120;

          return Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.blue,
                  Colors.green,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
              builder: (context, authenState) {
                if (authenState is AuthenticationStateLoggedIn) {
                  return StudentHeader(
                    student: Student(
                      name: authenState.appUser.fullName,
                      email: authenState.appUser.email,
                      studentId: authenState.appUser.email.toString(),
                      major: "Computer Network and Data Communication",
                    ),
                    isExpanded: expanded,
                  );
                } else if (authenState is AuthenticationStateLoading) {
                  return Skeletonizer(
                    child: StudentHeader(
                      student: FakeData.student,
                    ),
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
          );
        },
      ),
    );
  }
}
