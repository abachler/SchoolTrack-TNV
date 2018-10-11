Case of 
	: (Form event:C388=On Load:K2:1)
		C_TEXT:C284(vtACT_referenciaBusqueda;vtACT_referencia;vtACT_nombreApoderado)
		C_DATE:C307(vdACT_fechaPago)
		C_REAL:C285(vrACT_total)
		C_TEXT:C284(vtACT_idACSel)
		C_TEXT:C284(vtACT_textoAC)
		
		If (True:C214)
			  // Usuario (SO): Saul Ponce Ticket Nº 193649
			  // Fecha y hora: 03/01/18, 10:26:51
			C_TEXT:C284(vsACT_ConvenioBanco;vsACTBanco_Referencias)
			vsACT_ConvenioBanco:=""
			vsACTBanco_Referencias:=""
			Variable4:=""
		End if 
		
		vtACT_referenciaBusqueda:=""
		vtACT_referencia:=""
		vtACT_nombreApoderado:=""
		vdACT_fechaPago:=!00-00-00!
		vrACT_total:=0
		vtACT_idACSel:=""
		
		ACT_OpcionesReferenciasMX ("declaraArreglos")
		
		MNU_SetMenuBar ("XS_edicion")
		
		ST_LoadModuleFormatExceptions ("SchoolTrack")
		
		OBJECT SET ENABLED:C1123(*;"btn_carga@";(Size of array:C274(alACT_idAviso)>0))
		
		OBJECT SET VISIBLE:C603(*;"avisoEliminado";False:C215)  //20170217 RCH
		
	: (Form event:C388=On Clicked:K2:4)
		If (Size of array:C274(atACT_referencia)>0)
			vtACT_referencia:=atACT_referencia{1}
			vtACT_nombreApoderado:=ST_UppercaseFirstLetter (atACT_apoderado{1})
			vdACT_fechaPago:=adACT_fechaPago{1}
			vrACT_total:=arACT_total{1}
			ACT_OpcionesReferenciasMX ("cargaDetalleCargos")
			
			If ((vtACT_idACSel#"0") & (vtACT_idACSel#""))
				C_LONGINT:C283($col;$line)
				C_POINTER:C301($ptr)
				LISTBOX GET CELL POSITION:C971(lb_referencias;$col;$line;$ptr)
				If (Find in field:C653([ACT_Avisos_de_Cobranza:124]ID_Aviso:1;alACT_idAviso{$line})>=0)
					$b_mostrarMsjEliminado:=False:C215
				Else 
					$b_mostrarMsjEliminado:=True:C214
				End if 
				OBJECT SET VISIBLE:C603(*;"avisoEliminado";$b_mostrarMsjEliminado)
			End if 
			
		End if 
		
		OBJECT SET ENABLED:C1123(*;"btn_carga@";(Size of array:C274(alACT_idAviso)>0))
		
End case 