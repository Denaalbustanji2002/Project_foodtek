import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../cubits/ThemeCubit.dart' show ThemeCubit;
import '../../../../states/ThemeState.dart';
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
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        final isDark = state.themeMode == ThemeMode.dark;

        return Dialog(
          backgroundColor: isDark ? Colors.grey[900] : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Container(
            height: 170,
            width: 440,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      message,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
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
      },
    );
  }
}

void showNotificationDialog(
    BuildContext context,
    String title,
    String message, {
      VoidCallback? onConfirm,
      VoidCallback? onCancel,
    }) {
  showDialog(
    context: context,
    builder: (context) => RemoveFavoritesDialog(
      message: message,
      onConfirm: onConfirm,
    ),
  );
}
