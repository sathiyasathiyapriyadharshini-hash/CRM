import 'package:flutter/material.dart';

class EnquiryScreen extends StatelessWidget {
  const EnquiryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: const Color(0xFF6B4195),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Enquiry',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.calendar_month_outlined,
              color: Colors.white,
            ),
            onPressed: () async {
              await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2101),
              );
            },
          ),
        ],
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Filters Section
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildFilterChip('All', isSelected: true),
                    _buildFilterChip('New'),
                    _buildFilterChip('Follow up'),
                    _buildFilterChip('Intrested'),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Today Enquiry Section
              Text(
                'Today Enquiry',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).textTheme.titleLarge?.color,
                ),
              ),
              const SizedBox(height: 12),
              _buildEnquiryCard(
                name: 'Arun Kumar',
                leadNo: 'L001',
                phone: '12345 68452',
                email: 'crmapp@gmail.com',
                status: 'In Progress',
                statusColor: const Color(0xFFF7941D),
              ),
              _buildEnquiryCard(
                name: 'Arun Kumar',
                leadNo: 'L001',
                phone: '12345 68452',
                email: 'crmapp@gmail.com',
                status: 'Completed',
                statusColor: const Color(0xFF1B8D43),
              ),
              _buildEnquiryCard(
                name: 'Arun Kumar',
                leadNo: 'L001',
                phone: '12345 68452',
                email: 'crmapp@gmail.com',
                status: 'Completed',
                statusColor: const Color(0xFF4267B2),
              ),

              const SizedBox(height: 20),
              // Yesterday Enquiry Section
              Text(
                'Yesterday Enquiry',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).textTheme.titleLarge?.color,
                ),
              ),
              const SizedBox(height: 12),
              _buildEnquiryCard(
                name: 'Arun Kumar',
                leadNo: 'L001',
                phone: '12345 68452',
                email: 'crmapp@gmail.com',
                status: 'In Progress',
                statusColor: const Color(0xFFF7941D),
              ),
              _buildEnquiryCard(
                name: 'Arun Kumar',
                leadNo: 'L001',
                phone: '12345 68452',
                email: 'crmapp@gmail.com',
                status: 'Completed',
                statusColor: const Color(0xFF1B8D43),
              ),
              _buildEnquiryCard(
                name: 'Arun Kumar',
                leadNo: 'L001',
                phone: '12345 68452',
                email: 'crmapp@gmail.com',
                status: 'Completed',
                statusColor: const Color(0xFF4267B2),
              ),

              const SizedBox(height: 20),
              // Lastweek Enquiry Section
              Text(
                'Lastweek Enquiry',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).textTheme.titleLarge?.color,
                ),
              ),
              const SizedBox(height: 12),
              _buildEnquiryCard(
                name: 'Arun Kumar',
                leadNo: 'L001',
                phone: '12345 68452',
                email: 'crmapp@gmail.com',
                status: 'In Progress',
                statusColor: const Color(0xFFFF8103),
              ),
              _buildEnquiryCard(
                name: 'Arun Kumar',
                leadNo: 'L001',
                phone: '12345 68452',
                email: 'crmapp@gmail.com',
                status: 'Completed',
                statusColor: const Color(0xFF109B1E),
              ),
              _buildEnquiryCard(
                name: 'Arun Kumar',
                leadNo: 'L001',
                phone: '12345 68452',
                email: 'crmapp@gmail.com',
                status: 'Completed',
                statusColor: const Color(0xFF3F6AFF),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label, {bool isSelected = false}) {
    return Builder(
      builder: (context) => Container(
        margin: const EdgeInsets.only(right: 8),
        child: FilterChip(
          label: Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : const Color(0xFF6B4195),
              fontWeight: FontWeight.w500,
            ),
          ),
          selected: isSelected,
          onSelected: (bool selected) {},
          backgroundColor: Theme.of(context).cardColor,
          selectedColor: const Color(0xFF6B4195),
          checkmarkColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: const BorderSide(color: Color(0xFF6B4195)),
          ),
          showCheckmark: false,
        ),
      ),
    );
  }

  Widget _buildEnquiryCard({
    required String name,
    required String leadNo,
    required String phone,
    required String email,
    required String status,
    required Color statusColor,
  }) {
    return Builder(
      builder: (context) => Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Theme.of(context).dividerColor),
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildInfoRow(context, Icons.person_outline, 'Name : $name'),
                const SizedBox(height: 4),
                _buildInfoRow(context, Icons.track_changes, 'Lead No: $leadNo'),
                const SizedBox(height: 4),
                _buildInfoRow(
                  context,
                  Icons.phone_outlined,
                  'Phone No: $phone',
                ),
                const SizedBox(height: 4),
                _buildInfoRow(context, Icons.mail_outline, 'Email Id : $email'),
                const SizedBox(height: 4),
                _buildInfoRow(context, Icons.crop_free, 'Reference'),
              ],
            ),
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: statusColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  status,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(BuildContext context, IconData icon, String text) {
    return Row(
      children: [
        Icon(
          icon,
          size: 18,
          color: Theme.of(
            context,
          ).textTheme.bodyMedium?.color?.withOpacity(0.7),
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: TextStyle(
            fontSize: 14,
            color: Theme.of(context).textTheme.bodyLarge?.color,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
