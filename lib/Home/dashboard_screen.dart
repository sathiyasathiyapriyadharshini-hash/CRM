import 'package:crm/Leads/leads_screen.dart';
import 'package:crm/Home/notification_screen.dart';
import 'package:crm/Deals/deals_screen.dart';
import 'package:crm/Follows/follow_up_screen.dart';
<<<<<<< HEAD
import 'package:crm/Deals/deal_won.dart';
import 'package:crm/Deals/deal_lost.dart';
import 'package:crm/Meeting/add_meeting_screen.dart';
import 'package:crm/Meeting/meeting_screen.dart';
import 'package:crm/services/profile_service.dart';
import 'package:flutter/material.dart';
import '../BottomBar/custom_bottom_nav.dart';
import '../Drawer/drawer_screen.dart';
import '../Leads/enquiry_screen.dart';
import '../Leads/add_lead_screen.dart';
import '../utils/preference_service.dart';
=======
import 'package:crm/Meeting/add_meeting_screen.dart';
import 'package:crm/Meeting/meeting_screen.dart';
import 'package:flutter/material.dart';
import '../BottomBar/custom_bottom_nav.dart';
import '../Drawer/drawer_screen.dart';
>>>>>>> 5271cc96814591a548bd1c0b01a88df5c62cd342

class DashboardScreen extends StatefulWidget {
  final int initialIndex;
  final int followUpInitialIndex;

  const DashboardScreen({
    super.key,
    this.initialIndex = 0,
    this.followUpInitialIndex = 0,
  });

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

<<<<<<< HEAD
class _DashboardScreenState extends State<DashboardScreen>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  bool _isFabExpanded = false;
  late AnimationController _animationController;
  late Animation<double> _expandAnimation;

  void _toggleFab() {
    setState(() {
      _isFabExpanded = !_isFabExpanded;
      if (_isFabExpanded) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }
=======
class _DashboardScreenState extends State<DashboardScreen> {
  int _currentIndex = 0;
>>>>>>> 5271cc96814591a548bd1c0b01a88df5c62cd342

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
<<<<<<< HEAD
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _expandAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.fastOutSlowIn,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
=======
>>>>>>> 5271cc96814591a548bd1c0b01a88df5c62cd342
  }

  // Method to get current screen
  Widget _getCurrentScreen() {
    switch (_currentIndex) {
      case 0:
        return _DashboardContent();
      case 1:
        return FollowUpScreen(
          initialIndex: widget.followUpInitialIndex,
          onBack: () => setState(() => _currentIndex = 0),
        );
      case 2:
        return MeetingVisitScreen(
          onBack: () => setState(() => _currentIndex = 0),
        );
      case 3:
        return DealsScreen(onBack: () => setState(() => _currentIndex = 0));
      default:
        return _DashboardContent();
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      drawer: const DrawerScreen(),
      appBar: _currentIndex == 0
          ? AppBar(
<<<<<<< HEAD
              backgroundColor: const Color(0xFF26A69A),
=======
              backgroundColor: const Color(0xFF6B4195),
>>>>>>> 5271cc96814591a548bd1c0b01a88df5c62cd342
              elevation: 0,
              toolbarHeight: 0,
            )
          : null,
      body: _getCurrentScreen(),
      floatingActionButton: _currentIndex == 0
<<<<<<< HEAD
          ? AnimatedBuilder(
              animation: _expandAnimation,
              builder: (context, child) {
                return Stack(
                  alignment: Alignment.bottomRight,
                  clipBehavior: Clip.none,
                  children: [
                    if (_expandAnimation.value > 0) ...[
                      // Meeting - Top Right
                      Positioned(
                        bottom: (screenWidth * 0.25) * _expandAnimation.value,
                        right: 0,
                        child: Opacity(
                          opacity: _expandAnimation.value,
                          child: Transform.scale(
                            scale: _expandAnimation.value,
                            child: _buildFabAction(
                              icon: Icons.groups,
                              label: 'Meeting',
                              color: const Color(0xFF26A69A),
                              onTap: () {
                                _toggleFab();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const AddMeetingScreen(),
                                  ),
                                );
                              },
                              screenWidth: screenWidth,
                            ),
                          ),
                        ),
                      ),
                      // Lead - Top Left
                      Positioned(
                        bottom: (screenWidth * 0.25) * _expandAnimation.value,
                        right: (screenWidth * 0.22) * _expandAnimation.value,
                        child: Opacity(
                          opacity: _expandAnimation.value,
                          child: Transform.scale(
                            scale: _expandAnimation.value,
                            child: _buildFabAction(
                              icon: Icons.person_add_alt_1,
                              label: 'Lead',
                              color: const Color(0xFF26A69A),
                              onTap: () {
                                _toggleFab();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        const AddLeadScreen(isEnquiry: false),
                                  ),
                                );
                              },
                              screenWidth: screenWidth,
                            ),
                          ),
                        ),
                      ),
                      // Enquiry - Bottom Left (Moved further away)
                      Positioned(
                        bottom: 0,
                        right: (screenWidth * 0.25) * _expandAnimation.value,
                        child: Opacity(
                          opacity: _expandAnimation.value,
                          child: Transform.scale(
                            scale: _expandAnimation.value,
                            child: _buildFabAction(
                              icon: Icons.headset_mic,
                              label: 'Enquiry',
                              color: const Color(0xFF26A69A),
                              onTap: () {
                                _toggleFab();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        const AddLeadScreen(isEnquiry: true),
                                  ),
                                );
                              },
                              screenWidth: screenWidth,
                            ),
                          ),
                        ),
                      ),
                    ],
                    // Main Button
                    SizedBox(
                      height: screenWidth * 0.16,
                      width: screenWidth * 0.16,
                      child: FloatingActionButton(
                        onPressed: _toggleFab,
                        backgroundColor: const Color(0xFF26A69A),
                        shape: const CircleBorder(),
                        elevation: 4,
                        child: Transform.rotate(
                          angle:
                              _expandAnimation.value *
                              (3.14159 / 4), // Rotate 45 degrees
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                            size: screenWidth * 0.08,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
=======
          ? SizedBox(
              height: screenWidth * 0.16,
              width: screenWidth * 0.16,
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const AddMeetingScreen()),
                  );
                },
                backgroundColor: const Color(0xFF6B4195),
                shape: const CircleBorder(),
                child: Icon(
                  Icons.group_add,
                  color: Colors.white,
                  size: screenWidth * 0.08,
                ),
              ),
>>>>>>> 5271cc96814591a548bd1c0b01a88df5c62cd342
            )
          : null,
      bottomNavigationBar: CustomBottomNav(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
<<<<<<< HEAD

  Widget _buildFabAction({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
    required double screenWidth,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: screenWidth * 0.13,
        width: screenWidth * 0.13,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: screenWidth * 0.04),
            const SizedBox(height: 1),
            Text(
              label,
              style: TextStyle(
                color: Colors.white,
                fontSize: screenWidth * 0.02,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DashboardContent extends StatefulWidget {
  @override
  State<_DashboardContent> createState() => _DashboardContentState();
}

class _DashboardContentState extends State<_DashboardContent> {
  String _userName = 'Loading...';

  @override
  void initState() {
    super.initState();
    _loadName();
  }

  Future<void> _loadName() async {
    // Load from cache first
    final cachedName = await PreferenceService.getName();
    if (mounted && cachedName != null) {
      setState(() {
        _userName = cachedName;
      });
    }

    // Then fetch from API
    final profileData = await ProfileService.fetchProfileData();
    if (mounted && profileData != null) {
      setState(() {
        _userName = profileData['name'] ?? _userName;
      });
    }
  }

=======
}

class _DashboardContent extends StatelessWidget {
>>>>>>> 5271cc96814591a548bd1c0b01a88df5c62cd342
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double screenWidth = size.width;
    final double screenHeight = size.height;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Purple Header Area
          Container(
            padding: EdgeInsets.only(bottom: screenHeight * 0.03),
            decoration: const BoxDecoration(
<<<<<<< HEAD
              color: Color(0xFF26A69A),
=======
              color: Color(0xFF6B4195),
>>>>>>> 5271cc96814591a548bd1c0b01a88df5c62cd342
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
            ),
            child: Column(
              children: [
                // Top Custom App Bar
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.04,
                    vertical: screenHeight * 0.01,
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.menu, color: Colors.white),
                        onPressed: () => Scaffold.of(context).openDrawer(),
                      ),
                      Text(
<<<<<<< HEAD
                        _userName,
=======
                        'Tamilarasi',
>>>>>>> 5271cc96814591a548bd1c0b01a88df5c62cd342
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: screenWidth * 0.05,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(
                          Icons.notifications_none,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const NotificationScreen(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
<<<<<<< HEAD
=======
                // Search Bar
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.06,
                    vertical: screenHeight * 0.01,
                  ),
                  child: Container(
                    height: screenHeight * 0.06,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withAlpha(12),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: TextField(
                      style: TextStyle(fontSize: screenWidth * 0.038),
                      decoration: InputDecoration(
                        hintText: 'Search',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: screenWidth * 0.038,
                        ),
                        prefixIcon: Icon(
                          Icons.search,
                          color: const Color(0xFF6B4195),
                          size: screenWidth * 0.06,
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          vertical: screenHeight * 0.015,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
>>>>>>> 5271cc96814591a548bd1c0b01a88df5c62cd342
                // Hero Banner
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.all(20),
<<<<<<< HEAD
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              flex: 5,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'MANAGE YOUR LEADS\nEFFICIENTLY!',
                                    style: TextStyle(
                                      color: const Color(0xFF897418),
                                      fontWeight: FontWeight.bold,
                                      fontSize: screenWidth * 0.04,
                                      height: 1.2,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Capture, Track & Nurture\nProspects Seamlessly',
                                    style: TextStyle(
                                      color: const Color(
                                        0xFF26A69A,
                                      ).withAlpha(153),
                                      fontSize: screenWidth * 0.03,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: Transform.translate(
                                offset: const Offset(0, 5),
                                child: Image.asset(
                                  'assets/images/group.png',
                                  fit: BoxFit.contain,
                                  errorBuilder: (context, error, stackTrace) =>
                                      Icon(
                                        Icons.group,
                                        size: screenWidth * 0.15,
                                        color: const Color(
                                          0xFF26A69A,
                                        ).withAlpha(76),
                                      ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
=======
                    child: Row(
                      children: [
                        Expanded(
                          flex: 5,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'MANAGE YOUR LEADS\nEFFICIENTLY!',
                                style: TextStyle(
                                  color: const Color(0xFF897418),
                                  fontWeight: FontWeight.bold,
                                  fontSize: screenWidth * 0.04,
                                  height: 1.2,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Capture, Track & Nurture\nProspects Seamlessly',
                                style: TextStyle(
                                  color: const Color(0xFF6B4195).withAlpha(153),
                                  fontSize: screenWidth * 0.03,
                                ),
                              ),
                              const SizedBox(height: 16),
                              ElevatedButton(
>>>>>>> 5271cc96814591a548bd1c0b01a88df5c62cd342
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => const LeadsScreen(),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF2E8B57),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  padding: EdgeInsets.symmetric(
<<<<<<< HEAD
                                    horizontal: screenWidth * 0.02,
=======
                                    horizontal: screenWidth * 0.05,
>>>>>>> 5271cc96814591a548bd1c0b01a88df5c62cd342
                                    vertical: screenHeight * 0.01,
                                  ),
                                ),
                                child: Row(
<<<<<<< HEAD
                                  mainAxisAlignment: MainAxisAlignment.center,
=======
                                  mainAxisSize: MainAxisSize.min,
>>>>>>> 5271cc96814591a548bd1c0b01a88df5c62cd342
                                  children: [
                                    Text(
                                      'Get Lead',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: screenWidth * 0.03,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(width: screenWidth * 0.01),
                                    Icon(
                                      Icons.arrow_forward_outlined,
                                      color: Colors.white,
                                      size: screenWidth * 0.04,
                                    ),
                                  ],
                                ),
                              ),
<<<<<<< HEAD
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => const EnquiryScreen(),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF26A69A),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: screenWidth * 0.02,
                                    vertical: screenHeight * 0.01,
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Get Enquiry',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: screenWidth * 0.03,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(width: screenWidth * 0.01),
                                    Icon(
                                      Icons.arrow_forward_outlined,
                                      color: Colors.white,
                                      size: screenWidth * 0.04,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
=======
                            ],
                          ),
                        ),
                        // Illustration
                        Expanded(
                          flex: 4,
                          child: Image.asset(
                            'assets/images/group.png',
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) => Icon(
                              Icons.group,
                              size: screenWidth * 0.15,
                              color: const Color(0xFF6B4195).withAlpha(76),
                            ),
                          ),
>>>>>>> 5271cc96814591a548bd1c0b01a88df5c62cd342
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: screenHeight * 0.03),

          // Dashboard Title
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Dashboard',
                      style: TextStyle(
                        fontSize: screenWidth * 0.055,
                        fontWeight: FontWeight.bold,
<<<<<<< HEAD
                        color: const Color(0xFF26A69A),
=======
                        color: const Color(0xFF6B4195),
>>>>>>> 5271cc96814591a548bd1c0b01a88df5c62cd342
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () => _selectDate(context),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 9,
                        ),
                        decoration: BoxDecoration(
<<<<<<< HEAD
                          color: const Color(0xFF26A69A),
=======
                          color: const Color(0xFF6B4195),
>>>>>>> 5271cc96814591a548bd1c0b01a88df5c62cd342
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Row(
                          children: [
                            Icon(
                              Icons.calendar_month,
                              size: 16,
                              color: Colors.white,
                            ),
                            SizedBox(width: 4),
                            Text(
                              'Sort By Date',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  'Customer Management Hub',
                  style: TextStyle(
                    fontSize: screenWidth * 0.035,
                    color:
                        Theme.of(context).textTheme.bodyLarge?.color ??
                        Colors.black87,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: screenHeight * 0.03),

          // Today Follow-up Section
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
            child: Text(
<<<<<<< HEAD
              'Follow-up',
=======
              'Today Follow-up',
>>>>>>> 5271cc96814591a548bd1c0b01a88df5c62cd342
              style: TextStyle(
                fontSize: screenWidth * 0.045,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).textTheme.titleLarge?.color,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
            child: Row(
              children: [
                _buildFollowUpCard(
                  title: 'Today',
                  count: '30',
                  subtitle: 'Follow up',
                  countColor: const Color(0xFF2E8B57),
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0x99FFFFFF), Color(0xFFFFCDCD)],
                  ),
                  iconBgColor: const Color(0xFFF2B3B3),
                  iconPath: 'assets/icons/today.png',
                  screenWidth: screenWidth,
<<<<<<< HEAD
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const FollowUpScreen(initialIndex: 0),
                      ),
                    );
                  },
=======
>>>>>>> 5271cc96814591a548bd1c0b01a88df5c62cd342
                ),
                const SizedBox(width: 12),
                _buildFollowUpCard(
                  title: 'Missed',
                  count: '30',
                  subtitle: 'Follow up',
                  countColor: Colors.red,
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.white,
                      Color(0xD8FFF7D4),
                      Color(0xA5FFEC9B),
                    ],
                  ),
                  iconBgColor: const Color(0xFFFFEEC3),
                  iconPath: 'assets/icons/miss.png',
                  screenWidth: screenWidth,
<<<<<<< HEAD
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const FollowUpScreen(initialIndex: 3),
                      ),
                    );
                  },
                ),
                const SizedBox(width: 12),
                _buildFollowUpCard(
                  title: 'UpComing',
=======
                ),
                const SizedBox(width: 12),
                _buildFollowUpCard(
                  title: 'New',
>>>>>>> 5271cc96814591a548bd1c0b01a88df5c62cd342
                  count: '30',
                  subtitle: 'Follow up',
                  countColor: Colors.blue,
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.white,
                      Color(0xFFC7E2F6),
                      Color(0xFF86C0EC),
                    ],
                  ),
                  iconBgColor: const Color(0xFF86C0EC),
                  iconPath: 'assets/icons/new.png',
                  screenWidth: screenWidth,
<<<<<<< HEAD
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const FollowUpScreen(initialIndex: 2),
                      ),
                    );
                  },
=======
>>>>>>> 5271cc96814591a548bd1c0b01a88df5c62cd342
                ),
              ],
            ),
          ),

          SizedBox(height: screenHeight * 0.03),

          // Deals count Section
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
            child: Text(
<<<<<<< HEAD
              'Deals',
=======
              'Deals count',
>>>>>>> 5271cc96814591a548bd1c0b01a88df5c62cd342
              style: TextStyle(
                fontSize: screenWidth * 0.045,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).textTheme.titleLarge?.color,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
            child: ConstrainedBox(
              constraints: BoxConstraints(maxHeight: screenHeight * 0.28),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Large WON Card
                  Expanded(
                    flex: 4,
<<<<<<< HEAD
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const DealWonScreen(),
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Color(0x99FFFFFF), Color(0x6672C8C3)],
                          ),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/icons/won1.png',
                              width: screenWidth * 0.15,
                              height: screenWidth * 0.15,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(
                                    Icons.surfing,
                                    size: 50,
                                    color: Color(0xFF2E8B57),
                                  ),
                            ),
                            const SizedBox(height: 4),
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xFF79D6CC),
                              ),
                              child: Text(
                                '10',
                                style: TextStyle(
                                  fontSize: screenWidth * 0.05,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Active',
                              style: TextStyle(
                                fontSize: screenWidth * 0.045,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                            ),
                            Text(
                              'Deal',
                              style: TextStyle(
                                fontSize: screenWidth * 0.035,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
=======
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Color(0x99FFFFFF), Color(0x6672C8C3)],
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/icons/won1.png',
                            width: screenWidth * 0.15,
                            height: screenWidth * 0.15,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(
                                  Icons.surfing,
                                  size: 50,
                                  color: Color(0xFF2E8B57),
                                ),
                          ),
                          const SizedBox(height: 4),
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFF79D6CC),
                            ),
                            child: Text(
                              '10',
                              style: TextStyle(
                                fontSize: screenWidth * 0.05,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Won',
                            style: TextStyle(
                              fontSize: screenWidth * 0.045,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                          Text(
                            'Deal',
                            style: TextStyle(
                              fontSize: screenWidth * 0.035,
                              color: Colors.black54,
                            ),
                          ),
                        ],
>>>>>>> 5271cc96814591a548bd1c0b01a88df5c62cd342
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
<<<<<<< HEAD
                  // Right Column Stackn
=======
                  // Right Column Stack
>>>>>>> 5271cc96814591a548bd1c0b01a88df5c62cd342
                  Expanded(
                    flex: 5,
                    child: Column(
                      children: [
                        // Pending Card
                        Expanded(
<<<<<<< HEAD
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const DealsScreen(),
                                ),
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    const Color(
                                      0xFFFFFFFF,
                                    ).withOpacity(0.6), // White 60%
                                    const Color(0xA5FFEC9B), // Yellow 40%
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(16),
                              ),

                              child: Row(
                                children: [
                                  Image.asset(
                                    'assets/icons/pending.png',
                                    width: screenWidth * 0.1,
                                    height: screenWidth * 0.1,
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            const Icon(
                                              Icons.edit_note,
                                              size: 40,
                                              color: Colors.orange,
                                            ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Won',
                                          style: TextStyle(
                                            fontSize: screenWidth * 0.04,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black87,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Container(
                                          padding: const EdgeInsets.all(8),
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Color(0xFFFEEFB0),
                                          ),
                                          child: Text(
                                            '10',
                                            style: TextStyle(
                                              fontSize: screenWidth * 0.04,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black87,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
=======
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  const Color(
                                    0xFFFFFFFF,
                                  ).withOpacity(0.6), // White 60%
                                  const Color(0xA5FFEC9B), // Yellow 40%
                                ],
                              ),
                              borderRadius: BorderRadius.circular(16),
                            ),

                            child: Row(
                              children: [
                                Image.asset(
                                  'assets/icons/pending.png',
                                  width: screenWidth * 0.1,
                                  height: screenWidth * 0.1,
                                  errorBuilder: (context, error, stackTrace) =>
                                      const Icon(
                                        Icons.edit_note,
                                        size: 40,
                                        color: Colors.orange,
                                      ),
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Pending',
                                        style: TextStyle(
                                          fontSize: screenWidth * 0.04,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black87,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color(0xFFFEEFB0),
                                        ),
                                        child: Text(
                                          '10',
                                          style: TextStyle(
                                            fontSize: screenWidth * 0.04,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black87,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
>>>>>>> 5271cc96814591a548bd1c0b01a88df5c62cd342
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        // Lost Card
                        Expanded(
<<<<<<< HEAD
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const DealLostScreen(),
                                ),
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Color(0x99FFFFFF),
                                    Color(0x66F66955),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Row(
                                children: [
                                  Image.asset(
                                    'assets/icons/lost.png',
                                    width: screenWidth * 0.1,
                                    height: screenWidth * 0.1,
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            const Icon(
                                              Icons.handshake_outlined,
                                              size: 40,
                                              color: Colors.redAccent,
                                            ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Lost',
                                          style: TextStyle(
                                            fontSize: screenWidth * 0.04,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black87,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Container(
                                          padding: const EdgeInsets.all(8),
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Color(0xFFF3BF84),
                                          ),
                                          child: Text(
                                            '10',
                                            style: TextStyle(
                                              fontSize: screenWidth * 0.04,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black87,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
=======
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [Color(0x99FFFFFF), Color(0x66F66955)],
                              ),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Row(
                              children: [
                                Image.asset(
                                  'assets/icons/lost.png',
                                  width: screenWidth * 0.1,
                                  height: screenWidth * 0.1,
                                  errorBuilder: (context, error, stackTrace) =>
                                      const Icon(
                                        Icons.handshake_outlined,
                                        size: 40,
                                        color: Colors.redAccent,
                                      ),
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Lost',
                                        style: TextStyle(
                                          fontSize: screenWidth * 0.04,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black87,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color(0xFFF3BF84),
                                        ),
                                        child: Text(
                                          '10',
                                          style: TextStyle(
                                            fontSize: screenWidth * 0.04,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black87,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
>>>>>>> 5271cc96814591a548bd1c0b01a88df5c62cd342
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: screenHeight * 0.03),

          // Lead Pipeline Status Section
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.withOpacity(0.2)),
                borderRadius: BorderRadius.circular(16),
                color: Theme.of(context).cardTheme.color ?? Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(7),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'January Month Lead Pipeline Status',
                    style: TextStyle(
                      fontSize: screenWidth * 0.04,
                      fontWeight: FontWeight.bold,
                      color:
                          Theme.of(context).textTheme.titleMedium?.color ??
                          const Color(0xFF0B0B0B),
                    ),
                  ),
                  const SizedBox(height: 24),
                  _buildProgressItem(
                    label: 'New Leads',
                    percentage: 40,
                    color: const Color(0xFF4285F4),
                    screenWidth: screenWidth,
                  ),
                  const SizedBox(height: 16),
                  _buildProgressItem(
                    label: 'In Progress',
                    percentage: 25,
                    color: const Color(0xFFFFCA28),
                    screenWidth: screenWidth,
                  ),
                  const SizedBox(height: 16),
                  _buildProgressItem(
                    label: 'Won Deals',
                    percentage: 20,
                    color: const Color(0xFF66BB6A),
                    screenWidth: screenWidth,
                  ),
                  const SizedBox(height: 16),
                  _buildProgressItem(
                    label: 'Lost Deals',
                    percentage: 15,
                    color: const Color(0xFFEF5350),
                    screenWidth: screenWidth,
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 80),
        ],
      ),
    );
  }

  Widget _buildFollowUpCard({
    required String title,
    required String count,
    required String subtitle,
    required Color countColor,
    required Gradient gradient,
    required Color iconBgColor,
    required String iconPath,
    required double screenWidth,
<<<<<<< HEAD
    VoidCallback? onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: screenWidth * 0.28,
          decoration: BoxDecoration(
            gradient: gradient,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(12),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          padding: EdgeInsets.all(screenWidth * 0.03),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: const Color(0xFF26A69A),
                        fontWeight: FontWeight.bold,
                        fontSize: screenWidth * 0.032,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: iconBgColor,
                      shape: BoxShape.circle,
                    ),
                    child: Image.asset(
                      iconPath,
                      width: screenWidth * 0.04,
                      height: screenWidth * 0.04,
                      errorBuilder: (context, error, stackTrace) => Icon(
                        Icons.notifications_none,
                        size: screenWidth * 0.04,
                        color: const Color(0xFF26A69A),
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    count,
                    style: TextStyle(
                      color: countColor,
                      fontWeight: FontWeight.bold,
                      fontSize: screenWidth * 0.05,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: screenWidth * 0.025,
                    ),
                  ),
                ],
              ),
            ],
          ),
=======
  }) {
    return Expanded(
      child: Container(
        height: screenWidth * 0.28,
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(12),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        padding: EdgeInsets.all(screenWidth * 0.03),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: screenWidth * 0.035,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(screenWidth * 0.015),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: iconBgColor,
                  ),
                  child: Image.asset(
                    iconPath,
                    width: screenWidth * 0.045,
                    height: screenWidth * 0.045,
                    errorBuilder: (context, error, stackTrace) => SizedBox(
                      width: screenWidth * 0.045,
                      height: screenWidth * 0.045,
                    ),
                  ),
                ),
              ],
            ),
            Text(
              count,
              style: TextStyle(
                fontSize: screenWidth * 0.06,
                fontWeight: FontWeight.bold,
                color: countColor,
              ),
            ),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: screenWidth * 0.03,
                color: Colors.black.withAlpha(153),
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
>>>>>>> 5271cc96814591a548bd1c0b01a88df5c62cd342
        ),
      ),
    );
  }

  Widget _buildProgressItem({
    required String label,
    required int percentage,
    required Color color,
    required double screenWidth,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: screenWidth * 0.035,
                color: Colors.black87,
              ),
            ),
            const Spacer(),
            Text(
              '$percentage%',
              style: TextStyle(
                fontSize: screenWidth * 0.035,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: LinearProgressIndicator(
            value: percentage / 100,
            backgroundColor: Colors.grey[200],
            valueColor: AlwaysStoppedAnimation<Color>(color),
            minHeight: 8,
          ),
        ),
      ],
    );
  }

  Future<void> _selectDate(BuildContext context) async {
<<<<<<< HEAD
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(24),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildSortOption('Yesterday'),
              const Divider(),
              _buildSortOption('This Week'),
              const Divider(),
              _buildSortOption('This Month'),
              const Divider(),
              _buildSortOption('Last Month'),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSortOption(String label) {
    return InkWell(
      onTap: () => Navigator.pop(context),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Row(
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
=======
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(primary: Color(0xFF6B4195)),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      // Logic to filter by date could go here
    }
>>>>>>> 5271cc96814591a548bd1c0b01a88df5c62cd342
  }
}
