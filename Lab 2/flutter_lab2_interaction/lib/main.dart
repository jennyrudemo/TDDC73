import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_credit_card/credit_card_brand.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:dropdown_date_picker/dropdown_date_picker.dart';
import 'package:provider/provider.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Credit card interaction'),
    );
  }
}

class MyHomePage extends StatefulWidget with ChangeNotifier {
  MyHomePage({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with ChangeNotifier {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  bool useGlassMorphism = false;
  bool useBackgroundImage = false;
  OutlineInputBorder? border;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String cvvHint = 'XXX';

  bool _isAmex = false;
  //bool get isAmex => _isAmex; //necessary?
  String expiryDateText = "MM/YY";

  //_MyHomePageState.instance();

  void changeAmexStatus(bool status) {
    _isAmex = status;
    notifyListeners();
  }

  void changeExpiryDate(DateTime date) {
    String month = date.month.toString();
    String year =
        date.year.toString().replaceFirst('20', ''); //remove first two digits
    expiryDateText = "$month/$year";
    notifyListeners();
  }

  @override
  void initState() {
    border = OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.grey.withOpacity(0.7),
        width: 2.0,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizedBox cvvBox(bool amexStatus) {
      return SizedBox(
        width: MediaQuery.of(context).size.width * 0.3,
        child: TextFormField(
          obscureText: true,
          decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'CVV',
              hintText: amexStatus ? 'XXXX' : 'XXX'),
          maxLength: amexStatus ? 4 : 3,
          maxLengthEnforcement: MaxLengthEnforcement.enforced,
          onChanged: (value) {
            setState(() {
              cvvCode = value;
            });
          },
          onTap: () {
            setState(() {
              //flips the card
              isCvvFocused = true;
            });
          },
        ),
      );
    }

    DateTime selectedDate = DateTime.now(); //initial date

    return ChangeNotifierProvider<_MyHomePageState>(
        create: (context) => _MyHomePageState(),
        builder: (context, child) {
          return Scaffold(
            appBar: AppBar(
              title: Text(widget.title),
            ),
            //Fixes the problem with overflow and not seeing the bottom input fields
            body: SingleChildScrollView(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CreditCardWidget(
                      cardNumber: cardNumber,
                      expiryDate: expiryDateText,
                      cardHolderName: cardHolderName,
                      cvvCode: cvvCode,
                      showBackView:
                          isCvvFocused, //true when you want to show cvv(back) view
                      backgroundImage: 'images/21.jpeg',
                      obscureCardCvv: false,
                      obscureCardNumber: false,
                      isHolderNameVisible: true,
                      isChipVisible: true,
                      onCreditCardWidgetChange:
                          (CreditCardBrand creditCardBrand) {},
                      customCardTypeIcons: [
                        // Mastercard
                        CustomCardTypeIcon(
                          cardType: CardType.mastercard,
                          cardImage: Image.asset(
                            'images/mastercard.png',
                            height: 48,
                            width: 48,
                          ),
                        ),
                        // Amex
                        CustomCardTypeIcon(
                          cardType: CardType.americanExpress,
                          cardImage: Image.asset(
                            'images/amex.png',
                            height: 48,
                            width: 48,
                          ),
                        ),
                        // Discover
                        CustomCardTypeIcon(
                          cardType: CardType.discover,
                          cardImage: Image.asset(
                            'images/discover.png',
                            height: 48,
                            width: 48,
                          ),
                        ),
                        // Visa
                        CustomCardTypeIcon(
                          cardType: CardType.visa,
                          cardImage: Image.asset(
                            'images/visa.png',
                            height: 48,
                            width: 48,
                          ),
                        ),
                      ],
                    ),

                    //Number field
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                      child: TextFormField(
                        obscureText: false,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Number',
                          hintText: 'XXXX XXXX XXXX XXXX',
                        ),
                        //Shows the correct keyboard type
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                        ],
                        maxLength: 16,
                        //Ensure max length is kept
                        maxLengthEnforcement: MaxLengthEnforcement.enforced,
                        onChanged: (value) {
                          setState(() {
                            cardNumber = value;
                            //Check if the card is of brand American Express
                            if (cardNumber.startsWith('34') ||
                                cardNumber.startsWith('37')) {
                              context
                                  .read<_MyHomePageState>()
                                  .changeAmexStatus(true);
                            } else {
                              context
                                  .read<_MyHomePageState>()
                                  .changeAmexStatus(false);
                            }
                          });
                        },
                        //make sure credit card flips
                        onTap: () {
                          setState(() {
                            isCvvFocused = false;
                          });
                        },
                      ),
                    ),

                    //Date picker
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          OutlinedButton(
                            child: Selector<_MyHomePageState, String>(
                                selector: (_, notifier) =>
                                    notifier.expiryDateText,
                                builder: (_, value, __) => Text(
                                    "$expiryDateText",
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 16.0))),
                            onPressed: () {
                              //Flips card
                              setState(() {
                                isCvvFocused = false;
                              });
                              showMonthPicker(
                                context: context,
                                firstDate: DateTime.now(),
                                initialDate: DateTime.now(),
                              ).then((date) {
                                if (date != null) {
                                  setState(() {
                                    selectedDate = date;
                                    changeExpiryDate(selectedDate);
                                  });
                                }
                              });
                            },
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(width: 1.0, color: Colors.grey),
                              fixedSize: Size(
                                  MediaQuery.of(context).size.width * 0.6, 60),
                            ),
                          ),
                          //CVV field
                          Selector<_MyHomePageState, bool>(
                              selector: (_, notifier) => notifier._isAmex,
                              builder: (_, value, __) => cvvBox(value)),
                        ],
                      ),
                    ),

                    //Cardholder
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                      child: TextFormField(
                        obscureText: false,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Card Holder',
                        ),
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(
                              RegExp("[a-z A-Z]")),
                        ],
                        onChanged: (value) {
                          setState(() {
                            cardHolderName = value;
                          });
                        },
                        //make sure credit card flips
                        onTap: () {
                          setState(() {
                            isCvvFocused = false;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
