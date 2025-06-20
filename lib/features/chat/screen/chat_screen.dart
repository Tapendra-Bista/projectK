import 'dart:io';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:afriqueen/common/constant/constant_colors.dart';
import 'package:afriqueen/common/localization/enums/enums.dart';
import 'package:afriqueen/common/widgets/circular_indicator.dart';
import 'package:afriqueen/features/chat/bloc/chat_bloc.dart';
import 'package:afriqueen/features/chat/bloc/chat_event.dart';
import 'package:afriqueen/features/chat/bloc/chat_state.dart';
import 'package:afriqueen/features/chat/model/chat_message.dart';
import 'package:afriqueen/features/chat/widgets/chat_screen_widget.dart';
import 'package:afriqueen/features/chat/widgets/message_bubble.dart';
import 'package:afriqueen/services/service_locator/service_locator.dart';
import 'package:afriqueen/services/status/bloc/status_bloc.dart';
import 'package:afriqueen/services/status/bloc/status_event.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

// ----------individual chat screen ------------------
class ChatScreen extends StatefulWidget {
  final String receiverId;
  final String receiverName;
  final String imgURL;
  const ChatScreen(
      {Key? key,
      required this.receiverId,
      required this.receiverName,
      required this.imgURL})
      : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  bool _isComposing = false;
  bool _showEmoji = false;

  List<ChatMessage> _previousMessages = [];

  @override
  void initState() {
    super.initState();
    getIt<ChatBloc>().add(InitializeChatEvent(widget.receiverId));
    getIt<StatusBloc>().add(GetStatus(uid: widget.receiverId));

    messageController.addListener(_onTextChanged);
    _scrollController.addListener(_onScroll);
  }

  void _onTextChanged() {
    final isComposing = messageController.text.isNotEmpty;
    if (isComposing != _isComposing) {
      setState(() => _isComposing = isComposing);
      if (isComposing) {
        getIt<ChatBloc>().add(StartTyping());
      }
    }
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      getIt<ChatBloc>().add(LoadMoreMessages());
    }
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  void _hasNewMessages(List<ChatMessage> messages) {
    if (messages.length != _previousMessages.length) {
      _scrollToBottom();
      _previousMessages = messages;
    }
  }

  void _handleSendMessage() {
    final text = messageController.text.trim();
    if (text.isNotEmpty) {
      getIt<ChatBloc>().add(
        SendMessage(content: text, receiverId: widget.receiverId),
      );
      messageController.clear();
    }
  }

  @override
  void dispose() {
    messageController.dispose();
    _scrollController.dispose();
    getIt<ChatBloc>().add(LeaveChat());

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isValideUrl = widget.imgURL.isNotEmpty &&
        Uri.tryParse(widget.imgURL)!.hasAbsolutePath == true;
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.h),
          //---------Chat Screen PlatformAppBar-----------------
          child: ChatScreenAppBar(isValideUrl: isValideUrl, widget: widget)),
      body: BlocConsumer<ChatBloc, ChatState>(
        listener: (context, state) => _hasNewMessages(state.messages),
        builder: (context, state) {
          if (state.status == ChatStatus.error) {
            print("Error in Chat Screen : ${state.error}");
            return Center(
                child:
                    Text(" ${EnumLocale.defaultError.name.tr} ${state.error}"));
          }
          if (state.status == ChatStatus.loading) {
            return const Center(child: CustomCircularIndicator());
          }
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  reverse: true,
                  itemCount: state.messages.length,
                  itemBuilder: (context, index) {
                    final message = state.messages[index];
                    final isMe = message.senderId ==
                        FirebaseAuth.instance.currentUser?.uid;
                    return MessageBubble(
                      message: message,
                      isMe: isMe,
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    Row(
                      children: [
                        PlatformIconButton(
                          icon: const Icon(Icons.emoji_emotions_outlined),
                          onPressed: () {
                            setState(() => _showEmoji = !_showEmoji);
                            if (_showEmoji) {
                              FocusScope.of(context).unfocus();
                            }
                          },
                        ),
                        Flexible(
                          child: TextField(
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(color: AppColors.black),
                            // Fills available vertical space
                            maxLines: 5, // Must be null when expands is true
                            minLines: 1,
                            keyboardType: TextInputType.text,
                            controller: messageController,
                            onTap: () {
                              if (_showEmoji) {
                                setState(() => _showEmoji = false);
                              }
                            },
                            decoration: InputDecoration(
                              alignLabelWithHint: true,
                              isDense: true,
                              errorMaxLines: 3,
                              hintText: EnumLocale.messagesHint.name.tr,
                              hintStyle: Theme.of(context).textTheme.bodySmall,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.r),
                                borderSide: BorderSide(
                                    width: 1.w, color: AppColors.black),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.r),
                                borderSide: BorderSide(
                                    width: 1.w, color: AppColors.black),
                              ),
                              border: InputBorder.none,
                            ),

                            textCapitalization: TextCapitalization.sentences,
                          ),
                        ),
                        PlatformIconButton(
                          icon: Icon(Icons.send,
                              color:
                                  _isComposing ? AppColors.blue : Colors.grey),
                          onPressed: _isComposing ? _handleSendMessage : null,
                        )
                      ],
                    ),
                    if (_showEmoji)
                      SizedBox(
                        height: 250,
                        child: EmojiPicker(
                          textEditingController: messageController,
                          onEmojiSelected: (category, emoji) {
                            messageController.text += emoji.emoji;
                            messageController.selection =
                                TextSelection.fromPosition(TextPosition(
                                    offset: messageController.text.length));
                            setState(() => _isComposing =
                                messageController.text.isNotEmpty);
                          },
                          config: Config(
                            emojiViewConfig: EmojiViewConfig(
                              emojiSizeMax:
                                  32.0 * (Platform.isIOS ? 1.30 : 1.0),
                              backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                            ),
                            categoryViewConfig: const CategoryViewConfig(
                              initCategory: Category.RECENT,
                            ),
                            bottomActionBarConfig: BottomActionBarConfig(
                              enabled: true,
                              backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
