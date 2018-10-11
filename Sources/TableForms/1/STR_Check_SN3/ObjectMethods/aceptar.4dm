$resp:=CD_Dlog (0;__ ("Se aplicará el cambio a ")+String:C10(Records in set:C195("Selection"))+__ (" Asignaturas.")+"\r\r"+__ ("¿Desea continuar?");"";__ ("Si");__ ("No"))
If ($resp=1)
	READ WRITE:C146([Asignaturas:18])
	USE SET:C118("Selection")
	APPLY TO SELECTION:C70([Asignaturas:18];[Asignaturas:18]Publicar_en_SchoolNet:60:=vl_publicacion)
	KRL_UnloadReadOnly (->[Asignaturas:18])
	If (Records in set:C195("lockedset")>0)
		USE SET:C118("lockedset")
		$vt_key:=""
		While (Not:C34(End selection:C36([Asignaturas:18])))
			$vt_key:=ST_Concatenate (";";->[Asignaturas:18]Numero:1;->vl_publicacion)
			If (Not:C34(ST_activacionMallaAsignaturas ($vt_key)))
				BM_CreateRequest ("ST_activaMalla";$vt_key;String:C10([Asignaturas:18]Numero:1))
			End if 
			NEXT RECORD:C51([Asignaturas:18])
		End while 
	End if 
	USE SET:C118("Selection")
	ARRAY LONGINT:C221($al_numeros;0)
	SELECTION TO ARRAY:C260([Asignaturas:18]Numero:1;$al_numeros)
	$vt_publicacion:=""
	For ($x;0;3)
		
		If ($x=0)
			If (vl_publicacion ?? $x)
				$vt_publicacion:=$vt_publicacion+"Calificaciones "
			End if 
		End if 
		If ($x=1)
			If (vl_publicacion ?? $x)
				$vt_publicacion:=$vt_publicacion+"Aprendizajes "
			End if 
		End if 
		If ($x=2)
			If (vl_publicacion ?? $x)
				$vt_publicacion:=$vt_publicacion+"Observaciones "
			End if 
		End if 
		If ($x=3)
			If (vl_publicacion ?? $x)
				$vt_publicacion:=$vt_publicacion+"Planes de clase "
			End if 
		End if 
		
	End for 
	LOG_RegisterEvt ("Se realizó la modificación de la publicación en Sn3 para las asignaturas con Id: "+AT_array2text (->$al_numeros;"-")+" con las siguientes opciones "+$vt_publicacion+".")
	
End if 
CANCEL:C270