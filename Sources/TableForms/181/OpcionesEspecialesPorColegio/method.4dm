Case of 
	: (Form event:C388=On Load:K2:1)
		Case of 
			: (FORM Get current page:C276=1)
				XS_SetInterface 
				C_TEXT:C284($filter)
				
				vt_ItemsIFC:=""
				vt_ItemsIE:=""
				vd_Fecha1:=Current date:C33(*)
				vd_Fecha2:=Current date:C33(*)
				vt_Fecha1:=String:C10(vd_Fecha1;7)
				vt_Fecha2:=String:C10(vd_Fecha2;7)
				vl_desglosar:=0
				vl_export:=0
				ARRAY TEXT:C222(at_element2Var;0)
				ARRAY LONGINT:C221(al_element2Var;0)
				
				  //arreglos que almacenan en las preferencias los ids de los cargos
				ARRAY LONGINT:C221(al_idsItemsIFC;0)
				ARRAY LONGINT:C221(al_idsItemsIE;0)
				
				  //arreglos que se pasan al formulario de la lista de seleccion
				ARRAY LONGINT:C221(al_idsItemsForList;0)
				ARRAY TEXT:C222(at_nombreItemsForList;0)
				
				ARRAY LONGINT:C221(al_idsItems;0)
				ARRAY TEXT:C222(at_nombreItems;0)
				READ ONLY:C145([xxACT_Items:179])
				QUERY:C277([xxACT_Items:179];[xxACT_Items:179]ID:1>0)
				SELECTION TO ARRAY:C260([xxACT_Items:179]ID:1;al_idsItems;[xxACT_Items:179]Glosa:2;at_nombreItems)
				
				$filter:="&9##"+<>tXS_RS_DateSeparator+"##"+<>tXS_RS_DateSeparator+"####"
				OBJECT SET FILTER:C235(*;"vt_fecha@";$filter)
				
		End case 
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
End case 
