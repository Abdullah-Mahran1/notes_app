import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void showDeleteConfirmationDialog(BuildContext context, Function deleteItem) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
          title: const Text('Delete?'),
          content: const Text('Are you sure you want to delete this item?'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: const Text('Cancel',
                    style: TextStyle(color: Colors.white))),
            TextButton(
                onPressed: () {
                  // Perform the delete operation
                  deleteItem();
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: const Text('Delete',
                    style: TextStyle(color: Colors.white))),
          ]);
    },
  );
}
