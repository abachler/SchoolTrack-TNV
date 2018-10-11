//%attributes = {}
  // PP_RegistraFallecimiento()
  // Por: Alberto Bachler K.: 27-03-14, 20:22:40
  //  ---------------------------------------------

If ([Personas:7]Fallecido:88)
	$go:=True:C214
	$accountTrackIsInitialized:=Num:C11(PREF_fGet (0;"ACT_Inicializado";"0"))
	If (($accountTrackIsInitialized=1) & ([Personas:7]ES_Apoderado_de_Cuentas:42))
		CD_Dlog (0;__ ("No puede registrar el fallecimiento de persona ya que es apoderado de cuentas en AccountTrack.\r\r Por favor traspase las deudas de las cargas de este apoderado antes de marcarlo como fallecido."))
		[Personas:7]Fallecido:88:=False:C215
		[Personas:7]Estado_civil:10:=Old:C35([Personas:7]Estado_civil:10)
		[Personas:7]Inactivo:46:=Old:C35([Personas:7]Inactivo:46)
	Else 
		LOG_RegisterEvt (__ ("Se registró el fallecimiento de ")+[Personas:7]Apellidos_y_nombres:30)
		[Personas:7]Inactivo:46:=True:C214
		OBJECT SET VISIBLE:C603(*;"muerte@";True:C214)
	End if 
End if 
OBJECT SET ENTERABLE:C238([Personas:7]Fallecido:88;Not:C34([Personas:7]Fallecido:88))





