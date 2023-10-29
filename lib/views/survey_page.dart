import 'package:clovi_template/utils/color_utils.dart';
import 'package:clovi_template/views/components/bottom_button.dart';
import 'package:clovi_template/views/components/step_progress.dart';
import 'package:clovi_template/views/components/style_chip.dart';
import 'package:flutter/material.dart';

class SurveyPage extends StatefulWidget {
  const SurveyPage({super.key});
  @override
  _SurveyPageState createState() => _SurveyPageState();
}

class _SurveyPageState extends State<SurveyPage> {
  List<String> genders = ['여자', '남자'];
  List<String> ages = [
    '16-19',
    '20-24',
    '25-29',
    '30-34',
    '35-39',
    '40-44',
    '45-49'
  ];

  int tag = 1;
  List<String> tags = [];
  List<String> options = [
    '빈티지',
    '러블리',
    '귀여운',
    '힙한',
    '꾸안꾸',
    '아메카지',
    '디자이너',
    '모던',
    '스트릿',
    '클래식',
    '미니멀',
    '감성'
  ];

  String? selectedGender = '여자';
  String? selectedAge = '16-19';

  PageController _controller = PageController(initialPage: 0);
  double _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        _currentPage = _controller.page!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double fontSize = 70;

    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Padding(padding: const EdgeInsets.symmetric(vertical: 10)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: StepProgress(currentStep: _currentPage, steps: 3),
          ),
          Expanded(
            child: PageView(
              controller: _controller,
              children: [
                Column(children: [
                  Padding(padding: const EdgeInsets.symmetric(vertical: 10)),
                  Container(
                    width: screenWidth,
                    alignment: Alignment.center,
                    child: const Text("성별 입력",
                        style: TextStyle(
                            fontSize: 17.95,
                            color: Colors.black,
                            fontWeight: FontWeight.w700)),
                  ),
                  Padding(padding: const EdgeInsets.symmetric(vertical: 10)),
                  Container(
                      width: screenWidth,
                      alignment: Alignment.center,
                      child: const Text.rich(
                          TextSpan(text: "성별을 입력하고 내 성별의", children: <TextSpan>[
                            TextSpan(text: "\n인기 쇼츠를 시청해보세요.")
                          ]),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 11.47,
                              color: Color.fromARGB(255, 177, 177, 177)))),
                  Padding(padding: const EdgeInsets.symmetric(vertical: 10)),
                  Container(
                      child: DropdownButton<String>(
                    value: selectedGender,
                    underline: const SizedBox(),
                    iconSize: 0.0,
                    itemHeight: screenHeight * 0.15,
                    alignment: Alignment.center,
                    style: TextStyle(
                        fontSize: 70,
                        fontWeight: FontWeight.w900,
                        color: Colors.black),
                    items: genders
                        .map((gender) => DropdownMenuItem<String>(
                              value: gender,
                              child: Text(gender),
                            ))
                        .toList(),
                    onChanged: (gender) =>
                        setState(() => selectedGender = gender),
                  )),
                  Padding(padding: const EdgeInsets.symmetric(vertical: 10)),
                  Container(
                    width: screenWidth * 0.7,
                    alignment: Alignment.center,
                    child: const Text.rich(
                        TextSpan(
                          text: "성별을 입력하시면 ",
                          children: <TextSpan>[
                            TextSpan(
                              text: "개인정보 수집이용에",
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                              ),
                            ),
                            TextSpan(
                              text: " \n동의하는 것으로 간주합니다.",
                            )
                          ],
                        ),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 11.47,
                            color: Color.fromARGB(255, 177, 177, 177))),
                  ),
                ]),
                Column(children: [
                  Padding(padding: const EdgeInsets.symmetric(vertical: 10)),
                  Container(
                    width: screenWidth,
                    alignment: Alignment.center,
                    child: const Text("나이 입력",
                        style: TextStyle(
                            fontSize: 17.95,
                            color: Colors.black,
                            fontWeight: FontWeight.w700)),
                  ),
                  Padding(padding: const EdgeInsets.symmetric(vertical: 10)),
                  Container(
                      width: screenWidth,
                      alignment: Alignment.center,
                      child: const Text.rich(
                          TextSpan(
                              text: "나이를 입력하고 내 연령대의",
                              children: <TextSpan>[
                                TextSpan(text: "\n인기 쇼츠를 시청해보세요.")
                              ]),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 11.47,
                              color: Color.fromARGB(255, 177, 177, 177)))),
                  SizedBox(
                      height: screenHeight * 0.2,
                      width: screenWidth * 0.3,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 16),
                        child: TextFormField(
                          style: TextStyle(
                              fontSize: 70,
                              fontWeight: FontWeight.w800,
                              color: CalicoColors.representBlack),
                          textAlign: TextAlign.center,
                          decoration: const InputDecoration(
                              border: UnderlineInputBorder(),
                              hintText: '20',
                              hintStyle: TextStyle(
                                  fontSize: 70,
                                  fontWeight: FontWeight.w800,
                                  color: Color.fromARGB(255, 177, 177, 177))),
                        ),
                      )),
                  Container(
                    width: screenWidth * 0.7,
                    alignment: Alignment.center,
                    child: const Text.rich(
                        TextSpan(
                          text: "나이를 입력하시면 ",
                          children: <TextSpan>[
                            TextSpan(
                              text: "개인정보 수집이용에",
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                              ),
                            ),
                            TextSpan(
                              text: " \n동의하는 것으로 간주합니다.",
                            )
                          ],
                        ),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 11.47,
                            color: Color.fromARGB(255, 177, 177, 177))),
                  ),
                ]),
                Column(
                  children: [
                    Padding(padding: const EdgeInsets.symmetric(vertical: 10)),
                    Container(
                      width: screenWidth,
                      alignment: Alignment.center,
                      child: const Text("스타일 선택",
                          style: TextStyle(
                              fontSize: 17.95,
                              color: Colors.black,
                              fontWeight: FontWeight.w700)),
                    ),
                    Padding(padding: const EdgeInsets.symmetric(vertical: 10)),
                    Container(
                        width: screenWidth,
                        alignment: Alignment.center,
                        child: const Text.rich(
                            TextSpan(
                                text: "내가 좋아하거나 닮아가고 싶은",
                                children: <TextSpan>[
                                  TextSpan(text: "\n분위기를 선택해보세요.")
                                ]),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 11.47,
                                color: Color.fromARGB(255, 177, 177, 177)))),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: StyleChips(),
                    ),
                  ],
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: BottomButtons(pageController: _controller),
          ),
          Padding(padding: const EdgeInsets.symmetric(vertical: 10))
        ],
      ),
    );
  }
}
