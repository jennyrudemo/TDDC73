import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_credit_card/credit_card_brand.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:dropdown_date_picker/dropdown_date_picker.dart';
import 'package:provider/provider.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

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

class MyHomePage extends StatefulWidget with ChangeNotifier {
  MyHomePage({Key? key, required this.title}) : super(key: key);

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
  bool get isAmex => _isAmex;

  //_MyHomePageState.instance();

  void changeAmexStatus(bool status) {
    _isAmex = status;
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
    //bool isAmex = false;
    String cvvText = 'XXX';
    String data = "not amex";

    SizedBox cvvBox(bool amexStatus) {
      return SizedBox(
        width: MediaQuery.of(context).size.width * 0.3,
        child: TextFormField(
          obscureText: true,
          decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'CVV',
              hintText: amexStatus
                  ? 'XXXX'
                  : 'XXX' //uppdateras inte när isAmex ändras :(
              ),
          maxLength: amexStatus ? 4 : 3, // funkar inte :(
          maxLengthEnforcement: MaxLengthEnforcement.enforced,
          onChanged: (value) {
            //flips the card, but only we typing has started
            //isCvvFocused = true;
            setState(() {
              cvvCode = value;
            });
          },
          onTap: () {
            setState(() {
              isCvvFocused = true;
            });
          },
        ),
      );
    }

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
                    TextFormField(
                      obscureText: false,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Number',
                        hintText: 'XXXX XXXX XXXX XXXX',
                      ),
                      //controller: MaskedTextController(mask: '0000 0000 0000 0000'),
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

                    //Date picker
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          //TODO: fix date picker
                          //make sure credit card flips
                          onTap: () {
                            print("tapped");
                            setState(() {
                              isCvvFocused = false;
                            });
                          },
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: DropdownDatePicker(
                              firstDate: ValidDate(
                                year: DateTime.now().year,
                                month: DateTime.now().month,
                                day: DateTime.now().day,
                              ),
                              lastDate: ValidDate(
                                year: DateTime.now().year + 10,
                                month: 1,
                                day: 1,
                              ),
                              ascending: false,
                              dateFormat: DateFormat.ymd,
                            ),
                          ),
                        ),

                        //CVV field
                        Selector<_MyHomePageState, bool>(
                            selector: (_, notifier) => notifier.isAmex,
                            builder: (_, value, __) => cvvBox(value)),
                      ],
                    ),
                    // TextButton(onPressed: (){
                    //   show
                    // }), child: child)

                    //Cardholder
                    TextFormField(
                      obscureText: true,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Card Holder',
                      ),
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp("[a-z A-Z]")),
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

                    //Byt ut detta mot egna komponenter
                    // CreditCardForm(
                    //   cardHolderName: cardHolderName,
                    //   expiryDate: expiryDate,
                    //   cardNumber: cardNumber,
                    //   cvvCode: cvvCode,
                    //   formKey: formKey, // Required
                    //   onCreditCardModelChange: (CreditCardModel data) {
                    //     setState(() {
                    //       cardHolderName = data.cardHolderName;
                    //       //Hur ändrar vi på det? Finns restriktioner i form-widget
                    //       cvvCode = data.cvvCode;
                    //       //TODO: Check if date is valid (month not over 12 and under 1)
                    //       //Finns i form-widget. Hur kommunicerar vi det hit?
                    //       expiryDate = data.expiryDate;
                    //       cardNumber = data.cardNumber;
                    //       isCvvFocused = data.isCvvFocused;
                    //     });
                    //   }, // Required
                    //   themeColor: Colors.red,
                    //   obscureCvv: true,
                    //   obscureNumber: false,
                    //   isHolderNameVisible: true,
                    //   isCardNumberVisible: true,
                    //   isExpiryDateVisible: true,
                    //   //Testa detta
                    //   dateValidationMessage: "Incorrect date!",
                    //   cardNumberDecoration: const InputDecoration(
                    //     border: OutlineInputBorder(),
                    //     labelText: 'Number',
                    //     hintText: 'XXXX XXXX XXXX XXXX',
                    //   ),
                    //   expiryDateDecoration: const InputDecoration(
                    //     border: OutlineInputBorder(),
                    //     labelText: 'Expired Date',
                    //     hintText: 'MM/YY',
                    //   ),
                    //   cvvCodeDecoration: const InputDecoration(
                    //     border: OutlineInputBorder(),
                    //     labelText: 'CVV',
                    //     hintText: 'XXX',
                    //   ),
                    //   cardHolderDecoration: const InputDecoration(
                    //     border: OutlineInputBorder(),
                    //     labelText: 'Card Holder',
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
