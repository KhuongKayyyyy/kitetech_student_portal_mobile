import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kitetech_student_portal/core/constant/app_color.dart';
import 'package:kitetech_student_portal/core/router/app_router.dart';
import 'package:kitetech_student_portal/data/model/ElearningClass.dart';
import 'package:kitetech_student_portal/data/model/ElearningClassSection.dart';
import 'package:kitetech_student_portal/data/model/ElearningClassSectionMaterial.dart';

class ELearningSessionListSection extends StatefulWidget {
  final ElearningClassModel course;
  const ELearningSessionListSection({super.key, required this.course});

  @override
  State<ELearningSessionListSection> createState() =>
      _ELearningSessionListSectionState();
}

class _ELearningSessionListSectionState
    extends State<ELearningSessionListSection> {
  final ScrollController _scrollController = ScrollController();
  final Map<int, GlobalKey> _sectionKeys = {};
  final Set<int> _expandedSections = {};
  bool _showSectionMap = false;

  List<ClassSectionModel> _getCourseSections() {
    return MockClassSectionData.classSections
        .where((section) => section.elearningClass.id == widget.course.id)
        .toList();
  }

  @override
  void initState() {
    super.initState();
    final sections = _getCourseSections();
    for (var section in sections) {
      _sectionKeys[section.id] = GlobalKey();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToSection(int sectionId) {
    final key = _sectionKeys[sectionId];
    if (key?.currentContext != null) {
      Scrollable.ensureVisible(
        key!.currentContext!,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
      setState(() {
        _showSectionMap = false;
      });
    }
  }

  void _toggleSection(int sectionId) {
    setState(() {
      if (_expandedSections.contains(sectionId)) {
        _expandedSections.remove(sectionId);
      } else {
        _expandedSections.add(sectionId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final courseSections = _getCourseSections();

    return Stack(
      children: [
        SingleChildScrollView(
          controller: _scrollController,
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              _buildScheduleCard(),
              const SizedBox(height: 16),
              _buildSessionsCard(courseSections),
              const SizedBox(height: 32),
            ],
          ),
        ),
        if (_showSectionMap) _buildSectionMap(courseSections),
        _buildFloatingActionButton(courseSections),
      ],
    );
  }

  Widget _buildFloatingActionButton(List<ClassSectionModel> sections) {
    return Positioned(
      bottom: 20,
      right: 20,
      child: FloatingActionButton(
        mini: true,
        backgroundColor: AppColors.primaryColor,
        onPressed: () {
          setState(() {
            _showSectionMap = !_showSectionMap;
          });
        },
        child: Icon(
          _showSectionMap ? Icons.close : Icons.map_outlined,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildSectionMap(List<ClassSectionModel> sections) {
    return Positioned(
      top: 20,
      right: 20,
      child: Material(
        elevation: 8,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: 250,
          constraints: const BoxConstraints(maxHeight: 300),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.1),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(Icons.map_outlined,
                        color: AppColors.primaryColor.withOpacity(0.7),
                        size: 18),
                    const SizedBox(width: 8),
                    const Text(
                      'Section Map',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
              Flexible(
                child: ListView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(8),
                  itemCount: sections.length,
                  itemBuilder: (context, index) {
                    final section = sections[index];
                    return InkWell(
                      onTap: () => _scrollToSection(section.id),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        margin: const EdgeInsets.only(bottom: 4),
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.class_outlined,
                              size: 16,
                              color: Colors.blue[600],
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                section.name,
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Text(
                              'Sec ${section.section}',
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildScheduleCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.orange.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.schedule_outlined,
                  color: Colors.orange,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'Class Schedule',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildScheduleItem('Monday', '10:00 AM - 12:00 PM', 'Room A101'),
          _buildScheduleItem('Wednesday', '2:00 PM - 4:00 PM', 'Room B203'),
          _buildScheduleItem('Friday', '9:00 AM - 11:00 AM', 'Lab C105'),
        ],
      ),
    );
  }

  Widget _buildScheduleItem(String day, String time, String room) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              day,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              time,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[700],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              room,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.blue[600],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSessionsCard(List<ClassSectionModel> sections) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.cyan.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.class_outlined,
                  color: Colors.cyan,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  'Class Sessions',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    if (_expandedSections.length == sections.length) {
                      _expandedSections.clear();
                    } else {
                      _expandedSections.addAll(sections.map((s) => s.id));
                    }
                  });
                },
                icon: Icon(
                  _expandedSections.length == sections.length
                      ? Icons.unfold_less
                      : Icons.unfold_more,
                  color: Colors.grey[600],
                ),
                tooltip: _expandedSections.length == sections.length
                    ? 'Collapse All'
                    : 'Expand All',
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (sections.isEmpty)
            Container(
              padding: const EdgeInsets.all(20),
              child: Center(
                child: Text(
                  'No sessions available for this course',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ),
            )
          else
            ...sections.map((section) => _buildSessionItem(section)).toList(),
        ],
      ),
    );
  }

  Widget _buildSessionItem(ClassSectionModel section) {
    final materials = MockClassSectionMaterialData.materials
        .where((material) => material.classSection.id == section.id)
        .toList();
    final isExpanded = _expandedSections.contains(section.id);

    return Container(
      key: _sectionKeys[section.id],
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () => _toggleSection(section.id),
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          section.name,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.blue.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          'Section ${section.section}',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Colors.blue[700],
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      AnimatedRotation(
                        turns: isExpanded ? 0.5 : 0,
                        duration: const Duration(milliseconds: 200),
                        child: Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.folder_outlined,
                          size: 14, color: Colors.grey[600]),
                      const SizedBox(width: 4),
                      Text(
                        '${materials.length} materials',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(width: 16),
                      Icon(Icons.access_time,
                          size: 14, color: Colors.grey[600]),
                      const SizedBox(width: 4),
                      Text(
                        'Updated recently',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey[600],
                        ),
                      ),
                      const Spacer(),
                      Text(
                        isExpanded ? 'Tap to collapse' : 'Tap to expand',
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.grey[500],
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            height: isExpanded && materials.isNotEmpty ? null : 0,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 200),
              opacity: isExpanded ? 1.0 : 0.0,
              child: isExpanded && materials.isNotEmpty
                  ? Column(
                      children: [
                        const Divider(height: 1),
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Materials (${materials.length})',
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 12),
                              ...materials.map(
                                  (material) => _buildMaterialItem(material)),
                            ],
                          ),
                        ),
                      ],
                    )
                  : const SizedBox.shrink(),
            ),
          ),
          if (!isExpanded && materials.isNotEmpty) ...[
            const Divider(height: 1),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                children: [
                  ...materials
                      .take(2)
                      .map((material) => _buildMaterialPreview(material)),
                  if (materials.length > 2)
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        '+${materials.length - 2} more materials',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.blue[600],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildMaterialItem(ClassSectionMaterialModel material) {
    IconData icon;
    Color color;

    switch (material.type) {
      case ClassSectionMaterialType.docs:
        icon = Icons.description_outlined;
        color = Colors.blue;
        break;
      case ClassSectionMaterialType.announcement:
        icon = Icons.campaign_outlined;
        color = Colors.orange;
        break;
      case ClassSectionMaterialType.link:
        icon = Icons.link_outlined;
        color = Colors.green;
        break;
      case ClassSectionMaterialType.submission:
        icon = Icons.assignment_outlined;
        color = Colors.purple;
        break;
    }

    return InkWell(
      onTap: () => context.push(AppRouter.classMaterialDetail, extra: material),
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey[200]!),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Icon(icon, size: 16, color: color),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    material.material,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    material.content,
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey[600],
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 12,
              color: Colors.grey[400],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMaterialPreview(ClassSectionMaterialModel material) {
    IconData icon;
    Color color;

    switch (material.type) {
      case ClassSectionMaterialType.docs:
        icon = Icons.description_outlined;
        color = Colors.blue;
        break;
      case ClassSectionMaterialType.announcement:
        icon = Icons.campaign_outlined;
        color = Colors.orange;
        break;
      case ClassSectionMaterialType.link:
        icon = Icons.link_outlined;
        color = Colors.green;
        break;
      case ClassSectionMaterialType.submission:
        icon = Icons.assignment_outlined;
        color = Colors.purple;
        break;
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          Icon(icon, size: 12, color: color),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              material.material,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[700],
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
