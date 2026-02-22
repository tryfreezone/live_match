import 'package:flutter/material.dart';
import 'package:live_match/logic/locator.dart';
import 'home_page.dart';

class ProfileSetupPage extends StatefulWidget {
  const ProfileSetupPage({super.key});

  @override
  State<ProfileSetupPage> createState() => _ProfileSetupPageState();
}

class _ProfileSetupPageState extends State<ProfileSetupPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _locationController = TextEditingController();
  final _favoriteSportController = TextEditingController();
  final _contactNumberController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final user = Locator.userManagementService.userData.value;
    if (user != null) {
      _nameController.text = user.name ?? user.displayName ?? '';
      _ageController.text = user.age ?? '';
      _locationController.text = user.location ?? '';
      _favoriteSportController.text = user.favoriteSport ?? '';
      _contactNumberController.text = user.phoneNumber ?? '';
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _locationController.dispose();
    _favoriteSportController.dispose();
    _contactNumberController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    await Locator.userManagementService.updateBasicProfile(
      name: _nameController.text.trim(),
      age: _ageController.text.trim(),
      location: _locationController.text.trim(),
      favoriteSport: _favoriteSportController.text.trim(),
      contactNumber: _contactNumberController.text.trim(),
    );

    if (!mounted) return;

    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const HomePage()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF050B1A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF050B1A),
        elevation: 0,
        title: const Text('Complete your profile'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildTextField(
                  controller: _nameController,
                  hint: 'Full Name',
                  validator: (v) =>
                      v == null || v.isEmpty ? 'Please enter your name' : null,
                ),
                const SizedBox(height: 12),
                _buildTextField(
                  controller: _ageController,
                  hint: 'Age',
                  keyboardType: TextInputType.number,
                  validator: (v) =>
                      v == null || v.isEmpty ? 'Please enter your age' : null,
                ),
                const SizedBox(height: 12),
                _buildTextField(
                  controller: _locationController,
                  hint: 'Location',
                  validator: (v) => v == null || v.isEmpty
                      ? 'Please enter your location'
                      : null,
                ),
                const SizedBox(height: 12),
                _buildTextField(
                  controller: _favoriteSportController,
                  hint: 'Favourite sport',
                  validator: (v) => v == null || v.isEmpty
                      ? 'Please enter your favourite sport'
                      : null,
                ),
                const SizedBox(height: 12),
                _buildTextField(
                  controller: _contactNumberController,
                  hint: 'Contact number',
                  keyboardType: TextInputType.phone,
                  validator: (v) => v == null || v.isEmpty
                      ? 'Please enter your contact number'
                      : null,
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: _submit,
                    child: const Text('Save & Continue'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      style: const TextStyle(color: Colors.white),
      validator: validator,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white54),
        filled: true,
        fillColor: const Color(0xFF182345),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
