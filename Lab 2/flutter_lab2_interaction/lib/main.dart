import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_brand.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';

void main() {
  runApp(MyApp());
}

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

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  bool useGlassMorphism = false;
  bool useBackgroundImage = false;
  OutlineInputBorder? border;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

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
                expiryDate: expiryDate,
                cardHolderName: cardHolderName,
                cvvCode: cvvCode,
                showBackView:
                    isCvvFocused, //true when you want to show cvv(back) view
                backgroundImage: 'images/21.jpeg',
                obscureCardCvv: false,
                obscureCardNumber: false,
                isHolderNameVisible: true,
                isChipVisible: true,
                onCreditCardWidgetChange: (CreditCardBrand creditCardBrand) {},
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
                  // Diners Club
                  /*CustomCardTypeIcon(
                    cardType: CardType.dinersclub,
                    cardImage: Image.asset(
                      'images/dinerclub.png',
                      height: 48,
                      width: 48,
                    ),
                  ),*/
                  // Discover
                  CustomCardTypeIcon(
                    cardType: CardType.discover,
                    cardImage: Image.asset(
                      'images/discover.png',
                      height: 48,
                      width: 48,
                    ),
                  ),
                  // JCB
                  // CustomCardTypeIcon(
                  //   cardType: CardType.jcb,
                  //   cardImage: Image.asset(
                  //     'images/jcb.png',
                  //     height: 48,
                  //     width: 48,
                  //   ),
                  // ),
                  // Troy
                  // CustomCardTypeIcon(
                  //   cardType: CardType.troy,
                  //   cardImage: Image.asset(
                  //     'images/troy.png',
                  //     height: 48,
                  //     width: 48,
                  //   ),
                  // ),
                  // Union Pay
                  // CustomCardTypeIcon(
                  //   cardType: CardType.unionpay,
                  //   cardImage: Image.asset(
                  //     'images/unionpay.png',
                  //     height: 48,
                  //     width: 48,
                  //   ),
                  // ),
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
              CreditCardForm(
                cardHolderName: cardHolderName,
                expiryDate: expiryDate,
                cardNumber: cardNumber,
                cvvCode: cvvCode,
                formKey: formKey, // Required
                onCreditCardModelChange: (CreditCardModel data) {
                  setState(() {
                    cardHolderName = data.cardHolderName;
                    cvvCode = data.cvvCode;
                    expiryDate = data.expiryDate;
                    cardNumber = data.cardNumber;
                    isCvvFocused = data.isCvvFocused;
                  });
                }, // Required
                themeColor: Colors.red,
                obscureCvv: true,
                obscureNumber: false,
                isHolderNameVisible: true,
                isCardNumberVisible: true,
                isExpiryDateVisible: true,
                cardNumberDecoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Number',
                  hintText: 'XXXX XXXX XXXX XXXX',
                ),
                expiryDateDecoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Expired Date',
                  hintText: 'MM/YY',
                ),
                cvvCodeDecoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'CVV',
                  hintText: 'XXX',
                ),
                cardHolderDecoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Card Holder',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
