
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shop_app/DB/DBProduct.dart';
import 'package:shop_app/DB/DBUser.dart';
import 'package:shop_app/components/DialogApp.dart';
import 'package:shop_app/components/custom_surfix_icon.dart';
import 'package:shop_app/components/default_button.dart';
import 'package:shop_app/components/form_error.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/models/Product.dart';
import 'package:shop_app/screens/AdminPanel/AddProduct/components/AddPhotoButton.dart';
import 'package:shop_app/screens/AdminPanel/AddProduct/components/Gellery.dart';
import 'package:shop_app/size_config.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
class AddProductForm extends StatefulWidget {
  @override
  _AddProductFormState createState() => _AddProductFormState();
}

class _AddProductFormState extends State<AddProductForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> errors = [];
  List images = [];
  Product product=new Product(id: "1", images: [],marque: "", title: "", price: 0, description: "");
  /*String firstName;
  String lastName;
  String phoneNumber;
  String address;*/



  void addError({String error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPhotosProduct(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildTitleFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildMarqueFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildDescreptionFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPriceFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          //buildAddressFormField(),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(40)),
          images.length !=0? galleryPhoto(images):Container(),
          images.length !=0?SizedBox(height: getProportionateScreenHeight(40)):
          SizedBox(height: getProportionateScreenHeight(0)),
          DefaultButton(
            text: "Add",
            press: () async {
              if (_formKey.currentState.validate()) {
                //product.images = await DBProduct.ajouterPhotoProduit(images);
                //await ajouterPhotoProduit();
                await ajouterProduit();
              }
            },
          ),
          
        ],
      ),
    );
  }
  Future<void> ajouterProduit() async {
    await DBProduct.ajouterProduit(product,this.images);
    DialogApp.afficherDialog2pop(context, "Le produit a été ajouté");
  }
  Future<void> ajouterPhotoProduit()async{
    //await DBProduct.ajouterPhotoProduit( images);
  }
  Widget galleryPhoto(List images){
    return Container(
      height: SizeConfig.screenWidth/3,
      width: SizeConfig.screenWidth,
      child : Gallery(images)
    );
  }
  TextFormField buildAddressFormField() {
    return TextFormField(
      onSaved: (newValue){},
      onChanged: (value) {
        
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kPriceNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Address",
        hintText: "Enter your phone address",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon:
            CustomSurffixIcon(svgIcon: "assets/icons/Location point.svg"),
      ),
    );
  }

  TextFormField buildPriceFormField() {
    return TextFormField(
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.phone,
      onSaved: (newValue) => {

      },
      onChanged: (value) {
        this.product.price =double.parse(value) ;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kPriceNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "price",
        hintText: "the price of your product",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        icon : FaIcon(FontAwesomeIcons.dollarSign),
      ),
    );
  }

  TextFormField buildDescreptionFormField() {
    return TextFormField(
      textInputAction: TextInputAction.next,
      maxLines: 5,
      onChanged: (newValue) {
        this.product.description = newValue;
      },
      decoration: InputDecoration(
        labelText: "description",
        hintText: "the description of your product",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        icon: FaIcon(FontAwesomeIcons.paragraph),
      ),
    );
  }
  Widget buildPhotosProduct(){
    return InkWell(
      onTap:(){ 
        loadAssets();
      },
      child: AddPhotoButton()
    );
  }
  TextFormField buildMarqueFormField() {
    return TextFormField(
      textInputAction: TextInputAction.next,
      onSaved: (newValue) {

      },
      onChanged: (value) {
        this.product.marque = value;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kTitleNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "marque",
        hintText: "the marque of your product",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        icon: FaIcon(
          FontAwesomeIcons.infoCircle
        ),
      ),
    );
  }
  TextFormField buildTitleFormField() {
    return TextFormField(
      textInputAction: TextInputAction.next,
      onSaved: (newValue) {

      },
      onChanged: (value) {
        this.product.title = value;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kTitleNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "title",
        hintText: "the title of your product",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        icon: FaIcon(
          FontAwesomeIcons.infoCircle
        ),
      ),
    );
  }
  Future<void> loadAssets() async {
    /*setState(() {
      images = [];
    });*/

    List resultList;
    String error;

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 10,
      );
    } on Exception catch (e) {
      error = e.toString();
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      if(resultList!=null)
      images =images + resultList;
      if (error == null) error = 'No Error Dectected';
    });

    this.product.images = [];
  }
}
