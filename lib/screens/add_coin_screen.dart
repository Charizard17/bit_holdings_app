import 'package:flutter/material.dart';

import '../services/flutterfire.dart';
import '../services/api_methods.dart';

FlutterFire _flutterFire = FlutterFire();
ApiMethods _apiMethods = ApiMethods();

class AddCoinScreen extends StatefulWidget {
  const AddCoinScreen({Key? key}) : super(key: key);

  @override
  State<AddCoinScreen> createState() => _AddCoinScreenState();
}

class _AddCoinScreenState extends State<AddCoinScreen> {
  bool _coinSelected = false;
  String _selectedCoinName = '';
  String priceOnChanged = '';
  String quantityOnChanged = '';
  TextEditingController _buyPrice = TextEditingController();
  TextEditingController _quantity = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    Future<void> _selectDate(BuildContext context) async {
      DateTime? selectedDate = await showDatePicker(
        context: context,
        initialDate: _selectedDate,
        firstDate: DateTime(2009),
        lastDate: DateTime(DateTime.now().year + 1),
      );
      if (selectedDate != null && selectedDate != _selectedDate) {
        setState(() {
          _selectedDate = selectedDate;
        });
      }
    }

    return Scaffold(
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.only(top: 20),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back_rounded,
                        size: 30,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    Text(
                      'Add Coin',
                      style: TextStyle(
                        fontSize: 25,
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_rounded,
                      size: 35,
                      color: Colors.transparent,
                    )
                  ],
                ),
                SizedBox(height: 10),
                _coinSelected == false
                    ? Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Step 1– Select your coin',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      )
                    : Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Step 2– Fill transaction details',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                Divider(
                  thickness: 1,
                  color: Colors.white,
                ),
                SizedBox(height: 10),
                _coinSelected == false
                    ? Expanded(
                        child: FutureBuilder(
                          future: _apiMethods.getCoinsList(),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (!snapshot.hasData) {
                              return Center(
                                child: CircularProgressIndicator(
                                  color: Theme.of(context).primaryColor,
                                ),
                              );
                            }

                            return ListView.builder(
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: EdgeInsets.only(bottom: 15),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 10,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[700],
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: GestureDetector(
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: CircleAvatar(
                                            backgroundColor: Colors.black,
                                            radius: 20,
                                            child: ClipOval(
                                              child: Image.network(
                                                snapshot.data[index].image,
                                                fit: BoxFit.cover,
                                                width: 40,
                                                height: 40,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 30),
                                        Expanded(
                                          flex: 3,
                                          child: Text(
                                            snapshot.data[index].name,
                                            style: TextStyle(
                                              fontSize: 18,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Text(
                                            snapshot.data[index].symbol
                                                .toString()
                                                .toUpperCase(),
                                            style: TextStyle(
                                              color: Colors.white70,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    onTap: () async {
                                      setState(() {
                                        this._selectedCoinName =
                                            snapshot.data[index].name;
                                      });
                                      _coinSelected = true;
                                    },
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      )
                    : Column(
                        children: [
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Coin:',
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                              Text(
                                _selectedCoinName,
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '*Price per coin:',
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                              Container(
                                width: 100,
                                child: TextField(
                                  controller: _buyPrice,
                                  decoration: InputDecoration(
                                    hintText: '\$1000.00',
                                    hintStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                    ),
                                  ),
                                  keyboardType: TextInputType.number,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                  onChanged: (newValue) {
                                    priceOnChanged = newValue;
                                  },
                                ),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '*Quantity:',
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                              Container(
                                width: 100,
                                child: TextField(
                                  controller: _quantity,
                                  decoration: InputDecoration(
                                    hintText: '0.35',
                                    hintStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                    ),
                                  ),
                                  keyboardType: TextInputType.number,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                  onChanged: (newValue) {
                                    quantityOnChanged = newValue;
                                  },
                                ),
                              )
                            ],
                          ),
                          // SizedBox(height: 20),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //   children: [
                          //     Text(
                          //       'Invested amount:',
                          //       style: TextStyle(
                          //         fontSize: 18,
                          //       ),
                          //     ),
                          //     Text(
                          //       '\$${double.parse(priceOnChanged)*double.parse(quantityOnChanged)}',
                          //       style: TextStyle(
                          //         fontSize: 18,
                          //       ),
                          //     ),
                          //   ],
                          // ),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Transaction Date:',
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                              OutlinedButton(
                                child: Text(
                                  '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                ),
                                onPressed: () {
                                  _selectDate(context);
                                },
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          MaterialButton(
                            color: Theme.of(context).primaryColor,
                            child: Text(
                              'Add',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onPressed: (_quantity.text != '' &&
                                        _buyPrice.text != '' &&
                                        double.parse(_quantity.text) *
                                                double.parse(_buyPrice.text) >
                                            0) ==
                                    true
                                ? () async {
                                    await _flutterFire.addCoin(
                                        _selectedCoinName.replaceAll(' ', '-'),
                                        _quantity.text,
                                        _buyPrice.text,
                                        _selectedDate.toString());
                                    Navigator.of(context).pop();
                                  }
                                : () {},
                          ),
                        ],
                      ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
