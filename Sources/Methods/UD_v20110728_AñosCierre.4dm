//%attributes = {}
  // MÉTODO: UD_v20110728_AñosCierre
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 28/07/11, 18:55:00
  // ----------------------------------------------------
  // DESCRIPCIÓN
  // 
  //
  // PARÁMETROS
  // UD_v20110728_AñosCierre()
  // ----------------------------------------------------


  // DECLARACIONES E INICIALIZACIONES



  // CODIGO PRINCIPAL

ALL RECORDS:C47([xxSTR_HistoricoNiveles:191])
DISTINCT VALUES:C339([xxSTR_HistoricoNiveles:191]Año:2;$al_Years)

For ($i;1;Size of array:C274($al_Years))
	QUERY:C277([xxSTR_DatosDeCierre:24];[xxSTR_DatosDeCierre:24]Year:1=$al_Years{$i})
	If (Records in selection:C76([xxSTR_DatosDeCierre:24])=0)
		CREATE RECORD:C68([xxSTR_DatosDeCierre:24])
		[xxSTR_DatosDeCierre:24]Year:1:=$al_Years{$i}
		[xxSTR_DatosDeCierre:24]NombreAgnoEscolar:5:=String:C10($al_Years{$i})
		SAVE RECORD:C53([xxSTR_DatosDeCierre:24])
	End if 
End for 


If (<>vtXS_CountryCode="cl")
	READ WRITE:C146([xxSTR_DatosDeCierre:24])
	ALL RECORDS:C47([xxSTR_DatosDeCierre:24])
	APPLY TO SELECTION:C70([xxSTR_DatosDeCierre:24];[xxSTR_DatosDeCierre:24]NombreAgnoEscolar:5:=String:C10([xxSTR_DatosDeCierre:24]Year:1))
End if 

