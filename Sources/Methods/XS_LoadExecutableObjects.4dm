//%attributes = {}
  // Método: XS_LoadExecutableObjects
  //----------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 12/07/10, 11:53:15
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // ƒ
  //----------------------------------------------
  // Declaraciones e inicializaciones


  // Código principal

If (Application type:C494=4D Remote mode:K5:5)
	$p:=Execute on server:C373("XS_LoadExecutableObjects";Pila_256K;"Actualizando ExecObjects")
	
Else 
	$file:=SYS_CarpetaAplicacion (CLG_Estructura)+"Config"+Folder separator:K24:12+"ExecObjects.txt"
	
	  //MAIN CODE
	SET CHANNEL:C77(10;$file)
	If (ok=1)
		$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Actualizando librería de objetos ejecutables…"))
		READ WRITE:C146([XShell_ExecutableObjects:280])
		ALL RECORDS:C47([XShell_ExecutableObjects:280])
		KRL_DeleteSelection (->[XShell_ExecutableObjects:280])
		RECEIVE VARIABLE:C81(nbRecords)
		For ($k;1;nbrecords)
			$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$k/nbRecords)
			CREATE RECORD:C68([XShell_ExecutableObjects:280])
			RECEIVE RECORD:C79([XShell_ExecutableObjects:280])
			SAVE RECORD:C53([XShell_ExecutableObjects:280])
		End for 
		SET CHANNEL:C77(11)
		READ ONLY:C145([XShell_ExecutableObjects:280])
		SQ_RestauraSecuencias (->[XShell_ExecutableObjects:280]Object_ID:13)
		$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
	Else 
		$r:=CD_Dlog (1;__ ("No se encontró el archivo que contiene la librería de objetos ejecutables."))
	End if 
End if 