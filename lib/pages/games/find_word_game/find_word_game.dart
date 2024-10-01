import 'dart:math';
import 'package:flutter/material.dart';
import 'package:word_search_safety/word_search_safety.dart';

class WordPuzzle extends StatefulWidget {
  const WordPuzzle({super.key});

  @override
  _WordPuzzleState createState() => _WordPuzzleState();
}

class _WordPuzzleState extends State<WordPuzzle> {
  GlobalKey<_WordPuzzleWidgetState> globalKey = GlobalKey();
  late List<WordPuzzleQuestionModel> ques;

  @override
  void initState() {
    super.initState();
    ques = [
      WordPuzzleQuestionModel(
        question: "What is name of this game?",
        answer: "mario",
        img:
            "https://images.pexels.com/photos/163077/mario-yoschi-figures-funny-163077.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
      ),
      WordPuzzleQuestionModel(
        question: "What is this animal?",
        answer: "cat",
        img:
            "https://images.pexels.com/photos/617278/pexels-photo-617278.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
      ),
      WordPuzzleQuestionModel(
        question: "What is this animal name?",
        answer: "wolf",
        img:
            "https://as1.ftcdn.net/v2/jpg/02/48/64/04/1000_F_248640483_5KAZi0GqcWrBu6GOhFEAxk1quNEuOzHJ.jpg",
      )
      // let me find online image 1st
    ];
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.green,
          child: Column(
            children: [
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return Container(
                      color: Colors.blue,
                      child: WordPuzzleWidget(
                        constraints.biggest,
                        ques.map((ques) => ques.clone()).toList(),
                        key: globalKey,
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                width: screenWidth,
                child: ElevatedButton(
                  style: Theme.of(context).elevatedButtonTheme.style?.copyWith(backgroundColor: const WidgetStatePropertyAll(Colors.green)),
                  onPressed: () {
                    globalKey.currentState!.puzzleGenerator(
                      loop: ques.map((ques) => ques.clone()).toList(),
                    );
                  },
                  child: const Text("reload"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

final WordSearchSafety wordSearch = WordSearchSafety();

class WordPuzzleWidget extends StatefulWidget {
  Size size;
  List<WordPuzzleQuestionModel> ques;
  WordPuzzleWidget(this.size, this.ques, {super.key});

  @override
  _WordPuzzleWidgetState createState() => _WordPuzzleWidgetState();
}

class _WordPuzzleWidgetState extends State<WordPuzzleWidget> {
  late Size size;
  late List<WordPuzzleQuestionModel> ques;
  int indexQues = 0; // current index question
  int hintCount = 0;


  @override
  void initState() {
    super.initState();
    size = widget.size;
    ques = widget.ques;
    puzzleGenerator();
  }

  @override
  Widget build(BuildContext context) {
    WordPuzzleQuestionModel currentQuestion = ques[indexQues];
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Icon(
                    Icons.healing_outlined,
                    size: 45,
                    color: Colors.yellow[200],
                  ),
                ),
                Row(
                  children: [
                    InkWell(
                      onTap: () => puzzleGenerator(left: true),
                      child: Icon(
                        Icons.arrow_back_ios,
                        size: 45,
                        color: Colors.yellow[200],
                      ),
                    ),
                    InkWell(
                      onTap: () => puzzleGenerator(next: true),
                      child: Icon(
                        Icons.arrow_forward_ios,
                        size: 45,
                        color: Colors.yellow[200],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
              child: Container(
                alignment: Alignment.center,
                constraints: BoxConstraints(
                  maxWidth: size.width / 2 * 1.5,
                ),
                child: Image.network(
                  currentQuestion.img,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            alignment: Alignment.center,
            child: Text(
              "${currentQuestion.question ?? ""}",
              style: const TextStyle(
                fontSize: 25,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
            alignment: Alignment.center,
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: currentQuestion.puzzles.map((puzzle) {
                    // later change color based condition
                    Color color;

                    if (currentQuestion.isDone) {
                      color = Colors.green;
                    } else if (puzzle.hintShow){
                      color = Colors.yellow;}

                    else if (currentQuestion.isFull)
                      {color = Colors.red;}
                    else
                      {color = const Color(0xff7EE7FD);}

                    return InkWell(
                      onTap: () {
                        if (puzzle.hintShow || currentQuestion.isDone) return;

                        currentQuestion.isFull = false;
                        puzzle.clearValue();
                        setState(() {});
                      },
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: color,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        width: constraints.biggest.width / 7 - 6,
                        height: constraints.biggest.width / 7 - 6,
                        margin: const EdgeInsets.all(3),
                        child: Text(
                          (puzzle.currentValue ?? '').toUpperCase(),
                          style: const TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          ),
          Container(
            // padding: const EdgeInsets.all(2),
            alignment: Alignment.center,
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 1.5,
                crossAxisCount: 4,
                crossAxisSpacing: 4,
                mainAxisSpacing: 4,
              ),
              itemCount: 16, 
              shrinkWrap: true,
              itemBuilder: (context, index) {
                bool statusBtn = currentQuestion.puzzles
                        .indexWhere((puzzle) => puzzle.currentIndex == index) >= 0;

                return LayoutBuilder(
                  builder: (context, constraints) {
                    Color color =
                        statusBtn ? Colors.white70 : const Color(0xff7EE7FD);

                    return Container(
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      // margin: ,
                      alignment: Alignment.center,
                      child: OutlinedButton(
                        child: Text(
                          "${currentQuestion.arrayBtns?[index]}".toUpperCase(),
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () {
                          if (!statusBtn) setBtnClick(index);
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void puzzleGenerator({
    List<WordPuzzleQuestionModel>? loop,
    bool next = false,
    bool left = false,
  }) {
    if (loop != null) {
      indexQues = 0;
      ques;
      ques.addAll(loop);
    } else {
      if (next && indexQues < ques.length - 1) {
        indexQues++;
      } else if (left && indexQues > 0){
        indexQues--;}
      else if (indexQues >= ques.length - 1){ return;}

      setState(() {});

      if (ques[indexQues].isDone) return;
    }

    WordPuzzleQuestionModel currentQuestion = ques[indexQues];

    setState(() {});

    final List<String> wl = [currentQuestion.answer];

    final WSSettings ws = WSSettings(
      width: 16, 
      height: 1,
      orientations: List.from([
        WSOrientation.horizontal,
      ]),
    );

    

    final WSNewPuzzle newPuzzle = wordSearch.newPuzzle(wl, ws);

    if (newPuzzle.errors!.isEmpty) {
      currentQuestion.arrayBtns = newPuzzle.puzzle!.expand((list) => list).toList();
      currentQuestion.arrayBtns?.shuffle(); 

      bool isDone = currentQuestion.isDone;

      if (!isDone) {
        currentQuestion.puzzles = List.generate(wl[0].split("").length, (index) {
          return WordPuzzleChar(
              correctValue: currentQuestion.answer.split("")[index]);
        });
      }
    }

    hintCount = 0;
    setState(() {});
  }

  hintGenerator() async {
    WordPuzzleQuestionModel currentQuestion = ques[indexQues];

    List<WordPuzzleChar> puzzleNoHints = currentQuestion.puzzles
        .where((puzzle) => !puzzle.hintShow && puzzle.currentIndex == null)
        .toList();

    if (puzzleNoHints.isNotEmpty) {
      hintCount++;
      int indexHint = Random().nextInt(puzzleNoHints.length);
      int countTemp = 0;
      currentQuestion.puzzles = currentQuestion.puzzles.map((puzzle) {
        if (!puzzle.hintShow && puzzle.currentIndex == null) countTemp++;

        if (indexHint == countTemp - 1) {
          puzzle.hintShow = true;
          puzzle.currentValue = puzzle.correctValue;
          puzzle.currentIndex = currentQuestion.arrayBtns
              ?.indexWhere((btn) => btn == puzzle.correctValue);
        }

        return puzzle;
      }).toList();


      if (currentQuestion.fieldCompleteCorrect()) {
        currentQuestion.isDone = true;

        setState(() {});

        await Future.delayed(const Duration(seconds: 1));
        puzzleGenerator(next: true);
      }

      setState(() {});
    }
  }

  Future<void> setBtnClick(int index) async {
    WordPuzzleQuestionModel currentQuestion = ques[indexQues];

    int currentIndexEmpty =
        currentQuestion.puzzles.indexWhere((puzzle) => puzzle.currentValue == null);

    if (currentIndexEmpty >= 0) {
      currentQuestion.puzzles[currentIndexEmpty].currentIndex = index;
      currentQuestion.puzzles[currentIndexEmpty].currentValue =
          currentQuestion.arrayBtns?[index];

      if (currentQuestion.fieldCompleteCorrect()) {
        currentQuestion.isDone = true;

        setState(() {});

        await Future.delayed(const Duration(seconds: 1));
        puzzleGenerator(next: true);
      }
      setState(() {});
    }
  }
}

class WordPuzzleQuestionModel {
  String question;
  String img;
  String answer;
  bool isDone = false;
  bool isFull = false;
  late List<WordPuzzleChar> puzzles;
  List<String>? arrayBtns;

  WordPuzzleQuestionModel({
    required this.img,
    required this.question,
    required this.answer,
    this.arrayBtns,
  });

  void setWordPuzzleChar(List<WordPuzzleChar> puzzles) => this.puzzles = puzzles;

  void setIsDone() => isDone = true;

  bool fieldCompleteCorrect() {

    bool complete =
        puzzles.where((puzzle) => puzzle.currentValue == null).isEmpty;

    if (!complete) {
      isFull = false;
      return complete;
    }

    isFull = true;

    String answeredString =
        puzzles.map((puzzle) => puzzle.currentValue).join("");
    return answeredString == answer;
  }

  WordPuzzleQuestionModel clone() {
    return WordPuzzleQuestionModel(
      answer: answer,
      img: img,
      question: question,
    );
  }
}

class WordPuzzleChar {
  String? currentValue;
  int? currentIndex;
  String correctValue;
  bool hintShow;

  WordPuzzleChar({
    this.hintShow = false,
    required this.correctValue,
    this.currentIndex,
    this.currentValue,
  });

  getCurrentValue() {
    return currentValue;
  }

  void clearValue() {
    currentIndex = null;
    currentValue = null;
  }
}
