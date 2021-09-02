import 'package:fiction_team_task/providers/upload_product_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';

class UploadProductScreen extends StatefulWidget {
  static const routeName = '/UploadProductForm';

  @override
  _UploadProductScreenState createState() => _UploadProductScreenState();
}

class _UploadProductScreenState extends State<UploadProductScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _oldPriceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _saleController = TextEditingController();
  final TextEditingController _newProductController = TextEditingController();
  String _saleValue;
  String _newProductValue;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _titleController.clear();
    _priceController.clear();
    _descriptionController.clear();
    _quantityController.clear();
    _saleController.clear();
    _newProductController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UploadProductProvider>(
      builder: (context, uploadProProvider, _) {
        return Scaffold(
          bottomSheet: Container(
            height: kBottomNavigationBarHeight * 0.8,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(
                  color: Colors.grey,
                  width: 0.5,
                ),
              ),
            ),
            child: uploadProProvider.uploading == true
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Container(
                    color: Colors.grey[400],
                    child: TextButton(
                      onPressed: () => uploadProProvider.uploadProduct(
                        context: context,
                        newProductController: _newProductController,
                        saleController: _saleController,
                        descriptionController: _descriptionController,
                        priceController: _priceController,
                        quantityController: _quantityController,
                        titleController: _titleController,
                        oldPriceController: _oldPriceController,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Upload',
                            style: TextStyle(
                                color: Colors.blue[900], fontSize: 18),
                          ),
                          Icon(
                            Icons.upload_rounded,
                            size: 20,
                            color: Colors.blue[900],
                          ),
                        ],
                      ),
                    ),
                  ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Center(
                  child: Card(
                    margin: EdgeInsets.all(15),
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  flex: 2,
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 9),
                                    child: TextFormField(
                                      controller: _titleController,
                                      key: ValueKey('Title'),
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'Please enter a Title';
                                        }
                                        return null;
                                      },
                                      keyboardType: TextInputType.emailAddress,
                                      decoration: InputDecoration(
                                        labelText: 'Product Title',
                                      ),
                                    ),
                                  ),
                                ),
                                Flexible(
                                  flex: 1,
                                  child: TextFormField(
                                    controller: _priceController,
                                    key: ValueKey('Price '),
                                    keyboardType: TextInputType.number,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Price is missed';
                                      }
                                      return null;
                                    },
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.allow(
                                          RegExp(r'[0-9]')),
                                    ],
                                    decoration: InputDecoration(
                                      labelText: 'Price ',
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Flexible(
                                  flex: 1,
                                  child: TextFormField(
                                    controller: _oldPriceController,
                                    key: ValueKey('oldPrice'),
                                    keyboardType: TextInputType.number,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'old Price is missed';
                                      }
                                      return null;
                                    },
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.allow(
                                          RegExp(r'[0-9]')),
                                    ],
                                    decoration: InputDecoration(
                                      labelText: 'old Price ',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                uploadProProvider.imageFile == null
                                    ? Container(
                                  margin: EdgeInsets.all(10),
                                  height: 200,
                                  width: 200,
                                  decoration: BoxDecoration(
                                    border: Border.all(width: 1),
                                    borderRadius:
                                    BorderRadius.circular(40),
                                    color: Colors.grey[400],
                                  ),
                                )
                                    : Container(
                                  margin: EdgeInsets.all(10),
                                  height: 200,
                                  width: 200,
                                  decoration: BoxDecoration(
                                    border: Border.all(width: 1),
                                    borderRadius:
                                    BorderRadius.circular(40),
                                    color: Colors.grey[400],
                                  ),
                                  child: Image.file(
                                    uploadProProvider.imageFile,
                                    fit: BoxFit.fitHeight,
                                  ),
                                ),

                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    customFittedBox(
                                        context: context,
                                        iconColor: Colors.purpleAccent,
                                        icon: Icons.camera,
                                        labelText: 'Camera',
                                        function: () => uploadProProvider
                                            .pickImageCamera(context)),
                                    customFittedBox(
                                        context: context,
                                        iconColor: Colors.purpleAccent,
                                        icon: Icons.image,
                                        labelText: 'Gallery',
                                        function: () => uploadProProvider
                                            .pickImageGallery(context)),
                                    customFittedBox(
                                        context: context,
                                        iconColor: Colors.red,
                                        icon: Icons.remove_circle_rounded,
                                        labelText: 'Remove',
                                        function: () =>
                                            uploadProProvider.remove(context)),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 9),
                                    child: Container(
                                      child: TextFormField(
                                        readOnly: true,
                                        controller: _saleController,
                                        key: ValueKey('sale'),
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return 'Please enter the Sale State';
                                          }
                                          return null;
                                        },
                                        //keyboardType: TextInputType.emailAddress,
                                        decoration: InputDecoration(
                                          labelText: 'if in Sale or not ',
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                DropdownButton<String>(
                                  items: [
                                    DropdownMenuItem<String>(
                                      child: Text('On Sale'),
                                      value: 'true',
                                    ),
                                    DropdownMenuItem<String>(
                                      child: Text('Not in Sale'),
                                      value: false.toString(),
                                    ),
                                  ],
                                  onChanged: (String value) {
                                    setState(() {
                                      _saleValue = value;
                                      _saleController.text = value;
                                    });
                                  },
                                  hint: Text('Select a Sale State'),
                                  value: _saleValue,
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 9),
                                    child: Container(
                                      child: TextFormField(
                                        controller: _newProductController,
                                        key: ValueKey('New or Not'),
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return 'Please fill this section';
                                          }
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                          labelText: 'if New or Not',
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                DropdownButton<String>(
                                  items: [
                                    DropdownMenuItem<String>(
                                      child: Text('New'),
                                      value: true.toString(),
                                    ),
                                    DropdownMenuItem<String>(
                                      child: Text('Not'),
                                      value: false.toString(),
                                    ),
                                  ],
                                  onChanged: (String value) {
                                    setState(() {
                                      _newProductValue = value;
                                      _newProductController.text = value;
                                    });
                                  },
                                  hint: Text('Select if New or Not'),
                                  value: _newProductValue,
                                ),
                              ],
                            ),
                            SizedBox(height: 15),
                            TextFormField(
                              controller: _descriptionController,
                              key: ValueKey('Description'),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'product description is required';
                                }
                                return null;
                              },
                              //controller: this._controller,
                              maxLines: 10,
                              textCapitalization: TextCapitalization.sentences,
                              decoration: InputDecoration(
                                //  counterText: charLength.toString(),
                                labelText: 'Description',
                                hintText: 'Product description',
                                border: OutlineInputBorder(),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 9),
                              child: TextFormField(
                                controller: _quantityController,
                                keyboardType: TextInputType.number,
                                key: ValueKey('Quantity'),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Quantity is missed';
                                  }
                                  return null;
                                },
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'[0-9]')),
                                ],
                                decoration: InputDecoration(
                                  labelText: 'Quantity',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

Widget customFittedBox(
    {Function function,
    IconData icon,
    Color iconColor,
    context,
    String labelText}) {
  return FittedBox(
    child: FlatButton.icon(
      textColor: Colors.white,
      onPressed: function,
      icon: Icon(icon, color: iconColor),
      label: Text(
        labelText,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          color: Theme.of(context).textSelectionColor,
        ),
      ),
    ),
  );
}
