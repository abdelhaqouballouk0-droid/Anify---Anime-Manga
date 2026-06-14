import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../widgets/app_logo.dart';
import '../data/sample_data.dart';

class ChatBotScreen extends StatefulWidget {
  const ChatBotScreen({super.key});

  @override
  State<ChatBotScreen> createState() => _ChatBotScreenState();
}

class ChatMessage {
  final String text;
  final bool fromUser;
  const ChatMessage({required this.text, required this.fromUser});
}

class _ChatBotScreenState extends State<ChatBotScreen> {
  final _controller = TextEditingController();
  final _messages = <ChatMessage>[
    const ChatMessage(
      text:
          'Salut ! Je suis ton assistant anime & manga. Pose-moi une question ou demande une recommandation.',
      fromUser: false,
    ),
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _sendMessage() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    setState(() {
      _messages.add(ChatMessage(text: text, fromUser: true));
      _controller.clear();
    });
    Future.delayed(const Duration(milliseconds: 250), () {
      final response = _composeReply(text);
      setState(() {
        _messages.add(ChatMessage(text: response, fromUser: false));
      });
    });
  }

  String _composeReply(String query) {
    final lower = query.toLowerCase();
    if (lower.contains('recommande') ||
        lower.contains('recommend') ||
        lower.contains('sugg')) {
      return 'Je te recommande : Jujutsu Kaisen, Demon Slayer, Solo Leveling et Chainsaw Man. Dis-moi si tu préfères action ou fantasy !';
    }
    if (lower.contains('manga')) {
      return 'Pour du manga, Chainsaw Man, One Piece et Spy x Family sont d’excellents choix selon ton style. Tu veux un résumé ?';
    }
    if (lower.contains('anime')) {
      return 'Pour un anime récent, essaie Jujutsu Kaisen ou Demon Slayer. Pour quelque chose de plus posé, Frieren est top.';
    }
    for (final m in SampleData.searchPool) {
      if (lower.contains(m.title.toLowerCase()) ||
          lower.contains(m.jpTitle.toLowerCase())) {
        return '${m.title} (${m.jpTitle}) : ${m.synopsis}';
      }
    }
    if (lower.contains('quiz')) {
      return 'Tu peux lancer le quiz depuis les paramètres ou le bouton dédié. Prêt à tester tes connaissances ?';
    }
    if (lower.contains('genre')) {
      return 'Tu peux explorer des genres comme Action, Fantasy, Supernatural, Adventure ou Comedy. Quel ton veux-tu ?';
    }
    return 'Je suis là pour t’aider avec anime et manga. Demande-moi une recommandation, un résumé ou un titre similaire.';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: const [
            AppLogo(size: 26, withBackground: false),
            SizedBox(width: 10),
            Text('Anime ChatBot'),
          ],
        ),
        backgroundColor: AppColors.surface,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: Align(
                    alignment: message.fromUser
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Container(
                      constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.75),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 12),
                      decoration: BoxDecoration(
                        color: message.fromUser
                            ? AppColors.accent
                            : const Color(0x14FFFFFF),
                        borderRadius: BorderRadius.only(
                          topLeft: const Radius.circular(18),
                          topRight: const Radius.circular(18),
                          bottomLeft:
                              Radius.circular(message.fromUser ? 18 : 4),
                          bottomRight:
                              Radius.circular(message.fromUser ? 4 : 18),
                        ),
                        border: Border.all(color: const Color(0x14FFFFFF)),
                      ),
                      child: Text(
                        message.text,
                        style: TextStyle(
                          color:
                              message.fromUser ? Colors.white : AppColors.text1,
                          height: 1.45,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const Divider(color: Color(0x14FFFFFF), height: 1),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0x0DFFFFFF),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: const Color(0x14FFFFFF)),
                    ),
                    child: TextField(
                      controller: _controller,
                      cursorColor: AppColors.accent,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                        hintText: 'Pose une question au chatbot...',
                        hintStyle: TextStyle(color: AppColors.text3),
                        border: InputBorder.none,
                      ),
                      onSubmitted: (_) => _sendMessage(),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: _sendMessage,
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: AppColors.accent,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Icon(Icons.send_rounded, color: Colors.white),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
