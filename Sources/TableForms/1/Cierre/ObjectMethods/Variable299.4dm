_O_DISABLE BUTTON:C193(bPrev)
_O_DISABLE BUTTON:C193(bNext)

dbuACT_VerificaIntegridadPagos ("desdeCierre")

If (Size of array:C274(aQR_Longint1)>0)
	$resp:=CD_Dlog (0;__ ("Existen problemas relacionados a ")+String:C10(Size of array:C274(aQR_Longint1))+__ (" pagos. Por favor revise y corrija el siguiente listado de pagos antes de continuar.\r\rSi a pesar de los problemas encontrados usted desea continuar, presione Continuar.");__ ("");__ ("Ok");__ ("Continuar"))
	OBJECT SET VISIBLE:C603(lb_ErroresPagos;True:C214)
	OBJECT SET VISIBLE:C603(bTextFile;True:C214)
	OBJECT SET VISIBLE:C603(vt_instrucciones;False:C215)
	If ($resp=2)
		_O_ENABLE BUTTON:C192(bNext)
		OBJECT SET VISIBLE:C603(bDiagnostico;False:C215)
	Else 
		_O_DISABLE BUTTON:C193(bDiagnostico)
	End if 
Else 
	vt_instrucciones:="No se encontraron problemas relacionados a los pagos."
	OBJECT SET VISIBLE:C603(bDiagnostico;False:C215)
	_O_ENABLE BUTTON:C192(bNext)
End if 
OBJECT SET VISIBLE:C603(*;"vt1";False:C215)
OBJECT SET VISIBLE:C603(*;"vt2";True:C214)