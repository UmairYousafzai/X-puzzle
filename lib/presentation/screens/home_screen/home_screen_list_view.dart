import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xpuzzle/presentation/screens/start_quiz_screen.dart';

import '../../../data/data_source/local/question_generator.dart';
import '../../../data/data_source/local/shared_preference_helper.dart';
import '../../../domain/entities/question.dart';
import '../../../domain/use_cases/get_questions.dart';
import '../../../domain/use_cases/store_questions.dart';
import '../../../utils/navigation/navigate.dart';
import '../../providers/home_screen_providers.dart';
import '../../providers/question/question_provider.dart';
import '../../providers/question/question_usecase_provider.dart';
import '../../providers/result_provider.dart';
import '../../providers/shared_pref_provider.dart';
import '../../providers/time/time_use_case_provider.dart';
import '../../theme/colors.dart';
import '../dialogs/style_completed_custom_dialog.dart';
import '../game_screen/game_screen.dart';
import '../results_screen.dart';
import 'home_screen_list_card.dart';

class HomeScreenListView extends ConsumerStatefulWidget {
  const HomeScreenListView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return HomeScreenListViewState();
  }
}

class HomeScreenListViewState extends ConsumerState<HomeScreenListView> {
  Future<void> generateAndStoreQuestion({
    required GetQuestions getQuestionsUseCase,
    required StoreQuestions storeQuestions,
    required QuestionProviderNotifier questionNotifier,
    bool isPPAndPS = false,
    bool isPPAndNS = false,
    bool isNPAndPS = false,
    bool isNPAndNS = false,
  }) async {
    List<Question> questions = generatePositiveMultipleAndPositiveInteger(
        numberOfQuestion: 10,
        isPPAndPS: isPPAndPS,
        isPPAndNS: isPPAndNS,
        isNPAndPS: isNPAndPS,
        isNPAndNS: isNPAndNS);

    await storeQuestions.execute(questions);
    if (questions.isNotEmpty) {
      await getQuestions(getQuestionsUseCase, questionNotifier,
          isPPAndPS: isPPAndPS,
          isPPAndNS: isPPAndNS,
          isNPAndPS: isNPAndPS,
          isNPAndNS: isNPAndNS);
    }
  }

  Future<List<Question>> getQuestions(
      GetQuestions getQuestion,
      QuestionProviderNotifier questionNotifier, {
        bool isPPAndPS = false,
        bool isPPAndNS = false,
        bool isNPAndPS = false,
        bool isNPAndNS = false,
      }) async {
    var questions = await getQuestion.execute(
        isPPAndPS: isPPAndPS,
        isPPAndNS: isPPAndNS,
        isNPAndPS: isNPAndPS,
        isNPAndNS: isNPAndNS);

    if (questions.isNotEmpty) {
      questionNotifier.addQuestion(
          questions: questions,
          isPPAndPS: isPPAndPS,
          isPPAndNS: isPPAndNS,
          isNPAndPS: isNPAndPS,
          isNPAndNS: isNPAndNS);
    }

    await Future.delayed(const Duration(milliseconds: 1000));
    return questions;
  }

  bool isQuestionsCompleted(List<Question> questions) {
    if (questions.isNotEmpty) {
      for (final question in questions) {
        if (!question.isComplete) {
          return false;
        }
      }
    } else {
      return false;
    }
    return true;
  }

  void onResult() async {
    await getQuestionsForResult();

    Navigator.push(
        context, MaterialPageRoute(builder: (ctx) => const ResultsScreen()));
  }

  void onTryAgain(
      Map<String, dynamic> screenState,
      GetQuestions getQuestionUseCase,
      StoreQuestions storeQuestionsUseCase,
      QuestionProviderNotifier questionNotifier,
      HomeScreenViewNotifier screenStateNotifier,
      ) async {
    print("ontry again============>()");

    var screenState = ref.watch(homeViewTypeProvider);
    ref.watch(sharedPreferencesProvider).when(
        data: (sharedPreference) async {
          resetSpecificQuestionData(
              screenState,
              getQuestionUseCase,
              storeQuestionsUseCase,
              questionNotifier,
              screenStateNotifier,
              sharedPreference);
        },
        error: (err, stack) {
          if (kDebugMode) {
            print(err);
          }
        },
        loading: () {});
  }

  Future<void> resetSpecificQuestionData(
      Map<String, dynamic> screenState,
      GetQuestions getQuestionUseCase,
      StoreQuestions storeQuestionsUseCase,
      QuestionProviderNotifier questionNotifier,
      HomeScreenViewNotifier screenStateNotifier,
      SharedPreferencesHelper sharedPreference) async {
    var isPPAndPS = screenState["style"] == 0 ? true : false;
    var isPPAndNS = screenState["style"] == 1 ? true : false;
    var isNPAndPS = screenState["style"] == 2 ? true : false;
    var isNPAndNS = screenState["style"] == 3 ? true : false;
    await sharedPreference.saveQuestionProgress(
        value: 0,
        isPPAndPS: isPPAndPS,
        isPPAndNS: isPPAndNS,
        isNPAndPS: isNPAndPS,
        isNPAndNS: isNPAndNS);
    await sharedPreference.setStyleStatus(
        value: false,
        isPPAndPS: isPPAndPS,
        isPPAndNS: isPPAndNS,
        isNPAndPS: isNPAndPS,
        isNPAndNS: isNPAndNS);
    await ref.watch(deleteQuestionsUseCaseProvider).execute(
        isPPAndPS: isPPAndPS,
        isPPAndNS: isPPAndNS,
        isNPAndPS: isNPAndPS,
        isNPAndNS: isNPAndNS);
    ref.watch(deleteQuestionTimeUseCaseProvider).execute(
        isPPAndPS: isPPAndPS,
        isPPAndNS: isPPAndNS,
        isNPAndPS: isNPAndPS,
        isNPAndNS: isNPAndNS);

    generateQuestionAndNavigate(true, getQuestionUseCase, storeQuestionsUseCase,
        questionNotifier, screenStateNotifier);
  }

  Future<void> getQuestionsForResult() async {
    var screenState = ref.watch(homeViewTypeProvider);
    await ref.watch(questionProvider.notifier).fetchQuestion(
        isPPAndPS: screenState["style"] == 0 ? true : false,
        isPPAndNS: screenState["style"] == 1 ? true : false,
        isNPAndPS: screenState["style"] == 2 ? true : false,
        isNPAndNS: screenState["style"] == 3 ? true : false);
    setQuestionTypeForResults(screenState);
  }

  void setQuestionTypeForResults(
      Map<String, dynamic> screenState,
      ) {
    ref.read(resultProvider.notifier).setQuestionType(
        isPPAndPS: screenState["style"] == 0 ? true : false,
        isPPAndNS: screenState["style"] == 1 ? true : false,
        isNPAndPS: screenState["style"] == 2 ? true : false,
        isNPAndNS: screenState["style"] == 3 ? true : false);
  }

  void generateQuestionAndNavigate(
      bool shouldGetQuestion,
      GetQuestions getQuestionUseCase,
      StoreQuestions storeQuestionsUseCase,
      QuestionProviderNotifier questionNotifier,
      HomeScreenViewNotifier screenStateNotifier,
      ) async {
    var screenState = ref.watch(homeViewTypeProvider);
    if (shouldGetQuestion) {
      await generateAndStoreQuestion(
          getQuestionsUseCase: getQuestionUseCase,
          storeQuestions: storeQuestionsUseCase,
          questionNotifier: questionNotifier,
          isPPAndPS: screenState["style"] == 0 ? true : false,
          isPPAndNS: screenState["style"] == 1 ? true : false,
          isNPAndPS: screenState["style"] == 2 ? true : false,
          isNPAndNS: screenState["style"] == 3 ? true : false);
    }
    screenStateNotifier.setLoading(false);

    navigateToScreen(context, const StartQuizScreen());
  }

  void onItemClicked(int index, BuildContext context) async {
    final screenState = ref.watch(homeViewTypeProvider);
    final screenStateNotifier = ref.read(homeViewTypeProvider.notifier);
    final storeQuestionsUseCase = ref.watch(storeQuestionUseCaseProvider);
    final isPPAndPSQuestionUseCase = ref.watch(isPPAndPSUseCaseProvider);
    final isPPAndNSQuestionUseCase = ref.watch(isPPAndNSUseCaseProvider);
    final isNPAndPSQuestionUseCase = ref.watch(isNPAndPSUseCaseProvider);
    final isNPAndNSQuestionUseCase = ref.watch(isNPAndNSUseCaseProvider);
    final getQuestionUseCase = ref.watch(getQuestionUseCaseProvider);
    var questionNotifier = ref.read(questionProvider.notifier);
    screenStateNotifier.setStyle(index);
    screenStateNotifier.setLoading(true);
    var questions = await getQuestions(getQuestionUseCase, questionNotifier,
        isPPAndPS: index == 0,
        isPPAndNS: index == 1,
        isNPAndPS: index == 2,
        isNPAndNS: index == 3);
    var isQuestionsExist = false;
    if (index == 0) {
      isQuestionsExist = await isPPAndPSQuestionUseCase.execute();
    } else if (index == 1) {
      isQuestionsExist = await isPPAndNSQuestionUseCase.execute();
    } else if (index == 2) {
      isQuestionsExist = await isNPAndPSQuestionUseCase.execute();
    } else if (index == 3) {
      isQuestionsExist = await isNPAndNSQuestionUseCase.execute();
    }
    if (isQuestionsExist && questions.isEmpty) {
      screenStateNotifier.setLoading(false);
      showStyleCompletedCustomDialog(context, () {
        onResult();
      }, () {
        screenStateNotifier.setLoading(true);
        onTryAgain(
          screenState,
          getQuestionUseCase,
          storeQuestionsUseCase,
          questionNotifier,
          screenStateNotifier,
        );
      });
    } else {
      generateQuestionAndNavigate(
        questions.isEmpty,
        getQuestionUseCase,
        storeQuestionsUseCase,
        questionNotifier,
        screenStateNotifier,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenState = ref.watch(homeViewTypeProvider);
    final ctxt = context;
    final cards = ref.watch(homeScreenStylesProvider);

    return screenState["is_loading"]
        ? Center(
      child: CircularProgressIndicator(
        color: MColors().colorSecondaryBlueLight,
      ),
    )
        : SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.715,
      child: ListView.builder(
        itemCount: cards.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              onItemClicked(index, ctxt);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: ListStyleCard(
                  item: cards[index],
                  onClicked: () {
                    onItemClicked(index, ctxt);
                  }),
            ),
          );
        },
      ),
    );
  }
}