import 'package:f1rst/features/home/state_managers/state.dart';
import 'package:f1rst/views/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class UserCubit extends Cubit<UserState> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final ImagePicker picker = ImagePicker();

  UserCubit() : super(UserState.initial());

  void changeTabIndex(int index) {
    emit(state.copyWith(selectedIndex: index));
  }

  Future<void> getUser() async {
    emit(state.copyWith(isLoading: true));
    try {
      if (auth.currentUser == null) return;

      final doc =
          await firestore.collection('users').doc(auth.currentUser!.uid).get();
      final data = doc.data()!;

      emit(state.copyWith(
        email: data['email'],
        phoneNumber: data['phoneNumber'],
        aboutUser: data['aboutUser'],
        userImage: data['userImage'] ?? "",
        isLoading: false,
      ));
    } catch (e) {
      print(e);
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }

  Future<void> updateUserAbout(String aboutUser) async {
    try {
      await firestore.collection('users').doc(auth.currentUser!.uid).update({
        'aboutUser': aboutUser,
      });
      emit(state.copyWith(aboutUser: aboutUser));
    } catch (e) {
      print(e);
      getUser();
    }
  }

  Future<void> updateUserImage(String imagePath) async {
    try {
      final userImage = await uploadImage(imagePath);
      await firestore.collection('users').doc(auth.currentUser!.uid).update({
        'userImage': userImage,
      });
      emit(state.copyWith(userImage: userImage));
    } catch (e) {
      print("Error in updateUserImage: $e");
    }
  }

  Future<String?> uploadImage(String imagePath) async {
    try {
      if (imagePath.isEmpty) {
        throw Exception("Image path is empty.");
      }

      final file = File(imagePath);
      if (!await file.exists()) {
        throw Exception("File does not exist at path: $imagePath");
      }

      final fileName = imagePath.split('/').last;
      final storageRef = FirebaseStorage.instance.ref('images/$fileName');

      final uploadTask = storageRef.putFile(file);
      final snapshot = await uploadTask;

      if (snapshot.state == TaskState.success) {
        return await snapshot.ref.getDownloadURL();
      } else {
        throw Exception("Failed to upload image.");
      }
    } catch (e) {
      print("Error uploading image: $e");
      return null;
    }
  }

  Future<void> pickImage() async {
    try {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        await updateUserImage(pickedFile.path);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> deleteUser(BuildContext context) async {
    try {
      await firestore.collection('users').doc(auth.currentUser!.uid).delete();
      await auth.currentUser!.delete().then((value) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SplashScreen()));
      });
    } catch (e) {
      print(e);
    }
  }
}
