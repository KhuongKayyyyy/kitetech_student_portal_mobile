import 'package:flutter/material.dart';
import 'package:kitetech_student_portal/core/constant/app_color.dart';
import 'package:kitetech_student_portal/core/constant/app_text_style.dart';
import 'package:kitetech_student_portal/core/util/fake_data.dart';
import 'package:kitetech_student_portal/core/util/string_util.dart';
import 'package:kitetech_student_portal/data/model/class.dart';
import 'package:kitetech_student_portal/presentation/widget/timetable/subject_class_item.dart';
import 'package:scrollable_clean_calendar/controllers/clean_calendar_controller.dart';
import 'package:scrollable_clean_calendar/scrollable_clean_calendar.dart';
import 'package:scrollable_clean_calendar/utils/enums.dart';

class TimetablePage extends StatefulWidget {
  const TimetablePage({super.key});

  @override
  State<TimetablePage> createState() => _TimetablePageState();
}

class _TimetablePageState extends State<TimetablePage> {
  late final CleanCalendarController calendarController;

  late final PageController pageController;
  List<ClassModel> classes = [];

  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    classes = FakeData.classes;
    calendarController = CleanCalendarController(
      minDate: DateTime(2025, 1, 1),
      maxDate: DateTime(2025, 12, 31),
      rangeMode: false,
      onDayTapped: _onDayTapped,
      weekdayStart: DateTime.monday,
      initialFocusDate: DateTime(2025, 5),
      initialDateSelected: DateTime(2025, 5, 1),
    );

    final initialMonthIndex = _monthDifference(
      calendarController.minDate,
      calendarController.initialFocusDate!,
    );
    pageController = PageController(initialPage: initialMonthIndex);
  }

  int _monthDifference(DateTime start, DateTime end) {
    return (end.year - start.year) * 12 + (end.month - start.month);
  }

  DateTime _getDateForPage(int index) {
    return DateTime(
      calendarController.minDate.year,
      calendarController.minDate.month + index,
    );
  }

  void _onDayTapped(DateTime date) {
    classes = FakeData.classes.where((element) {
      return element.date.year == date.year &&
          element.date.month == date.month &&
          element.date.day == date.day;
    }).toList();
    setState(() {
      selectedDate = date;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Thời khóa biểu", style: AppTextStyle.title),
        backgroundColor: AppColors.primaryColor.withOpacity(0.2),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 400,
              child: PageView.builder(
                controller: pageController,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final focusDate = _getDateForPage(index);
                  return ScrollableCleanCalendar(
                    calendarController: CleanCalendarController(
                      minDate: DateTime(focusDate.year, focusDate.month, 1),
                      maxDate: DateTime(focusDate.year, focusDate.month + 1, 0),
                      weekdayStart: DateTime.monday,
                      rangeMode: false,
                      initialFocusDate: focusDate,
                      initialDateSelected: focusDate,
                      onDayTapped: _onDayTapped,
                    ),
                    daySelectedBackgroundColor:
                        AppColors.primaryColor.withOpacity(0.2),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 15),
                    layout: Layout.BEAUTY,
                    calendarCrossAxisSpacing: 0,
                  );
                },
                itemCount: _monthDifference(calendarController.minDate,
                        calendarController.maxDate) +
                    1,
              ),
            ),
            Text(
              StringUtil.formatDate(selectedDate),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            classes.isEmpty
                ? Container(
                    padding: const EdgeInsets.all(20),
                    child: const Column(
                      children: [
                        Icon(
                          Icons.calendar_today,
                          size: 60,
                          color: Colors.grey,
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Không có lịch học',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Hôm nay bạn không có lịch học nào',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return SubjectClassItem(classModel: classes[index]);
                    },
                    itemCount: classes.length,
                  ),
          ],
        ),
      ),
    );
  }
}
