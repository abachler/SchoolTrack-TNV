C_BOOLEAN:C305($b_aceptar)
$b_aceptar:=True:C214

If (Table:C252(yBWR_currentTable)=Table:C252(->[Personas:7]))
	Case of 
		: (rb_actual0=1)
			[Personas:7]ACT_ReceptorDT_Tipo:112:=0
			[Personas:7]ACT_ReceptorDT_id_Apdo:113:=0
			[Personas:7]ACT_ReceptorDT_id_Ter:114:=0
		: (rb_otro1=1)
			If ([Personas:7]No:1#l_idApdoSel)
				[Personas:7]ACT_ReceptorDT_Tipo:112:=1
				[Personas:7]ACT_ReceptorDT_id_Apdo:113:=l_idApdoSel
				[Personas:7]ACT_ReceptorDT_id_Ter:114:=0
			Else 
				$b_aceptar:=False:C215
			End if 
		: (rb_otro2=1)
			[Personas:7]ACT_ReceptorDT_Tipo:112:=2
			[Personas:7]ACT_ReceptorDT_id_Apdo:113:=0
			[Personas:7]ACT_ReceptorDT_id_Ter:114:=l_idTerSel
		: (rb_publicoGeneral=1)
			[Personas:7]ACT_ReceptorDT_Tipo:112:=3
			[Personas:7]ACT_ReceptorDT_id_Apdo:113:=0
			[Personas:7]ACT_ReceptorDT_id_Ter:114:=0
		: (rb_noEmitir=1)
			[Personas:7]ACT_ReceptorDT_Tipo:112:=4
			[Personas:7]ACT_ReceptorDT_id_Apdo:113:=0
			[Personas:7]ACT_ReceptorDT_id_Ter:114:=0
	End case 
Else 
	If (Table:C252(yBWR_currentTable)=Table:C252(->[ACT_Terceros:138]))
		Case of 
			: (rb_actual0=1)
				[ACT_Terceros:138]ReceptorDT_tipo:76:=0
				[ACT_Terceros:138]ReceptorDT_id_apoderado:78:=0
				[ACT_Terceros:138]ReceptorDT_id_tercero:77:=0
			: (rb_otro1=1)
				If (Not:C34([ACT_Terceros:138]Es_publico_general:79))  //publico general debe tener seleccionado el mismo responsable
					[ACT_Terceros:138]ReceptorDT_tipo:76:=1
					[ACT_Terceros:138]ReceptorDT_id_apoderado:78:=l_idApdoSel
					[ACT_Terceros:138]ReceptorDT_id_tercero:77:=0
				Else 
					$b_aceptar:=False:C215
				End if 
			: (rb_otro2=1)
				If (Not:C34([ACT_Terceros:138]Es_publico_general:79))  //publico general debe tener seleccionado el mismo responsable
					If ([ACT_Terceros:138]Id:1#l_idTerSel)
						[ACT_Terceros:138]ReceptorDT_tipo:76:=2
						[ACT_Terceros:138]ReceptorDT_id_apoderado:78:=0
						[ACT_Terceros:138]ReceptorDT_id_tercero:77:=l_idTerSel
					Else 
						$b_aceptar:=False:C215
					End if 
				Else 
					$b_aceptar:=False:C215
				End if 
			: (rb_publicoGeneral=1)
				If (Not:C34([ACT_Terceros:138]Es_publico_general:79))  //publico general debe tener seleccionado el mismo responsable
					[ACT_Terceros:138]ReceptorDT_tipo:76:=3
					[ACT_Terceros:138]ReceptorDT_id_apoderado:78:=0
					[ACT_Terceros:138]ReceptorDT_id_tercero:77:=0
				Else 
					$b_aceptar:=False:C215
				End if 
			: (rb_noEmitir=1)
				If (Not:C34([ACT_Terceros:138]Es_publico_general:79))  //publico general debe tener seleccionado el mismo responsable
					[ACT_Terceros:138]ReceptorDT_tipo:76:=4
					[ACT_Terceros:138]ReceptorDT_id_apoderado:78:=0
					[ACT_Terceros:138]ReceptorDT_id_tercero:77:=0
				Else 
					$b_aceptar:=False:C215
				End if 
		End case 
	End if 
End if 

If ($b_aceptar)
	ACCEPT:C269
Else 
	BEEP:C151
End if 