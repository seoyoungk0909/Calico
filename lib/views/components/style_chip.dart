import 'package:flutter/material.dart';
import 'package:clovi_template/utils/color_utils.dart';

enum StyleFilter {
  vintage('빈티지'),
  lovely('러블리'),
  cute('귀여운'),
  hip('힙한'),
  qaq('꾸안꾸'),
  amecage('아메카지'),
  designer('디자이너'),
  modern('모던'),
  street('스트릿'),
  classic('클래식'),
  minimal('미니멀'),
  vibe('감성');

  final String desc;
  const StyleFilter(this.desc);
}

class StyleChips extends StatefulWidget {
  const StyleChips({super.key});

  @override
  State<StyleChips> createState() => _StyleChipsExampleState();
}

class _StyleChipsExampleState extends State<StyleChips> {
  Set<StyleFilter> filters = <StyleFilter>{};

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
        width: screenWidth * 0.8,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 5.0,
              children: StyleFilter.values.map((StyleFilter tag) {
                return FilterChip(
                    backgroundColor: Colors.transparent,
                    selectedColor: CalicoColors.representBlack,
                    checkmarkColor: Color.fromARGB(255, 177, 177, 177),
                    shape: StadiumBorder(
                        side: BorderSide(
                            color: Color.fromARGB(255, 177, 177, 177),
                            width: 1)),
                    label: Text(tag.desc,
                        style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: Color.fromARGB(255, 177, 177, 177))),
                    selected: filters.contains(tag),
                    onSelected: (bool selected) {
                      setState(() {
                        if (selected) {
                          filters.add(tag);
                        } else {
                          filters.remove(tag);
                        }
                      });
                    });
              }).toList(),
            ),
            Padding(padding: const EdgeInsets.symmetric(vertical: 10)),
            const SizedBox(height: 10.0),
            Text(
                'Looking for: ${filters.map((StyleFilter s) => s.desc).join(', ')}',
                style: TextStyle(
                    color: CalicoColors.representOrange, fontSize: 11.5))
          ],
        ));
  }
}
