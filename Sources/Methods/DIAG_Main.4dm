//%attributes = {}
  //DIAG_Main

C_LONGINT:C283($0;$result)
C_BOOLEAN:C305($displayResult;$1)

If (Count parameters:C259=1)
	$displayResult:=$1
Else 
	$displayResult:=True:C214
End if 

ARRAY TEXT:C222($at_errores;0)
APPEND TO ARRAY:C911($at_errores;__ ("ERROR GRAVE: Asignatura sin estilo de evaluación definido.\rSOLUCION: Definir el estilo de evaluación"))
APPEND TO ARRAY:C911($at_errores;__ ("ERROR GRAVE: El estilo de evaluación definido para la asignatura no existe.\rSOLUCION: Debe reasignar un estilo de evaluación existente."))
APPEND TO ARRAY:C911($at_errores;__ ("ERROR GRAVE: Nivel sin estilo de evaluación definido.\rSOLUCION: Asignar el estilo de evaluación oficial en Configuración/Niveles"))
APPEND TO ARRAY:C911($at_errores;__ ("ERROR GRAVE: El estilo de evaluación definido para el nivel no existe.\rSOLUCION: Debe reasignar un estilo de evaluación existente en Configuración/Niveles."))
APPEND TO ARRAY:C911($at_errores;__ ("ERROR GRAVE: La letra oficial del curso no ha sido definida.\rSOLUCION: Digite la letra oficial del curso en la ficha del curso"))
APPEND TO ARRAY:C911($at_errores;__ ("ERROR GRAVE: La asignatura no tiene posición definida en el modelo de acta y certificado.\rSOLUCION: Definir la posición de la asignatura en Configuración /Informes especiales/Actas y Certificados"))
APPEND TO ARRAY:C911($at_errores;__ ("ADVERTENCIA: El sector correspondiente al subsector no ha sido definido.\rSOLUCION: Definir el sector correpondiente en Configuración/Subsectores"))
APPEND TO ARRAY:C911($at_errores;__ ("ERROR GRAVE: La imagen necesaria para el encabezamiento del acta no ha sido definida.\rSOLUCION: Definir la imagen correpondiente en Configuración/Subsectores"))
APPEND TO ARRAY:C911($at_errores;__ ("ERROR GRAVE: La abreviación oficial del nivel o grado no ha sido definida.\rSOLUCION: Digite la abreviación en el nivel o grado en Archivo/Configuración/Niveles"))
APPEND TO ARRAY:C911($at_errores;__ ("ADVERTENCIA: La abreviación del subsector no ha sido definida.\rSOLUCION: Ingrese la abreviación correspondiente en Preferencias > Subsectores"))
APPEND TO ARRAY:C911($at_errores;__ ("ERROR GRAVE: El número de columnas es superior a 30.\rSOLUCION: Reduzca el número de columnas a un máximo de 30"))
APPEND TO ARRAY:C911($at_errores;__ ("ERROR GRAVE: Nombres de profesores firmantes no definidos.\rSOLUCION: En la ficha del curso, haga clic en la lengueta Firmas en actas y defina los profesores firmantes."))
APPEND TO ARRAY:C911($at_errores;__ ("ERROR GRAVE: El estilo de evaluación no tiene definido el modo de evaluación de referencia.\rSOLUCION: En Preferencias -> Evaluación defina el modo de evaluación de referencia."))
APPEND TO ARRAY:C911($at_errores;__ ("ERROR GRAVE: El estilo de evaluación no tiene definido el modo de ingreso de las evaluaciones.\rSOLUCION: En Preferencias -> Evaluación defina el modo de ingreso de las evaluaciones."))
APPEND TO ARRAY:C911($at_errores;__ ("ERROR GRAVE: El estilo de evaluación no tiene definido el modo de impresion de las evaluaciones.\rSOLUCION: En Preferencias -> Evaluación defina el modo de impresión de las evaluaciones."))
APPEND TO ARRAY:C911($at_errores;__ ("ERROR GRAVE: El estilo de evaluación no tiene definido el modo de visualización de las evaluaciones.\rSOLUCION: En Preferencias -> Evaluación defina el modo de visualización de las evaluaciones."))
APPEND TO ARRAY:C911($at_errores;__ ("ERROR GRAVE: El estilo de evaluación no tiene definido el modo de impresión de las evaluaciones en documentos oficiales.\rSOLUCION: En Preferencias -> Evaluación defina el modo de impresión de las evaluaciones en documentos oficiales."))
APPEND TO ARRAY:C911($at_errores;__ ("ADVERTENCIA: La fecha de término del año escolar para el nivel no era válida y fué ajustada.\rRECOMENDACION:  Ejecutar el comando \"Reparar Informaciones conductuales\" para corregir eventuales errores en los cálculos de asistencia."))
APPEND TO ARRAY:C911($at_errores;__ ("ADVERTENCIA: Se detectaron duplicados en la lista de días feriados.\rLos duplicados fueron eliminados.\rRECOMENDACION:  Ejecutar el comando \"Reparar Informaciones conductuales\" para corregir eventuales errores en los cálculos de asistencia."))
APPEND TO ARRAY:C911($at_errores;__ ("ERROR GRAVE: El alumno no puede estar cursando dos asignaturas incluidas en actas con el mismo nombre.\rSOLUCION:  Retirar al alumno de la asignatura o cambiar el nombre."))
APPEND TO ARRAY:C911($at_errores;__ ("ADVERTENCIA: El subsector no está definido en la lista de subsectores de aprendizaje por lo que no tiene incidencia en promedio ni puede ser incluido en Actas.\rEsto NO ES NECESARIAMENTE un error pero puede conducir a resultados inesperados."))
APPEND TO ARRAY:C911($at_errores;__ ("ERROR GRAVE: La columna no esta definida en el modelo de acta del nivel o del curso (si el modelo es específico al curso).\rSOLUCION:  Definir la columna en el modelo."))


$vb_MsgON:=<>vb_MsgON
<>vb_MsgON:=True:C214
ARRAY LONGINT:C221(aDiagnosticErrors;0)
  // construccion de la lista de errores graves
ARRAY LONGINT:C221(aErroresGraves;22)
For ($i;1;Size of array:C274(aErroresGraves))
	aErroresGraves{$i}:=$i
End for 
DELETE FROM ARRAY:C228(aErroresGraves;21)
DELETE FROM ARRAY:C228(aErroresGraves;19)
DELETE FROM ARRAY:C228(aErroresGraves;18)
  //DELETE FROM ARRAY(aErroresGraves;12)
DELETE FROM ARRAY:C228(aErroresGraves;10)
  //DELETE FROM ARRAY(aErroresGraves;9)
DELETE FROM ARRAY:C228(aErroresGraves;7)
  //DELETE FROM ARRAY(aErroresGraves;5)

EVS_LoadStyles 
SYS_GetServerProperty (XS_DataFileName)

  //vt_DiagnosticFileName:=SYS_CarpetaAplicacion (CLG_DocumentosLocal_ST)+"Diagnósticos_"+<>gCustom+"_"+String(Current date;ISO date;Current time)+".txt"
  //MONO cambio de gCustom a gRolBD en el nombre del archivo ticket 195635
vt_DiagnosticFileName:=SYS_CarpetaAplicacion (CLG_DocumentosLocal_ST)+"Diagnósticos_"+<>gRolBD+"_"+DTS_Get_GMT_TimeStamp +".txt"  //20170426 ASM Ticket 180324

vhDIAG_docRef:=Create document:C266(vt_DiagnosticFileName;"TEXT")
$text:="Autodiagnóstico de la base de datos "+SYS_GetServerProperty (XS_DataFileName)+"\r"+String:C10(Current date:C33(*);2)+"\r\r"
IO_SendPacket (vhDIAG_docRef;$text)
$text:=__ ("\r\r1. INSTRUCCIONES\r")
IO_SendPacket (vhDIAG_docRef;$text)
$text:=__ ("Bajo el título \"Errores detectados\" usted encontrará\rla lista de objetos en los que se detectaron errores. \rCada error detectado es seguido del código de error.\r")
IO_SendPacket (vhDIAG_docRef;$text)
$text:=__ ("La descripción del error y su solución se encuentra \ral final del documento bajo el título \r\"Explicación de los errores detectados\"")
IO_SendPacket (vhDIAG_docRef;$text)
$text:=__ ("\r\r2. ERRORES DETECTADOS\r")
IO_SendPacket (vhDIAG_docRef;$text)

dbu_DeleteOrphanGradesRecords 



If (True:C214)
	DIAG_EvaluationStyles 
End if 

If (True:C214)
	DIAG_GradesSubjectNames 
End if 

If (True:C214)
	DIAG_HGradesSubjectNames 
End if 

Case of 
	: (<>vtXS_CountryCode="cl")
		DIAG_VerifActasYCertificados 
End case 

If (True:C214)
	DIAG_VerificaMaterias 
End if 

If (True:C214)
	DIAG_VerificaAsignaturasAlumnos 
End if 

If (Size of array:C274(aDiagnosticErrors)>0)
	$text:=__ ("\r\r3. EXPLICACIÓN DE LOS ERRORES DETECTADOS\r")
	IO_SendPacket (vhDIAG_docRef;$text)
	If (SYS_IsWindows )
		$endOfLine:="\r"+Char:C90(10)
	Else 
		$endOfLine:="\r"
	End if 
	SORT ARRAY:C229(aDiagnosticErrors;>)
	For ($i;1;Size of array:C274(aDiagnosticErrors))
		$text:="Error Nº: "+String:C10(aDiagnosticErrors{$i})+$endOfLine+$at_errores{aDiagnosticErrors{$i}}+$endOfLine+$endOfLine
		IO_SendPacket (vhDIAG_docRef;$text)
	End for 
	CLOSE DOCUMENT:C267(vhDIAG_docRef)
	
	$result:=1
	If (Size of array:C274(aDiagnosticErrors)>0)
		$result:=0
		For ($i;1;Size of array:C274(aErroresGraves))
			If (Find in array:C230(aDiagnosticErrors;aErroresGraves{$i})>0)
				$result:=-1
				$i:=Size of array:C274(aErroresGraves)
			End if 
		End for 
	End if 
	OBJECT SET VISIBLE:C603(bDiagnostico;False:C215)
	Case of 
		: ($result=-1)
			vt_ResultadoDiagnostico:=Replace string:C233(__ ("El programa de autodiágnostico terminó de ejecutarse.\rSe detectaron errores graves en la base de datos.\rPara mayor información consulte el documento:\r\rˆ0");"ˆ0";vt_DiagnosticFileName)
		: ($result=0)
			vt_ResultadoDiagnostico:=Replace string:C233(__ ("El programa de autodiágnostico terminó de ejecutarse.\rSe detectaron pequeños problemas en la base de datos.\rPara mayor información consulte el documento:\r\rˆ0");"ˆ0";vt_DiagnosticFileName)
		: ($result=1)
			vt_ResultadoDiagnostico:=__ ("El programa de autodiagnóstico se ejecutó exitosamente.\rNo se detectó ningún problema.")
	End case 
	
	If ($displayResult)
		If (Application type:C494=4D Server:K5:6)
			
		Else 
			OK:=CD_Dlog (0;vt_ResultadoDiagnostico+__ ("\r\r¿Desea imprimir el informe de diagnóstico ahora?");__ ("");__ ("Si");__ ("No"))
			If (ok=1)
				ARRAY TEXT:C222(at_TextLines;0)
				OBJECT SET VISIBLE:C603(*;"Diagnostico@";True:C214)
				
				$ref:=Open document:C264(vt_DiagnosticFileName)
				RECEIVE PACKET:C104($ref;$record;"\r")
				While (OK=1)
					INSERT IN ARRAY:C227(at_TextLines;Size of array:C274(at_TextLines)+1;1)
					at_TextLines{Size of array:C274(at_TextLines)}:=$record
					RECEIVE PACKET:C104($ref;$record;"\r")
				End while 
				CLOSE DOCUMENT:C267($ref)
				
				READ ONLY:C145(*)
				QUERY:C277([xShell_Reports:54];[xShell_Reports:54]ReportName:26="Diagnostico")
				xSR_ReportBlob:=[xShell_Reports:54]xReportData_:29
				
				ALL RECORDS:C47([xxSTR_Constants:1])
				REDUCE SELECTION:C351([xxSTR_Constants:1];1)
				
				If ((Macintosh option down:C545) | (Windows Alt down:C563))
					iSR_WinRef:=SR Preview (xSR_ReportBlob;10;60;610;600;8;[xShell_Reports:54]ReportName:26)
				Else 
					$err:=SR Print Report (xSR_ReportBlob;3;65535)
				End if 
				
			End if 
		End if 
	End if 
Else 
	$result:=1
	$text:=__ ("El programa de autodiágnostico terminó de ejecutarse.\rSe detectaron errores graves en la base de datos.\rPara mayor información consulte el documento:\r\rˆ0")
	IO_SendPacket (vhDIAG_docRef;$text)
	If ($displayResult)
		If (Application type:C494=4D Server:K5:6)
			
		Else 
			CD_Dlog (0;__ ("El programa de autodiagnóstico se ejecutó exitosamente.\rNo se detectó ningún problema."))
			DELAY PROCESS:C323(Current process:C322;60*10)
			CLOSE WINDOW:C154
		End if 
	End if 
	$text:=__ ("No se detectó ningún problema.")
	IO_SendPacket (vhDIAG_docRef;$text)
	CLOSE DOCUMENT:C267(vhDIAG_docRef)
End if 


<>vb_MsgON:=$vb_MsgON

$0:=$result

