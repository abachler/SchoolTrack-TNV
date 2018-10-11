C_BOOLEAN:C305($go)
C_TEXT:C284($msg)
$msg:="Antes de guardar: "+"\r\r"
$go:=True:C214
If (Size of array:C274(at_Descripcion)>0)
	If (viNameFile#"")
		If (PWTrf_h1=1)  //separado por algún caracter
			For ($i;1;Size of array:C274(al_Numero))
				If ((al_Numero{$i}=0) & ((at_Descripcion{$i}="Monto") | ((at_Descripcion{$i}="Identificador único") | (at_Descripcion{$i}="Rut titular cuenta corriente") | (at_Descripcion{$i}="Rut titular tarjeta de crédito"))))
					$i:=Size of array:C274(at_Descripcion)
					$go:=False:C215
					$msg:=$msg+"Los campos monto e identificador principal deben tener una posición definida."+"\r"
				End if 
			End for 
			
			For ($i;1;Size of array:C274(at_Relleno))
				If ((at_Relleno{$i}="") & (al_Numero{$i}>0))
					$i:=Size of array:C274(at_Relleno)
					$go:=False:C215
					$msg:=$msg+"Los campos deben tener especificada la columna relleno."+"\r"
				Else 
					If ((at_Relleno{$i}#"Ajustado a contenido") & (at_Alineado{$i}="") & (al_Numero{$i}>0))
						$i:=Size of array:C274(at_Relleno)
						$go:=False:C215
						$msg:=$msg+"Los campos a utilizar deben tener especificada la columna alineado de datos (salv"+"o los ajustados a contenido)."+"\r"
					End if 
				End if 
			End for 
			
			For ($i;1;Size of array:C274(al_Numero))  //valida que todo tenga posicion en pac
				If ((al_Numero{$i}=0) & (PWTrf_Ptb1=1) & (vlACT_id_modo_pago=-10))
					If (at_idsTextos{$i}#"7")  //fecha pagos //20180822 RCH Ticket 214674
						$go:=False:C215
						$msg:=$msg+at_Descripcion{$i}+": Para el modo de importación PAC se deben especificar todas las posiciones de los campos, salvo la fecha de pago."+"\r"
					End if 
				End if 
			End for 
			
		Else 
			If (PWTrf_h2=1)  //ancho fijo
				Case of 
					: ((PWTrf_Ptb1=1) & (vlACT_id_modo_pago=-10))  //PAC
						For ($j;1;Size of array:C274(at_Descripcion))
							If ((al_PosIni{$j}=0) | (al_Largo{$j}=0))  //compruebo que todo tenga posición definida
								If (at_idsTextos{$i}#"7")  //fecha pagos //20180822 RCH Ticket 214674
									$go:=False:C215
									$j:=Size of array:C274(at_Descripcion)
									$msg:=$msg+at_Descripcion{$j}+": Para el modo de importación PAC se deben especificar los inicios y largos de todos los campos, salvo la columna fecha pago."+"\r"
								End if 
							End if 
						End for 
						
					: ((PWTrf_Ptb1=1) & (vlACT_id_modo_pago=-9))  //PAT
						
				End case 
				
				For ($j;1;Size of array:C274(at_Descripcion))  //2 campos dentro del mismo rango
					For ($i;1;Size of array:C274(at_Descripcion))
						If ((al_PosIni{$i}>0) & (al_Largo{$i}>0))
							$largo:=al_PosIni{$i}+al_Largo{$i}
							If ((al_PosIni{$j}<$largo) & (al_PosIni{$j}>=al_PosIni{$i}) & ($j#$i))
								$go:=False:C215
								$msg:=$msg+"No puede especificar 2 campos dentro del mismo rango. Revise los campos "+at_Descripcion{$i}+" y "+at_Descripcion{$j}+"\r"
								$i:=Size of array:C274(at_Descripcion)
								$j:=Size of array:C274(at_Descripcion)
							End if 
						End if 
					End for 
				End for 
				
				For ($i;1;Size of array:C274(al_PosIni))  //confirmo que hayan montos e identificadores
					If ((at_Descripcion{$i}="Monto") | ((at_Descripcion{$i}="Código respuesta") & ((vlACT_id_modo_pago=-9) | (vlACT_id_modo_pago=-10))) | ((at_Descripcion{$i}="Identificador único") | (at_Descripcion{$i}="Rut titular cuenta corriente") | (at_Descripcion{$i}="Rut titular tarjeta de crédito")) & ((al_PosIni{$i}=0) | (al_Largo{$i}=0)))
						$i:=Size of array:C274(at_Descripcion)
						$go:=False:C215
						If ((vlACT_id_modo_pago=-10) | (vlACT_id_modo_pago=-9))
							$msg:=$msg+"Los campos monto, identificador principal y código respuesta deben tener un inicio y un largo especificado."+"\r"
						Else 
							$msg:=$msg+"Los campos monto e identificador principal deben tener un inicio y un largo especificado."+"\r"
						End if 
					End if 
				End for 
				
				
				For ($i;1;Size of array:C274(at_Alineado))  //compruebo alineado
					If ((at_Alineado{$i}="") & (al_PosIni{$i}>0) & (al_Largo{$i}>0))
						$i:=Size of array:C274(at_Descripcion)
						$go:=False:C215
						$msg:=$msg+"Debe especificar el alineado de los campos a utilizar"+"\r"
					End if 
				End for 
				
				For ($i;1;Size of array:C274(at_Relleno))  //compruebo relleno
					If ((at_Relleno{$i}="") & (al_PosIni{$i}>0) & (al_Largo{$i}>0))
						$i:=Size of array:C274(at_Descripcion)
						$go:=False:C215
						$msg:=$msg+"Debe especificar el relleno de los campos a utilizar"+"\r"
					End if 
				End for 
				
				  //If (vt_ICodApr#"")  //compruebo que el cod aprobación tenga el mismo largo de la descripción de la respuesta
				If ((vt_ICodApr#"") & (Find in array:C230(at_idsTextos;"2")#-1))  //20110912 AS. se agrega validacion para los archivos que no necesitan codigo de validación
					C_LONGINT:C283($el)
					  //Case of 
					  //: ((PWTrf_Ptb1=1) & (vlACT_id_modo_pago=-10))  //PAC
					  //$el:=Find in array(at_idsTextos;"5")  //Descripción respuesta
					  //Else 
					  //$el:=Find in array(at_idsTextos;"2")  //Código respuesta
					  //End case 
					  //ticket 157568 JVP 04042016
					$el:=Find in array:C230(at_idsTextos;"2")  //Código respuesta
					If ($el>0)
						If ((PWTrf_h2=1) & ((al_Largo{$el})#(Length:C16(vt_ICodApr))))  //compruebo que para ancho fijo el largo sea igual al largo del cod aprobación ingresado
							$go:=False:C215
							$msg:=$msg+"El código de aprobación ingresado no puede tener un largo distinto que el largo d"+"e l"+"a Descripción respuesta"+"\r"
						End if 
					Else 
						If (vlACT_id_modo_pago=-11)  //para cuponera no se valida
							$go:=False:C215
						End if 
					End if 
				End if 
			End if 
		End if 
		Case of 
			: ((PWTrf_Ptb1=1) & (vlACT_id_modo_pago=-10))  //PAC
				If (vt_ICodApr="")  //compruebo cod aprob para PAC
					$msg:=$msg+"Para los modos de importación PAC se debe especificar el código de aprobaci"+"ón."+"\r"
					$go:=False:C215
				End if 
		End case 
		
		If ($go)
			If (vb_testImport)
				C_LONGINT:C283($resp)
				$resp:=1
				If ((WTrf_tb2=1) | (WTrf_ac2=1))
					QUERY:C277([xxACT_ArchivosBancarios:118];[xxACT_ArchivosBancarios:118]Nombre:3=viNameFile;*)
					  //QUERY([xxACT_ArchivosBancarios]; & ;[xxACT_ArchivosBancarios]Tipo=vt_tipoArchivo;*)
					QUERY:C277([xxACT_ArchivosBancarios:118]; & ;[xxACT_ArchivosBancarios:118]id_forma_de_pago:13=vlACT_id_modo_pago;*)
					QUERY:C277([xxACT_ArchivosBancarios:118]; & ;[xxACT_ArchivosBancarios:118]ImpExp:5=True:C214)
					If (Records in selection:C76([xxACT_ArchivosBancarios:118])>0)
						If (Not:C34(vb_editarArchivoTf))
							$go:=False:C215
							CD_Dlog (0;__ ("Ya existe un registro con el mismo nombre de archivo, no es posible almacenar el nuevo modelo. Por favor modifique el nombre del archivo"))
						Else 
							WTrf_tb2:=0
							WTrf_ac2:=0
						End if 
					End if 
				End if 
				If ($go)
					If ((WTrf_tb2=1) | (WTrf_ac2=1))
						CREATE RECORD:C68([xxACT_ArchivosBancarios:118])
					Else 
						If (((WTrf_tb3=1) & (vNombreOldModeloTB#viNameFile)) | ((WTrf_ac3=1) & (vNombreOldModeloC#viNameFile)))
							$resp:=CD_Dlog (0;__ ("¿Desea guardar un nuevo modelo?");__ ("");__ ("Si");__ ("No"))
							If ($resp=1)  //crear un nuevo modelo
								CREATE RECORD:C68([xxACT_ArchivosBancarios:118])
							Else 
								LOAD RECORD:C52([xxACT_ArchivosBancarios:118])
							End if 
						Else 
							$resp:=2  //para modificar en el log
						End if 
					End if 
					C_BLOB:C604(xBlob)
					  //BLOB_Variables2Blob (->xBlob;0;->al_Numero;->at_Descripcion;->al_PosIni;->al_Largo;->al_PosFinal;->at_Alineado;->at_Relleno;->al_Decimales;->PWTrf_h2;->PWTrf_h1;->WTrf_s1;->WTrf_s2;->WTrf_s3;->cs_IEncabezado;->cs_IPie;->vIIdentificador;->vt_ICodApr;->at_idsTextos;->WTrf_s4;->WTrf_s4_CaracterOtro)
					BLOB_Variables2Blob (->xBlob;0;->al_Numero;->at_Descripcion;->al_PosIni;->al_Largo;->al_PosFinal;->at_Alineado;->at_Relleno;->al_Decimales;->PWTrf_h2;->PWTrf_h1;->WTrf_s1;->WTrf_s2;->WTrf_s3;->cs_IEncabezado;->cs_IPie;->vIIdentificador;->vt_ICodApr;->at_idsTextos;->WTrf_s4;->WTrf_s4_CaracterOtro;->cs_usarComoTexto)  //20180817 RCH ticket 214673
					[xxACT_ArchivosBancarios:118]Codigo_Pais:7:=<>vtXS_CountryCode
					[xxACT_ArchivosBancarios:118]CreadoPorAsistente:9:=True:C214
					[xxACT_ArchivosBancarios:118]ImpExp:5:=True:C214
					[xxACT_ArchivosBancarios:118]Nombre:3:=viNameFile
					[xxACT_ArchivosBancarios:118]Rol_BD:8:=<>gRolBD
					[xxACT_ArchivosBancarios:118]Tipo:6:=vt_tipoArchivo
					[xxACT_ArchivosBancarios:118]id_forma_de_pago:13:=vlACT_id_modo_pago
					[xxACT_ArchivosBancarios:118]xData:2:=xBlob
					SAVE RECORD:C53([xxACT_ArchivosBancarios:118])
					LOG_RegisterEvt (ST_Boolean2Str (($resp=1);"Creación";"Modificación")+" de archivo de exportación número: "+String:C10([xxACT_ArchivosBancarios:118]ID:1)+", nombre: "+viNameFile+", tipo: "+vt_tipoArchivo)
					KRL_UnloadReadOnly (->[xxACT_ArchivosBancarios:118])
					SET BLOB SIZE:C606(xBlob;0)
					QUERY:C277([xxACT_ArchivosBancarios:118];[xxACT_ArchivosBancarios:118]ID:1=vI_RecordNumber)
					ACCEPT:C269
				End if 
			Else 
				vb_testImport:=True:C214
				CD_Dlog (0;__ ("El archivo ha sido validado. Puede realizar una prueba de importación o puede guardar el modelo de archivo."))
			End if 
		Else 
			CD_Dlog (0;$msg)
		End if 
	Else 
		CD_Dlog (0;__ ("Ingrese nombre al archivo"))
	End if 
Else 
	CD_Dlog (0;__ ("Debe agregar columnas en la configuración de los registros del cuerpo"))
End if 