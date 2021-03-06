class UserModel{

  String email,nom,prenom,telephone,adresse,id,photoProfil;
  UserModel.fromJson(Map<String,dynamic> data){
    nom=data["nom"];
    email=data["email"];
    prenom=data["prenom"];
    telephone=data["telephone"];
    adresse=data["adresse"];
    id=data["id"];
    photoProfil = data['photoProfil'];
  }
  UserModel(String nom,String prenom,String email,String telephone,String adresse){
    this.nom=nom;
    this.email=email;
    this.prenom=prenom;
    this.telephone=telephone;
    this.adresse=adresse;
    this.id=id;
    this.photoProfil="";
  }


  Map<String,dynamic> toMap(){
    return {
      "nom":nom,
      "email":email,
      "prenom":prenom,
      "telephone":telephone,
      "adresse":adresse,
      "id":id,
      "photoProfil":photoProfil,
    };
  }
}
