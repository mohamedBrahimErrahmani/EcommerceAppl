
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
  Product product;
  static List images = [];
  AddProductForm(this.product);
  @override
  _AddProductFormState createState() => _AddProductFormState();
}

class _AddProductFormState extends State<AddProductForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> errors = [];
  bool modifierProduct;
  Product productAjout;
  static List imagesAjoute = [];
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
  void initState() {
    if(widget.product == null){
      this.productAjout=new Product(id: "1", images: [],promotion :false,disponible: true, marque: "", title: "", price: 0, description: "");
      this.modifierProduct = false;
      AddProductForm.images = [];
    }
    else{
      productAjout = widget.product;
      AddProductForm.images = widget.product.images;
      this.modifierProduct = true;
    }
    
    super.initState();
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
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(40)),
          AddProductForm.images.length !=0? galleryPhoto():Container(),
          AddProductForm.images.length !=0?SizedBox(height: getProportionateScreenHeight(40)):
          SizedBox(height: getProportionateScreenHeight(0)),
          buildPromotion(),
          SizedBox(height: getProportionateScreenHeight(0)),
          buildDisponibilite(),
          SizedBox(height: getProportionateScreenHeight(30)),
          DefaultButton(
            text: this.modifierProduct==false? "Ajouter" : "Modifier",
            press: () async {
              if (_formKey.currentState.validate()) {
                if(this.modifierProduct==false){
                  if(AddProductForm.images.length != 0){
                    await ajouterProduit();
                  }
                  else{
                    DialogApp.afficherDialog(context, "Vous devez ajouter au moin une photo");
                  }
                }
                else{
                  modifierProduit();
                }
              }
            },
          ),
          SizedBox(height: getProportionateScreenHeight(40)),
        ],
      ),
    );
  }
  Future<void> ajouterProduit() async {
    await DBProduct.ajouterProduit(this.productAjout,AddProductForm.images);
    DialogApp.afficherDialog2pop(context, "Le produit a été ajouté");
  }
  Future<void> modifierProduit() async {
    await DBProduct.modifierProduit(this.productAjout,imagesAjoute);
    DialogApp.afficherDialog2pop(context, "Le produit a été modifié");
  }
  Widget galleryPhoto(){
    return Container(
      height: SizeConfig.screenWidth/3,
      width: SizeConfig.screenWidth,
      child :widget.product!=null? Gallery(liensPhotos :productAjout.images):Gallery()
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
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon:
            CustomSurffixIcon(svgIcon: "assets/icons/Location point.svg"),
      ),
    );
  }

  TextFormField buildPriceFormField() {
    return TextFormField(
      initialValue :modifierProduct == true? this.productAjout.price.toString():"",
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.phone,
      onSaved: (newValue) => {

      },
      onChanged: (value) {
        this.productAjout.price =double.parse(value) ;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kPriceNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "prix",
        hintText: "Le prix de votre produit",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        icon : FaIcon(FontAwesomeIcons.dollarSign),
      ),
    );
  }

  TextFormField buildDescreptionFormField() {
    return TextFormField(
      initialValue :modifierProduct == true?this.productAjout.description:"",
      textInputAction: TextInputAction.next,
      maxLines: 5,
      onChanged: (newValue) {
        this.productAjout.description = newValue;
      },
      decoration: InputDecoration(
        labelText: "description",
        hintText: "La description de votre poduit",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        icon: FaIcon(FontAwesomeIcons.paragraph),
      ),
    );
  }
  Widget buildDisponibilite(){
    return Row(
      children: [
        Checkbox(
          checkColor: Colors.white,
          focusColor: kPrimaryColor,
          activeColor: kPrimaryColor,
          value: this.productAjout.disponible,
          onChanged: (bool value) {
            setState(() {
              this.productAjout.disponible = value;
            });
          },
        ),
        Text(
          "Produit disponible",
          style: TextStyle(
            color : Colors.black,
            fontSize: 15
          ),
        )
      ],
    );
  }
  Widget buildPromotion(){
    return Row(
      children: [
        Checkbox(
          checkColor: Colors.white,
          focusColor: kPrimaryColor,
          activeColor: kPrimaryColor,
          value: this.productAjout.promotion,
          onChanged: (bool value) {
            setState(() {
              this.productAjout.promotion = value;
            });
          },
        ),
        Text(
          "Produit en promotion",
          style: TextStyle(
            color : Colors.black,
            fontSize: 15
          ),
        )
      ],
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
      initialValue :modifierProduct == true?this.productAjout.marque:"",
      textInputAction: TextInputAction.next,
      onSaved: (newValue) {

      },
      onChanged: (value) {
        this.productAjout.marque = value;
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
        hintText: "La marque de votre produit",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        icon: FaIcon(
          FontAwesomeIcons.infoCircle
        ),
      ),
    );
  }
  TextFormField buildTitleFormField() {
    return TextFormField(
      initialValue :modifierProduct == true? this.productAjout.title:"",
      textInputAction: TextInputAction.next,
      onSaved: (newValue) {

      },
      onChanged: (value) {
        this.productAjout.title = value;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kTitleNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "nom",
        hintText: "Le nom de votre produit",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        icon: FaIcon(
          FontAwesomeIcons.infoCircle
        ),
      ),
    );
  }
  Future<void> loadAssets() async {
    imagesAjoute = [];
    List resultList = [];
    String error;

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 10,
      );
    } on Exception catch (e) {
      error = e.toString();
    }
    if (!mounted) return;

    setState(() {
      if(resultList!=null)
      AddProductForm.images =AddProductForm.images + resultList;
      imagesAjoute = imagesAjoute + resultList;
      if (error == null) error = 'No Error Dectected';
    });
  }
}
