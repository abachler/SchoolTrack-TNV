//%attributes = {}
  // SN3_LiberaRegistrosXEnviar()
  // Por: Alberto Bachler: 14/08/13, 04:20:00
  // --------------------------------------------- //
  //
  // ---------------------------------------------
ARRAY TEXT:C222($at_cadenaVacia;Records in selection:C76([xxSN3_RegistrosXEnviar:143]))
ARRAY LONGINT:C221($al_ceros;Records in selection:C76([xxSN3_RegistrosXEnviar:143]))
READ WRITE:C146([xxSN3_RegistrosXEnviar:143])
ARRAY TO SELECTION:C261($al_ceros;[xxSN3_RegistrosXEnviar:143]tipoDato:1;$al_ceros;[xxSN3_RegistrosXEnviar:143]accion:3;$al_ceros;[xxSN3_RegistrosXEnviar:143]ID:2;$at_cadenaVacia;[xxSN3_RegistrosXEnviar:143]llave:4;$at_cadenaVacia;[xxSN3_RegistrosXEnviar:143]DTS_Local:5)
KRL_UnloadReadOnly (->[xxSN3_RegistrosXEnviar:143])