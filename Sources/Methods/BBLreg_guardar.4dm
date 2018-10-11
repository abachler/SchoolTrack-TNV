//%attributes = {}
  // BBLreg_guardar()
  // Por: Alberto Bachler: 17/09/13, 13:30:28
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------
C_LONGINT:C283($0)
C_LONGINT:C283($l_elemento)
ARRAY TEXT:C222($at_lugares;0)

If (False:C215)
	C_LONGINT:C283(BBLreg_guardar ;$0)
End if 


If ((KRL_RegistroFueModificado (->[BBL_Registros:66])) & (USR_checkRights ("M";->[BBL_Registros:66])))
	If (Is new record:C668([BBL_Registros:66]))
		[BBL_Items:61]Copias:24:=[BBL_Items:61]Copias:24+1
		[BBL_Items:61]Copias_disponibles:43:=[BBL_Items:61]Copias_disponibles:43+1
		If ([BBL_Registros:66]Número_de_copia:2>[BBL_Items:61]UltimoNumeroDeCopia:49)
			[BBL_Items:61]UltimoNumeroDeCopia:49:=[BBL_Registros:66]Número_de_copia:2
		End if 
	End if 
	BBLreg_GeneraCodigoBarra   // el codigo de barra se regenera solo cuando ha sido modificado
	
	If ([BBL_Registros:66]Lugar:13#Old:C35([BBL_Registros:66]Lugar:13))
		AT_Text2Array (->$at_lugares;[BBL_Items:61]Lugares:51;", ")
		$l_elemento:=Find in array:C230($at_lugares;Old:C35([BBL_Registros:66]Lugar:13))
		If ($l_elemento>0)
			DELETE FROM ARRAY:C228($at_lugares;$l_elemento)
		End if 
		If (Find in array:C230($at_lugares;[BBL_Registros:66]Lugar:13)<0)
			APPEND TO ARRAY:C911($at_lugares;[BBL_Registros:66]Lugar:13)
			[BBL_Items:61]Lugares:51:=AT_array2text (->$at_lugares;", ")
		End if 
		SAVE RECORD:C53([BBL_Items:61])
	End if 
	SAVE RECORD:C53([BBL_Registros:66])
	$0:=1
Else 
	$0:=0
End if 

