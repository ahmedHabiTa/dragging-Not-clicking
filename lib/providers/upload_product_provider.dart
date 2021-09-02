import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fiction_team_task/presentation/screens/home_screen.dart';
import 'package:fiction_team_task/presentation/widgets/error_dialog.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class UploadProductProvider with ChangeNotifier {
  File imageFile;
  bool uploading = false;
  String imageUrl;
  ImagePicker imagePicker = ImagePicker();
  var uuid = Uuid();

  Future<void> pickImageCamera(context) async {
    final pickedImage = await imagePicker.pickImage(source: ImageSource.camera);
    if (pickedImage != null) {
      imageFile = File(pickedImage.path);
      notifyListeners();
    }
    notifyListeners();
  }

  Future<void> pickImageGallery(context) async {
    final pickedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      imageFile = File(pickedImage.path);
      notifyListeners();
    }
    notifyListeners();
  }
  Future<void> remove(context) async {
    imageFile = null;
    notifyListeners();
  }

  Future<void> uploadProduct({
    context,
    TextEditingController titleController,
    TextEditingController priceController,
    TextEditingController oldPriceController,
    TextEditingController descriptionController,
    TextEditingController quantityController,
    TextEditingController saleController,
    TextEditingController newProductController,
  }) async {
    if (imageFile == null) {
      showDialog(
          context: context,
          builder: (c) {
            return ErrorAlertDialog(
              message: 'please select an Image',
            );
          });
    } else if (imageFile != null &&
        titleController.text.isNotEmpty &&
        priceController.text.isNotEmpty &&
        descriptionController.text.isNotEmpty &&
        quantityController.text.isNotEmpty &&
        saleController.text.isNotEmpty &&
        newProductController.text.isNotEmpty &&
        oldPriceController.text.isNotEmpty) {
      uploading = true;
      notifyListeners();
      Reference ref = FirebaseStorage.instance
          .ref()
          .child('products_images');
      await ref.putFile(imageFile);
      await ref.getDownloadURL().then((url) {
        imageUrl = url;
        notifyListeners();
      });
      final productId = uuid.v4();
      await FirebaseFirestore.instance
          .collection("products")
          .doc(productId)
          .set({
        'productID': productId,
        'title': titleController.text,
        'price': double.parse(priceController.text),
        'oldPrice': double.parse(oldPriceController.text),
        'description': descriptionController.text,
        'imageUrl': imageUrl ??
            'https://cdn1.vectorstock.com/i/thumb-large/62/60/default-avatar-photo-placeholder-profile-image-vector-21666260.jpg',
        'quantity': int.parse(quantityController.text),
        'sale': bool.fromEnvironment(saleController.text),
        'newProduct': bool.fromEnvironment(newProductController.text),
        'created At': Timestamp.now(),
      }).then((value) {
        uploading = false;
        notifyListeners();
        Fluttertoast.showToast(
            msg: "product Uploaded successfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
        notifyListeners();
         Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
      });
    } else {
      showDialog(
          context: context,
          builder: (c) {
            return ErrorAlertDialog(
              message: 'please fill all the requirements',
            );
          });
    }
    notifyListeners();
  }
}
