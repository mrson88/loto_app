import 'package:checkbox_grouped/checkbox_grouped.dart';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loto_app/screens/register_page.dart';
import 'package:loto_app/screens/todo_list.dart';
import 'package:loto_app/widget/constant.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _AuthPageState();
}

class _AuthPageState extends State<HomePage> {
  bool isLoading = true;
  String userToken = '';
  List items = [];
  TextEditingController textController = TextEditingController();
  String values = '';

  GroupController controller = GroupController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Check Lô Xiên'),
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  'assets/images/background_img/anh gai.png',
                ),
                fit: BoxFit.cover)),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                nInputDecoration(
                    text: 'Nhập lô', obs: false, controller: textController),
                CustomRadioButton(
                  enableShape: true,
                  autoWidth: false,
                  width: 60,
                  shapeRadius: 20,
                  padding: 10,
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  elevation: 0,
                  absoluteZeroSpacing: true,
                  unSelectedColor: Theme.of(context).canvasColor,
                  buttonLables: [
                    'X2',
                    'X3',
                    'X4',
                  ],
                  buttonValues: [
                    "2",
                    "3",
                    "4",
                  ],
                  buttonTextStyle: ButtonTextStyle(
                      selectedColor: Colors.white,
                      unSelectedColor: Colors.black,
                      textStyle: TextStyle(fontSize: 16)),
                  radioButtonValue: (value) {
                    print(value);

                    values = value;
                  },
                  selectedColor: Theme.of(context).colorScheme.secondary,
                ),
                SizedBox(
                  width: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          items = [];
                          setState(() {
                            items = submitText();
                            hideKeyboard();
                          });

                          print(items[0].length);
                        },
                        child: Text("Nhập")),
                    SizedBox(
                      width: 20,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          List copy = [];
                          print('itemlength=${items.length}');
                          print('item=${items}');

                          for (var i = 0; i <= items.length - 1; i++) {
                            for (var j = 0; j <= items[i].length - 1; j++) {
                              if (j == (items[i].length - 1)) {
                                items[i][j] = '${items[i][j]}/';
                              }
                              copy.add(items[i][j]);
                            }
                          }
                          String copyAll = copy.toString();
                          String witoutEquals = copyAll
                              .replaceAll('[', '')
                              .replaceAll('/]', '')
                              .replaceAll('/,', ' ');

                          Clipboard.setData(ClipboardData(text: witoutEquals));
                          print(items.length);
                          print(copyAll);
                          print(witoutEquals);
                        },
                        child: Text("Copy")),
                  ],
                ),
                Container(
                  child: Text(
                    'Tổng số=${items.length}',
                    style: TextStyle(fontSize: 30, color: Colors.black),
                  ),
                ),
                Wrap(
                  direction: Axis.horizontal,
                  children: List.generate(items.length, (index) {
                    return Card(
                      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                      color: Colors.red,
                      child: Text(
                        '${items[index].toString().replaceAll('[', '').replaceAll(']', '')}',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                        maxLines: 5,
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List submitText() {
    List items = [];
    print(values);
    List item = textController.text.split(',');
    for (var i = 0; i <= item.length - 1; i++) {
      if (int.parse(item[i]) < 10) {
        item[i] = '0${item[i]}';
      }
    }
    print(item);
    if (values == '2') {
      for (var i = 0; i <= item.length - 1; i++) {
        for (var j = i + 1; j <= item.length - 1; j++) {
          items.add([item[i], item[j]]);
        }
      }
    }
    if (values == '3') {
      for (var i = 0; i <= item.length - 1; i++) {
        for (var j = i + 1; j <= item.length - 1; j++) {
          for (var k = j + 1; k <= item.length - 1; k++) {
            items.add([item[i], item[j], item[k]]);
          }
        }
      }
    }
    if (values == '4') {
      for (var i = 0; i <= item.length - 1; i++) {
        for (var j = i + 1; j <= item.length - 1; j++) {
          for (var k = j + 1; k <= item.length - 1; k++) {
            for (var l = k + 1; l <= item.length - 1; l++)
              items.add([item[i], item[j], item[k], item[l]]);
          }
        }
      }
    }

    print(items.length);
    print(items);

    //Get the data from form
    // print(textController.text);
    // print(item);
    //Submit data to the server
    //show success
    return items;
  }

  void navigateToAddPage() {
    setState(() {
      isLoading = true;
    });
    final route = MaterialPageRoute(
        builder: (context) => TodoListPage(userToken: userToken));
    Navigator.push(context, route);
  }

  void navigateToRegisterPage() {
    setState(() {
      isLoading = true;
    });
    final route = MaterialPageRoute(builder: (context) => RegisterPage());
    Navigator.push(context, route);
  }

  void hideKeyboard() {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }
}
