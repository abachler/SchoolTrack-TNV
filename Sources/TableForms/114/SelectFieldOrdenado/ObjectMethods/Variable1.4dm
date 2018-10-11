If (False:C215)
	  //============================== IDENTIFICACION ==============================
	  // Script ◊aFilePop
	  //Autor: Alberto Bachler
	  //Creada el 24/6/96 a 8:11 AM
	  //============================== DESCRIPCION ==============================
	  //Package:
	  //Descripción:
	  //Sintaxis:
	  //============================== MODIFICACIONES ==============================
	  //Fecha: 
	  //Autor:
	  //Descripción:
End if 

Case of 
	: (Form event:C388=On Load:K2:1)
		ARRAY TEXT:C222(at_TablaPop;0)
		ARRAY TEXT:C222(at_CamposPop;0)
		  //ARRAY LONGINT(al_PosTablas;0)
		  //ARRAY LONGINT(al_PosCampos;0)
		ARRAY INTEGER:C220(al_PosTablas;0)
		ARRAY INTEGER:C220(al_PosCampos;0)
		For ($i;1;Get last table number:C254)
			  //20130321 RCH
			If (Is table number valid:C999($i))
				APPEND TO ARRAY:C911(at_TablaPop;Table name:C256($i))
				APPEND TO ARRAY:C911(al_PosTablas;$i)
			End if 
		End for 
		SORT ARRAY:C229(at_TablaPop;al_PosTablas;>)
		at_TablaPop:=1
		vl_iFileNo:=al_PosTablas{at_TablaPop}
		
		For ($i;1;Get last field number:C255(vl_iFileNo))
			  //20130321 RCH
			If (Is field number valid:C1000(vl_iFileNo;$i))
				APPEND TO ARRAY:C911(at_CamposPop;Field name:C257(vl_iFileNo;$i))
				APPEND TO ARRAY:C911(al_PosCampos;$i)
			End if 
		End for 
		SORT ARRAY:C229(at_CamposPop;al_PosCampos;>)
		vl_IfieldPop:=0
	: ((Form event:C388=On Data Change:K2:15) | (Form event:C388=On Clicked:K2:4))
		If (at_TablaPop>0)
			vl_iFileNo:=al_PosTablas{at_TablaPop}
			at_CamposPop:=0
			ARRAY TEXT:C222(at_CamposPop;0)
			  //ARRAY LONGINT(al_PosCampos;0)
			ARRAY INTEGER:C220(al_PosCampos;0)
			For ($i;1;Get last field number:C255(vl_iFileNo))
				  //20130321 RCH
				If (Is field number valid:C1000(vl_iFileNo;$i))
					APPEND TO ARRAY:C911(at_CamposPop;Field name:C257(vl_iFileNo;$i))
					APPEND TO ARRAY:C911(al_PosCampos;$i)
				End if 
			End for 
		End if 
		SORT ARRAY:C229(at_CamposPop;al_PosCampos;>)
End case 