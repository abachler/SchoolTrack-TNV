vtCM_Aplicacion:=CD_Request (__ ("identificador Nueva aplicación:");__ ("OK");__ ("Cancelar");__ ("");__ (""))
$index:=Find in field:C653([CMT_Transferencia:158]Aplicacion:2;vtCM_Aplicacion)
If ($index#-1)
	CD_Dlog (0;__ ("Este indentificador ya existe. Por favor utilice otro o seleccione de la lista desplegable."))
	vtCM_Aplicacion:=""
Else 
	APPEND TO ARRAY:C911(atCM_PopUp;vtCM_Aplicacion)
End if 
CMT_Transferencia ("OnLoad";->vtCM_Aplicacion)