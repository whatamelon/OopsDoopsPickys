import 'package:dropdown_below/dropdown_below.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:explore/widgets/responsive.dart';

import '../widgets/web_scrollbar.dart';


class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  ScrollController _scrollController2;
  TextEditingController _textEditingController;
  double _scrollPosition = 0;
  double _opacity = 0;
  String _userEmail = '';
  
//  var selectedRange = RangeValues(21, 32);
  String _ratingTop = '44';
  double _ratingTop2 = 1;
  double _ratingPants = 21;

  List _topList = [
    {'no': 1, 'keyword': '44'},
    {'no': 2, 'keyword': '44반'},
    {'no': 3, 'keyword': '55'},
    {'no': 4, 'keyword': '55반'},
    {'no': 5, 'keyword': '66'},
    {'no': 6, 'keyword': '66반'},
    {'no': 7, 'keyword': '77'},
    {'no': 8, 'keyword': '77반'},
    {'no': 9, 'keyword': '88'},
    {'no': 10, 'keyword': '88반'},
    {'no': 11, 'keyword': '99'},
    {'no': 12, 'keyword': '100'},
    {'no': 13, 'keyword': '110'}
  ];
  List<DropdownMenuItem> _dropdownTopItems;
  var _selectedTop;

  _scrollListener() {
    setState(() {
      _scrollPosition = _scrollController2.position.pixels;
    });
  }

  @override
  void initState() {
    _dropdownTopItems = buildDropdownItems(_topList);
    _textEditingController = TextEditingController();
    _scrollController2 = ScrollController();
    _scrollController2.addListener(_scrollListener);
    super.initState();
  }

  List<DropdownMenuItem> buildDropdownItems(List _testList) {
    List<DropdownMenuItem> items = List();
    for (var i in _testList) {
      items.add(
        DropdownMenuItem(
          value: i,
          child: Text(i['keyword']),
        ),
      );
    }
    return items;
  }

  onChangeDropdownTop(selectedTest) {
    print(selectedTest);
    setState(() {
      _selectedTop = selectedTest;
    });
  }

  Future<bool> _navigatePop() async{
    print('하아위~');
    return false;
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    _opacity = _scrollPosition < screenSize.height * 0.40
        ? _scrollPosition / (screenSize.height * 0.40)
        : 1;

    return WillPopScope(
      onWillPop:() async => _navigatePop(),
      child: Scaffold(
        appBar:  AppBar(
          backgroundColor:
          Theme.of(context).bottomAppBarColor.withOpacity(_opacity),
          elevation: 0,
          centerTitle: true,
          leading: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Icon(Icons.arrow_back_ios, color: Colors.red,)),
          actions: [
            IconButton(
              icon: Icon(Icons.brightness_6),
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onPressed: () {
                DynamicTheme.of(context).setBrightness(
                    Theme.of(context).brightness == Brightness.dark
                        ? Brightness.light
                        : Brightness.dark);
                print(Theme.of(context).brightness);
              },
            ),
          ],
          title: Text(
            '픽키 회원가입',
            style: TextStyle(
              color: Colors.blueGrey[700],
              fontSize: 20,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w400,
              letterSpacing: 3,
            ),
          ),
        ),
        body: _buildBody(screenSize),
      ),
    );
  }

 Widget _buildBody(screenSize) {
    return  SingleChildScrollView(
        controller: _scrollController2,
        physics: ClampingScrollPhysics(),
        child: Container(
          width: screenSize.width,
          padding: EdgeInsets.fromLTRB(screenSize.width*0.4, screenSize.height*0.05, screenSize.width*0.3, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('이메일'),
              SizedBox(height: 10,),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: screenSize.width * 0.2,
                      child: TextField(
                        onSubmitted: (value) {
                          print(value);
                          setState(() {
                            _userEmail = value;
                          });
                        },
                        controller: _textEditingController,
                        decoration: InputDecoration(
                            labelText: "이메일을 적어주세요.",
                            hintText: "user@email.com",
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black) //This is Ignored
                            )
                        ),
                      ),
                    ),
                    FlatButton(
                        onPressed: () {
                          setState(() {
                            _userEmail = _textEditingController.text;
                          });
                        },
                        child: Text('클릭!')
                    ),
                  ],
                ),
              ),
              Container(
                  child: Text('$_userEmail')
              ),
              SizedBox(height: 20,),
              Container(child: Text('상의')),
              SizedBox(height: 10,),
              Container(
                width: screenSize.width * 0.2,
                child: DropdownBelow(
                  itemWidth: screenSize.width * 0.2,
                  itemTextstyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black),
                  boxTextstyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Color(0XFFbbbbbb)),
                  boxPadding: EdgeInsets.fromLTRB(13, 12, 0, 12),
                  boxHeight: 45,
                  hint: Text('상의 사이즈를 선택해주세요.'),
                  value: _selectedTop,
                  items: _dropdownTopItems,
                  onChanged: onChangeDropdownTop,
                ),
              ),
            ],
          ),
        )
      );
 }
}
