//%attributes = {}
  //BBLsys_LoadSystemUsers
If (Application type:C494=4D Remote mode:K5:5)
	$pID:=Execute on server:C373("BBLsys_LoadSystemUsers";Pila_256K)
Else 
	READ WRITE:C146([BBL_Lectores:72])
	QUERY:C277([BBL_Lectores:72];[BBL_Lectores:72]ID:1<0)
	DELETE SELECTION:C66([BBL_Lectores:72])
	$file:=SYS_CarpetaAplicacion (CLG_Estructura)+"Config"+Folder separator:K24:12+"bbl_SystemUsers.txt"
	SET CHANNEL:C77(10;$file)
	If (ok=1)
		RECEIVE VARIABLE:C81(nbRec)
		$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Importando usuarios sistema "))
		For ($i;1;nbRec)
			RECEIVE RECORD:C79([BBL_Lectores:72])
			QUERY:C277([BBL_Prestamos:60];[BBL_Prestamos:60]Número_de_lector:2=[BBL_Lectores:72]ID:1)
			[BBL_Lectores:72]Total_de_préstamos:8:=Records in selection:C76([BBL_Prestamos:60])
			QUERY SELECTION:C341([BBL_Prestamos:60];[BBL_Prestamos:60]Fecha_de_devolución:5=!00-00-00!)
			[BBL_Lectores:72]Préstamos_actuales:9:=Records in selection:C76([BBL_Prestamos:60])
			SAVE RECORD:C53([BBL_Lectores:72])
			$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/nbRec)
		End for 
		$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
	End if 
	SET CHANNEL:C77(11)
End if 