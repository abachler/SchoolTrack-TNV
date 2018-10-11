_O_DISABLE BUTTON:C193(bPrev)
_O_DISABLE BUTTON:C193(bNext)

If (((Macintosh option down:C545) | (Windows Alt down:C563)) & (<>lUSR_RelatedTableUserID=-1))
	vt_ResultadoDiagnostico:=__ ("El programa de autodiagnóstico se ejecutó exitosamente.\rNo se detectó ningún problema.")
	OBJECT SET COLOR:C271(vt_ResultadoDiagnostico;-9)
	_O_ENABLE BUTTON:C192(bPrev)
	_O_ENABLE BUTTON:C192(bNext)
	OBJECT SET VISIBLE:C603(bDiagnostico;False:C215)
Else 
	$displayResult:=False:C215
	DIAG_Main ($displayResult)
	
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
			If (Application type:C494=4D Remote mode:K5:5)
				$diagnosticFile:=SYS_LongName2Filepath (Application file:C491)+"Diagnóstico_"+<>gRolBD+".txt"
			Else 
				$diagnosticFile:=SYS_LongName2Filepath (SYS_GetDataPath )+"Diagnóstico_"+<>gRolBD+".txt"
			End if 
			vt_ResultadoDiagnostico:=Replace string:C233(__ ("El programa de autodiágnostico terminó de ejecutarse.\rSe detectaron errores graves en la base de datos.\rPara mayor información consulte el documento:\r\rˆ0");"ˆ0";vt_DiagnosticFileName)
			OBJECT SET COLOR:C271(vt_ResultadoDiagnostico;-3)
			OBJECT SET VISIBLE:C603(*;"printdiagnostico@";True:C214)
			_O_ENABLE BUTTON:C192(bPrev)
		: ($result=0)
			If (Application type:C494=4D Remote mode:K5:5)
				$diagnosticFile:=SYS_LongName2Filepath (Application file:C491)+"Diagnóstico_"+<>gRolBD+".txt"
			Else 
				$diagnosticFile:=SYS_LongName2Filepath (SYS_GetDataPath )+"Diagnóstico_"+<>gRolBD+".txt"
			End if 
			vt_ResultadoDiagnostico:=Replace string:C233(__ ("El programa de autodiágnostico terminó de ejecutarse.\rSe detectaron pequeños problemas en la base de datos.\rPara mayor información consulte el documento:\r\rˆ0");"ˆ0";vt_DiagnosticFileName)
			OBJECT SET VISIBLE:C603(*;"printdiagnostico@";True:C214)
			OBJECT SET COLOR:C271(vt_ResultadoDiagnostico;-47)
			_O_ENABLE BUTTON:C192(bPrev)
			_O_ENABLE BUTTON:C192(bNext)
		: ($result=1)
			vt_ResultadoDiagnostico:=__ ("El programa de autodiagnóstico se ejecutó exitosamente.\rNo se detectó ningún problema.")
			OBJECT SET COLOR:C271(vt_ResultadoDiagnostico;-9)
			_O_ENABLE BUTTON:C192(bPrev)
			_O_ENABLE BUTTON:C192(bNext)
	End case 
	
End if 