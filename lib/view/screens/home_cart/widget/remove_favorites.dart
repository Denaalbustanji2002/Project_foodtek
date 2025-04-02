import 'package:flutter/material.dart';
import '../../../widget/custom_primary_button.dart';

class RemoveFavoritesDialog extends StatelessWidget {
  final String message;
  final VoidCallback? onConfirm;

  const RemoveFavoritesDialog({
    Key? key,
    required this.message,
    this.onConfirm,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        height: 170, // Set height of the dialog
        width: 440, // Set width of the dialog
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  message,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),

              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomPrimaryButton(
                    text: "Yes",
                    onTap: () {
                      if (onConfirm != null) {
                        onConfirm!();
                      }
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void showNotificationDialog(BuildContext context, String title, String message,
    {VoidCallback? onConfirm, VoidCallback? onCancel}) {
  showDialog(
    context: context,
    builder: (context) => RemoveFavoritesDialog(
      message: message,
      onConfirm: onConfirm,
    ),
  );
}
