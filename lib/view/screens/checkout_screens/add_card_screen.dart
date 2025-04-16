import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

// Make sure these imports match your project structure
import '../../../core/screen_index.dart';
import '../../../cubits/navigatiion_cubit.dart';
import '../../../helper/responsive.dart';
import '../home_cart/widget/notification_widget.dart';

class AddtoCardScreen extends StatefulWidget {
  const AddtoCardScreen({Key? key}) : super(key: key);

  @override
  State<AddtoCardScreen> createState() => _AddCardScreenState();
}

class _AddCardScreenState extends State<AddtoCardScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController expiryController = TextEditingController();
  final TextEditingController cvvController = TextEditingController();

  bool _obscureCvv = true;
  bool _isProcessing = false;

  @override
  void dispose() {
    nameController.dispose();
    cardNumberController.dispose();
    expiryController.dispose();
    cvvController.dispose();
    super.dispose();
  }

  void _formatCardNumber() {
    final text = cardNumberController.text.replaceAll(RegExp(r'\D'), '');
    final chunks = <String>[];

    for (var i = 0; i < text.length; i += 4) {
      chunks.add(text.substring(i, i + 4 > text.length ? text.length : i + 4));
    }

    cardNumberController.text = chunks.join(' ');
    cardNumberController.selection = TextSelection.fromPosition(
      TextPosition(offset: cardNumberController.text.length),
    );
  }

  void _formatExpiryDate() {
    var text = expiryController.text.replaceAll(RegExp(r'[^\d]'), '');
    if (text.length >= 3) {
      text = '${text.substring(0, 2)}/${text.substring(2)}';
    }
    expiryController.text = text;
    expiryController.selection = TextSelection.fromPosition(
      TextPosition(offset: expiryController.text.length),
    );
  }

  void _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isProcessing = true);

    try {
      // Simulate payment processing
      await Future.delayed(const Duration(seconds: 2));

      if (mounted) {
        context.read<NavigationCubit>().goTo(ScreenIndex.OrderDoneSuccessfullyScreen);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Payment failed: ${e.toString()}')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isProcessing = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: NotificationWidget(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(responsiveWidth(context, 14)),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: responsiveHeight(context, 16)),
                _buildTitle(),
                SizedBox(height: responsiveHeight(context, 24)),
                _buildCardImage(),
                SizedBox(height: responsiveHeight(context, 16)),
                _buildNameField(),
                SizedBox(height: responsiveHeight(context, 16)),
                _buildCardNumberField(),
                SizedBox(height: responsiveHeight(context, 16)),
                _buildExpiryAndCvvFields(),
                SizedBox(height: responsiveHeight(context, 16)),
                _buildInfoText(),
                SizedBox(height: responsiveHeight(context, 16)),
                _buildPayButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      'Add Card',
      style: GoogleFonts.inter(
        color: const Color(0xFF391713),
        fontSize: responsiveHeight(context, 20),
        fontWeight: FontWeight.w600,
        height: 1.0,
      ),
    );
  }

  Widget _buildCardImage() {
    return Center(
      child: Image.asset(
        'assets/images/addcard.png',
        fit: BoxFit.contain,
      ),
    );
  }

  Widget _buildNameField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildFieldLabel('Name'),
        SizedBox(height: responsiveHeight(context, 2)),
        _buildTextField(
          controller: nameController,
          hintText: '',
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter cardholder name';
            }
            if (value.length < 2) {
              return 'Name too short';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildCardNumberField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildFieldLabel('Card Number'),
        SizedBox(height: responsiveHeight(context, 2)),
        _buildTextField(
          controller: cardNumberController,
          hintText: '',
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(19),
          ],
          onChanged: (value) => _formatCardNumber(),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter card number';
            }
            final digits = value.replaceAll(' ', '');
            if (digits.length != 16) {
              return 'Card number must be 16 digits';
            }
            if (!RegExp(r'^\d+$').hasMatch(digits)) {
              return 'Only numbers allowed';
            }
            return null;
          },
          suffixIcon: Padding(
            padding: EdgeInsets.only(right: responsiveWidth(context, 10)),
            child: Image.asset(
              'assets/images/card_icon.png',
              width: responsiveWidth(context, 20),
              height: responsiveHeight(context, 20),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildExpiryAndCvvFields() {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildFieldLabel('Expiry'),
              SizedBox(height: responsiveHeight(context, 2)),
              _buildTextField(
                controller: expiryController,
                hintText: 'MM/YY',
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(5),
                ],
                onChanged: (value) => _formatExpiryDate(),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter expiry date';
                  }
                  if (!RegExp(r'^\d{2}/\d{2}$').hasMatch(value)) {
                    return 'MM/YY format';
                  }

                  final parts = value.split('/');
                  final month = int.tryParse(parts[0]) ?? 0;
                  if (month < 1 || month > 12) {
                    return 'Invalid month';
                  }

                  return null;
                },
                width: 176,
              ),
            ],
          ),
        ),
        SizedBox(width: responsiveWidth(context, 7)),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildFieldLabel('CVV'),
              SizedBox(height: responsiveHeight(context, 2)),
              _buildTextField(
                controller: cvvController,
                hintText: '',
                keyboardType: TextInputType.number,
                obscureText: _obscureCvv,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(4),
                ],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter CVV';
                  }
                  if (value.length < 3) {
                    return '3-4 digits required';
                  }
                  return null;
                },
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureCvv ? Icons.visibility : Icons.visibility_off,
                    size: 20,
                    color: Colors.grey,
                  ),
                  onPressed: () => setState(() => _obscureCvv = !_obscureCvv),
                ),
                width: 176,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFieldLabel(String text) {
    return Text(
      text,
      style: GoogleFonts.plusJakartaSans(
        color: const Color(0XFF6C7278),
        fontSize: responsiveHeight(context, 12),
        fontWeight: FontWeight.w500,
        letterSpacing: -0.02,
        height: 1.6,
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
    Widget? suffixIcon,
    double? width,
    List<TextInputFormatter>? inputFormatters,
    void Function(String)? onChanged,
    bool obscureText = false,
  }) {
    return Container(
      width: width != null ? responsiveWidth(context, width) : double.infinity,
      height: responsiveHeight(context, 46),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color(0xFFEDF1F3),
          width: 1,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x3DE4E5E7),
            offset: Offset(0, 1),
            blurRadius: 2,
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        validator: validator,
        inputFormatters: inputFormatters,
        onChanged: onChanged,
        obscureText: obscureText,
        style: GoogleFonts.inter(
          fontWeight: FontWeight.w700,
          fontSize: 14,
          color: const Color(0XFF1A1C1E),
          height: 1.4,
          letterSpacing: -0.01,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: GoogleFonts.inter(
            fontWeight: FontWeight.w400,
            fontSize: responsiveHeight(context, 14),
            color: Colors.grey[500],
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: responsiveWidth(context, 13),
            vertical: responsiveHeight(context, 14),
          ),
          border: InputBorder.none,
          suffixIcon: suffixIcon,
          errorStyle: TextStyle(
            fontSize: responsiveHeight(context, 10),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoText() {
    return Container(
      alignment: Alignment.center,
      child: Text(
        'We will send you an order details to your\nemail after the successful payment',
        style: GoogleFonts.inter(
          color: const Color(0XFF929DA9),
          fontSize: responsiveHeight(context, 12),
          fontWeight: FontWeight.w400,
          letterSpacing: 0.02,
          height: 1.4,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildPayButton() {
    return Center(
      child: SizedBox(
        width: responsiveWidth(context, 327),
        height: responsiveHeight(context, 57),
        child: ElevatedButton(
          onPressed: _isProcessing ? null : _submitForm,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF25AE4B),
            padding: EdgeInsets.symmetric(
              horizontal: responsiveWidth(context, 22),
              vertical: responsiveHeight(context, 18),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          child: _isProcessing
              ? const CircularProgressIndicator(color: Colors.white)
              : Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                "assets/images/noun_Lock_1911126.png",
                height: 21,
                width: 16,
              ),
              SizedBox(width: responsiveWidth(context, 16)),
              Text(
                "Pay for the order",
                style: GoogleFonts.inter(
                  fontSize: responsiveHeight(context, 18),
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  height: 1.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}