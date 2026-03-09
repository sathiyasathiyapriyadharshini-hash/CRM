import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Follows/enquiry_details_screen.dart';
<<<<<<< HEAD
import '../services/profile_service.dart';
import '../services/lead_service.dart';
import 'add_lead_screen.dart';
=======
>>>>>>> 5271cc96814591a548bd1c0b01a88df5c62cd342

class LeadsScreen extends StatefulWidget {
  const LeadsScreen({super.key});

  @override
  State<LeadsScreen> createState() => _LeadsScreenState();
}

class _LeadsScreenState extends State<LeadsScreen> {
  String _selectedFilter = 'All';
  DateTime? _selectedDate;
<<<<<<< HEAD
  bool _isLoading = false;
  List<dynamic> _allLeads = [];
  List<dynamic> _allFollowUps = [];
  String _employeeName = '';

  @override
  void initState() {
    super.initState();
    _refreshData();
    _fetchProfileName();
  }

  Future<void> _refreshData() async {
    if (_selectedFilter.contains('Follow up')) {
      await _fetchFollowUps();
    } else {
      await _fetchLeads();
    }
  }

  Future<void> _fetchFollowUps() async {
    setState(() => _isLoading = true);
    try {
      final followUps = await LeadService.fetchFollowUpHistoryAll();
      if (mounted) {
        setState(() {
          _allFollowUps = followUps;
          _isLoading = false;
        });
      }
    } catch (e) {
      debugPrint("Error fetching follow-ups: $e");
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _fetchProfileName() async {
    final profileData = await ProfileService.fetchProfileData();
    if (mounted && profileData != null) {
      setState(() {
        _employeeName = profileData['name'] ?? 'N/A';
      });
    }
  }

  Future<void> _fetchLeads() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final leads = await LeadService.fetchLeads(enquiryType: 'Lead');
      if (mounted) {
        setState(() {
          _allLeads = leads;
          _allFollowUps = []; // Reset follow-ups when refreshing leads
        });
      }
    } catch (e) {
      debugPrint("Error fetching leads: $e");
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
=======
>>>>>>> 5271cc96814591a548bd1c0b01a88df5c62cd342

  final List<String> _filters = [
    'All',
    'New',
    'Follow up',
<<<<<<< HEAD
    'Today Follow up',
=======
>>>>>>> 5271cc96814591a548bd1c0b01a88df5c62cd342
    'Interested',
    'Negotiation',
  ];

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
<<<<<<< HEAD
            colorScheme: const ColorScheme.light(primary: Color(0xFF26A69A)),
=======
            colorScheme: const ColorScheme.light(primary: Color(0xFF6B4195)),
>>>>>>> 5271cc96814591a548bd1c0b01a88df5c62cd342
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber.replaceAll(RegExp(r'[^\d+]'), ''),
    );
    try {
      if (await canLaunchUrl(launchUri)) {
        await launchUrl(launchUri);
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Could not launch dialer')),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    }
  }

<<<<<<< HEAD
  List<dynamic> get _filteredLeads {
    if (_selectedFilter == 'Follow up' ||
        _selectedFilter == 'Today Follow up') {
      List<dynamic> filtered = _allFollowUps;
      DateTime? filterDate = _selectedDate;
      if (_selectedFilter == 'Today Follow up') {
        filterDate = DateTime.now();
      }

      if (filterDate != null) {
        String targetDate =
            '${filterDate.year}-${filterDate.month.toString().padLeft(2, '0')}-${filterDate.day.toString().padLeft(2, '0')}';
        filtered = filtered.where((log) {
          String logDate =
              (log['call_date'] ?? log['enquiry_date'])?.toString() ?? '';
          return logDate.startsWith(targetDate);
        }).toList();
      }
      return filtered;
    }

    List<dynamic> filtered = _allLeads;
    // status mapping for filters
    final Map<String, String> statusMap = {
      'Interested': 'Interested',
      'Negotiation': 'Negotiation',
      // 'Follow up': 'Follow up', // Handled by separate API call logic now
    };

    // Filter by status (Filter Chips)
    if (_selectedFilter != 'All' && _selectedFilter != 'New') {
      filtered = filtered.where((lead) {
        String status = (lead['lead_status'] ?? lead['status'] ?? '')
            .toString()
            .trim()
            .toLowerCase();
        String? target = statusMap[_selectedFilter]?.toLowerCase();
        return target != null && status == target;
      }).toList();
    }

    // Filter by date
    if (_selectedDate != null) {
      filtered = filtered.where((lead) {
        String? enquiryDateStr =
            lead['enquiry_date']?.toString() ?? lead['entry_date']?.toString();
        if (enquiryDateStr == null || enquiryDateStr.isEmpty) return false;

        try {
          final separators = RegExp(r'[-/ ]');
          List<String> parts = enquiryDateStr.split(separators);
          if (parts.length >= 3) {
            int year, month, day;
            if (parts[0].length == 4) {
              year = int.parse(parts[0]);
              month = int.parse(parts[1]);
              day = int.parse(parts[2]);
            } else {
              day = int.parse(parts[0]);
              month = int.parse(parts[1]);
              year = int.parse(parts[2]);
            }

            return year == _selectedDate!.year &&
                month == _selectedDate!.month &&
                day == _selectedDate!.day;
          }
        } catch (e) {
          debugPrint("Error parsing date: $enquiryDateStr - $e");
        }
        return false;
      }).toList();
    } else if (_selectedFilter == 'New') {
      DateTime today = DateTime.now();
      filtered = filtered.where((lead) {
        String status = (lead['lead_status'] ?? lead['status'] ?? '')
            .toString()
            .trim()
            .toLowerCase();
        if (status == 'follow up' ||
            status == 'interested' ||
            status == 'negotiation') {
          return false;
        }

        String? enquiryDateStr =
            lead['enquiry_date']?.toString() ?? lead['entry_date']?.toString();
        if (enquiryDateStr == null || enquiryDateStr.isEmpty) return false;
        try {
          final separators = RegExp(r'[-/ ]');
          List<String> parts = enquiryDateStr.split(separators);
          if (parts.length >= 3) {
            int year, month, day;
            if (parts[0].length == 4) {
              year = int.parse(parts[0]);
              month = int.parse(parts[1]);
              day = int.parse(parts[2]);
            } else {
              day = int.parse(parts[0]);
              month = int.parse(parts[1]);
              year = int.parse(parts[2]);
            }
            return year == today.year &&
                month == today.month &&
                day == today.day;
          }
        } catch (_) {}
        return false;
      }).toList();
    }

    return filtered;
  }

=======
>>>>>>> 5271cc96814591a548bd1c0b01a88df5c62cd342
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double screenWidth = size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Lead',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: screenWidth * 0.05,
          ),
        ),
<<<<<<< HEAD
        backgroundColor: const Color(0xFF26A69A),
=======
        backgroundColor: const Color(0xFF6B4195),
>>>>>>> 5271cc96814591a548bd1c0b01a88df5c62cd342
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_month, color: Colors.white),
            onPressed: () => _selectDate(context),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Filter Chips
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: _filters.map((filter) {
                  final isSelected = _selectedFilter == filter;
                  return Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: GestureDetector(
<<<<<<< HEAD
                      onTap: () async {
                        setState(() {
                          _selectedFilter = filter;
                          if (filter == 'New' || filter == 'Today Follow up') {
                            _selectedDate = DateTime.now();
                          } else {
                            _selectedDate = null;
                          }
                        });
                        await _refreshData();
=======
                      onTap: () {
                        setState(() {
                          _selectedFilter = filter;
                        });
>>>>>>> 5271cc96814591a548bd1c0b01a88df5c62cd342
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.06,
                          vertical: screenWidth * 0.02,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
<<<<<<< HEAD
                              ? const Color(0xFF26A69A)
                              : Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(color: const Color(0xFF26A69A)),
=======
                              ? const Color(0xFF6B4195)
                              : Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(color: const Color(0xFF6B4195)),
>>>>>>> 5271cc96814591a548bd1c0b01a88df5c62cd342
                        ),
                        child: Text(
                          filter,
                          style: TextStyle(
                            color: isSelected
                                ? Colors.white
<<<<<<< HEAD
                                : const Color(0xFF26A69A),
=======
                                : const Color(0xFF6B4195),
>>>>>>> 5271cc96814591a548bd1c0b01a88df5c62cd342
                            fontWeight: FontWeight.w500,
                            fontSize: screenWidth * 0.035,
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),

<<<<<<< HEAD
          // Leads Section Header (Always Visible)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: _buildSectionHeader(
              _selectedFilter.contains('Follow up')
                  ? 'Follow-up History (${_filteredLeads.length})'
                  : 'Today lead (${_filteredLeads.length})',
              screenWidth,
              trailing: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const AddLeadScreen(isEnquiry: false),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF5C7BCF),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                child: const Text(
                  'Add Lead',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),

          // Leads List or Empty State
          Expanded(
            child: _isLoading
                ? const Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Color(0xFF26A69A),
                      ),
                    ),
                  )
                : _filteredLeads.isEmpty
                ? const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.info_outline, size: 48, color: Colors.grey),
                        SizedBox(height: 16),
                        Text(
                          "No leads found for current selection",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: _filteredLeads.length,
                    itemBuilder: (context, index) {
                      final item = _filteredLeads[index];

                      if (_selectedFilter == 'Follow up' ||
                          _selectedFilter == 'Today Follow up') {
                        return _buildLeadCard(
                          lead: item,
                          name:
                              (item['cus_name'] ?? item['le_name'])
                                  ?.toString() ??
                              'N/A',
                          contact1: item['mobile_1']?.toString() ?? 'N/A',
                          contact2:
                              (item['moble_2'] ?? item['mobile_2'])
                                  ?.toString() ??
                              'N/A',
                          email: item['email']?.toString() ?? 'N/A',
                          service:
                              (item['required_project'] ??
                                      item['product_service'])
                                  ?.toString() ??
                              'N/A',
                          followUpDate:
                              (item['call_date'] ?? item['enquiry_date'])
                                  ?.toString() ??
                              'N/A',
                          screenWidth: screenWidth,
                        );
                      }

                      return _buildLeadCard(
                        lead: item,
                        name: item['le_name']?.toString() ?? 'N/A',
                        contact1: item['mobile_1']?.toString() ?? 'N/A',
                        contact2: item['moble_2']?.toString() ?? 'N/A',
                        email: item['email']?.toString() ?? 'N/A',
                        service: item['product_service']?.toString() ?? 'N/A',
                        followUpDate: item['enquiry_date']?.toString() ?? 'N/A',
                        screenWidth: screenWidth,
                      );
                    },
                  ),
=======
          // Leads List
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                _buildSectionHeader('Today lead', screenWidth),
                _buildLeadCard(
                  name: 'Arun Kumar',
                  leadNo: 'L001',
                  phone: '12345 68452',
                  email: 'crmapp@gmail.com',
                  reference: 'Reference',
                  screenWidth: screenWidth,
                ),
                _buildLeadCard(
                  name: 'Arun Kumar',
                  leadNo: 'L001',
                  phone: '12345 68452',
                  email: 'crmapp@gmail.com',
                  reference: 'Reference',
                  screenWidth: screenWidth,
                ),
                _buildLeadCard(
                  name: 'Arun Kumar',
                  leadNo: 'L001',
                  phone: '12345 68452',
                  email: 'crmapp@gmail.com',
                  reference: 'Reference',
                  screenWidth: screenWidth,
                ),

                const SizedBox(height: 16),
                _buildSectionHeader('Yesterday lead', screenWidth),
                _buildLeadCard(
                  name: 'Arun Kumar',
                  leadNo: 'L001',
                  phone: '12345 68452',
                  email: 'crmapp@gmail.com',
                  reference: 'Reference',
                  screenWidth: screenWidth,
                ),
                _buildLeadCard(
                  name: 'Arun Kumar',
                  leadNo: 'L001',
                  phone: '12345 68452',
                  email: 'crmapp@gmail.com',
                  reference: 'Reference',
                  screenWidth: screenWidth,
                ),
                _buildLeadCard(
                  name: 'Arun Kumar',
                  leadNo: 'L001',
                  phone: '12345 68452',
                  email: 'crmapp@gmail.com',
                  reference: 'Reference',
                  screenWidth: screenWidth,
                ),
                _buildSectionHeader('Lastweek lead', screenWidth),

                _buildLeadCard(
                  name: 'Arun Kumar',
                  leadNo: 'L001',
                  phone: '12345 68452',
                  email: 'crmapp@gmail.com',
                  reference: 'Reference',
                  screenWidth: screenWidth,
                ),
                _buildLeadCard(
                  name: 'Arun Kumar',
                  leadNo: 'L001',
                  phone: '12345 68452',
                  email: 'crmapp@gmail.com',
                  reference: 'Reference',
                  screenWidth: screenWidth,
                ),
                _buildLeadCard(
                  name: 'Arun Kumar',
                  leadNo: 'L001',
                  phone: '12345 68452',
                  email: 'crmapp@gmail.com',
                  reference: 'Reference',
                  screenWidth: screenWidth,
                ),
              ],
            ),
>>>>>>> 5271cc96814591a548bd1c0b01a88df5c62cd342
          ),
        ],
      ),
    );
  }

<<<<<<< HEAD
  void _showCallConfirmation(Map<String, dynamic> lead) {
    final String name =
        (lead['le_name'] ?? lead['cus_name'])?.toString() ?? 'N/A';
    final String phone = lead['mobile_1']?.toString() ?? 'N/A';
=======
  void _showCallConfirmation(String name, String phone) {
>>>>>>> 5271cc96814591a548bd1c0b01a88df5c62cd342
    final double screenWidth = MediaQuery.of(context).size.width;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, bottom: 0),
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Confirm Call',
                  style: TextStyle(
                    fontSize: screenWidth * 0.045,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).textTheme.titleLarge?.color,
                  ),
                ),
                const SizedBox(height: 20),
                Divider(color: Theme.of(context).dividerColor),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Icon(
                      Icons.account_circle_outlined,
                      size: screenWidth * 0.12,
                      color: Colors.grey,
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: TextStyle(
                            fontSize: screenWidth * 0.04,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).textTheme.bodyLarge?.color,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '+91 $phone',
                          style: TextStyle(
                            fontSize: screenWidth * 0.035,
                            color: Theme.of(
                              context,
                            ).textTheme.bodyMedium?.color,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Text(
                              'Status: ',
                              style: TextStyle(
                                fontSize: screenWidth * 0.035,
                                color: Theme.of(
                                  context,
                                ).textTheme.bodySmall?.color,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFF448AFF),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                'New Lead',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: screenWidth * 0.03,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Divider(color: Theme.of(context).dividerColor),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Do you want to call this lead?',
                    style: TextStyle(
                      fontSize: screenWidth * 0.04,
                      color: Theme.of(context).textTheme.bodyMedium?.color,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          side: BorderSide(color: Colors.grey.shade400),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Cancel',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          _makePhoneCall(phone);
                          // Show Lead details popup after 2 seconds
                          Future.delayed(const Duration(seconds: 2), () {
                            if (mounted) {
<<<<<<< HEAD
                              _showLeadDetailsPopup(lead);
=======
                              _showLeadDetailsPopup(name);
>>>>>>> 5271cc96814591a548bd1c0b01a88df5c62cd342
                            }
                          });
                        },
                        style: ElevatedButton.styleFrom(
<<<<<<< HEAD
                          backgroundColor: const Color(0xFF4BA751),
=======
                          backgroundColor: const Color(0xFF4CAF50),
>>>>>>> 5271cc96814591a548bd1c0b01a88df5c62cd342
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Call Now',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        );
      },
    );
  }

<<<<<<< HEAD
  Widget _buildSectionHeader(
    String title,
    double screenWidth, {
    Widget? trailing,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: screenWidth * 0.045,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).textTheme.bodyLarge?.color,
            ),
          ),
          if (trailing != null) trailing,
        ],
=======
  Widget _buildSectionHeader(String title, double screenWidth) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: screenWidth * 0.045,
          fontWeight: FontWeight.w500,
          color: Theme.of(context).textTheme.bodyLarge?.color,
        ),
>>>>>>> 5271cc96814591a548bd1c0b01a88df5c62cd342
      ),
    );
  }

  Widget _buildLeadCard({
<<<<<<< HEAD
    required Map<String, dynamic> lead,
    required String name,
    required String contact1,
    required String contact2,
    required String email,
    required String service,
    required String followUpDate,
=======
    required String name,
    required String leadNo,
    required String phone,
    required String email,
    required String reference,
>>>>>>> 5271cc96814591a548bd1c0b01a88df5c62cd342
    required double screenWidth,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
<<<<<<< HEAD
          MaterialPageRoute(
            builder: (context) => EnquiryDetailsScreen(lead: lead),
          ),
=======
          MaterialPageRoute(builder: (context) => const EnquiryDetailsScreen()),
>>>>>>> 5271cc96814591a548bd1c0b01a88df5c62cd342
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Theme.of(context).dividerColor),
        ),
<<<<<<< HEAD
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoRow(Icons.person_outline, 'Name : $name', screenWidth),
            const SizedBox(height: 8),
            _buildInfoRow(
              Icons.phone_outlined,
              'Contact No 1: $contact1',
              screenWidth,
            ),
            const SizedBox(height: 8),
            _buildInfoRow(
              Icons.phone_outlined,
              'Contact No 2: $contact2',
              screenWidth,
            ),
            const SizedBox(height: 8),
            _buildInfoRow(
              Icons.assignment_outlined,
              'Service Required: $service',
              screenWidth,
            ),
            const SizedBox(height: 8),
            _buildInfoRow(
              Icons.calendar_today_outlined,
              'Follow up date: $followUpDate',
              screenWidth,
            ),
            const SizedBox(height: 8),
            _buildInfoRow(Icons.mail_outline, 'Email: $email', screenWidth),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => _showCallConfirmation(lead),
                icon: const Icon(Icons.phone, color: Colors.white),
                label: const Text(
                  'Call Now',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4BA751),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
=======
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: _buildInfoRow(
                          Icons.person_outline,
                          'Name : $name',
                          screenWidth,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => _showCallConfirmation(name, phone),
                        child: Image.asset(
                          'assets/icons/green_call.png',
                          width: screenWidth * 0.08,
                          height: screenWidth * 0.08,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  _buildInfoRow(Icons.adjust, 'Lead No: $leadNo', screenWidth),
                  const SizedBox(height: 8),
                  _buildInfoRow(
                    Icons.phone_outlined,
                    'Phone  No: $phone',
                    screenWidth,
                  ),
                  const SizedBox(height: 8),
                  _buildInfoRow(
                    Icons.mail_outline,
                    'Email Id : $email',
                    screenWidth,
                  ),
                  const SizedBox(height: 8),
                  _buildInfoRow(Icons.fullscreen, reference, screenWidth),
                ],
>>>>>>> 5271cc96814591a548bd1c0b01a88df5c62cd342
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text, double screenWidth) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: screenWidth * 0.045,
          color: Theme.of(context).textTheme.bodyLarge?.color,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: screenWidth * 0.035,
              color: Theme.of(context).textTheme.bodyMedium?.color,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }

<<<<<<< HEAD
  void _showLeadDetailsPopup(Map<String, dynamic> lead) {
=======
  void _showLeadDetailsPopup(String name) {
>>>>>>> 5271cc96814591a548bd1c0b01a88df5c62cd342
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
<<<<<<< HEAD
      builder: (context) => _LeadDetailsPopupContent(
        lead: lead,
        employeeName: _employeeName,
        onRefresh: _refreshData,
      ),
    );
  }
}

class _LeadDetailsPopupContent extends StatefulWidget {
  final Map<String, dynamic> lead;
  final String employeeName;
  final VoidCallback? onRefresh;

  const _LeadDetailsPopupContent({
    required this.lead,
    required this.employeeName,
    this.onRefresh,
  });

  @override
  State<_LeadDetailsPopupContent> createState() =>
      _LeadDetailsPopupContentState();
}

class _LeadDetailsPopupContentState extends State<_LeadDetailsPopupContent> {
  String selectedOutcome = 'Select Outcome';
  String selectedMode = 'Select Follow-up Mode';
  String selectedStatus = 'Select Lead Status';
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  late TextEditingController customerNameController;
  late TextEditingController attendedByController;
  final budgetController = TextEditingController();
  final otherServiceController = TextEditingController();
  final notesController = TextEditingController();

  bool isSubmitting = false;

  List<Map<String, dynamic>> outcomeList = [];
  List<Map<String, dynamic>> modeList = [];
  List<Map<String, dynamic>> statusList = [];

  bool isLoadingDropdowns = true;

  @override
  void initState() {
    super.initState();
    customerNameController = TextEditingController(
      text:
          (widget.lead['le_name'] ?? widget.lead['cus_name'])?.toString() ?? '',
    );
    attendedByController = TextEditingController(text: widget.employeeName);
    budgetController.text =
        (widget.lead['budget'] ?? widget.lead['customer_budget'])?.toString() ??
        '';
    _loadDropdownData();
  }

  Future<void> _loadDropdownData() async {
    try {
      final results = await Future.wait([
        LeadService.fetchDropdownData(type: '3014'), // Call Outcome
        LeadService.fetchDropdownData(type: '3015'), // Follow-up Mode
        LeadService.fetchDropdownData(type: '3009'), // Lead Status
      ]);

      if (mounted) {
        setState(() {
          outcomeList = List<Map<String, dynamic>>.from(results[0]);
          modeList = List<Map<String, dynamic>>.from(results[1]);
          statusList = List<Map<String, dynamic>>.from(results[2]);
          isLoadingDropdowns = false;
        });
      }
    } catch (e) {
      debugPrint("Error loading dropdown data: $e");
      if (mounted) {
        setState(() => isLoadingDropdowns = false);
      }
    }
  }

  @override
  void dispose() {
    customerNameController.dispose();
    attendedByController.dispose();
    budgetController.dispose();
    otherServiceController.dispose();
    notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      height: MediaQuery.of(context).size.height * 0.9,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: Column(
        children: [
          const SizedBox(height: 12),
          Container(
            width: 50,
            height: 5,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2.5),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => Navigator.pop(context),
                ),
                Text(
                  'Lead details',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).textTheme.titleLarge?.color,
                  ),
                ),
              ],
            ),
          ),
          Divider(color: Theme.of(context).dividerColor),
          Expanded(
            child: isLoadingDropdowns
                ? const Center(
                    child: CircularProgressIndicator(color: Color(0xFF26A69A)),
                  )
                : SingleChildScrollView(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildPopupLabel('Customer Name'),
                        const SizedBox(height: 8),
                        TextField(
                          controller: customerNameController,
                          decoration: InputDecoration(
                            hintText: 'Enter Customer Name',
                            hintStyle: TextStyle(
                              color: Theme.of(
                                context,
                              ).textTheme.bodySmall?.color,
                              fontSize: 14,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                color: Theme.of(context).dividerColor,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                color: Theme.of(context).dividerColor,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        _buildPopupLabel('Call Outcome', isRequired: true),
                        const SizedBox(height: 8),
                        _buildPopupDropdown(
                          value: selectedOutcome,
                          items: [
                            'Select Outcome',
                            ...outcomeList.map((e) => e['name'].toString()),
                          ],
                          onChanged: (val) => setState(
                            () => selectedOutcome = val ?? 'Select Outcome',
                          ),
                        ),
                        const SizedBox(height: 20),
                        _buildPopupLabel('Follow-Up Mode', isRequired: true),
                        const SizedBox(height: 8),
                        _buildPopupDropdown(
                          value: selectedMode,
                          items: [
                            'Select Follow-up Mode',
                            ...modeList.map((e) => e['name'].toString()),
                          ],
                          onChanged: (val) => setState(
                            () => selectedMode = val ?? 'Select Follow-up Mode',
                          ),
                        ),
                        const SizedBox(height: 20),
                        _buildPopupLabel('Attended By'),
                        const SizedBox(height: 8),
                        TextField(
                          controller: attendedByController,
                          decoration: InputDecoration(
                            hintText: 'Enter Employee Name',
                            hintStyle: TextStyle(
                              color: Theme.of(
                                context,
                              ).textTheme.bodySmall?.color,
                              fontSize: 14,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                color: Theme.of(context).dividerColor,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                color: Theme.of(context).dividerColor,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildPopupLabel(
                                    'Next Follow-up Date',
                                    isRequired: true,
                                  ),
                                  const SizedBox(height: 8),
                                  _buildDatePickerField(
                                    selectedDate != null
                                        ? '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}'
                                        : '',
                                    () async {
                                      final date = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime.now(),
                                        lastDate: DateTime(2100),
                                      );
                                      if (date != null) {
                                        setState(() => selectedDate = date);
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildPopupLabel(
                                    'Next Follow-up Time',
                                    isRequired: true,
                                  ),
                                  const SizedBox(height: 8),
                                  _buildTimePickerField(
                                    selectedTime != null
                                        ? selectedTime!.format(context)
                                        : '',
                                    () async {
                                      final time = await showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay.now(),
                                      );
                                      if (time != null) {
                                        setState(() => selectedTime = time);
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        _buildPopupLabel('Customer Budget'),
                        const SizedBox(height: 8),
                        TextField(
                          controller: budgetController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: '₹25,000',
                            hintStyle: TextStyle(
                              color: Theme.of(
                                context,
                              ).textTheme.bodySmall?.color,
                              fontSize: 14,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                color: Theme.of(context).dividerColor,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                color: Theme.of(context).dividerColor,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        _buildPopupLabel('Other Service Required'),
                        const SizedBox(height: 8),
                        TextField(
                          controller: otherServiceController,
                          decoration: InputDecoration(
                            hintText: 'Enter Other Services',
                            hintStyle: TextStyle(
                              color: Theme.of(
                                context,
                              ).textTheme.bodySmall?.color,
                              fontSize: 14,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                color: Theme.of(context).dividerColor,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                color: Theme.of(context).dividerColor,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        _buildPopupLabel('Notes / Call Summary'),
                        const SizedBox(height: 8),
                        TextField(
                          controller: notesController,
                          maxLines: 4,
                          decoration: InputDecoration(
                            hintText: 'Enter discussion summary..',
                            hintStyle: TextStyle(
                              color: Theme.of(
                                context,
                              ).textTheme.bodySmall?.color,
                              fontSize: 14,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                color: Theme.of(context).dividerColor,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                color: Theme.of(context).dividerColor,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        _buildPopupLabel('Lead Status'),
                        const SizedBox(height: 8),
                        _buildPopupDropdown(
                          value: selectedStatus,
                          items: [
                            'Select Lead Status',
                            ...statusList.map((e) => e['name'].toString()),
                          ],
                          onChanged: (val) => setState(
                            () => selectedStatus = val ?? 'Select Lead Status',
                          ),
                        ),
                        const SizedBox(height: 24),
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: isSubmitting
                                ? null
                                : () async {
                                    if (selectedOutcome == 'Select Outcome') {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            'Please select call outcome',
                                          ),
                                        ),
                                      );
                                      return;
                                    }
                                    if (selectedMode ==
                                        'Select Follow-up Mode') {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            'Please select follow-up mode',
                                          ),
                                        ),
                                      );
                                      return;
                                    }

                                    setState(() => isSubmitting = true);

                                    try {
                                      final String dateStr =
                                          selectedDate != null
                                          ? "${selectedDate!.year}-${selectedDate!.month.toString().padLeft(2, '0')}-${selectedDate!.day.toString().padLeft(2, '0')}"
                                          : "";
                                      final String timeStr =
                                          selectedTime != null
                                          ? "${selectedTime!.hour.toString().padLeft(2, '0')}:${selectedTime!.minute.toString().padLeft(2, '0')}:00"
                                          : "";
                                      debugPrint(
                                        "DEBUG: widget.lead contents: ${widget.lead}",
                                      );
                                      // Detection logic: History records (3016) have 'call_date' or 'call_by'
                                      final bool isHistoryRecord =
                                          widget.lead.containsKey(
                                            'call_date',
                                          ) ||
                                          widget.lead.containsKey('call_by');

                                      // Robust ID extraction per user suggestion
                                      final String leadId = isHistoryRecord
                                          ? (widget.lead['led_id']
                                                    ?.toString() ??
                                                '')
                                          : (widget.lead['id']?.toString() ??
                                                '');

                                      final String recordId = isHistoryRecord
                                          ? (widget.lead['id']?.toString() ??
                                                '')
                                          : '';

                                      final Map<String, dynamic>
                                      followUpData = {
                                        'id': recordId,
                                        'led_id': leadId,
                                        'call_date': DateTime.now()
                                            .toString()
                                            .split(' ')[0],
                                        'cus_name': customerNameController.text,
                                        'le_name': customerNameController.text,
                                        'call_outcome':
                                            selectedOutcome == 'Select Outcome'
                                            ? ''
                                            : (() {
                                                final idx = outcomeList
                                                    .indexWhere(
                                                      (e) =>
                                                          e['name']
                                                              .toString() ==
                                                          selectedOutcome,
                                                    );
                                                if (idx == -1) return '';
                                                final item = outcomeList[idx];
                                                return (item['value'] ??
                                                        (idx + 1))
                                                    .toString();
                                              })(),
                                        'follow_up_mode':
                                            selectedMode ==
                                                'Select Follow-up Mode'
                                            ? ''
                                            : (() {
                                                final idx = modeList.indexWhere(
                                                  (e) =>
                                                      e['name'].toString() ==
                                                      selectedMode,
                                                );
                                                if (idx == -1) return '';
                                                final item = modeList[idx];
                                                return (item['value'] ??
                                                        (idx + 1))
                                                    .toString();
                                              })(),
                                        'required_project':
                                            (widget.lead['product_service'] ??
                                                    widget
                                                        .lead['required_project'])
                                                ?.toString() ??
                                            '',
                                        'other_required':
                                            otherServiceController.text,
                                        'customer_budget':
                                            budgetController.text,
                                        'next_follow_up_date': dateStr,
                                        'next_follow_up_time': timeStr,
                                        'call_summary': notesController.text,
                                        'lead_status':
                                            selectedStatus ==
                                                'Select Lead Status'
                                            ? ''
                                            : (() {
                                                final idx = statusList
                                                    .indexWhere(
                                                      (e) =>
                                                          e['name']
                                                              .toString() ==
                                                          selectedStatus,
                                                    );
                                                if (idx == -1) return '';
                                                final item = statusList[idx];
                                                return (item['value'] ??
                                                        (idx + 1))
                                                    .toString();
                                              })(),
                                        'type_status':
                                            'lead', // Added per user request
                                      };

                                      final response = isHistoryRecord
                                          ? await LeadService.updateFollowUp(
                                              followUpData,
                                            )
                                          : await LeadService.addFollowUp(
                                              followUpData,
                                            );

                                      // Printing response for debugging as requested
                                      debugPrint(
                                        "------------ LEAD FOLLOW-UP SUBMISSION RESPONSE ------------",
                                      );
                                      debugPrint(response.toString());

                                      if (mounted) {
                                        if (response['error'] == false) {
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                response['error_msg'] ??
                                                    'Success',
                                              ),
                                              backgroundColor: Colors.green,
                                            ),
                                          );
                                          if (widget.onRefresh != null) {
                                            widget.onRefresh!();
                                          }
                                          Navigator.pop(context);
                                        } else {
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                response['error_msg'] ??
                                                    'Error',
                                              ),
                                              backgroundColor: Colors.red,
                                            ),
                                          );
                                        }
                                      }
                                    } catch (e) {
                                      debugPrint('Submit error: $e');
                                      if (mounted) {
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                              'Submission failed. Please try again.',
                                            ),
                                            backgroundColor: Colors.red,
                                          ),
                                        );
                                      }
                                    } finally {
                                      if (mounted) {
                                        setState(() => isSubmitting = false);
                                      }
                                    }
                                  },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF26A69A),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: isSubmitting
                                ? const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2,
                                    ),
                                  )
                                : const Text(
                                    'Submit',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                          ),
                        ),
                        const SizedBox(height: 32),
                      ],
                    ),
                  ),
          ),
        ],
      ),
=======
      builder: (context) {
        String selectedOutcome = 'Select Outcome';
        String selectedResponse = 'Today Follow-up';
        String selectedMode = 'Select Follow-up Mode';
        String selectedStatus = 'Select Lead Status';
        DateTime? selectedDate;
        TimeOfDay? selectedTime;

        return StatefulBuilder(
          builder: (context, setModalState) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.9,
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 12),
                  Container(
                    width: 50,
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(2.5),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back),
                          onPressed: () => Navigator.pop(context),
                        ),
                        Text(
                          'Lead details',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Theme.of(
                              context,
                            ).textTheme.titleLarge?.color,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(color: Theme.of(context).dividerColor),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildPopupLabel('Call Outcome', isRequired: true),
                          const SizedBox(height: 8),
                          _buildPopupDropdown(
                            value: selectedOutcome,
                            items: [
                              'Select Outcome',
                              'Connected',
                              'Switched Off',
                              'Busy',
                              'Wrong Number',
                            ],
                            onChanged: (val) => setModalState(
                              () => selectedOutcome = val ?? 'Select Outcome',
                            ),
                          ),
                          const SizedBox(height: 20),
                          _buildPopupLabel('Lead Response', isRequired: true),
                          const SizedBox(height: 10),
                          _buildRadioGroup(
                            selectedResponse,
                            ['Today Follow-up', 'Reschedule', 'Upcoming'],
                            (val) =>
                                setModalState(() => selectedResponse = val),
                          ),
                          const SizedBox(height: 20),
                          _buildPopupLabel('Follow-Up Mode', isRequired: true),
                          const SizedBox(height: 8),
                          _buildPopupDropdown(
                            value: selectedMode,
                            items: [
                              'Select Follow-up Mode',
                              'Call',
                              'WhatsApp',
                              'Meeting',
                              'Demo',
                            ],
                            onChanged: (val) => setModalState(
                              () =>
                                  selectedMode = val ?? 'Select Follow-up Mode',
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _buildPopupLabel(
                                      'Follow-up Date',
                                      isRequired: true,
                                    ),
                                    const SizedBox(height: 8),
                                    _buildDatePickerField(
                                      selectedDate != null
                                          ? '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}'
                                          : '',
                                      () async {
                                        final date = await showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime.now(),
                                          lastDate: DateTime(2100),
                                        );
                                        if (date != null) {
                                          setModalState(
                                            () => selectedDate = date,
                                          );
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _buildPopupLabel(
                                      'Follow-up Time',
                                      isRequired: true,
                                    ),
                                    const SizedBox(height: 8),
                                    _buildTimePickerField(
                                      selectedTime != null
                                          ? selectedTime!.format(context)
                                          : '',
                                      () async {
                                        final time = await showTimePicker(
                                          context: context,
                                          initialTime: TimeOfDay.now(),
                                        );
                                        if (time != null) {
                                          setModalState(
                                            () => selectedTime = time,
                                          );
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          _buildPopupLabel('Notes / Call Summary'),
                          const SizedBox(height: 8),
                          TextField(
                            maxLines: 4,
                            decoration: InputDecoration(
                              hintText: 'Enter discussion summary..',
                              hintStyle: TextStyle(
                                color: Theme.of(
                                  context,
                                ).textTheme.bodySmall?.color,
                                fontSize: 14,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                  color: Theme.of(context).dividerColor,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                  color: Theme.of(context).dividerColor,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          _buildPopupLabel('Lead Status'),
                          const SizedBox(height: 8),
                          _buildPopupDropdown(
                            value: selectedStatus,
                            items: [
                              'Select Lead Status',
                              'New',
                              'Interested',
                              'Not Interested',
                            ],
                            onChanged: (val) => setModalState(
                              () =>
                                  selectedStatus = val ?? 'Select Lead Status',
                            ),
                          ),
                          const SizedBox(height: 24),
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF6B4195),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: const Text(
                                'Submit',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 32),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
>>>>>>> 5271cc96814591a548bd1c0b01a88df5c62cd342
    );
  }

  Widget _buildPopupLabel(String text, {bool isRequired = false}) {
    return RichText(
      text: TextSpan(
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).textTheme.bodyLarge?.color,
        ),
        children: [
          TextSpan(text: text),
          if (isRequired)
            const TextSpan(
              text: ' *',
              style: TextStyle(color: Colors.red),
            ),
        ],
      ),
    );
  }

  Widget _buildPopupDropdown({
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).dividerColor),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          items: items.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(
                item,
                style: TextStyle(
                  color: item.startsWith('Select')
                      ? Colors.grey
                      : Theme.of(context).textTheme.bodyLarge?.color,
                  fontSize: 14,
                ),
              ),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

<<<<<<< HEAD
=======
  Widget _buildRadioGroup(
    String selectedValue,
    List<String> options,
    ValueChanged<String> onChanged,
  ) {
    return Wrap(
      spacing: 30,
      runSpacing: 12,
      children: options.map((option) {
        bool isSelected = selectedValue == option;
        return GestureDetector(
          onTap: () => onChanged(option),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected
                        ? const Color(0xFF6B4195)
                        : Theme.of(context).dividerColor,
                    width: 2,
                  ),
                ),
                child: isSelected
                    ? Center(
                        child: Container(
                          width: 10,
                          height: 10,
                          decoration: const BoxDecoration(
                            color: Color(0xFF6B4195),
                            shape: BoxShape.circle,
                          ),
                        ),
                      )
                    : null,
              ),
              const SizedBox(width: 8),
              Text(
                option,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).textTheme.bodyMedium?.color,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

>>>>>>> 5271cc96814591a548bd1c0b01a88df5c62cd342
  Widget _buildDatePickerField(String text, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 45,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).dividerColor),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(
              Icons.calendar_month_outlined,
              size: 20,
              color: Theme.of(context).textTheme.bodySmall?.color,
            ),
            const SizedBox(width: 8),
            Text(
              text,
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).textTheme.bodyMedium?.color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimePickerField(String text, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 45,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).dividerColor),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(
              Icons.access_time,
              size: 20,
              color: Theme.of(context).textTheme.bodySmall?.color,
            ),
            const SizedBox(width: 8),
            Text(
              text,
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).textTheme.bodyMedium?.color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
