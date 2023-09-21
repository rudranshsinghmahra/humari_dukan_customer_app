import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:humari_dukan/services/firebase_services.dart';
import 'package:humari_dukan/widgets/custom_appbar.dart';

class AddAddressScreen extends StatefulWidget {
  const AddAddressScreen({Key? key, required this.placeMark}) : super(key: key);
  final Placemark? placeMark;

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  TextEditingController recipientNameController = TextEditingController();
  TextEditingController houseNumber = TextEditingController();
  TextEditingController locality = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController state = TextEditingController();
  TextEditingController pinCode = TextEditingController();
  TextEditingController country = TextEditingController();
  FirebaseServices services = FirebaseServices();
  String? addressType;

  final _formKey = GlobalKey<FormState>();

  void _submitForm() {
    if (_formKey.currentState!.validate() && addressType != null) {
      services
          .addAddressToDatabase(
              recipientNameController.text.trim(),
              houseNumber.text.trim(),
              locality.text.trim(),
              city.text.trim(),
              state.text.trim(),
              pinCode.text.trim(),
              country.text.trim(),
              addressType.toString())
          .then((value) => {
                Navigator.pop(context),
              });
    }
  }

  @override
  Widget build(BuildContext context) {
    houseNumber.text = widget.placeMark!.street!;
    locality.text = widget.placeMark!.subLocality!;
    city.text = widget.placeMark!.locality!;
    state.text = widget.placeMark!.administrativeArea!;
    pinCode.text = widget.placeMark!.postalCode!;
    country.text = widget.placeMark!.country!;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            const CustomAppBar(
                appbarTitle: "Add New Address", showShoppingCart: false),
            Padding(
              padding: const EdgeInsets.only(top: 70, left: 10, right: 10),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            value: addressType == 'Home',
                            onChanged: (newValue) {
                              setState(() {
                                addressType = newValue! ? 'Home' : null;
                              });
                            },
                          ),
                          const Text('Home'),
                          Checkbox(
                            value: addressType == 'Office',
                            onChanged: (newValue) {
                              setState(() {
                                addressType = newValue! ? 'Office' : null;
                              });
                            },
                          ),
                          const Text('Office'),
                          Checkbox(
                            value: addressType == 'Other',
                            onChanged: (newValue) {
                              setState(() {
                                addressType = newValue! ? 'Other' : null;
                              });
                            },
                          ),
                          const Text('Other'),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Row(
                          children: [
                            Expanded(
                                child: TextFormField(
                              controller: recipientNameController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter the recipient name';
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                label: Text(
                                  "Recipient Name",
                                  style: TextStyle(color: Color(0xffff4a85)),
                                ),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xffff4a85),
                                  ),
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 1.0,
                                  ),
                                ),
                              ),
                            )),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: Row(
                          children: [
                            Flexible(
                              flex: 1,
                              child: TextFormField(
                                controller: houseNumber,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter the house number';
                                  }
                                  return null;
                                },
                                decoration: const InputDecoration(
                                  label: Text(
                                    "House Number",
                                    style: TextStyle(color: Color(0xffff4a85)),
                                  ),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xffff4a85),
                                    ),
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      width: 1.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Flexible(
                              flex: 2,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: TextFormField(
                                  controller: locality,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter the locality';
                                    }
                                    return null;
                                  },
                                  decoration: const InputDecoration(
                                    label: Text(
                                      "Locality",
                                      style:
                                          TextStyle(color: Color(0xffff4a85)),
                                    ),
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xffff4a85),
                                      ),
                                    ),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        width: 1.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Row(
                          children: [
                            Expanded(
                                child: TextFormField(
                              controller: city,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter the city';
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                label: Text(
                                  "City",
                                  style: TextStyle(color: Color(0xffff4a85)),
                                ),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xffff4a85),
                                  ),
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 1.0,
                                  ),
                                ),
                              ),
                            )),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Row(
                          children: [
                            Expanded(
                                child: TextFormField(
                              controller: state,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter the state';
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                label: Text(
                                  "State",
                                  style: TextStyle(color: Color(0xffff4a85)),
                                ),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xffff4a85),
                                  ),
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 1.0,
                                  ),
                                ),
                              ),
                            )),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Row(
                          children: [
                            Flexible(
                              flex: 1,
                              child: TextFormField(
                                controller: pinCode,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter the pincode';
                                  }
                                  return null;
                                },
                                decoration: const InputDecoration(
                                  label: Text(
                                    "Pincode",
                                    style: TextStyle(color: Color(0xffff4a85)),
                                  ),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xffff4a85),
                                    ),
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      width: 1.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Flexible(
                              flex: 2,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: TextFormField(
                                  controller: country,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter the country';
                                    }
                                    return null;
                                  },
                                  decoration: const InputDecoration(
                                    label: Text(
                                      "Country",
                                      style: TextStyle(
                                        color: Color(
                                          0xffff4a85,
                                        ),
                                      ),
                                    ),
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xffff4a85),
                                      ),
                                    ),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        width: 1.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 18.0),
                        child: ElevatedButton(
                            onPressed: () {
                              _submitForm();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(
                                0xffff4a85,
                              ),
                            ),
                            child: Row(
                              children: const [
                                Expanded(
                                    child: Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: Center(
                                      child: Text(
                                    "SAVE ADDRESS",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  )),
                                )),
                              ],
                            )),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
