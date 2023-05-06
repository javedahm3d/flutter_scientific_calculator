import 'package:calculator/buttons.dart';
import 'package:calculator/calculations.dart';
import 'package:calculator/gloabl.dart';
// import 'package:calculator/gloabl.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

import 'gloabl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var input = '';
  var inputdisp = '';

  var answer = '';
  bool isINVTapped = false;
  late ScrollController _controller;
  bool isAnswer = false;
  bool isFunc = false;
  bool isErr = false;
  bool isClear = false;
  int bracketCount = 0;
  String lastIn = '';
  String msg = '';
  final List<String> functions1 = [
    'INV',
    'RAD',
    'sin',
    'cos',
    'tan',
    'ln',
    '%',
    'log',
    '!',
    '^',
    'π',
    'x²',
    '(',
    ')',
    '√'
  ];

  final List<String> functions2 = [
    'INV',
    'RAD',
    'sin-¹',
    'cos-¹',
    'tan-¹',
    'abs',
    '%',
    'log',
    '!',
    '^',
    'x²',
    'e',
    '(',
    ')',
    '√'
  ];
  final List<String> mainButtons = [
    '7',
    '8',
    '9',
    '÷',
    '⌫',
    '4',
    '5',
    '6',
    '×',
    'C',
    '1',
    '2',
    '3',
    '-',
    ' ',
    '.',
    '0',
    ' ',
    '+',
    '='
  ];

  bool get isDEg => isDegree;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = ScrollController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    _controller.dispose();
  }

  bool isNumeric(String s) => s != null && double.tryParse(s) != null;

  @override
  Widget build(BuildContext context) {
    setState(() {
      //scroll controller
      if (input.length >= 5) {
        _controller.jumpTo(_controller.position.maxScrollExtent);
      }
    });
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 23, 23, 23),
      appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 23, 23, 23),
          title: Text(
            isDEg ? 'DEG' : 'RAD',
            style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w400),
          ),
          actions: [
            PopupMenuButton(
                color: Colors.grey.shade900,
                icon: Icon(
                  Icons.more_vert,
                  color: Colors.grey,
                ),
                itemBuilder: (BuildContext c) => [
                      PopupMenuItem(
                          child: Text(
                        'new functionalities will be added here in next update',
                        style: TextStyle(color: Colors.grey),
                      ))
                    ]),
          ]),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          //input and output diplay
          Expanded(
            flex: 3,
            child: DefaultTextStyle(
              style: TextStyle(
                  letterSpacing: 1.5, color: Colors.white, fontSize: 60),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Expanded(flex: 1, child: Container()),
                  Expanded(
                    flex: 1,
                    child: SingleChildScrollView(
                      controller: _controller,
                      child: SizedBox(
                          child: input.length <= 10
                              ? Text(
                                  input,
                                  softWrap: true,
                                  style: TextStyle(
                                      fontSize: isAnswer ? 35 : 60,
                                      color: isAnswer
                                          ? Colors.grey
                                          : Colors.white),
                                )
                              : (input.length <= 13
                                  ? Text(
                                      input,
                                      softWrap: true,
                                      style: TextStyle(
                                          fontSize: isAnswer ? 35 : 52,
                                          color: isAnswer
                                              ? Colors.grey
                                              : Colors.white),
                                    )
                                  : Text(
                                      input,
                                      softWrap: true,
                                      style: TextStyle(
                                          fontSize: 35,
                                          color: isAnswer
                                              ? Colors.grey
                                              : Colors.white),
                                    ))),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          isErr
                              ? SizedBox()
                              : Text(
                                  answer,
                                  style: TextStyle(
                                      fontSize: isAnswer
                                          ? (answer.length > 15 ? 60 : 50)
                                          : 40,
                                      color: isAnswer
                                          ? Colors.white
                                          : Colors.grey),
                                ),
                          SizedBox(
                            child: isErr
                                ? Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      msg,
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.grey.shade400),
                                    ),
                                  )
                                : null,
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),

          // upper grey functions
          Container(
              height: MediaQuery.of(context).size.height * 0.22,
              child: Container(
                color: Colors.blueGrey,
                child: GridView.builder(
                  padding: EdgeInsets.all(0),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 1.3,
                      crossAxisCount: 5,
                      mainAxisSpacing: 0,
                      crossAxisSpacing: 0),
                  itemCount: functions1.length,
                  itemBuilder: (context, index) {
                    //inv button funtion
                    if (index == 0) {
                      return Container(
                        color: isINVTapped
                            ? Colors.lightBlueAccent
                            : Color.fromARGB(255, 136, 165, 188),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              isINVTapped = !isINVTapped;
                            });
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                              child: Center(
                                  child: Text(
                                'INV',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 28,
                                    fontWeight: FontWeight.w400),
                              )),
                            ),
                          ),
                        ),
                      );
                    }

// RAD -> DEGREE
                    if (index == 1) {
                      return Container(
                        color: Colors.blueGrey,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              isDegree = !isDEg;
                              if (isFunc) {
                                answer = calculations('$input)');
                              } else {
                                answer = calculations(input);
                              }
                            });
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                              child: Center(
                                  child: Text(
                                isDEg ? 'RAD' : 'DEG',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 28,
                                    fontWeight: FontWeight.w400),
                              )),
                            ),
                          ),
                        ),
                      );
                    }

                    if (isINVTapped) {
                      //'sin-¹','cos-¹','tan-¹',
                      return MyButtons(
                        buttonText: functions2[index],
                        buttonsTapped: () {
                          setState(() {
                            if (index == 2) {
                              input += 'sin-¹(';

                              isFunc = true;
                              bracketCount += 1;
                            } else if (index == 3) {
                              input += 'cos-¹(';

                              isFunc = true;
                              bracketCount += 1;
                            } else if (index == 4) {
                              input += 'tan-¹(';

                              isFunc = true;
                              bracketCount += 1;
                            } else if (index == 13) {
                              input += ')';
                              isFunc = false;
                              if (bracketCount > 0) {
                                bracketCount -= 1;
                              }
                            } else if (index == 12) {
                              input += '(';
                              isFunc = true;
                              bracketCount += 1;
                            } else if (index == 5) {
                              if (answer[0] == '-') {
                                input = answer.substring(1);
                                answer = '';
                              }
                            } else if (index == 7) {
                              if (input.isNotEmpty) {
                                lastIn = input[input.length - 1];
                                if (isNumeric(lastIn) || lastIn == ')') {
                                  input += '×log(';
                                } else {
                                  input += 'log(';
                                }
                              } else {
                                input += 'log(';
                              }
                              answer = calculations(input);

                              isFunc = true;
                              bracketCount += 1;
                            } else if (index == 10) {
                              input += '^2';
                            } else if (index == 11) {
                              if (input.isNotEmpty) {
                                lastIn = input[input.length - 1];
                                if (isNumeric(lastIn) || lastIn == ')') {
                                  input += '×e';
                                } else {
                                  input += 'e';
                                }
                              } else {
                                input += 'e';
                              }
                              answer = calculations(input);
                            } else {
                              input += functions1[index];
                            }
                            if (isClear) {
                              msg = '';
                              answer = '';
                              input = '';
                            }
                            if (input.isNotEmpty &&
                                    isNumeric(input[input.length - 1]) ||
                                (input[input.length - 1] == '!')) {
                              try {
                                if (isFunc == true) {
                                  answer = calculations(input + ')');
                                } else {
                                  answer = calculations(input);
                                }

                                if (answer.endsWith('err')) {
                                  msg = answer.substring(0, answer.length - 4);
                                  answer =
                                      answer.substring(0, answer.length - 4);

                                  isErr = true;
                                } else {
                                  isErr = false;
                                  msg = '';
                                }
                              } catch (e) {
                                print(e);
                              }
                            }
                          });
                        },
                      );
                    }

                    //sin cos tan ln
                    else {
                      return MyButtons(
                        buttonText: functions1[index],
                        buttonsTapped: () {
                          setState(() {
                            if (index == 2) {
                              if (input.isNotEmpty) {
                                lastIn = input[input.length - 1];
                                if (isNumeric(lastIn) || lastIn == ')') {
                                  input += '×sin(';
                                } else {
                                  input += 'sin(';
                                }
                              } else {
                                input += 'sin(';
                              }

                              isFunc = true;
                            } else if (index == 3) {
                              if (input.isNotEmpty) {
                                lastIn = input[input.length - 1];
                                if (isNumeric(lastIn) || lastIn == ')') {
                                  input += '×cos(';
                                } else {
                                  input += 'cos(';
                                }
                              } else {
                                input += 'cos(';
                              }

                              isFunc = true;
                            } else if (index == 4) {
                              if (input.isNotEmpty) {
                                lastIn = input[input.length - 1];
                                if (isNumeric(lastIn) || lastIn == ')') {
                                  input += '×tan(';
                                } else {
                                  input += 'tan(';
                                }
                              } else {
                                input += 'tan(';
                              }

                              isFunc = true;
                            } else if (index == 13) {
                              input += ')';
                              isFunc = false;
                            } else if (index == 12) {
                              if (input.isNotEmpty) {
                                lastIn = input[input.length - 1];
                                if (isNumeric(lastIn) || lastIn == ')') {
                                  input += '×(';
                                } else {
                                  input += '(';
                                }
                              } else {
                                input += '(';
                              }
                              isFunc = true;
                            } else if (index == 5) {
                              if (input.isNotEmpty) {
                                lastIn = input[input.length - 1];
                                if (isNumeric(lastIn) || lastIn == ')') {
                                  input += '×ln(';
                                } else {
                                  input += 'ln(';
                                }
                              } else {
                                input += 'ln(';
                              }
                              isFunc = true;
                            } else if (index == 7) {
                              if (input.isNotEmpty) {
                                lastIn = input[input.length - 1];
                                if (isNumeric(lastIn) || lastIn == ')') {
                                  input += '×log(';
                                } else {
                                  input += 'log(';
                                }
                              } else {
                                input += 'log(';
                              }
                              isFunc = true;
                            } else if (index == 10) {
                              if (input.isNotEmpty) {
                                lastIn = input[input.length - 1];
                                if (isNumeric(lastIn) || lastIn == ')') {
                                  input += '×π';
                                } else {
                                  input += 'π';
                                }
                              } else {
                                input += 'π';
                              }
                              answer = calculations(input);
                            } else if (index == 11) {
                              input += '^2';
                            } else {
                              input += functions1[index];
                            }
                            if (isClear) {
                              msg = '';
                              answer = '';
                              input = '';
                            }
                            if (input.isNotEmpty &&
                                    isNumeric(input[input.length - 1]) ||
                                (input[input.length - 1] == '!')) {
                              try {
                                if (isFunc == true) {
                                  answer = calculations(input + ')');
                                } else {
                                  answer = calculations(input);
                                }

                                if (answer.endsWith('err')) {
                                  msg = answer.substring(0, answer.length - 4);
                                  answer =
                                      answer.substring(0, answer.length - 4);

                                  isErr = true;
                                } else {
                                  isErr = false;
                                  msg = '';
                                }
                              } catch (e) {
                                print(e);
                              }
                            }
                          });
                        },
                      );
                    }
                  },
                ),
              )),

          // main butons
          Container(
              height: MediaQuery.of(context).size.height * 0.4,
              child: Container(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 0.96,
                      crossAxisCount: 5,
                      mainAxisSpacing: 0,
                      crossAxisSpacing: 0),
                  itemCount: mainButtons.length,
                  itemBuilder: (context, index) {
                    return MyButtons(
                      buttonText: mainButtons[index],
                      textsize: 50,
                      buttonsTapped: () {
                        setState(() {
                          if (index == 4) {
                            if (input.endsWith('sin(') ||
                                input.endsWith('cos(') ||
                                input.endsWith('tan(') ||
                                input.endsWith('log(')) {
                              input = input.substring(0, input.length - 4);
                            } else if (input.endsWith('sin-¹(') ||
                                input.endsWith('cos-¹(') ||
                                input.endsWith('tan-¹(')) {
                              input = input.substring(0, input.length - 6);
                            } else if (input.endsWith('ln(')) {
                              input = input.substring(0, input.length - 3);
                            } else {
                              input = input.substring(0, input.length - 1);
                            }
                            if (input.isEmpty) {
                              answer = '';
                            }
                            isFunc = false;
                          } else if (index == 9) {
                            isClear = true;
                            input = '';
                            msg = '';
                            answer = '';
                            isFunc = false;
                            isClear = false;
                          } else if (index == 15) {
                            if (input.isNotEmpty) {
                              if (isNumeric(input[input.length - 1])) {
                                input += '.';
                              } else {
                                input += '0.';
                              }
                            } else {
                              input += '0.';
                            }
                          } else if (index == mainButtons.length - 1) {
                            setState(() {
                              if (isFunc == true) {
                                isFunc = false;
                                input += ')';
                              }
                              // isAnswer = input.isEmpty ? false : true;
                              if (isNumeric(answer)) {
                                input = calculations(input);
                                answer = '';
                              } else if (answer.endsWith("err")) {
                                msg = answer.substring(0, answer.length - 4);
                                answer = '';

                                //  for ementerr error
                                if (msg == 'emen') {
                                  msg = '';
                                  answer = '';
                                }

                                isErr = true;
                              } else {
                                isErr = false;
                              }
                            });
                          } else {
                            input += mainButtons[index];

                            isAnswer = false;
                          }

                          if (input.isNotEmpty &&
                              isNumeric(input[input.length - 1])) {
                            try {
                              if (isFunc == true) {
                                answer = calculations(input + ')');
                              } else {
                                answer = calculations(input);
                              }
                              if (answer.endsWith('err')) {
                                msg = answer.substring(0, answer.length - 4);
                                answer = msg;

                                isErr = true;
                              } else {
                                isErr = false;
                                msg = '';
                              }
                            } catch (e) {
                              print(e);
                            }
                          }
                        });
                      },
                    );
                  },
                ),
              ))
        ],
      ),
    );
  }
}
