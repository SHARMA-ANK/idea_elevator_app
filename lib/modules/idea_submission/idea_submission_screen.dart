import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:idea_elevator/modules/home/home_controller.dart';
import 'package:idea_elevator/modules/idea_submission/idea_controller.dart';

class IdeaSubmissionScreen extends StatelessWidget {
  IdeaSubmissionScreen({super.key});

  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _taglineCtrl = TextEditingController();
  final _descCtrl = TextEditingController();

  void _submit() {
    if (_formKey.currentState!.validate()) {
      Get.find<IdeaController>()
          .addIdea(_nameCtrl.text, _taglineCtrl.text, _descCtrl.text);
      Get.snackbar("Success!", "Your brilliant idea has been submitted.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white);
      _nameCtrl.clear();
      _taglineCtrl.clear();
      _descCtrl.clear();
      FocusManager.instance.primaryFocus?.unfocus();
      Get.find<HomeController>().changeTabIndex(0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Submit Your Idea')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildHeader(),
                const SizedBox(height: 24),
                Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      children: [
                        _buildTextFormField(
                            labelText: 'Startup Name',
                            hintText: 'e.g., "Connectify"',
                            icon: Icons.business_center,
                            controller: _nameCtrl),
                        const SizedBox(height: 20),
                        _buildTextFormField(
                            labelText: 'Tagline',
                            hintText: 'A catchy one-liner',
                            icon: Icons.label_important_outline,
                            controller: _taglineCtrl),
                        const SizedBox(height: 20),
                        _buildTextFormField(
                            labelText: 'Detailed Description',
                            hintText: 'What problem does it solve?',
                            icon: Icons.description_outlined,
                            maxLines: 4,
                            controller: _descCtrl),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                _buildSubmitButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextFormField(
      {required TextEditingController controller,
      required String labelText,
      required String hintText,
      required IconData icon,
      int maxLines = 1}) {
    final bool isDark = Get.isDarkMode;
    final Color hintAndLabelColor = isDark ? Colors.white70 : Colors.black54;
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      style: TextStyle(color: isDark ? Colors.white : Colors.black87),
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        labelStyle: TextStyle(color: hintAndLabelColor),
        floatingLabelStyle: TextStyle(color: Get.theme.primaryColor),
        hintStyle: TextStyle(color: hintAndLabelColor),
        errorStyle: TextStyle(
            color: Colors.redAccent.shade100, fontWeight: FontWeight.bold),
        prefixIcon:
            Icon(icon, color: isDark ? Colors.white70 : Colors.grey.shade600),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide(color: Get.theme.primaryColor, width: 2.0)),
        filled: true,
        fillColor: isDark ? Colors.grey[850] : Colors.grey[50],
      ),
      validator: (value) =>
          value!.trim().isEmpty ? '$labelText is required' : null,
    );
  }

  Widget _buildHeader() {
    return Column(children: [
      Icon(Icons.rocket_launch_outlined,
          size: 80, color: Get.theme.colorScheme.secondary),
      const SizedBox(height: 16),
      Text('Launch Your Next Big Idea',
          textAlign: TextAlign.center,
          style: Get.textTheme.headlineSmall
              ?.copyWith(fontWeight: FontWeight.bold))
    ]);
  }

  Widget _buildSubmitButton() {
    return Container(
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: Get.theme.primaryColor.withOpacity(0.4),
                  blurRadius: 10,
                  offset: Offset(0, 5))
            ],
            gradient: LinearGradient(colors: [
              Get.theme.primaryColor,
              Color.lerp(Get.theme.primaryColor, Colors.cyan, 0.5)!
            ], begin: Alignment.topLeft, end: Alignment.bottomRight),
            borderRadius: BorderRadius.circular(30)),
        child: ElevatedButton(
            onPressed: _submit,
            style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.publish, color: Colors.white),
                  SizedBox(width: 12),
                  Text('LAUNCH IDEA',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white))
                ])));
  }
}
