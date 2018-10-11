//%attributes = {}

TRACE:C157
C_OBJECT:C1216($ob_objeto;$undefined)
  //Creo un objeto para modificar campo
OB SET:C1220($ob_objeto;"Fecha";"ERROR";"Numero";1234)

READ WRITE:C146([xxSTR_Niveles:6])
  //Busco un registro de niveles para hacer la prueba
QUERY BY ATTRIBUTE:C1331([xxSTR_Niveles:6];[xxSTR_Niveles:6]OB_responsable:28;"nombre";#;$undefined)
FIRST RECORD:C50([xxSTR_Niveles:6])

  //Mofifico el valor del objeto y de otro campo, en este caso número de nivel
OB SET:C1220([xxSTR_Niveles:6]OB_responsable:28;"2015";$ob_objeto)
[xxSTR_Niveles:6]NoNivel:5:=123
  //Muestro los valores OLD de los campos.. Prueba 1
ALERT:C41("Prueba 1:\nOld num: "+String:C10(Old:C35([xxSTR_Niveles:6]NoNivel:5))+"\nOLD objeto: "+JSON Stringify:C1217(Old:C35([xxSTR_Niveles:6]OB_responsable:28)))

  //Asigno los valores OLD a los campos
[xxSTR_Niveles:6]OB_responsable:28:=Old:C35([xxSTR_Niveles:6]OB_responsable:28)
[xxSTR_Niveles:6]NoNivel:5:=Old:C35([xxSTR_Niveles:6]NoNivel:5)
  //Muestro los valores OLD de los campos.. Prueba 2
ALERT:C41("Prueba 2:\nOld num: "+String:C10(Old:C35([xxSTR_Niveles:6]NoNivel:5))+"\nOLD objeto: "+JSON Stringify:C1217(Old:C35([xxSTR_Niveles:6]OB_responsable:28)))

  //Vuelvo a modificar los valores de los campos

OB SET:C1220([xxSTR_Niveles:6]OB_responsable:28;"2015";$ob_objeto)
[xxSTR_Niveles:6]NoNivel:5:=123
  //Muestro los valores OLD de los campos.. Prueba 3
ALERT:C41("Prueba 3:\nOld num: "+String:C10(Old:C35([xxSTR_Niveles:6]NoNivel:5))+"\nOLD objeto: "+JSON Stringify:C1217(Old:C35([xxSTR_Niveles:6]OB_responsable:28)))

KRL_UnloadReadOnly (->[ACT_Cargos:173])

