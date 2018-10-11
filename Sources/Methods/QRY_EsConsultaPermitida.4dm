//%attributes = {}
  // QRY_EsConsultaPermitida()
  // Por: Alberto Bachler: 09/04/13, 15:07:54
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_BOOLEAN:C305($0)

C_BOOLEAN:C305($b_consultaEjecutable)
C_LONGINT:C283($i)

If (False:C215)
	C_BOOLEAN:C305(QRY_EsConsultaPermitida ;$0)
End if 

$b_consultaEjecutable:=True:C214
For ($i;1;Size of array:C274(alQRY_numeroTabla))
	If (Not:C34(USR_checkRights ("L";Table:C252(alQRY_numeroTabla{$i}))))
		$b_consultaEjecutable:=False:C215
	End if 
End for 

If (Not:C34($b_consultaEjecutable))
	CD_Dlog (0;__ ("Esta consulta opera sobre algunas tablas a las que usted no tiene permitido el acceso"))
End if 

$0:=$b_consultaEjecutable
