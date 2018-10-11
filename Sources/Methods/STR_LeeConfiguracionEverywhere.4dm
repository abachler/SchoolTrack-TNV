//%attributes = {}
  //STR_LeeConfiguracionEverywhere

STR_LeeConfiguracion 
$p:=Execute on server:C373("STR_LeeConfiguracion";Pila_256K;"ReadConfig")
KRL_ExecuteOnConnectedClients ("STR_LeeConfiguracion")