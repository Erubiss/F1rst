// ignore_for_file: prefer_const_constructors

import 'package:f1rst/features/home/state_managers/cubit.dart';
import 'package:flutter/material.dart';

void aboutUserBottomSheetbar(
    BuildContext context, UserCubit cubit, TextEditingController ctrl) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return Padding(
        padding: EdgeInsets.only(
          left: 16.0,
          right: 16.0,
          top: 16.0,
          bottom: MediaQuery.of(context).viewInsets.bottom + 16.0,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Uptate About you',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 10),
              TextField(
                controller: ctrl,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'About you',
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  await cubit.updateUserAbout(ctrl.text).then((value) {
                    ctrl.clear();
                    Navigator.of(context).pop();
                  });
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightBlueAccent),
                child: Center(child: Text('Confirm')),
              ),
            ],
          ),
        ),
      );
    },
  );
}
