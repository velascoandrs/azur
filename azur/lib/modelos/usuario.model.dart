class Usuario {
    int id; 
    String cedulaRuc;
    String telefono;
    String correo;
    int tipo;
    

    // Factory recibe el json desde el servicio y retorna una instancia del usuario
    factory Usuario(Map jsonMap){
        try{
            return new Usuario.deserializar(jsonMap);
        }catch(ex){
            throw ex;
        }
    }

    // Deserializar el usuario desde el json
     Usuario.deserializar(Map json):
      id = json["id"].toInt(),
      cedulaRuc = json["cedulaRuc"],
      telefono = json["telefono"],
      correo = json["correo"],
      tipo = json["tipo"].toInt();

}
