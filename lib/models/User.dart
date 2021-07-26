class UserModel{

  String email,nom,prenom,telephone,adresse,id;
  UserModel.fromJson(Map<String,dynamic> data){
    nom=data["nom"];
    email=data["email"];
    prenom=data["prenom"];
    telephone=data["telephone"];
    adresse=data["adresse"];
    id=data["id"];

  }
  UserModel(String nom,String prenom,String email,String telephone,String adresse){
    this.nom=nom;
    this.email=email;
    this.prenom=prenom;
    this.telephone=telephone;
    this.adresse=adresse;
    this.id=id;
  }


  Map<String,dynamic> toMap(){
    return {
      "nom":nom,
      "email":email,
      "prenom":prenom,
      "telephone":telephone,
      "adresse":adresse,
      "id":id,
    };
  }
}
