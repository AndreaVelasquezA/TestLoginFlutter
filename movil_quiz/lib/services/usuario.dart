class Usuario {
  static String email = "";
  static String pass = "";

  static void setString(String newEmail, String newPass){
    email = newEmail;
    pass = newPass;
  }

  static String usuarioEmail(){
    return email;
  }

  static String usuarioPass(){
    return pass;
  }
}