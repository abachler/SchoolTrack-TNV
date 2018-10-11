//%attributes = {}
  //Metodo: BBLin_LoadMARCcodes
  //Por abachler
  //Creada el 08/10/2007, 09:36:39
  // ----------------------------------------------------
  // Descripción
  // 
  //
  // ----------------------------------------------------
  // Parámetros
  // 
  // ----------------------------------------------------

  //DECLARACIONES & INICIALIZACIONES
If (Application type:C494=4D Remote mode:K5:5)
	$pId:=Execute on server:C373(Current method name:C684;Pila_256K)
Else 
	C_DATE:C307($date)
	C_TIME:C306($time)
	C_TEXT:C284($t_nombreTabla)
	C_LONGINT:C283($l_registros)
	$file:=SYS_CarpetaAplicacion (CLG_Estructura)+"Config"+Folder separator:K24:12+"MARC_codes.txt"
	
	  //MAIN CODE
	SET CHANNEL:C77(10;$file)
	If (ok=1)
		KRL_ClearTable (->[xxBBL_MarcRecordStructure:75])
		$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Actualizando la lista de Códigos MARC…"))
		
		RECEIVE VARIABLE:C81($t_nombreTabla)
		RECEIVE VARIABLE:C81($l_registros)
		  //ABC191072 
		For ($k;1;$l_registros)
			$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$k/$l_registros;__ ("Actualizando la lista de Códigos MARC…"))
			CREATE RECORD:C68([xxBBL_MarcRecordStructure:75])
			RECEIVE RECORD:C79([xxBBL_MarcRecordStructure:75])
			[xxBBL_MarcRecordStructure:75]Auto_UUID:12:=Generate UUID:C1066  //20140123 RCH
			SAVE RECORD:C53([xxBBL_MarcRecordStructure:75])
		End for 
		SET CHANNEL:C77(11)
		READ ONLY:C145([xxBBL_MarcRecordStructure:75])
		$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
	Else 
		$r:=CD_Dlog (1;__ ("El archivo que contiene los códigos MARC no pudo ser encontrado o abierto."))
	End if 
End if 



  //END OF MAIN CODE 


  //CLEANING


  //END OF METHOD 

