Spell_CheckSpelling 

Case of 
	: (Form event:C388=On Load:K2:1)
		C_LONGINT:C283(hl_paginasColegio)
		hl_paginasColegio:=AT_Array2ReferencedList (-><>atSTR_PaginasColegio;-><>alSTR_PaginasColegio;0;False:C215;True:C214)
		
		CFG_STR_LoadConfiguration ("Colegio")
		XS_SetConfigInterface 
		
		Case of 
			: (<>vtXS_CountryCode="cl")
				OBJECT SET TITLE:C194(*;"colegio_IdColegio";"Rol Base de Datos:")
				OBJECT SET TITLE:C194(*;"colegio_IdInstitucion@";"RUT:")
				OBJECT SET TITLE:C194(*;"colegio_IdDirector@";"RUN:")
				OBJECT SET FORMAT:C236([Colegio:31]Director_RUN:28;"###.###.###-#")
				OBJECT SET FORMAT:C236([Colegio:31]RUT:2;"###.###.###-#")
				OBJECT SET FORMAT:C236([Colegio:31]RepresentanteLegal_RUN:40;"###.###.###-#")
				OBJECT SET FILTER:C235([Colegio:31]Director_RUN:28;"~"+Char:C90(Double quote:K15:41)+"k;K;0-9;.;-"+Char:C90(Double quote:K15:41))
				OBJECT SET FILTER:C235([Colegio:31]RUT:2;"~"+Char:C90(Double quote:K15:41)+"k;K;0-9;.;-"+Char:C90(Double quote:K15:41))
				OBJECT SET FILTER:C235([Colegio:31]RepresentanteLegal_RUN:40;"~"+Char:C90(Double quote:K15:41)+"k;K;0-9;.;-"+Char:C90(Double quote:K15:41))
			Else 
				Case of 
					: (<>vtXS_CountryCode="mx")
						OBJECT SET TITLE:C194(*;"colegio_IdInstitucion@";"ID Institución:")
						OBJECT SET TITLE:C194(*;"colegio_IdColegio";"Clave Centro de Trabajo:")
						OBJECT SET TITLE:C194(*;"colegio_IdDirector@";"CURP:")
					Else 
						OBJECT SET TITLE:C194(*;"colegio_IdInstitucion@";"ID Institución:")
						OBJECT SET TITLE:C194(*;"colegio_IdColegio";"ID Escuela:")
						OBJECT SET TITLE:C194(*;"colegio_IdDirector@";"DNI:")
				End case 
				
				OBJECT SET FORMAT:C236([Colegio:31]Director_RUN:28;"")
				OBJECT SET FORMAT:C236([Colegio:31]RUT:2;"")
				OBJECT SET FORMAT:C236([Colegio:31]RepresentanteLegal_RUN:40;"")
		End case 
		
		If (USR_GetUserID >0)
			OBJECT SET ENTERABLE:C238(hl_pais;False:C215)
			OBJECT SET ENABLED:C1123(hl_pais;False:C215)
		End if 
		
	: ((Form event:C388=On Clicked:K2:4) | (Form event:C388=On Data Change:K2:15))
		ENABLE MENU ITEM:C149(1;4)
	: (Form event:C388=On Menu Selected:K2:14)
		
	: (Form event:C388=On Close Box:K2:21)
		vbCFG_CloseWindow:=True:C214
		POST KEY:C465(27;0)
End case 
