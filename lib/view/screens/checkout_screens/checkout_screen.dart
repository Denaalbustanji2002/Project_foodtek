import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

// Assuming these are your actual imports - make sure paths are correct
import '../../../core/screen_index.dart';
import '../../../cubits/navigatiion_cubit.dart';
import '../home_cart/widget/appbar2.dart';
import '../home_cart/widget/notification_widget.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({Key? key}) : super(key: key);

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  // Payment method selection
  PaymentMethod _paymentMethod = PaymentMethod.none;
  CardType _cardType = CardType.none;

  // Helper methods for responsive design
  double responsiveWidth(double width) => MediaQuery.of(context).size.width * (width / 414);
  double responsiveHeight(double height) => MediaQuery.of(context).size.height * (height / 896);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar:  NotificationWidget(), // Assuming this is your custom app bar
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              _buildTitle(),
              const SizedBox(height: 16),

              // Delivery Address Section
              _buildDeliverySection(),
              const SizedBox(height: 24),

              // Promo Code Section
              _buildPromoCodeSection(),
              const SizedBox(height: 24),

              // Payment Method Section
              _buildPaymentMethodSection(),
              const SizedBox(height: 10),

              // Card Type Section (only visible if card payment selected)
              if (_paymentMethod == PaymentMethod.card) ...[
                _buildCardTypeSection(),
                const SizedBox(height: 16),
              ],

              const SizedBox(height: 25),

              // Order Summary Section
              _buildOrderSummary(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      "Checkout",
      style: GoogleFonts.inter(
        color: const Color(0xFF391713),
        fontSize: responsiveHeight(20),
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _buildDeliverySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Pay With:',
          style: GoogleFonts.inter(
            color: const Color(0xFF0A0D13),
            fontSize: responsiveHeight(18),
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 14),

        // Pickup Address
        _buildAddressRow(
          icon: Icons.share_location,
          address: '88 Zurab Gorgiladze St',
          location: 'Georgia, Batumi',
        ),
        const SizedBox(height: 12),

        // Delivery Address
        _buildAddressRow(
          icon: Icons.location_on_outlined,
          address: '5 Noe Zhordania St',
          location: 'Georgia, Batumi',
          showChangeButton: true,
        ),
      ],
    );
  }

  Widget _buildAddressRow({
    required IconData icon,
    required String address,
    required String location,
    bool showChangeButton = false,
  }) {
    return Row(
      children: [
        Icon(icon, color: Colors.green, size: 20),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                address,
                style: GoogleFonts.inter(
                  fontSize: responsiveHeight(15),
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF2F2E36),
                ),
              ),
              Text(
                location,
                style: TextStyle(
                  fontSize: responsiveHeight(13),
                  fontWeight: FontWeight.w400,
                  color: const Color(0XFFB8B8B8),
                ),
              ),
            ],
          ),
        ),
        if (showChangeButton)
          TextButton(
            onPressed: () => _changeAddress(),
            child: Text(
              'Change',
              style: GoogleFonts.inter(
                fontSize: responsiveHeight(14),
                color: const Color(0xFF25AE4B),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildPromoCodeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Promo Code?',
          style: GoogleFonts.inter(
            fontSize: responsiveHeight(16),
            fontWeight: FontWeight.w600,
            color: const Color(0xFF0A0D13),
          ),
        ),
        const SizedBox(height: 14),
        Row(
          children: [
            Expanded(
              child: Container(
                height: responsiveHeight(45),
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0XFFD6D6D6)),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                  ),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: responsiveWidth(12),
                      vertical: responsiveHeight(16),
                    ),
                    hintText: 'Enter Your Promo',
                    hintStyle: GoogleFonts.inter(
                      color: const Color(0XFF878787),
                      fontSize: responsiveHeight(12),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              height: responsiveHeight(45),
              width: responsiveWidth(90),
              decoration: const BoxDecoration(
                color: Color(0xFF34B56F),
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
              child: TextButton(
                onPressed: _applyPromoCode,
                child: Text(
                  'Add',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: responsiveHeight(12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPaymentMethodSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Pay With:',
          style: GoogleFonts.inter(
            color: const Color(0xFF0A0D13),
            fontSize: responsiveHeight(18),
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 14),
        Row(
          children: [
            _buildPaymentOption(
              isSelected: _paymentMethod == PaymentMethod.card,
              label: 'Card',
              onTap: () => setState(() {
                _paymentMethod = PaymentMethod.card;
              }),
            ),
            SizedBox(width: responsiveWidth(38)),
            _buildPaymentOption(
              isSelected: _paymentMethod == PaymentMethod.cash,
              label: 'Cash',
              onTap: () => setState(() {
                _paymentMethod = PaymentMethod.cash;
                _cardType = CardType.none;
              }),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPaymentOption({
    required bool isSelected,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            width: responsiveWidth(15),
            height: responsiveHeight(15),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: isSelected ? const Color(0xFF34B56F) : Colors.grey,
                width: 2,
              ),
            ),
            child: isSelected
                ? Center(
              child: Container(
                width: responsiveWidth(9),
                height: responsiveHeight(9),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF34B56F),
                ),
              ),
            )
                : null,
          ),
          SizedBox(width: responsiveWidth(10)),
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: responsiveHeight(16),
              fontWeight: FontWeight.w500,
              color: const Color(0xFF0A0D13),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCardTypeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Card Type:',
          style: GoogleFonts.inter(
            color: const Color(0xFF0A0D13),
            fontSize: responsiveHeight(18),
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            _buildCardTypeOption(
              isSelected: _cardType == CardType.mastercard,
              imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/2/2a/Mastercard-logo.svg/1280px-Mastercard-logo.svg.png',
              onTap: () => setState(() => _cardType = CardType.mastercard),
            ),
            SizedBox(width: responsiveWidth(38)),
            _buildCardTypeOption(
              isSelected: _cardType == CardType.visa,
              imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/5/5e/Visa_Inc._logo.svg/2560px-Visa_Inc._logo.svg.png',
              onTap: () => setState(() => _cardType = CardType.visa),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCardTypeOption({
    required bool isSelected,
    required String imageUrl,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            width: responsiveWidth(15),
            height: responsiveHeight(15),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: isSelected ? const Color(0xFF34B56F) : Colors.grey,
                width: 2,
              ),
            ),
            child: isSelected
                ? Center(
              child: Container(
                width: responsiveWidth(9),
                height: responsiveHeight(9),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF34B56F),
                ),
              ),
            )
                : null,
          ),
          SizedBox(width: responsiveWidth(10)),
          Image.network(
            imageUrl,
            width: responsiveWidth(26.27),
            height: responsiveHeight(17),
            fit: BoxFit.contain,
          ),
        ],
      ),
    );
  }

  Widget _buildOrderSummary() {
    return Container(
      height: responsiveHeight(210),
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF25AE4B),
        borderRadius: BorderRadius.circular(7),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _buildSummaryRow('Sub-Total', '100 \$'),
          SizedBox(height: responsiveHeight(6)),
          _buildSummaryRow('Delivery Charge', '10 \$'),
          SizedBox(height: responsiveHeight(6)),
          _buildSummaryRow('Discount', '10 \$'),
          SizedBox(height: responsiveHeight(6)),
          _buildSummaryRow(
            'Total:',
            '110\$',
            isTotal: true,
          ),
          SizedBox(height: responsiveHeight(16)),
          SizedBox(
            width: double.infinity,
            height: responsiveHeight(40),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7),
                ),
              ),
              onPressed: _placeOrder,
              child: Text(
                'Place My Order',
                style: GoogleFonts.inter(
                  color: const Color(0xFF34B56F),
                  fontSize: responsiveHeight(14),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            color: Colors.white,
            fontWeight: isTotal ? FontWeight.w700 : FontWeight.w400,
            fontSize: isTotal ? responsiveHeight(18) : responsiveHeight(16),
          ),
        ),
        Text(
          value,
          style: GoogleFonts.inter(
            color: Colors.white,
            fontWeight: isTotal ? FontWeight.w700 : FontWeight.w400,
            fontSize: isTotal ? responsiveHeight(18) : responsiveHeight(16),
          ),
        ),
      ],
    );
  }

  // Action Methods
  void _changeAddress() {
    // Implement address change logic
  }

  void _applyPromoCode() {
    // Implement promo code application logic
  }

  void _placeOrder() {
    if (_paymentMethod == PaymentMethod.none) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a payment method')),
      );
      return;
    }

    if (_paymentMethod == PaymentMethod.card && _cardType == CardType.none) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a card type')),
      );
      return;
    }
    if (_paymentMethod == PaymentMethod.cash) {
      // Navigate to OrderDoneSuccessfullyScreen for cash payment
      context.read<NavigationCubit>().goTo(ScreenIndex.OrderDoneSuccessfullyScreen);
    } else {
      // Original navigation for card payment
      context.read<NavigationCubit>().goTo(ScreenIndex.AddtoCardScreen);
    }

  }
}

// Enums for better state management
enum PaymentMethod { none, card, cash }
enum CardType { none, mastercard, visa }