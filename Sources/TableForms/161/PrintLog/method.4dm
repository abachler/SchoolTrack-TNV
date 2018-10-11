  // Método: Método de Formulario: [SN3_PublicationPrefs]PrintLog
  //----------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 07/02/10, 18:27:26
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones


  // Código principal

Case of 
	: (Form event:C388=On Load:K2:1)
		vt_Log_Title:=__ ("SchoolNet: Registro de Actividades")
		ARRAY TEXT:C222(SN3_Log_Tipo_Str;Size of array:C274(SN3_Log_Tipo))
		For ($i;1;Size of array:C274(SN3_Log_Tipo))
			Case of 
				: (SN3_Log_Tipo{$i}=SN3_Log_Error)
					SN3_Log_Tipo_Str{$i}:=__ ("Error")
				: (SN3_Log_Tipo{$i}=SN3_Log_FileGeneration)
					SN3_Log_Tipo_Str{$i}:=__ ("Generación de Archivos")
				: (SN3_Log_Tipo{$i}=SN3_Log_FileSent)
					SN3_Log_Tipo_Str{$i}:=__ ("Envío de Archivos")
				: (SN3_Log_Tipo{$i}=SN3_Log_Info)
					SN3_Log_Tipo_Str{$i}:=__ ("Información")
			End case 
		End for 
		If (Find in array:C230(SN3_Log_Tipo;SN3_Log_Error)>-1)
			$plErr:=PL_SetArraysNam (xPLP_Fact;1;6;"SN3_Log_Fecha";"SN3_Log_Hora";"SN3_Log_Tipo_Str";"SN3_Log_Descripcion";"SN3_Log_DescError";"SN3_Log_Maquina")
			PL_SetHeaders (xPLP_Fact;1;6;__ ("Fecha");__ ("Hora");__ ("Tipo");__ ("Evento");__ ("Descripción Error");__ ("Máquina"))
			PL_SetWidths (xPLP_Fact;1;6;50;50;85;290;135;76)
		Else 
			$plErr:=PL_SetArraysNam (xPLP_Fact;1;4;"SN3_Log_Fecha";"SN3_Log_Hora";"SN3_Log_Tipo_Str";"SN3_Log_Descripcion")
			PL_SetHeaders (xPLP_Fact;1;4;__ ("Fecha");__ ("Hora");__ ("Tipo");__ ("Evento"))
			PL_SetWidths (xPLP_Fact;1;4;50;50;150;436)
		End if 
		PL_SetFormat (xPLP_Fact;2;"&/2")
		PL_SetHdrOpts (xPLP_Fact;2;0)
		PL_SetHdrStyle (xPLP_Fact;0;"Tahoma";9;1)
		PL_SetStyle (xPLP_Fact;0;"Tahoma";7;0)
		PL_SetFrame (xPLP_Fact;1;"Black";"Black";0;1;"Black";"Black";0)
		PL_SetDividers (xPLP_Fact;0.5;"Black";"Gray";0;0.5;"Black";"Gray";0)  //Print only column dividers: Solid gray hairlines 
	: (Form event:C388=On Printing Footer:K2:20)
		sPage:="- "+String:C10(Printing page:C275)+" -"
		sPrintDate:=__ ("Impreso el ")+String:C10(Current date:C33(*);7)+__ (" a las ")+String:C10(Current time:C178(*);2)+__ (" por ")+<>tUSR_CurrentUser
End case 