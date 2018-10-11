  //```!!! Los modelos antiguos (con método asociado) se deben importar con shift presionado
C_TEXT:C284($filePath)
$filePath:=xfGetFileName ("Restaurar desde:";"")
If ($filePath#"")
	USE CHARACTER SET:C205("MacRoman";1)
	If (Shift down:C543)
		vArchivoPath:=$filePath
		[xxACT_ArchivosBancarios:118]Nombre:3:=SYS_Path2FileName (vArchivoPath)
		SET BLOB SIZE:C606([xxACT_ArchivosBancarios:118]xData:2;0)
		EM_ErrorManager ("Install")
		EM_ErrorManager ("SetMode";"")
		DOCUMENT TO BLOB:C525(vArchivoPath;[xxACT_ArchivosBancarios:118]xData:2)
		EM_ErrorManager ("Clear")
		If (ok=1)
			$offset:=0
			vtCode:=BLOB to text:C555([xxACT_ArchivosBancarios:118]xData:2;Mac text without length:K22:10;$offset;32000)
			$validFile:=ACTtrf_IsValidTransferFile (vtCode)
			If (Not:C34($validFile))
				CD_Dlog (0;__ ("El archivo seleccionado no parece contener código. Vuelva a intentarlo seleccionando el archivo correcto.\rSi usted cree que el archivo es el correcto, contáctese con Colegium."))
				SET BLOB SIZE:C606([xxACT_ArchivosBancarios:118]xData:2;0)
				vArchivoPath:=""
				[xxACT_ArchivosBancarios:118]Nombre:3:=""
			Else 
				$valid:=ACTtrf_IsColegiumTransferFile (vtCode)
				If (Not:C34($valid))
					CD_Dlog (0;__ ("El archivo seleccionado contiene código, pero no corresponde a un archivo de transferencia bancaria generado por Colegium."))
					SET BLOB SIZE:C606([xxACT_ArchivosBancarios:118]xData:2;0)
					vArchivoPath:=""
					[xxACT_ArchivosBancarios:118]Nombre:3:=""
				Else 
					[xxACT_ArchivosBancarios:118]ImpExp:5:=ACTtrf_DetectFileType (vtCode)
					[xxACT_ArchivosBancarios:118]CreadoPorAsistente:9:=False:C215
					[xxACT_ArchivosBancarios:118]Codigo_Pais:7:=<>vtXS_CountryCode
					C_LONGINT:C283($vlTipo1;$vlTipo2;$vlTipo3;$choice)
					$vlTipo1:=Position:C15("PAT";[xxACT_ArchivosBancarios:118]Nombre:3)
					$vlTipo2:=Position:C15("PAC";[xxACT_ArchivosBancarios:118]Nombre:3)
					$vlTipo3:=Position:C15("CUP";[xxACT_ArchivosBancarios:118]Nombre:3)
					Case of 
						: ($vlTipo1>0)
							[xxACT_ArchivosBancarios:118]id_forma_de_pago:13:=-9
						: ($vlTipo2>0)
							[xxACT_ArchivosBancarios:118]id_forma_de_pago:13:=-10
						: ($vlTipo3>0)
							[xxACT_ArchivosBancarios:118]id_forma_de_pago:13:=-11
					End case 
					[xxACT_ArchivosBancarios:118]Tipo:6:=ACTcfgfdp_OpcionesGenerales ("GetFormaDePagoFromID";->[xxACT_ArchivosBancarios:118]id_forma_de_pago:13)
					$choice:=Find in array:C230(aTiposArchivosText;[xxACT_ArchivosBancarios:118]Tipo:6)
					If ($choice>-1)
						vTipo:=aTiposArchivosText{$choice}
					Else 
						_O_ENABLE BUTTON:C192(bTrapType)
					End if 
				End if 
			End if 
		Else 
			CD_Dlog (0;__ ("Se produjo un error al leer el archivo. Verifique que no esté siendo utilizado por otra aplicación e intente otra vez."))
			SET BLOB SIZE:C606([xxACT_ArchivosBancarios:118]xData:2;0)
			vArchivoPath:=""
			[xxACT_ArchivosBancarios:118]Nombre:3:=""
		End if 
		IT_SetButtonState ((BLOB size:C605([xxACT_ArchivosBancarios:118]xData:2)>0);->bEdit)
	Else 
		C_LONGINT:C283($var;$index)
		C_TEXT:C284($nombre;$tipo;$validate)
		
		SET CHANNEL:C77(10;$filePath)
		RECEIVE VARIABLE:C81($validate)
		If ($validate="Colegium S.A. - Wizard")
			RECEIVE RECORD:C79([xxACT_ArchivosBancarios:118])
			If ([xxACT_ArchivosBancarios:118]CreadoPorAsistente:9=True:C214)
				$nombre:=[xxACT_ArchivosBancarios:118]Nombre:3
				$tipo:=[xxACT_ArchivosBancarios:118]Tipo:6
				$vl_tipo:=[xxACT_ArchivosBancarios:118]id_forma_de_pago:13
				If ($vl_tipo=0)
					C_LONGINT:C283($vlTipo1;$vlTipo2;$vlTipo3;$choice)
					$vlTipo1:=Position:C15("PAT";$nombre)
					$vlTipo2:=Position:C15("PAC";$nombre)
					$vlTipo3:=Position:C15("CUP";$nombre)
					Case of 
						: ($vlTipo1>0)
							[xxACT_ArchivosBancarios:118]id_forma_de_pago:13:=-9
						: ($vlTipo2>0)
							[xxACT_ArchivosBancarios:118]id_forma_de_pago:13:=-10
						: ($vlTipo3>0)
							[xxACT_ArchivosBancarios:118]id_forma_de_pago:13:=-11
					End case 
					$vl_tipo:=[xxACT_ArchivosBancarios:118]id_forma_de_pago:13
				End if 
				$var:=1
				SET QUERY DESTINATION:C396(Into variable:K19:4;$var)
				While ($var>0)
					If ($index>0)
						$nombre:=[xxACT_ArchivosBancarios:118]Nombre:3+" "+String:C10($index)
					End if 
					QUERY:C277([xxACT_ArchivosBancarios:118];[xxACT_ArchivosBancarios:118]Nombre:3=$nombre;*)
					  //QUERY([xxACT_ArchivosBancarios]; & ;[xxACT_ArchivosBancarios]Tipo=$tipo)
					QUERY:C277([xxACT_ArchivosBancarios:118]; & ;[xxACT_ArchivosBancarios:118]id_forma_de_pago:13=$vl_tipo)
					$index:=$index+1
				End while 
				SET QUERY DESTINATION:C396(Into current selection:K19:1)
				[xxACT_ArchivosBancarios:118]Nombre:3:=$nombre
				[xxACT_ArchivosBancarios:118]Rol_BD:8:=<>gRolBD
				[xxACT_ArchivosBancarios:118]Codigo_Pais:7:=<>vtXS_CountryCode
				[xxACT_ArchivosBancarios:118]Tipo:6:=ACTcfg_OpcionesFormasDePago ("GetFormaDePagoXID";->[xxACT_ArchivosBancarios:118]id_forma_de_pago:13)
				[xxACT_ArchivosBancarios:118]Auto_UUID:14:=Generate UUID:C1066  // ASM 20141111 Ticket 138376 , se duplicaba el uuid al importar el archivo
				SAVE RECORD:C53([xxACT_ArchivosBancarios:118])
				KRL_ReloadAsReadOnly (->[xxACT_ArchivosBancarios:118])
				ACTcfg_UpdateTransferAreas 
				CANCEL:C270
			Else 
				CD_Dlog (0;__ ("El archivo no corresponde a un modelo creado por el asistente. El archivo no puede ser importado."))
			End if 
		Else 
			CD_Dlog (0;__ ("El archivo no corresponde a un modelo de archivo de transferencia creado por el asistente."))
		End if 
		SET CHANNEL:C77(11)
	End if 
	USE CHARACTER SET:C205(*;1)
End if 