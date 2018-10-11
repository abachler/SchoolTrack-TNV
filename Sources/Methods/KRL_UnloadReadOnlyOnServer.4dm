//%attributes = {"executedOnServer":true}
  //KRL_UnloadReadOnlyOnServer
  //MONO 25-06-13: Está creado por que en algunos triggers en el server llego con tablas en
  // READ WRITE siendo que en el cliente están en READ ONLY además no se descargan los registros
  // quedando bloqueados, intenté llamar a KRL_UnloadReadOnly con un "execute on server" pero esto no me descargó el registro
  //sólo pude hacer de esta forma con la propiedad del método de ejecución en el servidor.

C_POINTER:C301($1)
KRL_UnloadReadOnly ($1)