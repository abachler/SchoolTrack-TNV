C_BOOLEAN:C305($go)
C_TEXT:C284($msg)
C_LONGINT:C283($numero;$largo;$tieneCaracter;$pos)
$msg:="Antes de guardar: "+"\r\r"
$go:=True:C214
If (Size of array:C274(al_Numero)>0)
	ARRAY TEXT:C222(atACTtrf_DescripcionExp;0)
	ACTtrf_Master (7;"atACTtrf_DescripcionExp")
	
	  //ARRAY TEXT($at_TextosFijos;19)  `OJO!!! al agregar un elemento MODIFICAR el valor de index en xAL_ACT_CBEntry_exportBankFiles, ´línea 107-123 124 (if($index<=8)). textos fijos que no son campos de la Base de datos SOLO para el cuerpoy para la columnaDescripción
	  //$at_TextosFijos{1}:="Texto Fijo"
	  //$at_TextosFijos{2}:="Código Plan de Cuentas"
	  //$at_TextosFijos{3}:="Monto al debe moneda Base"
	  //$at_TextosFijos{4}:="Monto al haber moneda Base"
	  //$at_TextosFijos{5}:="Descripción de Movimiento"
	  //$at_TextosFijos{6}:="Código centro de costos"
	  //$at_TextosFijos{7}:="Código Auxiliar"
	  //$at_TextosFijos{8}:="Código Forma de Pago"
	  //$at_TextosFijos{9}:="Monto del concepto"
	  //$at_TextosFijos{10}:="Tipo de movimiento"
	  //$at_TextosFijos{11}:="Correlativo"
	  //$at_TextosFijos{12}:="Fecha actual"
	  //$at_TextosFijos{13}:="Nro. dcto. referencia"
	  //$at_TextosFijos{14}:="Tipo documento"
	  //$at_TextosFijos{15}:="Fecha referencia documento"
	  //$at_TextosFijos{16}:="Fecha vencimiento documento"
	  //$at_TextosFijos{17}:="Tipo documento conciliación"
	  //$at_TextosFijos{18}:="Número documento conciliación"
	  //$at_TextosFijos{19}:="Código Interno Forma de Pago"
	
	ARRAY LONGINT:C221(al_recordTablePointersExpTemp;Size of array:C274(al_Numero))
	ARRAY LONGINT:C221(al_recordFieldPointersExpTemp;Size of array:C274(al_Numero))
	For ($i;1;Size of array:C274(al_Numero))  //'Guardo los punteros de los campos a utilizar
		$indice:=Find in array:C230(atACTtrf_DescripcionExp;at_Descripcion{$i})
		If ($indice>0)
			al_recordTablePointersExpTemp{$i}:=-1
			al_recordFieldPointersExpTemp{$i}:=-1
		Else 
			$index:=Find in array:C230(at_DescripcionExp;at_Descripcion{$i})
			If ($index>0)
				al_recordTablePointersExpTemp{$i}:=Table:C252(aRecordFieldPointersExp{$index})
				al_recordFieldPointersExpTemp{$i}:=Field:C253(aRecordFieldPointersExp{$index})
			End if 
		End if 
	End for 
	
	If (viNameFile#"")
		For ($i;1;Size of array:C274(at_Descripcion))  //para comprobar todos los campos tengan descripción
			If (at_Descripcion{$i}="")
				$msg:=$msg+"Ingrese todos los valores en la columna Descripción en la página 7 (registros del cuerpo)"+"\r"
				$i:=Size of array:C274(at_Descripcion)
				$go:=False:C215
			End if 
		End for 
		For ($i;1;Size of array:C274(at_Descripcion))  //para comprobar los rellenos
			If ((at_Descripcion{$i}="Texto Fijo") & (at_TextoFijo{$i}="") & (at_Relleno{$i}#"Ajustado a contenido"))  //test
				$msg:=$msg+"Ingrese un valor en todos los campos de Descripción Texto Fijo en la página 7 (registros del cuerpo)"+"\r"
				$i:=Size of array:C274(at_Descripcion)
				$go:=False:C215
			End if 
		End for 
		For ($i;1;Size of array:C274(at_Descripcion))  //para comprobar los campos texto fijos tengan valor
			$numero:=Num:C11(at_formato{$i})  //de acá
			If ($numero>0)
				$largo:=$numero
			Else 
				$pos:=Position:C15("mm";at_formato{$i})
				If ($pos>0)
					$largo:=Length:C16(at_formato{$i})
					$tieneCaracter:=Position:C15("+";at_formato{$i})
					If ($tieneCaracter>0)
						$largo:=$largo-7
					End if 
				Else 
					$largo:=0
				End if 
			End if   //hasta acá
			If (at_Relleno{$i}="")
				If ((al_Largo{$i}>Length:C16(at_TextoFijo{$i})) & ((al_Largo{$i}<$largo) | ($largo=0)))  //cuando el largo sea igual al largo del texto fijo no se validará
					$msg:=$msg+"Verifique los valores de la columna Relleno de la página 7 (registros del cuerpo)"+"\r"
					$i:=Size of array:C274(at_Descripcion)
					$go:=False:C215
				End if 
			Else 
				If ((at_Relleno{$i}#"Ajustado a contenido") & (at_Alineado{$i}="") & ((al_Largo{$i}<$largo) | ($largo=0)))
					$msg:=$msg+"Ingrese todos los valores en la columna Alineado de la página 7 (registros del cuerpo, excepto para los formatos "+Char:C90(34)+"Ajustado a contenido"+Char:C90(34)+")"+"\r"
					$i:=Size of array:C274(at_Descripcion)
					$go:=False:C215
				End if 
			End if 
		End for 
		
		ARRAY TEXT:C222($at_validaDescripcionIde;7)  //para validar que exista identificador
		$at_validaDescripcionIde{1}:=String:C10(Table:C252(->[Personas:7]))+"-"+String:C10(Field:C253(->[Personas:7]RUT:6))
		$at_validaDescripcionIde{2}:=String:C10(Table:C252(->[Personas:7]))+"-"+String:C10(Field:C253(->[Personas:7]ACT_RUTTitular_TC:56))
		$at_validaDescripcionIde{3}:=String:C10(Table:C252(->[Personas:7]))+"-"+String:C10(Field:C253(->[Personas:7]ACT_RUTTitutal_Cta:50))
		$at_validaDescripcionIde{4}:=String:C10(Table:C252(->[ACT_CuentasCorrientes:175]))+"-"+String:C10(Field:C253(->[ACT_CuentasCorrientes:175]Codigo:19))
		$at_validaDescripcionIde{5}:=String:C10(Table:C252(->[Personas:7]))+"-"+String:C10(Field:C253(->[Personas:7]ACT_CodMandatoPAC:62))
		$at_validaDescripcionIde{6}:=String:C10(Table:C252(->[Personas:7]))+"-"+String:C10(Field:C253(->[Personas:7]ACT_CodMandatoPAT:63))
		$at_validaDescripcionIde{7}:=String:C10(Table:C252(->[Familia:78]))+"-"+String:C10(Field:C253(->[Familia:78]Codigo_interno:14))
		APPEND TO ARRAY:C911($at_validaDescripcionIde;String:C10(Table:C252(->[ACT_Avisos_de_Cobranza:124]))+"-"+String:C10(Field:C253(->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1)))
		
		ARRAY TEXT:C222($at_validaDescripcionMonto;2)  //para validar que exista monto
		$at_validaDescripcionMonto{1}:=String:C10(Table:C252(->[ACT_Avisos_de_Cobranza:124]))+"-"+String:C10(Field:C253(->[ACT_Avisos_de_Cobranza:124]Monto_a_Pagar:14))
		$at_validaDescripcionMonto{2}:=String:C10(Table:C252(->[ACT_Avisos_de_Cobranza:124]))+"-"+String:C10(Field:C253(->[ACT_Avisos_de_Cobranza:124]Monto_Neto:11))
		
		C_BOOLEAN:C305($vb_idValido1)
		C_BOOLEAN:C305($vb_idValido2)
		C_TEXT:C284($vt_codValida)
		For ($i;1;Size of array:C274(at_Descripcion))
			If ((al_recordTablePointersExpTemp{$i}#-1) & (al_recordFieldPointersExpTemp{$i}#-1))
				$vt_codValida:=String:C10(al_recordTablePointersExpTemp{$i})+"-"+String:C10(al_recordFieldPointersExpTemp{$i})
				$vl_valida1:=Find in array:C230($at_validaDescripcionIde;$vt_codValida)
				$vl_valida2:=Find in array:C230($at_validaDescripcionMonto;$vt_codValida)
				If ($vl_valida1>=1)
					$vb_idValido1:=True:C214
				End if 
				If ($vl_valida2>=1)
					$vb_idValido2:=True:C214
				End if 
			End if 
		End for 
		If (((Not:C34($vb_idValido1)) | (Not:C34($vb_idValido2))) & (PWTrf_Pac1=0))
			$msg:=$msg+"El modelo debe tener un identificardor y un monto"+"\r"
			$go:=False:C215
		End if 
		
		If (cs_encabezado=1)  //para registros de encabezado
			For ($i;1;Size of array:C274(at_DescripcionHe))  //para comprobar todos los campos tengan descripción
				If (at_DescripcionHe{$i}="")
					$msg:=$msg+"Ingrese todos los valores en la columna Descripción en la página 5"+"\r"
					$i:=Size of array:C274(at_DescripcionHe)
					$go:=False:C215
				End if 
			End for 
			For ($i;1;Size of array:C274(at_DescripcionHe))  //para comprobar los rellenos
				If ((at_DescripcionHe{$i}="Texto Fijo") & (at_TextoFijoHe{$i}="") & (at_RellenoHe{$i}#"Ajustado a contenido"))
					$msg:=$msg+"Ingrese un valor en todos los campos de Descripción Texto Fijo en la página 5"+"\r"
					$i:=Size of array:C274(at_DescripcionHe)
					$go:=False:C215
				End if 
			End for 
			For ($i;1;Size of array:C274(at_DescripcionHe))  //para comprobar los campos relleno  tengan valor
				$numero:=Num:C11(at_formatoHe{$i})  //de acá. valida los largos cuando hay formatos
				If ($numero>0)
					$largo:=$numero
				Else 
					$pos:=Position:C15("mm";at_formatoHe{$i})
					If ($pos>0)
						$largo:=Length:C16(at_formatoHe{$i})
						$tieneCaracter:=Position:C15("+";at_formatoHe{$i})
						If ($tieneCaracter>0)
							$largo:=$largo-7
						End if 
					Else 
						$largo:=0
					End if 
				End if   //hasta acá
				If (at_RellenoHe{$i}="")
					If ((al_LargoHe{$i}>Length:C16(at_TextoFijoHe{$i})) & ((al_LargoHe{$i}<$largo) | ($largo=0)))  //cuando el largo sea igual al largo del texto fijo no se validará
						$msg:=$msg+"Verifique los valores de la columna Relleno de la página 5"+"\r"
						$i:=Size of array:C274(at_DescripcionHe)
						$go:=False:C215
					End if 
				Else 
					If ((at_RellenoHe{$i}#"Ajustado a contenido") & (at_AlineadoHe{$i}="") & ((al_LargoHe{$i}<$largo) | ($largo=0)))
						$msg:=$msg+"Ingrese todos los valores en la columna Alineado de la página 5 (excepto para los"+" formatos "+Char:C90(34)+"Ajustado a contenido"+Char:C90(34)+")"+"\r"
						$i:=Size of array:C274(at_DescripcionHe)
						$go:=False:C215
					End if 
				End if 
			End for 
		End if 
		If (cs_registroControl=1)
			For ($i;1;Size of array:C274(at_DescripcionFo))  //para comprobar todos los campos tengan descripción
				If (at_DescripcionFo{$i}="")
					$msg:=$msg+"Ingrese todos los valores en la columna Descripción en la página 6"+"\r"
					$i:=Size of array:C274(at_DescripcionFo)
					$go:=False:C215
				End if 
			End for 
			For ($i;1;Size of array:C274(at_DescripcionFo))  //para comprobar los rellenos
				If ((at_DescripcionFo{$i}="Texto Fijo") & (at_TextoFijoFo{$i}="") & (at_RellenoFo{$i}#"Ajustado a contenido"))
					$msg:=$msg+"Ingrese un valor en todos los campos de Descripción Texto Fijo en la página 6"+"\r"
					$i:=Size of array:C274(at_DescripcionFo)
					$go:=False:C215
				End if 
			End for 
			For ($i;1;Size of array:C274(at_DescripcionFo))  //para comprobar los campos texto fijos tengan valor
				$numero:=Num:C11(at_formatoFo{$i})  //de acá. valida los largos cuando hay formatos
				If ($numero>0)
					$largo:=$numero
				Else 
					$pos:=Position:C15("mm";at_formatoFo{$i})
					If ($pos>0)
						$largo:=Length:C16(at_formatoFo{$i})
						$tieneCaracter:=Position:C15("+";at_formatoFo{$i})
						If ($tieneCaracter>0)
							$largo:=$largo-7
						End if 
					Else 
						$largo:=0
					End if 
				End if   //hasta acá
				If (at_RellenoFo{$i}="")
					If ((al_LargoFo{$i}>Length:C16(at_TextoFijoFo{$i})) & ((al_LargoFo{$i}<$largo) | ($largo=0)))  //cuando el largo sea igual al largo del texto fijo no se validará
						$msg:=$msg+"Verifique los valores de la columna Relleno de la página 6"+"\r"
						$i:=Size of array:C274(at_DescripcionFo)
						$go:=False:C215
					End if 
				Else 
					If ((at_RellenoFo{$i}#"Ajustado a contenido") & (at_AlineadoFo{$i}="") & ((al_LargoFo{$i}<$largo) | ($largo=0)))
						$msg:=$msg+"Ingrese todos los valores en la columna Alineado de la página 6 (excepto para los"+" formatos "+Char:C90(34)+"Ajustado a contenido"+Char:C90(34)+")"+"\r"
						$i:=Size of array:C274(at_DescripcionFo)
						$go:=False:C215
					End if 
				End if 
			End for 
		End if 
		If ($go)
			C_LONGINT:C283($resp)
			$resp:=1
			
			If ((WTrf_tb2=1) | (WTrf_ac2=1))
				QUERY:C277([xxACT_ArchivosBancarios:118];[xxACT_ArchivosBancarios:118]Nombre:3=viNameFile;*)
				  //QUERY([xxACT_ArchivosBancarios]; & ;[xxACT_ArchivosBancarios]Tipo=$tipo;*)
				QUERY:C277([xxACT_ArchivosBancarios:118]; & ;[xxACT_ArchivosBancarios:118]id_forma_de_pago:13=vlACT_id_modo_pago;*)
				QUERY:C277([xxACT_ArchivosBancarios:118]; & ;[xxACT_ArchivosBancarios:118]ImpExp:5=False:C215)
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
				C_BLOB:C604(xBlobH)
				C_BLOB:C604(xBlobF)
				BLOB_Variables2Blob (->xBlob;0;->al_recordTablePointersExpTemp;->al_recordFieldPointersExpTemp;->al_Numero;->at_Descripcion;->al_PosIni;->al_Largo;->al_PosFinal;->at_formato;->at_Alineado;->at_Relleno;->at_TextoFijo;->at_HeaderAC;->PWTrf_h2;->PWTrf_h1;->WTrf_s1;->WTrf_s2;->WTrf_s3;->WTrf_s4;->WTrf_s4_CaracterOtro)
				BLOB_Variables2Blob (->xBlobH;0;->al_NumeroHe;->at_DescripcionHe;->al_PosIniHe;->al_LargoHe;->al_PosFinalHe;->at_formatoHe;->at_AlineadoHe;->at_RellenoHe;->at_TextoFijoHe;->cs_encabezado)
				BLOB_Variables2Blob (->xBlobF;0;->al_NumeroFo;->at_DescripcionFo;->al_PosIniFo;->al_LargoFo;->al_PosFinalFo;->at_formatoFo;->at_AlineadoFo;->at_RellenoFo;->at_TextoFijoFo;->cs_registroControl)
				[xxACT_ArchivosBancarios:118]Codigo_Pais:7:=<>vtXS_CountryCode
				[xxACT_ArchivosBancarios:118]CreadoPorAsistente:9:=True:C214
				[xxACT_ArchivosBancarios:118]ImpExp:5:=False:C215
				[xxACT_ArchivosBancarios:118]Nombre:3:=viNameFile
				[xxACT_ArchivosBancarios:118]Rol_BD:8:=<>gRolBD
				[xxACT_ArchivosBancarios:118]Tipo:6:=vt_tipoArchivo
				[xxACT_ArchivosBancarios:118]id_forma_de_pago:13:=vlACT_id_modo_pago
				[xxACT_ArchivosBancarios:118]xData:2:=xBlob
				[xxACT_ArchivosBancarios:118]xDataHeader:10:=xBlobH
				[xxACT_ArchivosBancarios:118]xDataFooter:11:=xBlobF
				SAVE RECORD:C53([xxACT_ArchivosBancarios:118])
				LOG_RegisterEvt (ST_Boolean2Str (($resp=1);"Creación";"Modificación")+" de archivo de importación número: "+String:C10([xxACT_ArchivosBancarios:118]ID:1)+", nombre: "+viNameFile+", tipo: "+vt_tipoArchivo)
				KRL_UnloadReadOnly (->[xxACT_ArchivosBancarios:118])
				SET BLOB SIZE:C606(xBlob;0)
				SET BLOB SIZE:C606(xBlobH;0)
				SET BLOB SIZE:C606(xBlobF;0)
				QUERY:C277([xxACT_ArchivosBancarios:118];[xxACT_ArchivosBancarios:118]ID:1=vI_RecordNumber)
				ACCEPT:C269
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