import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../helper/responsive.dart';
import '../location_screen/delivery_tracking_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _textController = TextEditingController();

  List<ChatMessage> _getMessages(BuildContext context) => [
    ChatMessage(text: AppLocalizations.of(context)!.helloChat, isUserMessage: true),
    ChatMessage(text: AppLocalizations.of(context)!.helloIm, isUserMessage: false),
    ChatMessage(text:AppLocalizations.of(context)!.whatIsTheBest, isUserMessage: true),
    ChatMessage(
      text: AppLocalizations.of(context)!.programmingLanguagesExplanation,
      isUserMessage: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final messages = _getMessages(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Color(0xFF391713),
          iconSize: responsiveHeight(context, 20),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => DeliveryTrackingScreen()),
            );
          },
        ),
        title: Text(
          AppLocalizations.of(context)!.chat,
          style: GoogleFonts.inter(
            fontSize: responsiveHeight(context, 20),
            fontWeight: FontWeight.w600,
            color: Color(0xFF391713),
            letterSpacing: 0.0,
            height: 1.0,
          ),
        ),
        titleSpacing: 0.0,
        toolbarHeight: kToolbarHeight,
        leadingWidth: responsiveWidth(context, 40),
      ),
      body: Column(
        children: [
          Divider(color: Color(0xFFECECEC), thickness: 1),
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return _buildMessageItem(messages[index], context);
              },
            ),
          ),
          _buildMessageInputArea(),
          SizedBox(height: responsiveHeight(context, 40)),
        ],
      ),
    );
  }
  Widget _buildMessageItem(ChatMessage message, BuildContext context) {
    return Align(
      alignment:
      message.isUserMessage ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: message.isUserMessage ? Color(0xFF25AE4B) : Color(0xFFEEEEEE),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
            bottomLeft:
            message.isUserMessage
                ? Radius.circular(25)
                : Radius.circular(0),
            bottomRight:
            message.isUserMessage
                ? Radius.circular(0)
                : Radius.circular(25),
          ),
        ),
        child: Text(
          message.text,
          style: GoogleFonts.nunito(
            fontSize: responsiveHeight(context, 13),
            fontWeight: FontWeight.w700,
            height: 1.3,
            letterSpacing: 0.0,
            color:
            message.isUserMessage
                ? Color(0xFFFFFFFF)
                : Color(0xFF505050),
          ),
        ),
      ),
    );
  }

  Widget _buildMessageInputArea() {
    return Container(
      width: responsiveWidth(context, 333),
      height: responsiveHeight(context, 56),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.13),
            offset: Offset(5, 4),
            blurRadius: 20,
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _textController,
              decoration: InputDecoration(
                hintText: AppLocalizations.of(context)!.writeYourMessage,
                hintStyle: GoogleFonts.nunito(
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                  height: 1.0,
                  color: Color(0xFF9E9E9E),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          SizedBox(width: responsiveWidth(context, 10)),
          CircleAvatar(
            radius: responsiveHeight(context, 20),
            backgroundColor: Color(0xFFFFFFFF),
            child: IconButton(
              icon: Icon(Icons.send, color: Color(0xFF25AE4B)),
              onPressed: () {

              },
            ),
          ),
        ],
      ),
    );
  }
}

class ChatMessage {
  final String text;
  final bool isUserMessage;

  ChatMessage({required this.text, required this.isUserMessage});
}
