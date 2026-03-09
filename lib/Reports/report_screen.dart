import 'package:flutter/material.dart';
import 'report_detail_screen.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  String? _selectedReport;
  DateTime? _selectedDate;
  bool _isReportDropdownOpen = false;

  final List<String> _reportTypes = [
    'Follow - Up Report',
    'Deal Won Report',
    'Deal Lost Report',
    'Meeting Report',
  ];

  // Mock data list
  final List<Map<String, dynamic>> _allReports = [
    {
      'title': 'Lead Conversion summery',
      'date': '12 sep 2025',
      'dateTime': DateTime(2025, 9, 12),
      'status': 'Qualified',
      'count': 'Leads 45 Found',
      'viewCount': '3 times viewed',
<<<<<<< HEAD
      'statusColor': const Color(0xFF26A69A),
=======
      'statusColor': const Color(0xFF6B4195),
>>>>>>> 5271cc96814591a548bd1c0b01a88df5c62cd342
    },
    {
      'title': 'Follow up Report',
      'date': '12 sep 2025',
      'dateTime': DateTime(2025, 9, 12),
      'status': 'Pending',
      'nextFollowUp': '18 sep 2025',
      'assignedTo': 'Rakesh',
      'viewCount': '15 times viewed',
      'statusColor': const Color(0xFF920000),
      'type': 'Mail',
      'reportTypeCode': 'followup',
    },
    {
      'title': 'Lead Conversion summery',
      'date': '12 sep 2025',
      'dateTime': DateTime(2025, 9, 12),
      'status': 'Qualified',
      'count': 'Leads 45 Found',
      'viewCount': '3 times viewed',
<<<<<<< HEAD
      'statusColor': const Color(0xFF26A69A),
=======
      'statusColor': const Color(0xFF6B4195),
>>>>>>> 5271cc96814591a548bd1c0b01a88df5c62cd342
    },
    {
      'title': 'Follow up Report',
      'date': '12 sep 2025',
      'dateTime': DateTime(2025, 9, 12),
      'status': 'Pending',
      'nextFollowUp': '18 sep 2025',
      'assignedTo': 'Rakesh',
      'viewCount': '15 times viewed',
      'statusColor': const Color(0xFF920000),
      'type': 'Mail',
      'reportTypeCode': 'followup',
    },
    
  ];

  List<Map<String, dynamic>> _filteredReports = [];

  @override
  void initState() {
    super.initState();
    _filteredReports = List.from(_allReports);
  }

  void _filterReports() {
    setState(() {
      _filteredReports = _allReports.where((report) {
        bool matchesType = true;
        if (_selectedReport != null) {
          matchesType = report['type'] == _selectedReport;
        }

        bool matchesDate = true;
        if (_selectedDate != null) {
          // Compare only year, month, day
          matchesDate =
              report['dateTime'].year == _selectedDate!.year &&
              report['dateTime'].month == _selectedDate!.month &&
              report['dateTime'].day == _selectedDate!.day;
        }

        return matchesType && matchesDate;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FB),
      appBar: AppBar(
<<<<<<< HEAD
        backgroundColor: const Color(0xFF26A69A),
=======
        backgroundColor: const Color(0xFF6B4195),
>>>>>>> 5271cc96814591a548bd1c0b01a88df5c62cd342
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: screenWidth * 0.06,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Reports',
          style: TextStyle(
            color: Colors.white,
            fontSize: screenWidth * 0.05,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.white,
              size: screenWidth * 0.06,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Colors.white,
              padding: EdgeInsets.all(screenWidth * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Reports',
                    style: TextStyle(
                      fontSize: screenWidth * 0.045,
                      fontWeight: FontWeight.bold,
<<<<<<< HEAD
                      color: const Color(0xFF26A69A),
=======
                      color: const Color(0xFF6B4195),
>>>>>>> 5271cc96814591a548bd1c0b01a88df5c62cd342
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  // Custom Dropdown
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _isReportDropdownOpen = !_isReportDropdownOpen;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.04,
                        vertical: screenHeight * 0.015,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
<<<<<<< HEAD
                          color: const Color(0xFF26A69A).withAlpha(127),
=======
                          color: const Color(0xFF6B4195).withAlpha(127),
>>>>>>> 5271cc96814591a548bd1c0b01a88df5c62cd342
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _selectedReport ?? 'Select Report',
                            style: TextStyle(
                              color: _selectedReport == null
                                  ? Colors.grey
                                  : Colors.black,
                              fontSize: screenWidth * 0.04,
                            ),
                          ),
                          Icon(
                            _isReportDropdownOpen
                                ? Icons.arrow_drop_up
                                : Icons.arrow_drop_down,
<<<<<<< HEAD
                            color: const Color(0xFF26A69A),
=======
                            color: const Color(0xFF6B4195),
>>>>>>> 5271cc96814591a548bd1c0b01a88df5c62cd342
                            size: screenWidth * 0.06,
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (_isReportDropdownOpen)
                    Container(
                      margin: const EdgeInsets.only(top: 4),
                      decoration: BoxDecoration(
                        border: Border.all(
<<<<<<< HEAD
                          color: const Color(0xFF26A69A).withAlpha(127),
=======
                          color: const Color(0xFF6B4195).withAlpha(127),
>>>>>>> 5271cc96814591a548bd1c0b01a88df5c62cd342
                        ),
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                      ),
                      child: Column(
                        children: _reportTypes
                            .map(
                              (type) => ListTile(
                                title: Text(
                                  type,
                                  style: TextStyle(
                                    fontSize: screenWidth * 0.038,
                                  ),
                                ),
                                onTap: () {
                                  setState(() {
                                    _selectedReport = type;
                                    _isReportDropdownOpen = false;
                                  });
                                },
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  SizedBox(height: screenHeight * 0.02),
                  // Date Picker
                  GestureDetector(
                    onTap: () async {
                      final DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101),
                        builder: (context, child) {
                          return Theme(
                            data: Theme.of(context).copyWith(
                              colorScheme: const ColorScheme.light(
<<<<<<< HEAD
                                primary: Color(0xFF26A69A),
=======
                                primary: Color(0xFF6B4195),
>>>>>>> 5271cc96814591a548bd1c0b01a88df5c62cd342
                              ),
                            ),
                            child: child!,
                          );
                        },
                      );
                      if (picked != null) {
                        setState(() {
                          _selectedDate = picked;
                        });
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.04,
                        vertical: screenHeight * 0.015,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
<<<<<<< HEAD
                          color: const Color(0xFF26A69A).withAlpha(127),
=======
                          color: const Color(0xFF6B4195).withAlpha(127),
>>>>>>> 5271cc96814591a548bd1c0b01a88df5c62cd342
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _selectedDate == null
                                ? 'Date'
                                : '${_selectedDate!.day} ${_getMonthName(_selectedDate!.month)} ${_selectedDate!.year}',
                            style: TextStyle(
                              color: _selectedDate == null
                                  ? Colors.grey
                                  : Colors.black,
                              fontSize: screenWidth * 0.04,
                            ),
                          ),
                          Icon(
                            Icons.calendar_month_outlined,
<<<<<<< HEAD
                            color: const Color(0xFF26A69A),
=======
                            color: const Color(0xFF6B4195),
>>>>>>> 5271cc96814591a548bd1c0b01a88df5c62cd342
                            size: screenWidth * 0.06,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  Center(
                    child: SizedBox(
                      width: screenWidth * 0.32,
                      height: screenHeight * 0.06,
                      child: ElevatedButton(
                        onPressed: _filterReports,
                        style: ElevatedButton.styleFrom(
<<<<<<< HEAD
                          backgroundColor: const Color(0xFF26A69A),
=======
                          backgroundColor: const Color(0xFF6B4195),
>>>>>>> 5271cc96814591a548bd1c0b01a88df5c62cd342
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          'Search',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: screenWidth * 0.04,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 1, thickness: 1),
            Padding(
              padding: EdgeInsets.all(screenWidth * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      'Recent Search Reports',
                      style: TextStyle(
                        fontSize: screenWidth * 0.04,
                        fontWeight: FontWeight.bold,
<<<<<<< HEAD
                        color: const Color(0xFF26A69A),
=======
                        color: const Color(0xFF6B4195),
>>>>>>> 5271cc96814591a548bd1c0b01a88df5c62cd342
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  if (_filteredReports.isEmpty)
                    Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: screenHeight * 0.05,
                        ),
                        child: const Text(
                          'No reports found matching your search.',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    )
                  else
                    ..._filteredReports.map(
                      (report) => _buildReportCard(
                        title: report['title'],
                        date: report['date'],
                        status: report['status'],
                        count: report['count'],
                        nextFollowUp: report['nextFollowUp'],
                        assignedTo: report['assignedTo'],
                        type: report['type'],
                        viewCount: report['viewCount'],
                        statusColor: report['statusColor'],
                        screenWidth: screenWidth,
                        screenHeight: screenHeight,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReportCard({
    required String title,
    required String date,
    required String status,
    String? nextFollowUp,
    String? assignedTo,
    String? type,
    String? count,
    required String viewCount,
    required Color statusColor,
    required double screenWidth,
    required double screenHeight,
  }) {
    return Container(
      margin: EdgeInsets.only(
        bottom: screenHeight * 0.015,
        left: 16,
        right: 16,
      ),
      padding: EdgeInsets.all(screenWidth * 0.04),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(15),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: screenWidth * 0.045,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: screenHeight * 0.012),
          _buildIconText(
            Icons.calendar_month_outlined,
            date,
            screenWidth,
<<<<<<< HEAD
            color: const Color(0xFF26A69A),
=======
            color: const Color(0xFF6B4195),
>>>>>>> 5271cc96814591a548bd1c0b01a88df5c62cd342
          ),
          SizedBox(height: screenHeight * 0.008),
          Row(
            children: [
              Icon(
                Icons.filter_alt_outlined,
<<<<<<< HEAD
                color: const Color(0xFF26A69A),
=======
                color: const Color(0xFF6B4195),
>>>>>>> 5271cc96814591a548bd1c0b01a88df5c62cd342
                size: screenWidth * 0.045,
              ),
              SizedBox(width: screenWidth * 0.02),
              Expanded(
                child: RichText(
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: screenWidth * 0.038,
                      color: Colors.grey[600],
                    ),
                    children: [
                      const TextSpan(text: 'Status : '),
                      TextSpan(
                        text: status,
                        style: TextStyle(
                          color: status.toLowerCase() == 'pending'
                              ? Color(0xFF920000)
<<<<<<< HEAD
                              : const Color(0xFF26A69A),
=======
                              : const Color(0xFF6B4195),
>>>>>>> 5271cc96814591a548bd1c0b01a88df5c62cd342
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          if (count != null) ...[
            SizedBox(height: screenHeight * 0.008),
            _buildIconText(
              Icons.track_changes,
              'Leads $count Found',
              screenWidth,
<<<<<<< HEAD
              color: const Color(0xFF26A69A),
=======
              color: const Color(0xFF6B4195),
>>>>>>> 5271cc96814591a548bd1c0b01a88df5c62cd342
            ),
          ],
          if (nextFollowUp != null) ...[
            SizedBox(height: screenHeight * 0.008),
            _buildIconText(
              Icons.watch_later_outlined,
              'Next follow up : $nextFollowUp',
              screenWidth,
<<<<<<< HEAD
              color: const Color(0xFF26A69A),
=======
              color: const Color(0xFF6B4195),
>>>>>>> 5271cc96814591a548bd1c0b01a88df5c62cd342
            ),
          ],
          if (assignedTo != null) ...[
            SizedBox(height: screenHeight * 0.008),
            _buildIconText(
              Icons.person_outline,
              'Assigned to : $assignedTo',
              screenWidth,
<<<<<<< HEAD
              color: const Color(0xFF26A69A),
=======
              color: const Color(0xFF6B4195),
>>>>>>> 5271cc96814591a548bd1c0b01a88df5c62cd342
            ),
          ],
          if (type != null) ...[
            SizedBox(height: screenHeight * 0.008),
            _buildIconText(
              Icons.mail_outline,
              'Type : $type',
              screenWidth,
<<<<<<< HEAD
              color: const Color(0xFF26A69A),
=======
              color: const Color(0xFF6B4195),
>>>>>>> 5271cc96814591a548bd1c0b01a88df5c62cd342
            ),
          ],
          SizedBox(height: screenHeight * 0.008),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 4,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 111, 205, 224).withAlpha(30),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: _buildIconText(
                    Icons.visibility_outlined,
                    '$viewCount viewed',
                    screenWidth,
<<<<<<< HEAD
                    color: const Color(0xFF26A69A),
=======
                    color: const Color(0xFF6B4195),
>>>>>>> 5271cc96814591a548bd1c0b01a88df5c62cd342
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Flexible(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ReportDetailScreen(),
                      ),
                    );
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: Text(
                          'View Full Detail',
                          style: TextStyle(
<<<<<<< HEAD
                            color: const Color(0xFF26A69A),
=======
                            color: const Color(0xFF6B4195),
>>>>>>> 5271cc96814591a548bd1c0b01a88df5c62cd342
                            fontSize: screenWidth * 0.036,
                            fontWeight: FontWeight.w500,
                            decoration: TextDecoration.underline,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Icon(
                        Icons.keyboard_double_arrow_right,
<<<<<<< HEAD
                        color: const Color(0xFF26A69A),
=======
                        color: const Color(0xFF6B4195),
>>>>>>> 5271cc96814591a548bd1c0b01a88df5c62cd342
                        size: screenWidth * 0.045,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildIconText(
    IconData icon,
    String text,
    double screenWidth, {
    Color color = Colors.black87,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
<<<<<<< HEAD
        Icon(icon, size: screenWidth * 0.045, color: const Color(0xFF26A69A)),
=======
        Icon(icon, size: screenWidth * 0.045, color: const Color(0xFF6B4195)),
>>>>>>> 5271cc96814591a548bd1c0b01a88df5c62cd342
        SizedBox(width: screenWidth * 0.02),
        Flexible(
          child: Text(
            text,
            style: TextStyle(color: color, fontSize: screenWidth * 0.038),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  String _getMonthName(int month) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return months[month - 1];
  }
}
