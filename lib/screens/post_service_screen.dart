import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:helpinghands/data/category.dart';
import 'package:helpinghands/widgets/custom_text_field.dart';
import 'package:image_picker/image_picker.dart';

class PostServiceScreen extends StatefulWidget {
  const PostServiceScreen({Key? key}) : super(key: key);

  @override
  State<PostServiceScreen> createState() => _PostServiceScreenState();
}

class _PostServiceScreenState extends State<PostServiceScreen> {
  String? user = '';
  int? selected;
  File? _file;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();

  @override
  void initState() {
    getUser();
    super.initState();
  }

  void getUser() async {
    final User? cUser = FirebaseAuth.instance.currentUser;
    setState(() {
      user = cUser!.email ?? 'User';
    });
  }

  void pickImageFromGallery() async {
    try {
      final pickedImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      setState(() {
        _file = File(pickedImage!.path);
      });
    } on PlatformException catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Dear, $user',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w300,
                color: Colors.indigo,
              ),
            ),
            const Text(
              'Post your services.',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w700,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Choose a category',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            SingleChildScrollView(
              child: SizedBox(
                height: 60,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              selected = index;
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: index == selected
                                    ? categories[index].cColor
                                    : Colors.grey,
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 10,
                                    offset: Offset(0, 10),
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Text(
                                  categories[index].cName[0],
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: index == selected
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          categories[index].cName,
                          style: const TextStyle(fontSize: 10),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                pickImageFromGallery();
              },
              child: Container(
                height: 100,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.green[200],
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      offset: Offset(0, 10),
                    ),
                  ],
                ),
                child: _file == null
                    ? const Center(
                        child: Text(
                          'No image selected',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      )
                    : Image.file(
                        _file!,
                        fit: BoxFit.cover,
                      ),
              ),
            ),
            const SizedBox(height: 20),
            CustomTextField(
                labelText: 'Title',
                controller: _titleController,
                keyboardType: TextInputType.text),
            const SizedBox(height: 20),
            CustomTextField(
              labelText: 'Description',
              controller: _descController,
              keyboardType: TextInputType.text,
              maxLines: 5,
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text('Post'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
