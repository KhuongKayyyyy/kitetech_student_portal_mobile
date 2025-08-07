import 'package:flutter/material.dart';
import 'package:kitetech_student_portal/data/model/ElearningClassSectionMaterial.dart';
import 'package:url_launcher/url_launcher.dart';

class ClassMaterialDetail extends StatelessWidget {
  final ClassSectionMaterialModel material;
  const ClassMaterialDetail({super.key, required this.material});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Material Details',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black87),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildMaterialHeader(),
            const SizedBox(height: 24),
            _buildContentSection(),
            const SizedBox(height: 24),
            _buildActionSection(context),
          ],
        ),
      ),
    );
  }

  Widget _buildMaterialHeader() {
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
                  color: _getTypeColor().withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  _getTypeIcon(),
                  color: _getTypeColor(),
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: _getTypeColor().withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  _getTypeLabel(),
                  style: TextStyle(
                    color: _getTypeColor(),
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            material.material,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'From: ${material.classSection.name}',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContentSection() {
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
              Icon(
                Icons.description_outlined,
                color: Colors.grey[600],
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                'Content',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            material.content,
            style: TextStyle(
              fontSize: 15,
              color: Colors.grey[700],
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionSection(BuildContext context) {
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
              Icon(
                Icons.touch_app_outlined,
                color: Colors.grey[600],
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                'Actions',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildActionButton(context),
        ],
      ),
    );
  }

  Widget _buildActionButton(BuildContext context) {
    switch (material.type) {
      case ClassSectionMaterialType.link:
        return SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: () => _launchUrl(material.content),
            icon: const Icon(Icons.open_in_new),
            label: const Text('Open Link'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        );
      case ClassSectionMaterialType.docs:
        return SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: () => _downloadDocument(),
            icon: const Icon(Icons.download),
            label: const Text('Download Document'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        );
      case ClassSectionMaterialType.submission:
        return Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => _submitAssignment(context),
                icon: const Icon(Icons.upload),
                label: const Text('Submit Assignment'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () => _viewSubmissions(context),
                icon: const Icon(Icons.visibility),
                label: const Text('View My Submissions'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.orange,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        );
      case ClassSectionMaterialType.announcement:
        return SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: () => _markAsRead(context),
            icon: const Icon(Icons.check_circle_outline),
            label: const Text('Mark as Read'),
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.purple,
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        );
    }
  }

  Color _getTypeColor() {
    switch (material.type) {
      case ClassSectionMaterialType.docs:
        return Colors.green;
      case ClassSectionMaterialType.announcement:
        return Colors.purple;
      case ClassSectionMaterialType.link:
        return Colors.blue;
      case ClassSectionMaterialType.submission:
        return Colors.orange;
    }
  }

  IconData _getTypeIcon() {
    switch (material.type) {
      case ClassSectionMaterialType.docs:
        return Icons.description;
      case ClassSectionMaterialType.announcement:
        return Icons.campaign;
      case ClassSectionMaterialType.link:
        return Icons.link;
      case ClassSectionMaterialType.submission:
        return Icons.assignment;
    }
  }

  String _getTypeLabel() {
    switch (material.type) {
      case ClassSectionMaterialType.docs:
        return 'Document';
      case ClassSectionMaterialType.announcement:
        return 'Announcement';
      case ClassSectionMaterialType.link:
        return 'Link';
      case ClassSectionMaterialType.submission:
        return 'Assignment';
    }
  }

  void _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  void _downloadDocument() {
    // Implement document download functionality
    print('Downloading document: ${material.material}');
  }

  void _submitAssignment(BuildContext context) {
    // Implement assignment submission functionality
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Submit Assignment'),
        content: const Text(
            'Assignment submission feature will be implemented here.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _viewSubmissions(BuildContext context) {
    // Implement view submissions functionality
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('My Submissions'),
        content: const Text('Submissions history will be displayed here.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _markAsRead(BuildContext context) {
    // Implement mark as read functionality
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Announcement marked as read'),
        duration: Duration(seconds: 2),
      ),
    );
  }
}
