import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:idea_elevator/modules/idea_submission/idea_controller.dart';
import 'package:idea_elevator/modules/home/home_controller.dart';

class IdeaSubmissionScreen extends StatelessWidget {
  final IdeaController ideaController = Get.find();
  final HomeController homeController = Get.find();
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _taglineCtrl = TextEditingController();
  final _descCtrl = TextEditingController();

  void _submit() {
    if (_formKey.currentState!.validate()) {
      ideaController.addIdea(_nameCtrl.text, _taglineCtrl.text, _descCtrl.text);

      Get.snackbar(
        "Success!",
        "Your brilliant idea has been submitted.",
        snackPosition: SnackPosition.BOTTOM,
      );

      _nameCtrl.clear();
      _taglineCtrl.clear();
      _descCtrl.clear();

      // Switch to the idea listing tab
      homeController.changeTabIndex(0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Submit Your Idea')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameCtrl,
                decoration: InputDecoration(labelText: 'Startup Name'),
                validator: (v) => v!.isEmpty ? 'Required' : null,
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _taglineCtrl,
                decoration: InputDecoration(labelText: 'Tagline'),
                validator: (v) => v!.isEmpty ? 'Required' : null,
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _descCtrl,
                decoration: InputDecoration(labelText: 'Description'),
                maxLines: 4,
                validator: (v) => v!.isEmpty ? 'Required' : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(onPressed: _submit, child: Text('Submit Idea')),
            ],
          ),
        ),
      ),
    );
  }
}
