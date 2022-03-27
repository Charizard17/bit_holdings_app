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
                        color: Theme.of(context).focusColor,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    Text(
                      'Add Coin',
                      style: Theme.of(context).textTheme.titleMedium,
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
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      )
                    : Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Step 2– Fill transaction details',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                Divider(
                  color: Theme.of(context).textTheme.bodyMedium!.color,
                  thickness: 1,
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
                                    color: Theme.of(context).primaryColorLight,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: GestureDetector(
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: CircleAvatar(
                                            backgroundColor: Theme.of(context).primaryColor,
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
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium,
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Text(
                                            snapshot.data[index].symbol
                                                .toString()
                                                .toUpperCase(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .copyWith(
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
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              Text(
                                _selectedCoinName,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '*Price per coin:',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              Container(
                                width: 100,
                                child: TextField(
                                  controller: _buyPrice,
                                  decoration: InputDecoration(
                                    hintText: '\$1000.00',
                                    hintStyle:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                  keyboardType: TextInputType.number,
                                  style: Theme.of(context).textTheme.bodyMedium,
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
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              Container(
                                width: 100,
                                child: TextField(
                                  controller: _quantity,
                                  decoration: InputDecoration(
                                    hintText: '0.35',
                                    hintStyle:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                  keyboardType: TextInputType.number,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                  onChanged: (newValue) {
                                    quantityOnChanged = newValue;
                                  },
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Transaction Date:',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              OutlinedButton(
                                child: Text(
                                  '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                                onPressed: () {
                                  _selectDate(context);
                                },
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          MaterialButton(
                            color: Theme.of(context).focusColor,
                            child: Text(
                              'Add',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
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
