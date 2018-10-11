//%attributes = {}
  // BBLitm_MuestraFichaCatalogo()
  // Por: Alberto Bachler: 17/09/13, 13:23:33
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------
C_TEXT:C284($1)
C_TEXT:C284($t_tipoFicha)

If (False:C215)
	C_TEXT:C284(BBLitm_MuestraFichaCatalogo ;$1)
End if 

If (Count parameters:C259=1)
	$t_tipoFicha:=$1
End if 

BBLitm_ActualizaFichasCatalogo 

QUERY:C277([BBL_FichasCatalograficas:81];[BBL_FichasCatalograficas:81]Nº de item:5;=;[BBL_Items:61]Numero:1;*)
QUERY:C277([BBL_FichasCatalograficas:81]; & ;[BBL_FichasCatalograficas:81]Tipo:1=$t_tipoFicha)

OBJECT SET FONT STYLE:C166(*;"bFichaCatalogo@";Plain:K14:1)
OBJECT SET FONT STYLE:C166(*;"bFichaCatalogo"+$t_tipoFicha;Bold:K14:2)

If (Records in selection:C76([BBL_FichasCatalograficas:81])<=1)
	OBJECT SET VISIBLE:C603(*;"bFichaCatalografica@";False:C215)
Else 
	OBJECT SET VISIBLE:C603(*;"bFichaCatalografica_siguiente";True:C214)
	OBJECT SET VISIBLE:C603(*;"bFichaCatalografica_anterior";False:C215)
End if 
