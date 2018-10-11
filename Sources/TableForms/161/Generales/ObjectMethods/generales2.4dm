C_TEXT:C284($resp)
C_TEXT:C284($t_tituloObjeto)
C_LONGINT:C283($l_resp)
$t_tituloObjeto:=OBJECT Get title:C1068(*;"generales2")
$l_resp:=CD_Dlog (0;__ ("Se dispone a ")+ST_Qte (Choose:C955((SN3_AccesoDesactivado=1);__ ("marcar");__ ("desmarcar")))+__ (" la opción ")+ST_Qte ($t_tituloObjeto)+__ (", en el ambiente de producción, para el colegio ")+ST_Qte (<>gCustom)+__ (", rol ")+ST_Qte (<>gRolBD)+__ (", código de país: ")+ST_Qte (<>vtXS_CountryCode)+"."+"\r\r"+__ ("¿Está seguro que desea continuar?");"";__ ("Si");__ ("No"))

If ($l_resp=1)
	
	SN3ws_DesactivarSN3 (<>vtXS_CountryCode;<>gRolBD;String:C10(SN3_AccesoDesactivado);->$resp)
	
	If ($resp="")
		SN3_CreaRegistroLog (Self:C308;True:C214)
		CD_Dlog (0;__ ("Schoolnet 3, ha sido ")+_SI (SN3_AccesoDesactivado=1;__ ("desactivado");__ ("activado"))+".")
		
	Else 
		CD_Dlog (0;__ ("Error de comunicación, por favor intentar nuevamente más tarde."))
		If (SN3_AccesoDesactivado=0)
			SN3_AccesoDesactivado:=1
		Else 
			SN3_AccesoDesactivado:=0
		End if 
	End if 
Else 
	If (SN3_AccesoDesactivado=1)
		SN3_AccesoDesactivado:=0
	Else 
		SN3_AccesoDesactivado:=1
	End if 
End if 