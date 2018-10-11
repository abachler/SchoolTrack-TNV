//%attributes = {"executedOnServer":true}
  // IN_LoadSubjects()
  // Por: Alberto Bachler: 08/03/13, 16:15:42
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------

  //TRACE
C_LONGINT:C283($i_registros;$l_IdMateria;$l_IdProceso;$l_OrdenMateria;$l_OrdenSector;$l_registros;$l_respuesta)
C_TEXT:C284($t_carpeta;$t_materia;$t_nombreDocumento;$t_nombreTabla)


If (Application type:C494=4D Remote mode:K5:5)
	$l_IdProceso:=Execute on server:C373(Current method name:C684;Pila_256K;Current method name:C684)
Else 
	$t_nombreDocumento:=Get 4D folder:C485(Database folder:K5:14)+"Config"+Folder separator:K24:12+<>vtXS_CountryCode+Folder separator:K24:12+"Materias_"+<>vtXS_CountryCode+".txt"
	If ($t_nombreDocumento#"")
		SET CHANNEL:C77(10;$t_nombreDocumento)
		If (ok=1)
			READ WRITE:C146([xxSTR_Materias:20])
			If (IT_AltKeyIsDown )
				$l_respuesta:=CD_Dlog (0;__ ("¿Desea Ud. realmente inicializar el archivo completamente?");__ ("");__ ("Si");__ ("No"))
				If ($l_respuesta=1)
					QUERY:C277([xxSTR_Materias:20];[xxSTR_Materias:20]Subsector_Oficial:15=True:C214)
					DELETE SELECTION:C66([xxSTR_Materias:20])
				End if 
			End if 
			$l_IdProceso:=IT_UThermometer (1;0;__ ("Cargando el archivo de materias por defecto…"))
			
			  //ABC191072
			  //agregado recientemente.
			RECEIVE VARIABLE:C81($t_nombreTabla)
			RECEIVE VARIABLE:C81($l_registros)
			For ($i_registros;1;$l_registros)
				  //RECEIVE VARIABLE($t_materia)
				  //QUERY([xxSTR_Materias];[xxSTR_Materias]Materia=$t_materia)
				  //If (Records in selection([xxSTR_Materias])=0)
				RECEIVE RECORD:C79([xxSTR_Materias:20])
				$l_recNum:=Find in field:C653([xxSTR_Materias:20]ID_Materia:16;[xxSTR_Materias:20]ID_Materia:16)
				If ($l_recNum<0)
					
					  //RECEIVE RECORD([xxSTR_Materias])
					[xxSTR_Materias:20]Auto_UUID:21:=Generate UUID:C1066  //20140123 RCH
					SAVE RECORD:C53([xxSTR_Materias:20])
				Else 
					  //  //si existe no hacer nada
					  //el proximo receibe record, cambia al proximo registro.
					  //$l_OrdenSector:=[xxSTR_Materias]NoSector
					  //$l_OrdenMateria:=[xxSTR_Materias]Orden interno
					  //$l_IdMateria:=[xxSTR_Materias]ID_Materia
					  //DELETE RECORD([xxSTR_Materias])
					  //RECEIVE RECORD([xxSTR_Materias])
					  //[xxSTR_Materias]NoSector:=$l_OrdenSector
					  //[xxSTR_Materias]Orden interno:=$l_OrdenMateria
					  //[xxSTR_Materias]ID_Materia:=$l_IdMateria
					  //[xxSTR_Materias]Auto_UUID:=Generate UUID  //20140123 RCH
					  //SAVE RECORD([xxSTR_Materias])
				End if 
			End for 
			SET CHANNEL:C77(11)
			READ ONLY:C145([xxSTR_Materias:20])
			IT_UThermometer (-2;$l_IdProceso)
			STR_CargaArreglosInterproceso 
		Else 
			CD_Dlog (0;__ ("El archivo que contiene las materias no pudo ser cargado."))
		End if 
	End if 
End if 