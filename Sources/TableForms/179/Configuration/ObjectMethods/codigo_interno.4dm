  //20160223 JVP ticket 153095 
Case of 
	: (Form event:C388=On Data Change:K2:15)
		  //C_LONGINT($vl_indice)
		  //$vl_indice:=Find in field([xxACT_Items]Codigo_interno;[xxACT_Items]Codigo_interno)
		  //If ($vl_indice>0)
		  //CD_Dlog (0;"el código interno ya está siendo utilizado por otro ítem.")
		  //[xxACT_Items]Codigo_interno:=""
		  //End if 
		C_LONGINT:C283($vl_indice;$l_resp)  //20180924 RCH Ticket 216834
		$vl_indice:=Find in field:C653([xxACT_Items:179]Codigo_interno:48;[xxACT_Items:179]Codigo_interno:48)
		If ($vl_indice>0)
			$l_resp:=CD_Dlog (0;__ ("El código interno ya está siendo utilizado. Se recomienda que el valor ingresado sea único para cada ítem de cargo.")+"\n\n"+__ ("¿Desea mantener el código recién ingresado?");"";__ ("Si");__ ("No"))
			If ($l_resp=2)
				[xxACT_Items:179]Codigo_interno:48:=""
			End if 
		End if 
End case 

