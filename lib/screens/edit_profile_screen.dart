import 'package:flutter/material.dart';
import 'package:pos_lab/controllers/profile_controller.dart';
import 'package:pos_lab/dialogs/error_dialog.dart';
import 'package:pos_lab/dialogs/loading_dialog.dart';
import 'package:pos_lab/dialogs/success_dialog.dart';
import 'package:pos_lab/models/user_profile.dart';
import 'package:pos_lab/style/color.dart';
import 'package:pos_lab/ui_state/ui_status.dart';
import 'package:flutter/services.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _hasChanges = false;
  late final ProfileController controller;
  late UserProfile _originalProfile;
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _addressCtrl = TextEditingController();

  //validators
  String? _validateName(String? v) {
    final s = (v ?? '').trim();
    if (s.isEmpty) return "Name is required";
    if (s.length < 2) return "Name is too short";
    return null;
  }

  //Just Gmail allowed / Update to use email_validator package later
  String? _validateEmail(String? v) {
    final s = (v ?? '').trim().toLowerCase();

    if (s.isEmpty) {
      return "Email is required";
    }

    if (!s.endsWith("@gmail.com")) {
      return "Only Gmail addresses are allowed";
    }

    final gmailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@gmail\.com$');

    if (!gmailRegex.hasMatch(s)) {
      return "Invalid Gmail address";
    }

    return null;
  }

  String? _validatePhone(String? v) {
    final s = (v ?? '').trim();
    if (s.isEmpty) return "Phone is required";

    // digits only check (since we enforce digitsOnly formatter)
    if (s.length < 9) return "Phone number is too short";
    if (s.length > 10) return "Phone number is too long";
    return null;
  }

  String? _validateAddress(String? v) {
    final s = (v ?? '').trim();
    if (s.isEmpty) return "Address is required";
    if (s.length < 6) return "Address is too short";
    return null;
  }

  bool _listenerAttached = false;

  @override
  void initState() {
    super.initState();
    controller = ProfileController();

    final profile = controller.profile;
    _originalProfile = profile;

    _nameCtrl.text = profile.name;
    _emailCtrl.text = profile.email;
    _phoneCtrl.text = profile.phone;
    _addressCtrl.text = profile.address;

    _attachChangeListeners();
  }

  void _attachChangeListeners() {
    void checkChanges() {
      final changed =
          _nameCtrl.text.trim() != _originalProfile.name ||
          _emailCtrl.text.trim() != _originalProfile.email ||
          _phoneCtrl.text.trim() != _originalProfile.phone ||
          _addressCtrl.text.trim() != _originalProfile.address;

      if (_hasChanges != changed) {
        setState(() => _hasChanges = changed);
      }
    }

    _nameCtrl.addListener(checkChanges);
    _emailCtrl.addListener(checkChanges);
    _phoneCtrl.addListener(checkChanges);
    _addressCtrl.addListener(checkChanges);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_listenerAttached) return;
    _listenerAttached = true;

    controller.addListener(() async {
      switch (controller.status) {
        case UIStatus.loading:
          showLoading(context);
          break;

        case UIStatus.success:
          Navigator.pop(context); // close loading
          await showSuccess(context, "Profile updated successfully");
          Navigator.pop(context); // go back
          controller.resetStatus();
          break;

        case UIStatus.error:
          Navigator.pop(context); // close loading
          showError(context, controller.errorMessage ?? "Unknown error");
          controller.resetStatus();
          break;

        case UIStatus.idle:
          break;
      }
    });
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _phoneCtrl.dispose();
    _addressCtrl.dispose();
    super.dispose();
  }

  void _onSave() {
    final ok = _formKey.currentState?.validate() ?? false;
    if (!ok) return;

    final profile = UserProfile(
      id: _originalProfile.id,
      name: _nameCtrl.text.trim(),
      email: _emailCtrl.text.trim(),
      phone: _phoneCtrl.text.trim(),
      address: _addressCtrl.text.trim(),
    );

    controller.saveProfile(profile);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.col8,
      appBar: AppBar(
        backgroundColor: AppColor.col5,

        elevation: 1,
        title: Text(
          "Edit Profile",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),

      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              _buildField("Name", _nameCtrl, validator: _validateName),
              _buildField(
                "Email",
                _emailCtrl,
                keyboard: TextInputType.emailAddress,
                validator: _validateEmail,
              ),
              _buildField(
                "Phone",
                _phoneCtrl,
                keyboard: TextInputType.phone,
                validator: _validatePhone,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(15),
                ],
              ),
              _buildField(
                "Address",
                _addressCtrl,
                maxLines: 2,
                validator: _validateAddress,
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: _hasChanges ? _onSave : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _hasChanges
                        ? AppColor.col4
                        : Colors.grey.shade400,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  child: const Text(
                    "Save Changes",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildField(
    String label,
    TextEditingController controller, {
    int maxLines = 1,
    TextInputType keyboard = TextInputType.text,
    String? Function(String?)? validator,
    List<TextInputFormatter>? inputFormatters,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 6),
          TextFormField(
            controller: controller,
            keyboardType: keyboard,
            maxLines: maxLines,
            validator: validator,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            inputFormatters: inputFormatters,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide.none,
              ),
              errorMaxLines: 2,
            ),
          ),
        ],
      ),
    );
  }
}
