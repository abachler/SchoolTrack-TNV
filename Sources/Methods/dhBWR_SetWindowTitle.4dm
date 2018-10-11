//%attributes = {}
  //dhBWR_SetWindowTitle

  //xShell, Alberto Bachler
  //Metodo: dhBWR_SetWindowTitle
  //Por abachler
  //Creada el 10/02/2004, 08:47:00
  //Modificaciones:
If ("INSTRUCCIONES"="")
	  //llamado desde: BWR_SetWindowTitle
	  //utilizar para desviar el procesamiento estandar del evento en xShell
	  //En el Case of poner las instrucciones necesarias para procesar el evento para cada tabla en que se requiera
	  //Asignar True a $trapped si el evento es procesado
End if 

  //****DECLARACIONES****
C_BOOLEAN:C305($trapped)
$trapped:=False:C215

  //****INICIALIZACIONES****

Case of 
	: (<>vtXS_langage="es")
		$windowTitle:="Explorador "+vsBWR_CurrentModule
	: (<>vtXS_langage="en")
		$windowTitle:=vsBWR_CurrentModule+" Explorer"
	: (<>vtXS_langage="fr")
		$windowTitle:=vsBWR_CurrentModule+" Explorer"
	: (<>vtXS_langage="pt")
		$windowTitle:=vsBWR_CurrentModule+" Explorer"
	: (<>vtXS_langage="it")
		$windowTitle:=vsBWR_CurrentModule+" Explorer"
	: (<>vtXS_langage="de")
		$windowTitle:=vsBWR_CurrentModule+" Explorer"
End case 

$version:=" (v"+SYS_LeeVersionEstructura +")"
$windowTitle:=$windowTitle+$version

  //****CUERPO****
Case of 
	: (<>vsXS_CurrentModule="AccountTrack")
		Case of 
			: (Table:C252(yBWR_CurrentTable)=Table:C252(->[ACT_Documentos_de_Pago:176]))
				C_LONGINT:C283($Depositados)
				SET QUERY DESTINATION:C396(Into variable:K19:4;$Depositados)
				QUERY:C277([ACT_Documentos_de_Pago:176];[ACT_Documentos_de_Pago:176]Depositado:35=True:C214)
				SET QUERY DESTINATION:C396(Into current selection:K19:1)
				$windowTitle:=$windowTitle+":  "+vsBWR_selectedTableName+": "+String:C10(Size of array:C274(alBWR_recordNumber))+__ (" entre ")+String:C10($Depositados)+" - "+<>tUSR_CurrentUserName+" - "+<>gNombreAgnoEscolar
				SET WINDOW TITLE:C213($windowTitle)
				$trapped:=True:C214
			: (Table:C252(yBWR_CurrentTable)=Table:C252(->[Personas:7]))
				C_LONGINT:C283($ApdosdeCuentas)
				SET QUERY DESTINATION:C396(Into variable:K19:4;$ApdosdeCuentas)
				QUERY:C277([Personas:7];[Personas:7]ES_Apoderado_de_Cuentas:42=True:C214)
				SET QUERY DESTINATION:C396(Into current selection:K19:1)
				$windowTitle:=$windowTitle+":  "+vsBWR_selectedTableName+": "+String:C10(Size of array:C274(alBWR_recordNumber))+__ (" entre ")+String:C10($ApdosdeCuentas)+" - "+<>tUSR_CurrentUserName+" - "+<>gNombreAgnoEscolar
				SET WINDOW TITLE:C213($windowTitle)
				$trapped:=True:C214
		End case 
	: (<>vsXS_CurrentModule="AdmissionTrack")
		Case of 
			: (Table:C252(yBWR_CurrentTable)=Table:C252(->[Profesores:4]))
				C_LONGINT:C283($Entrevistadores)
				SET QUERY DESTINATION:C396(Into variable:K19:4;$Entrevistadores)
				QUERY:C277([Profesores:4];[Profesores:4]Es_Entrevistador_Admisiones:35=True:C214)
				SET QUERY DESTINATION:C396(Into current selection:K19:1)
				$windowTitle:=$windowTitle+":  "+vsBWR_selectedTableName+": "+String:C10(Size of array:C274(alBWR_recordNumber))+__ (" entre ")+String:C10($Entrevistadores)+" - "+<>tUSR_CurrentUserName+" - "+<>gNombreAgnoEscolar
				SET WINDOW TITLE:C213($windowTitle)
				$trapped:=True:C214
		End case 
	: (<>vsXS_CurrentModule="SchoolTrack")
		Case of 
			: (Table:C252(yBWR_CurrentTable)=Table:C252(->[Alumnos:2]))
				C_LONGINT:C283($alumnos)
				If (Not:C34(IT_AltKeyIsDown ))
					SET QUERY DESTINATION:C396(Into variable:K19:4;$alumnos)
					QUERY:C277([Alumnos:2];[Alumnos:2]curso:20#"@-ADT";*)
					QUERY:C277([Alumnos:2]; & ;[Alumnos:2]curso:20#"POST")  //para no mostrar los cursos de admissiontrack
					SET QUERY DESTINATION:C396(Into current selection:K19:1)
				Else 
					$alumnos:=Records in table:C83([Alumnos:2])
				End if 
				$windowTitle:=$windowTitle+":  "+vsBWR_selectedTableName+": "+String:C10(Size of array:C274(alBWR_recordNumber))+__ (" entre ")+String:C10($alumnos)+" - "+<>tUSR_CurrentUserName+" - "+<>gNombreAgnoEscolar
				SET WINDOW TITLE:C213($windowTitle)
				$trapped:=True:C214
			: (Table:C252(yBWR_CurrentTable)=Table:C252(->[Cursos:3]))
				C_LONGINT:C283($cursos)
				If (Not:C34(IT_AltKeyIsDown ))
					SET QUERY DESTINATION:C396(Into variable:K19:4;$cursos)
					QUERY:C277([Cursos:3];[Cursos:3]Numero_del_curso:6>0)  //para no mostrar los cursos de admissiontrack
					SET QUERY DESTINATION:C396(Into current selection:K19:1)
				Else 
					$cursos:=Records in table:C83([Cursos:3])
				End if 
				$windowTitle:=$windowTitle+":  "+vsBWR_selectedTableName+": "+String:C10(Size of array:C274(alBWR_recordNumber))+__ (" entre ")+String:C10($cursos)+" - "+<>tUSR_CurrentUserName+" - "+<>gNombreAgnoEscolar
				SET WINDOW TITLE:C213($windowTitle)
				$trapped:=True:C214
		End case 
End case 
  //****LIMPIEZA****

$0:=$trapped