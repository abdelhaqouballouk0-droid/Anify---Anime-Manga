import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../widgets/app_logo.dart';
import '../data/sample_data.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int currentIndex = 0;
  int score = 0;
  int? selectedOption;
  bool answered = false;

  void _selectOption(int index) {
    if (answered) return;
    setState(() {
      selectedOption = index;
      answered = true;
      if (index == SampleData.quizQuestions[currentIndex].answerIndex) {
        score += 1;
      }
    });
  }

  void _nextQuestion() {
    if (currentIndex + 1 >= SampleData.quizQuestions.length) {
      return;
    }
    setState(() {
      currentIndex += 1;
      selectedOption = null;
      answered = false;
    });
  }

  void _restart() {
    setState(() {
      currentIndex = 0;
      score = 0;
      selectedOption = null;
      answered = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final question = SampleData.quizQuestions[currentIndex];
    final completed =
        currentIndex >= SampleData.quizQuestions.length - 1 && answered;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: const [
            AppLogo(size: 26, withBackground: false),
            SizedBox(width: 10),
            Text('Anime & Manga Quiz'),
          ],
        ),
        backgroundColor: AppColors.surface,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _progressBar(),
            const SizedBox(height: 22),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0x14FFFFFF)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        'Question ${currentIndex + 1}/${SampleData.quizQuestions.length}',
                        style: const TextStyle(
                            fontSize: 13,
                            color: AppColors.accent300,
                            fontWeight: FontWeight.w700)),
                    const SizedBox(height: 12),
                    Text(question.question,
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                            height: 1.25)),
                    const SizedBox(height: 18),
                    ...List.generate(question.options.length, (index) {
                      final option = question.options[index];
                      final selected = selectedOption == index;
                      final correct = question.answerIndex == index;
                      final showCorrect = answered && correct;
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: GestureDetector(
                          onTap: () => _selectOption(index),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 14),
                            decoration: BoxDecoration(
                              color: showCorrect
                                  ? AppColors.teal
                                  : selected
                                      ? AppColors.accent
                                      : const Color(0x16FFFFFF),
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(
                                color: showCorrect
                                    ? AppColors.teal300
                                    : selected
                                        ? AppColors.accent300
                                        : const Color(0x14FFFFFF),
                              ),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(option,
                                      style: TextStyle(
                                        color: selected || showCorrect
                                            ? Colors.white
                                            : AppColors.text2,
                                        fontWeight: FontWeight.w700,
                                      )),
                                ),
                                if (answered && selected)
                                  Icon(
                                    correct
                                        ? Icons.check_circle_rounded
                                        : Icons.close_rounded,
                                    color: correct
                                        ? AppColors.teal300
                                        : AppColors.accent,
                                  ),
                                if (answered && showCorrect && !selected)
                                  const Icon(Icons.check_circle_rounded,
                                      color: AppColors.teal300),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                    if (answered) ...[
                      const Divider(color: Color(0x14FFFFFF)),
                      const SizedBox(height: 12),
                      Text('Explanation',
                          style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: AppColors.text2)),
                      const SizedBox(height: 8),
                      Text(question.explanation,
                          style: const TextStyle(
                              fontSize: 13.5,
                              color: AppColors.text3,
                              height: 1.5)),
                    ],
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            if (answered)
              ElevatedButton(
                onPressed: completed ? _restart : _nextQuestion,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.accent,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text(completed ? 'See results' : 'Next question',
                    style: const TextStyle(fontWeight: FontWeight.w800)),
              )
            else
              ElevatedButton(
                onPressed: selectedOption == null ? null : _nextQuestion,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.accent,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Submit answer',
                    style: TextStyle(fontWeight: FontWeight.w800)),
              ),
            if (completed)
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Text('Score: $score/${SampleData.quizQuestions.length}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.text2,
                        fontWeight: FontWeight.w700)),
              ),
          ],
        ),
      ),
    );
  }

  Widget _progressBar() {
    final progress =
        (currentIndex + (answered ? 1 : 0)) / SampleData.quizQuestions.length;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Quiz progress',
            style: TextStyle(fontSize: 13, color: AppColors.text3)),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: LinearProgressIndicator(
            value: progress,
            backgroundColor: const Color(0x14FFFFFF),
            color: AppColors.accent,
            minHeight: 10,
          ),
        ),
      ],
    );
  }
}
