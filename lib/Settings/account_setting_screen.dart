import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
<<<<<<< HEAD
import 'package:crm/services/profile_service.dart';
import 'package:crm/SignIn/splash.dart';
import 'package:crm/utils/preference_service.dart';

class AccountSettingScreen extends StatefulWidget {
  final bool isEditing;
  const AccountSettingScreen({super.key, this.isEditing = false});
=======

class AccountSettingScreen extends StatefulWidget {
  const AccountSettingScreen({super.key});
>>>>>>> 5271cc96814591a548bd1c0b01a88df5c62cd342

  @override
  State<AccountSettingScreen> createState() => _AccountSettingScreenState();
}

class _AccountSettingScreenState extends State<AccountSettingScreen> {
  bool _isEditing = false;
<<<<<<< HEAD
  bool _isLoading = true;
  File? _image;
  final _picker = ImagePicker();

  final _nameController = TextEditingController();
  final _userNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _locationController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _isEditing = widget.isEditing;
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    // Load from cache first for instant response
    final String? cachedName = await PreferenceService.getName();
    final String? cachedEmail = await PreferenceService.getEmail();
    final String? cachedPhone = await PreferenceService.getMobile();
    final String? cachedUname = await PreferenceService.getUname();

    if (mounted) {
      setState(() {
        _nameController.text = cachedName ?? 'N/A';
        _emailController.text = cachedEmail ?? 'N/A';
        _phoneController.text = cachedPhone ?? 'N/A';
        _userNameController.text = cachedUname ?? 'N/A';
      });
    }

    // Fetch from API for latest data
    final profileData = await ProfileService.fetchProfileData();

    if (mounted) {
      setState(() {
        if (profileData != null) {
          _nameController.text =
              profileData['name']?.toString() ?? _nameController.text;
          _emailController.text =
              profileData['email']?.toString() ?? _emailController.text;
          _phoneController.text =
              profileData['mobile']?.toString() ?? _phoneController.text;
        }

        String lt = SplashScreen.lt ?? '';
        String ln = SplashScreen.ln ?? '';
        if (lt.isNotEmpty && ln.isNotEmpty) {
          _locationController.text = "$lt, $ln";
        }
        _isLoading = false;
      });
    }
  }
=======
  File? _image;
  final _picker = ImagePicker();

  final _nameController = TextEditingController(text: 'Harish');
  final _emailController = TextEditingController(text: 'hariharansgs@app.in');
  final _phoneController = TextEditingController(text: '+91 98765 43210');
  final _addressController = TextEditingController(text: 'Coimbatore');
>>>>>>> 5271cc96814591a548bd1c0b01a88df5c62cd342

  @override
  void dispose() {
    _nameController.dispose();
<<<<<<< HEAD
    _userNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _locationController.dispose();
=======
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
>>>>>>> 5271cc96814591a548bd1c0b01a88df5c62cd342
    super.dispose();
  }

  Future<void> _pickImage() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
        });
      }
    } catch (e) {
      debugPrint('Error picking image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
<<<<<<< HEAD
        backgroundColor: const Color(0xFF26A69A),
=======
        backgroundColor: const Color(0xFF6B4195),
>>>>>>> 5271cc96814591a548bd1c0b01a88df5c62cd342
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Account Settings',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
<<<<<<< HEAD
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(color: Color(0xFF26A69A)),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Profile Information',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color:
                          Theme.of(context).textTheme.titleLarge?.color ??
                          Colors.black,
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Detail Card
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 24,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardTheme.color ?? Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.withOpacity(0.3)),
                    ),
                    child: Column(
                      children: [
                        // Profile Image
                        Center(
                          child: GestureDetector(
                            onTap: _pickImage,
                            child: Container(
                              width: 110,
                              height: 110,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: const Color(0xFF871A1A),
                                  width: 2,
                                ),
                                image: _image != null
                                    ? DecorationImage(
                                        image: FileImage(_image!),
                                        fit: BoxFit.cover,
                                      )
                                    : const DecorationImage(
                                        image: AssetImage(
                                          'assets/images/user_avatar.png',
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        // Change Photo Button
                        TextButton(
                          onPressed: _pickImage,
                          child: const Text(
                            'Change Photo',
                            style: TextStyle(
                              color: Color(0xFF26A69A),
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        // Basic Details Header
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Basic Details',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color:
                                    Theme.of(
                                      context,
                                    ).textTheme.titleMedium?.color ??
                                    Colors.black,
                              ),
                            ),
                            TextButton.icon(
                              onPressed: () async {
                                if (_isEditing) {
                                  // Call Update API
                                  setState(() {
                                    _isLoading = true;
                                  });

                                  final response =
                                      await ProfileService.updateProfileData(
                                        name: _nameController.text,
                                        mobile: _phoneController.text,
                                        email: _emailController.text,
                                      );

                                  if (mounted) {
                                    setState(() {
                                      _isLoading = false;
                                      if (response != null &&
                                          response['status'] == 'success') {
                                        _isEditing = false;
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              response['error_msg'] ??
                                                  'Profile updated successfully',
                                            ),
                                            backgroundColor: Colors.green,
                                          ),
                                        );
                                      } else {
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              response?['error_msg'] ??
                                                  'Failed to update profile',
                                            ),
                                            backgroundColor: Colors.red,
                                          ),
                                        );
                                      }
                                    });
                                  }
                                } else {
                                  setState(() {
                                    _isEditing = true;
                                  });
                                }
                              },
                              icon: Icon(
                                _isEditing
                                    ? Icons.save_outlined
                                    : Icons.edit_outlined,
                                color: Colors.green,
                                size: 20,
                              ),
                              label: Text(
                                _isEditing ? 'Save' : 'Edit',
                                style: const TextStyle(
                                  color: Colors.green,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        // Info Rows
                        _buildDetailItem('Name', _nameController),
                        const SizedBox(height: 16),
                        _buildDetailItem('Mail Id', _emailController),
                        const SizedBox(height: 16),
                        _buildDetailItem('Mobile Number', _phoneController),
                        const SizedBox(height: 16),
                        _buildDetailItem('Location', _locationController),
                      ],
                    ),
                  ),
                ],
              ),
            ),
=======
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Profile Information',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color:
                    Theme.of(context).textTheme.titleLarge?.color ??
                    Colors.black,
              ),
            ),
            const SizedBox(height: 20),
            // Detail Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              decoration: BoxDecoration(
                color: Theme.of(context).cardTheme.color ?? Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.withOpacity(0.3)),
              ),
              child: Column(
                children: [
                  // Profile Image
                  Center(
                    child: GestureDetector(
                      onTap: _pickImage,
                      child: Container(
                        width: 110,
                        height: 110,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: const Color(0xFF871A1A),
                            width: 2,
                          ),
                          image: _image != null
                              ? DecorationImage(
                                  image: FileImage(_image!),
                                  fit: BoxFit.cover,
                                )
                              : const DecorationImage(
                                  image: AssetImage(
                                    'assets/images/user_avatar.png',
                                  ),
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Change Photo Button
                  TextButton(
                    onPressed: _pickImage,
                    child: const Text(
                      'Change Photo',
                      style: TextStyle(
                        color: Color(0xFF6B4195),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Basic Details Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Basic Details',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color:
                              Theme.of(context).textTheme.titleMedium?.color ??
                              Colors.black,
                        ),
                      ),
                      TextButton.icon(
                        onPressed: () {
                          setState(() {
                            _isEditing = !_isEditing;
                          });
                          if (!_isEditing) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Changes saved'),
                                duration: Duration(seconds: 1),
                              ),
                            );
                          }
                        },
                        icon: Icon(
                          _isEditing
                              ? Icons.save_outlined
                              : Icons.edit_outlined,
                          color: Colors.green,
                          size: 20,
                        ),
                        label: Text(
                          _isEditing ? 'Save' : 'Edit',
                          style: const TextStyle(
                            color: Colors.green,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        style: TextButton.styleFrom(padding: EdgeInsets.zero),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Info Rows
                  _buildDetailItem('Name', _nameController),
                  const SizedBox(height: 16),
                  _buildDetailItem('Mail Id', _emailController),
                  const SizedBox(height: 16),
                  _buildDetailItem('Mobile Number', _phoneController),
                  const SizedBox(height: 16),
                  _buildDetailItem('Address', _addressController),
                ],
              ),
            ),
          ],
        ),
      ),
>>>>>>> 5271cc96814591a548bd1c0b01a88df5c62cd342
    );
  }

  Widget _buildDetailItem(String label, TextEditingController controller) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 120,
          child: Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Text(
              label,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color:
                    Theme.of(context).textTheme.bodyLarge?.color ??
                    Colors.black87,
              ),
            ),
          ),
        ),
        Expanded(
          child: _isEditing
              ? TextField(
                  controller: controller,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color:
                        Theme.of(context).textTheme.bodyLarge?.color ??
                        Colors.black,
                  ),
                  decoration: const InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(vertical: 8),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Text(
                    controller.text,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color:
                          Theme.of(context).textTheme.bodySmall?.color ??
                          Colors.black54,
                    ),
                  ),
                ),
        ),
      ],
    );
  }
}
