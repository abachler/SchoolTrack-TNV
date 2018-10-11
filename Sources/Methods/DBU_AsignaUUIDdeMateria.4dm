//%attributes = {}
  //DBU_AsignaUUIDdeMateria
  //nuevo campo de uuid de materia en asignaturas y asignaturas historico, es llenado con el uudi de materia de los subsectores
  //llamado con parametros desde el formulario [xxSTR_Materias].RelacionaMateriaAsignatura

ARRAY LONGINT:C221($al_recnum_asignaturas;0)
C_BOOLEAN:C305($useInterfaz;$1)
C_POINTER:C301($y_rnAsig;$2;$y_rnAsigHist;$3)
C_LONGINT:C283($i;$l_idTermometro;$l_encontrados;$l_noencontrados;$l_masdeunregistro)

If (Count parameters:C259=3)
	$useInterfaz:=$1
	$y_rnAsig:=$2
	$y_rnAsigHist:=$3
End if 

READ ONLY:C145([xxSTR_Materias:20])
READ ONLY:C145([Asignaturas:18])
READ ONLY:C145([Asignaturas_Historico:84])

QUERY BY FORMULA:C48([Asignaturas:18];Not:C34(Util_isValidUUID ([Asignaturas:18]Materia_UUID:46)))
LONGINT ARRAY FROM SELECTION:C647([Asignaturas:18];$al_recnum_asignaturas;"")

$l_idTermometro:=IT_Progress (1;0;0;"buscando uuid de materia para asignaturas actuales")
For ($i;1;Size of array:C274($al_recnum_asignaturas))
	READ WRITE:C146([Asignaturas:18])
	$l_idTermometro:=IT_Progress (0;$l_idTermometro;$i/Size of array:C274($al_recnum_asignaturas))
	
	GOTO RECORD:C242([Asignaturas:18];$al_recnum_asignaturas{$i})
	QUERY:C277([xxSTR_Materias:20];[xxSTR_Materias:20]Materia:2=[Asignaturas:18]Asignatura:3)
	
	Case of 
		: (Records in selection:C76([xxSTR_Materias:20])=1)
			[Asignaturas:18]Materia_UUID:46:=[xxSTR_Materias:20]Auto_UUID:21
			SAVE RECORD:C53([Asignaturas:18])
		: (Records in selection:C76([xxSTR_Materias:20])>1)
			If ($useInterfaz)
				APPEND TO ARRAY:C911($y_rnAsig->;$al_recnum_asignaturas{$i})
			End if 
			$l_masdeunregistro:=$l_masdeunregistro+1
		: (Records in selection:C76([xxSTR_Materias:20])=0)
			$l_noencontrados:=$l_noencontrados+1
			If ($useInterfaz)
				APPEND TO ARRAY:C911($y_rnAsig->;$al_recnum_asignaturas{$i})
			End if 
	End case 
	
	KRL_UnloadReadOnly (->[Asignaturas:18])
End for 
$l_idTermometro:=IT_Progress (-1;$l_idTermometro)


C_LONGINT:C283($i;$l_idTermometro;$l_encontrados;$l_noencontrados;$l_masdeunregistro)
ARRAY LONGINT:C221($al_recnum_asignaturas;0)

QUERY BY FORMULA:C48([Asignaturas_Historico:84];Not:C34(Util_isValidUUID ([Asignaturas_Historico:84]Materia_UUID:45)))
LONGINT ARRAY FROM SELECTION:C647([Asignaturas_Historico:84];$al_recnum_asignaturas;"")
$l_idTermometro:=IT_Progress (1;0;0;"buscando uuid de materia para asignaturas históricas")
For ($i;1;Size of array:C274($al_recnum_asignaturas))
	READ WRITE:C146([Asignaturas_Historico:84])
	$l_idTermometro:=IT_Progress (0;$l_idTermometro;$i/Size of array:C274($al_recnum_asignaturas))
	
	GOTO RECORD:C242([Asignaturas_Historico:84];$al_recnum_asignaturas{$i})
	QUERY:C277([xxSTR_Materias:20];[xxSTR_Materias:20]Materia:2=[Asignaturas_Historico:84]Asignatura:2)
	
	Case of 
		: (Records in selection:C76([xxSTR_Materias:20])=1)
			$l_encontrados:=$l_encontrados+1
			[Asignaturas_Historico:84]Materia_UUID:45:=[xxSTR_Materias:20]Auto_UUID:21
			SAVE RECORD:C53([Asignaturas_Historico:84])
		: (Records in selection:C76([xxSTR_Materias:20])>1)
			$l_masdeunregistro:=$l_masdeunregistro+1
			If ($useInterfaz)
				APPEND TO ARRAY:C911($y_rnAsigHist->;$al_recnum_asignaturas{$i})
			End if 
		: (Records in selection:C76([xxSTR_Materias:20])=0)
			$l_noencontrados:=$l_noencontrados+1
			If ($useInterfaz)
				APPEND TO ARRAY:C911($y_rnAsigHist->;$al_recnum_asignaturas{$i})
			End if 
	End case 
	
	KRL_UnloadReadOnly (->[Asignaturas_Historico:84])
End for 
$l_idTermometro:=IT_Progress (-1;$l_idTermometro)
