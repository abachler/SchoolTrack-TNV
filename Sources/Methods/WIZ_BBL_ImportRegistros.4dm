//%attributes = {}
  // WIZ_BBL_ImportRegistros()
  // Por: Alberto Bachler: 17/09/13, 13:50:26
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------
C_BOOLEAN:C305($b_codigoBarraValido;$b_crearItem;$b_crearRegistro;$b_nuevoCodigoBarraValido;$b_rechazarRegistro)
C_DATE:C307($d_copia_FechaAdquisicion)
C_LONGINT:C283($i;$l_advertencias;$l_copiasActualizadas;$l_elemento;$l_error;$l_IdTipoDocumento;$l_itemsActualizados;$l_itemsCreados;$l_numeroDeCopia;$l_numeroRegistro)
C_LONGINT:C283($l_recNumLector;$l_recNumRegistro;$l_registrosCreados;$l_registrosProcesados;$l_registrosRechazados;$l_numeroDeMaterias)
C_TIME:C306($h_refDocumento)
C_REAL:C285($r_copia_Costo;$r_copia_ValorRemplazo)
C_TEXT:C284($t_autor;$t_AutoresSecundarios;$t_AutorPrincipal;$t_ClasificacionDewey;$t_codigoBarraPersonalizado;$t_codigoDeBarra;$t_contenidoRegistro;$t_copia_Comentario;$t_copia_Proveedor;$t_copia_Volumen)
C_TEXT:C284($t_Cutter;$t_descripcion;$t_edicion;$t_Editor;$t_fechaEdicion;$t_FechaPublicacion;$t_FrecuenciaPublicacion;$t_ISBN;$t_ISSN;$t_LCCN)
C_TEXT:C284($t_lenguaje;$t_lugar;$t_LugarEdicion;$t_materia;$t_Materias;$t_mensaje;$t_Notas;$t_numeroEnSerie;$t_prefijoCodigoBarra)
C_TEXT:C284($t_primerAutor;$t_primerEditor;$t_primerTitulo;$t_Resumen;$t_rutaDirectorio;$t_rutaLog;$t_Serie_o_Coleccion;$t_TipoDocumento;$t_TipoRegistro;$t_tituloCompleto)
C_TEXT:C284($t_TituloPrincipal;$t_TitulosSecundarios;$t_volumen;$t_Volumenes;$t_plataformaOrigen)

ARRAY TEXT:C222($at_entradasLog;0)
ARRAY TEXT:C222($at_LlavesRegistroWIN;0)
ARRAY TEXT:C222($at_nombresRegistroWIN;0)



TRACE:C157
If (SYS_IsWindows )
	$l_error:=sys_GetRegEnum (GR_HKEY_LOCAL_MACHINE;"Software\\Adobe\\Acrobat Reader";$at_LLavesRegistroWIN;$at_nombresRegistroWIN)
	If (Size of array:C274($at_LlavesRegistroWIN)=0)
		$t_mensaje:=__ ("Para visualizar correctamente este formulario se requiere  Adobe Reader.\rSi no lo tiene instalado puede descargarlo e instalala desde el sitio web de Adobee®: www.adobe.com.\r\rSi ya está instalado o utiliza otro visualizador de documentos PDF haga c"+" en el botón Continuar.")
		OK:=CD_Dlog (0;$t_mensaje;__ ("");__ ("Continuar");__ ("Cancelar"))
	Else 
		OK:=1
	End if 
Else 
	OK:=1
End if 

If (OK=1)
	WDW_OpenFormWindow (->[xxSTR_Constants:1];"WIZ_ImportRegistros_BBL";2;8)
	DIALOG:C40([xxSTR_Constants:1];"WIZ_ImportRegistros_BBL")
	CLOSE WINDOW:C154
	
	If (OK=1)
		
		Case of 
			: (r1Mac=1)
				$t_plataformaOrigen:="MAC"
				USE CHARACTER SET:C205("MacRoman";1)
			: (r2Win=1)
				$t_plataformaOrigen:="WIN"
				USE CHARACTER SET:C205("windows-1252";1)
		End case 
		
		
		VS_LoadAutoFormatRefs 
		STR_CargaArreglosInterproceso 
		STR_LeeConfiguracion 
		EVS_initialize 
		EVS_LoadStyles 
		EVS_CargaMatrizEstilosEval 
		BBL_LeeConfiguracion 
		
		READ WRITE:C146([BBL_Items:61])
		$h_refDocumento:=Open document:C264(document;"*";Read mode:K24:5)
		If ($h_refDocumento#?00:00:00?)
			$t_rutaDirectorio:=SYS_GetParentNme (document)
			RECEIVE PACKET:C104($h_refDocumento;$t_contenidoRegistro;"\r")
			If ($t_plataformaOrigen="WIN")
				$t_contenidoRegistro:=_O_Win to Mac:C464($t_contenidoRegistro)
			End if 
			$l_registrosCreados:=0
			$l_copiasActualizadas:=0
			$l_itemsCreados:=0
			$l_itemsActualizados:=0
			$l_registrosProcesados:=0
			$l_registrosRechazados:=0
			$l_advertencias:=0
			WDW_Open (300;100;0;1986;"Importando Registros")
			
			TRACE:C157
			ARRAY TEXT:C222($at_ValoresCampos;0)
			While ($t_contenidoRegistro#"")
				$b_rechazarRegistro:=False:C215
				AT_Text2Array (->$at_ValoresCampos;$t_contenidoRegistro;"\t")
				ARRAY TEXT:C222($at_ValoresCampos;37)
				AT_Inc (0)
				$t_codigoDeBarra:=ST_Uppercase (ST_GetCleanString ($at_ValoresCampos{AT_Inc }))
				$l_numeroRegistro:=Num:C11(Replace string:C233(ST_GetCleanString ($at_ValoresCampos{AT_Inc });"e";""))
				$t_TituloPrincipal:=ST_GetCleanString ($at_ValoresCampos{AT_Inc })
				$l_numeroDeCopia:=Num:C11(ST_GetCleanString ($at_ValoresCampos{AT_Inc }))
				$t_TipoRegistro:=ST_GetCleanString ($at_ValoresCampos{AT_Inc })
				$t_ClasificacionDewey:=ST_GetCleanString ($at_ValoresCampos{AT_Inc })
				$t_TitulosSecundarios:=ST_GetCleanString ($at_ValoresCampos{AT_Inc })
				$t_AutorPrincipal:=ST_GetCleanString ($at_ValoresCampos{AT_Inc })
				$t_AutoresSecundarios:=ST_GetCleanString ($at_ValoresCampos{AT_Inc })
				$t_Volumenes:=ST_GetCleanString ($at_ValoresCampos{AT_Inc })
				$t_Editor:=ST_GetCleanString ($at_ValoresCampos{AT_Inc })
				$t_LugarEdicion:=ST_GetCleanString ($at_ValoresCampos{AT_Inc })
				$t_fechaEdicion:=ST_GetCleanString ($at_ValoresCampos{AT_Inc })
				$t_Materias:=ST_GetCleanString ($at_ValoresCampos{AT_Inc })
				$t_descripcion:=ST_GetCleanString ($at_ValoresCampos{AT_Inc })
				$t_Notas:=ST_GetCleanString ($at_ValoresCampos{AT_Inc })
				$t_Resumen:=ST_GetCleanString ($at_ValoresCampos{AT_Inc })
				$t_lenguaje:=ST_GetCleanString ($at_ValoresCampos{AT_Inc })
				$t_ISBN:=ST_GetCleanString ($at_ValoresCampos{AT_Inc })
				$t_ISSN:=ST_GetCleanString ($at_ValoresCampos{AT_Inc })
				$t_Serie_o_Coleccion:=ST_GetCleanString ($at_ValoresCampos{AT_Inc })
				$t_FrecuenciaPublicacion:=ST_GetCleanString ($at_ValoresCampos{AT_Inc })
				$t_volumen:=ST_GetCleanString ($at_ValoresCampos{AT_Inc })
				$t_numeroEnSerie:=ST_GetCleanString ($at_ValoresCampos{AT_Inc })
				$t_FechaPublicacion:=ST_GetCleanString ($at_ValoresCampos{AT_Inc })
				$t_Cutter:=ST_GetCleanString ($at_ValoresCampos{AT_Inc })
				$t_TipoDocumento:=ST_GetCleanString ($at_ValoresCampos{AT_Inc })
				$t_LCCN:=ST_GetCleanString ($at_ValoresCampos{AT_Inc })
				$t_lugar:=ST_GetCleanString ($at_ValoresCampos{AT_Inc })
				$t_edicion:=ST_GetCleanString ($at_ValoresCampos{AT_Inc })  //29
				$t_copia_Comentario:=ST_GetCleanString ($at_ValoresCampos{AT_Inc })
				$r_copia_Costo:=Num:C11(ST_GetCleanString ($at_ValoresCampos{AT_Inc }))
				$d_copia_FechaAdquisicion:=Date:C102(ST_GetCleanString ($at_ValoresCampos{AT_Inc }))
				$t_copia_Proveedor:=ST_GetCleanString ($at_ValoresCampos{AT_Inc })
				$r_copia_ValorRemplazo:=Num:C11(ST_GetCleanString ($at_ValoresCampos{AT_Inc }))
				$t_copia_Volumen:=ST_GetCleanString ($at_ValoresCampos{AT_Inc })
				$t_codigoBarraPersonalizado:=ST_Uppercase (ST_GetCleanString ($at_ValoresCampos{AT_Inc }))
				If ($t_codigoBarraPersonalizado="")
					$t_codigoBarraPersonalizado:=$t_codigoDeBarra
				End if 
				
				$l_registrosProcesados:=$l_registrosProcesados+1
				
				If ($t_TipoDocumento="")
					$t_TipoDocumento:="Libro"
				End if 
				
				Case of 
					: ($t_TituloPrincipal="")
						$b_rechazarRegistro:=True:C214
						$l_registrosRechazados:=$l_registrosRechazados+1
						APPEND TO ARRAY:C911($at_entradasLog;"ERROR"+"\t"+"Línea: "+String:C10($l_registrosProcesados)+"\t"+"SIN TITULO:"+"\t"+$t_contenidoRegistro)
						
				End case 
				
				If (Not:C34($b_rechazarRegistro))
					If ($t_codigoDeBarra#"")
						$b_codigoBarraValido:=Barcode_esValido ("Code39";$t_codigoDeBarra)
						If (Not:C34($b_codigoBarraValido))
							$b_rechazarRegistro:=True:C214
							$l_registrosRechazados:=$l_registrosRechazados+1
							APPEND TO ARRAY:C911($at_entradasLog;"ERROR"+"\t"+"Línea: "+String:C10($l_registrosProcesados)+"\t"+"BARCODE INVALIDO:"+"\t"+$t_contenidoRegistro)
							$l_recNumRegistro:=-1
						End if 
					End if 
				End if 
				
				If (Not:C34($b_rechazarRegistro))
					Case of 
						: ($t_codigoDeBarra#"")
							$l_recNumRegistro:=Find in field:C653([BBL_Registros:66]Barcode_SinFormato:26;$t_codigoDeBarra)
							$l_recNumLector:=Find in field:C653([BBL_Lectores:72]BarCode_SinFormato:38;$t_codigoDeBarra)
							Case of 
								: ($l_recNumLector>=0)
									$b_rechazarRegistro:=True:C214
									$l_registrosRechazados:=$l_registrosRechazados+1
									APPEND TO ARRAY:C911($at_entradasLog;"ERROR"+"\t"+"Línea: "+String:C10($l_registrosProcesados)+"\t"+"BARCODE DUPLICADO (un lector tiene el mismo código de barra):"+"\t"+$t_contenidoRegistro)
									$l_recNumRegistro:=-1
									
								: (($l_recNumRegistro>=0) & ($l_numeroRegistro>0))
									$recNum:=Find in field:C653([BBL_Registros:66]No_Registro:25;$l_numeroRegistro)
									If ($recNum>=0)
										KRL_GotoRecord (->[BBL_Registros:66];$recNum)
										If ([BBL_Registros:66]No_Registro:25#$l_numeroRegistro)
											$b_rechazarRegistro:=True:C214
											$l_registrosRechazados:=$l_registrosRechazados+1
											APPEND TO ARRAY:C911($at_entradasLog;"ERROR"+"\t"+"Línea: "+String:C10($l_registrosProcesados)+"\t"+"NUMERO DE REGISTRO NO CORRESPONDE AL CODIGO DE BARRA:"+"\t"+$t_contenidoRegistro)
										End if 
									End if 
									
								: ($l_recNumRegistro>=0)
									$b_crearRegistro:=False:C215
									$b_rechazarRegistro:=False:C215
									
								: ($l_recNumRegistro<0)
									$b_crearRegistro:=True:C214
									$b_rechazarRegistro:=False:C215
							End case 
							
						: ($l_numeroRegistro>0)
							$l_recNumRegistro:=Find in field:C653([BBL_Registros:66]No_Registro:25;$l_numeroRegistro)
							Case of 
								: ($l_recNumRegistro>=0)
									$b_crearRegistro:=False:C215
									$b_rechazarRegistro:=False:C215
									
								: ($l_recNumRegistro<0)
									$b_crearRegistro:=True:C214
									$b_rechazarRegistro:=False:C215
							End case 
							
						Else 
							$b_rechazarRegistro:=False:C215
					End case 
				End if 
				
				If (Not:C34($b_rechazarRegistro))
					If (($t_codigoBarraPersonalizado#"") & ($t_codigoBarraPersonalizado#$t_codigoDeBarra))
						$b_nuevoCodigoBarraValido:=Barcode_esValido ("Code39";$t_codigoBarraPersonalizado)
						If ($b_nuevoCodigoBarraValido)
							$recNumREG:=Find in field:C653([BBL_Registros:66]Barcode_SinFormato:26;$t_codigoBarraPersonalizado)
							$recNumLECT:=Find in field:C653([BBL_Lectores:72]BarCode_SinFormato:38;$t_codigoBarraPersonalizado)
							Case of 
								: ($recNumLECT>=0)
									$b_rechazarRegistro:=True:C214
									$l_registrosRechazados:=$l_registrosRechazados+1
									APPEND TO ARRAY:C911($at_entradasLog;"ERROR"+"\t"+"Línea: "+String:C10($l_registrosProcesados)+"\t"+"BARCODE DUPLICADO (un lector tiene el mismo código de barra):"+"\t"+$t_contenidoRegistro)
									$l_recNumRegistro:=-1
									
								: (($recNumREG>=0) & ($l_recNumRegistro#$recNumREG) & ($l_recNumRegistro>=0))
									$t_codigoBarraPersonalizado:=""
									APPEND TO ARRAY:C911($at_entradasLog;"AVISO"+"\t"+"Línea: "+String:C10($l_registrosProcesados)+"\t"+"EL NUEVO CODIGO DE BARRA YA EXISTE PARA OTRO REGISTRO. SE CONSERVÓ EL CODIGO EXIS"+"TENTE:"+"\t"+$t_contenidoRegistro)
									$l_advertencias:=$l_advertencias+1
							End case 
						Else 
							$b_rechazarRegistro:=True:C214
							$l_registrosRechazados:=$l_registrosRechazados+1
							APPEND TO ARRAY:C911($at_entradasLog;"ERROR"+"\t"+"Línea: "+String:C10($l_registrosProcesados)+"\t"+"NUEVO BARCODE INVALIDO:"+"\t"+$t_contenidoRegistro)
						End if 
					End if 
				End if 
				
				If (Not:C34($b_rechazarRegistro))
					$l_elemento:=Find in array:C230(<>atBBL_Media;$t_TipoDocumento)
					If ($l_elemento<0)
						BBLcfg_NuevoTipoDocumento ($t_TipoDocumento)
					Else 
						$t_prefijoCodigoBarra:=<>asBBL_AbrevMedia{$l_elemento}
						$l_IdTipoDocumento:=<>alBBL_IDMedia{$l_elemento}
					End if 
					
					If ($t_TipoRegistro="")
						$t_TipoRegistro:="Monografía"
					End if 
					
					If ($t_AutoresSecundarios#"")
						$t_autor:=$t_AutorPrincipal+"\r"+$t_AutoresSecundarios
					Else 
						$t_autor:=$t_AutorPrincipal
					End if 
					If ($t_TitulosSecundarios#"")
						$t_tituloCompleto:=$t_TituloPrincipal+"\r"+$t_TitulosSecundarios
					Else 
						$t_tituloCompleto:=$t_TituloPrincipal
					End if 
					$t_tituloCompleto:=Replace string:C233($t_tituloCompleto;";";"\r")
					$t_autor:=Replace string:C233($t_autor;";";"\r")
					$t_Editor:=Replace string:C233($t_Editor;";";"\r")
					
					READ WRITE:C146([BBL_Items:61])
					READ WRITE:C146([BBL_Registros:66])
					If ($l_recNumRegistro>=0)
						KRL_GotoRecord (->[BBL_Registros:66];$l_recNumRegistro;True:C214)
						RELATE ONE:C42([BBL_Registros:66]Número_de_item:1)
						If (Records in selection:C76([BBL_Items:61])=1)
							$b_crearItem:=False:C215
						End if 
					Else 
						$b_crearItem:=True:C214
					End if 
					
					If ($b_crearItem)
						  //el registro se crea en memoria sólo para obtener los campos primer titulo, primer autor y primer editor y realizar una búsqueda comn un posible match
						CREATE RECORD:C68([BBL_Items:61])
						[BBL_Items:61]Titulos:5:=$t_tituloCompleto
						[BBL_Items:61]Autores:7:=$t_autor
						[BBL_Items:61]Editores:9:=$t_Editor
						[BBL_Items:61]Materias_json:53:="{}"  //MONO ticket 161866
						BBLitm_NormalizaAutores 
						BBLitm_NormalizaTitulos 
						BBLitm_NormalizaEditores 
						$t_primerTitulo:=[BBL_Items:61]Primer_título:4
						$t_primerAutor:=[BBL_Items:61]Primer_autor:6
						$t_primerEditor:=[BBL_Items:61]Editores:9
						UNLOAD RECORD:C212([BBL_Items:61])
						
						QUERY:C277([BBL_Items:61]; & [BBL_Items:61]Clasificacion:2=$t_ClasificacionDewey;*)
						QUERY:C277([BBL_Items:61]; & [BBL_Items:61]Primer_título:4=$t_primerTitulo;*)
						QUERY:C277([BBL_Items:61]; & [BBL_Items:61]Primer_autor:6=$t_primerAutor;*)
						QUERY:C277([BBL_Items:61]; & [BBL_Items:61]Fecha_de_edicion:10=$t_fechaEdicion;*)
						QUERY:C277([BBL_Items:61]; & [BBL_Items:61]Primer_editor:8=$t_primerEditor)
						
						If (Records in selection:C76([BBL_Items:61])=0)
							CREATE RECORD:C68([BBL_Items:61])
							[BBL_Items:61]Numero:1:=SQ_SeqNumber (->[BBL_Items:61]Numero:1)
							[BBL_Items:61]Fecha_de_creacion:36:=Current date:C33(*)
							[BBL_Items:61]Creado_por:33:=<>tUSR_CurrentUser+": Importación"
							$l_itemsCreados:=$l_itemsCreados+1
						Else 
							$l_itemsActualizados:=$l_itemsActualizados+1
						End if 
					Else 
						$l_itemsActualizados:=$l_itemsActualizados+1
					End if 
					[BBL_Items:61]Titulos:5:=$t_tituloCompleto
					[BBL_Items:61]Autores:7:=$t_autor
					[BBL_Items:61]Editores:9:=$t_Editor
					[BBL_Items:61]Clasificacion:2:=$t_ClasificacionDewey
					[BBL_Items:61]LCCN:23:=$t_LCCN
					[BBL_Items:61]Clasificacion_principal:45:=Substring:C12([BBL_Items:61]Clasificacion:2;3)
					[BBL_Items:61]Tipo_de_registro:18:=$t_TipoRegistro
					[BBL_Items:61]Modificado_por:34:=<>tUSR_CurrentUser+": Importación"
					[BBL_Items:61]Fecha_de_modificacion:37:=Current date:C33(*)
					[BBL_Items:61]Media:15:=$t_TipoDocumento
					[BBL_Items:61]ID_Media:48:=$l_IdTipoDocumento
					[BBL_Items:61]Nivel_de_registro:19:="Monografía"
					[BBL_Items:61]Autores:7:=Replace string:C233($t_autor;";";"\r")
					[BBL_Items:61]Titulos:5:=Replace string:C233($t_tituloCompleto;";";"\r")
					[BBL_Items:61]Editores:9:=$t_Editor
					[BBL_Items:61]Fecha_de_edicion:10:=$t_fechaEdicion
					[BBL_Items:61]Lugar_de_edicion:12:=$t_LugarEdicion
					[BBL_Items:61]Edicion:11:=$t_edicion
					[BBL_Items:61]Volumenes:13:=$t_Volumenes
					[BBL_Items:61]Descripción:14:=$t_descripcion
					[BBL_Items:61]Notas:16:=$t_Notas
					[BBL_Items:61]Resumen:17:=$t_Resumen
					[BBL_Items:61]Idioma:35:=$t_lenguaje
					[BBL_Items:61]ISBN:3:=$t_ISBN
					[BBL_Items:61]Serie_ISSN:31:=$t_ISSN
					[BBL_Items:61]Serie_No:27:=$t_numeroEnSerie
					[BBL_Items:61]Serie_Nombre:26:=$t_Serie_o_Coleccion
					[BBL_Items:61]Serie_Frecuencia:29:=$t_FrecuenciaPublicacion
					[BBL_Items:61]Serie_Fecha_de_publicación:28:=$t_FechaPublicacion
					[BBL_Items:61]Volumen:30:=$t_volumen
					[BBL_Items:61]Cutter:47:=$t_Cutter
					[BBL_Items:61]Regla:20:="GEN"
					
					If ($t_Materias#"")
						$l_numeroDeMaterias:=ST_CountWords ($t_Materias;1;";")
						For ($i;1;$l_numeroDeMaterias)
							$t_materia:=ST_GetWord ($t_Materias;$i;";")
							BBLitm_AgregaMateria ([BBL_Items:61]Numero:1;$t_materia)
						End for 
					End if 
					
					BBLitm_NormalizaAutores 
					BBLitm_NormalizaTitulos 
					BBLitm_NormalizaEditores 
					SAVE RECORD:C53([BBL_Items:61])
					
					If ($b_crearRegistro)
						If ($l_numeroDeCopia#0)
							QUERY:C277([BBL_Registros:66];[BBL_Registros:66]Número_de_item:1=[BBL_Items:61]Numero:1;*)
							QUERY:C277([BBL_Registros:66]; & ;[BBL_Registros:66]Número_de_copia:2=$l_numeroDeCopia)
							If (Records in selection:C76([BBL_Registros:66])=0)
								  //se mantiene el numero de copia del archivo
							Else 
								$l_numeroDeCopia:=[BBL_Items:61]UltimoNumeroDeCopia:49+1
								$l_advertencias:=$l_advertencias+1
								INSERT IN ARRAY:C227($at_entradasLog;1;1)
								$at_entradasLog{1}:="AVISO"+"\t"+"Línea: "+String:C10($l_registrosProcesados)+"\t"+"Numero de copia existente. Reasignado "+"\t"+$t_contenidoRegistro
							End if 
						Else 
							$l_numeroDeCopia:=[BBL_Items:61]UltimoNumeroDeCopia:49+1
						End if 
						CREATE RECORD:C68([BBL_Registros:66])
						[BBL_Registros:66]ID:3:=SQ_SeqNumber (->[BBL_Registros:66]ID:3)
						[BBL_Registros:66]Número_de_item:1:=[BBL_Items:61]Numero:1
						[BBL_Registros:66]Creado_por:16:=<>tUSR_CurrentUser+": Importación"
						If ($l_numeroRegistro=0)
							[BBL_Registros:66]No_Registro:25:=SQ_SeqNumber (->[BBL_Registros:66]No_Registro:25)
						Else 
							[BBL_Registros:66]No_Registro:25:=$l_numeroRegistro
						End if 
						[BBL_Registros:66]Fecha_de_ingreso:5:=Current date:C33(*)
						$l_registrosCreados:=$l_registrosCreados+1
					Else 
						$l_copiasActualizadas:=$l_copiasActualizadas+1
					End if 
					
					[BBL_Registros:66]Código_de_barra:20:="*"+Replace string:C233($t_codigoBarraPersonalizado;"*";"")+"*"
					[BBL_Registros:66]Indice_Barcode:27:=0
					[BBL_Registros:66]Barcode_SinFormato:26:=$t_codigoBarraPersonalizado
					[BBL_Registros:66]Barcode_Protegido:28:=True:C214
					[BBL_Registros:66]Modificacion_Por:32:=<>tUSR_CurrentUser+": Importación"
					[BBL_Registros:66]Modificacion_Fecha:33:=Current date:C33(*)
					[BBL_Registros:66]Número_de_copia:2:=$l_numeroDeCopia
					[BBL_Registros:66]StatusID:34:=Disponible
					[BBL_Registros:66]Lugar:13:=$t_lugar
					[BBL_Registros:66]Comentario:11:=$t_copia_Comentario
					[BBL_Registros:66]Costo:8:=$r_copia_Costo
					[BBL_Registros:66]Fecha_de_adquisición:17:=$d_copia_FechaAdquisicion
					[BBL_Registros:66]Proveedor:4:=$t_copia_Proveedor
					[BBL_Registros:66]Valor_de_remplazo:9:=$r_copia_ValorRemplazo
					[BBL_Registros:66]Número_de_volumen:19:=$t_copia_Volumen
					BBLreg_GeneraCodigoBarra 
					SAVE RECORD:C53([BBL_Registros:66])
					
					If ($b_crearRegistro)
						[BBL_Items:61]Copias:24:=[BBL_Items:61]Copias:24+1
						[BBL_Items:61]Copias_disponibles:43:=[BBL_Items:61]Copias_disponibles:43+1
						If ([BBL_Registros:66]Número_de_copia:2>[BBL_Items:61]UltimoNumeroDeCopia:49)
							[BBL_Items:61]UltimoNumeroDeCopia:49:=[BBL_Registros:66]Número_de_copia:2
						End if 
					End if 
					SAVE RECORD:C53([BBL_Items:61])
					
				End if 
				GOTO XY:C161(0;0)
				MESSAGE:C88("Registros procesados: "+String:C10($l_registrosProcesados)+"\r"+"Items creados: "+String:C10($l_itemsCreados)+"\r"+"Items actualizado: "+String:C10($l_itemsActualizados)+"\r"+"Copias creadas: "+String:C10($l_registrosCreados)+"\r"+"Copias actualizadas:"+String:C10($l_copiasActualizadas)+"\r"+"Copias rechazadas: "+String:C10($l_registrosRechazados)+"\r"+"Avisos: "+String:C10($l_advertencias))
				RECEIVE PACKET:C104($h_refDocumento;$t_contenidoRegistro;"\r")
				If ($t_plataformaOrigen="WIN")
					$t_contenidoRegistro:=_O_Win to Mac:C464($t_contenidoRegistro)
				End if 
			End while 
		End if 
		CLOSE DOCUMENT:C267($h_refDocumento)
		CLOSE WINDOW:C154
		FLUSH CACHE:C297
		BBLdbu_BuildCards 
		BBLdbu_AsignaLugaresItems 
		SQ_SetSequences 
		FLUSH CACHE:C297
		
		CD_Dlog (0;__ ("Registros procesados: ")+String:C10($l_registrosProcesados)+__ ("\rItems creados: ")+String:C10($l_itemsCreados)+__ ("\rItems actualizado: ")+String:C10($l_itemsActualizados)+__ ("\rCopias creadas: ")+String:C10($l_registrosCreados)+__ ("\rCopias actualizadas:")+String:C10($l_copiasActualizadas)+__ ("\rCopias rechazadas: ")+String:C10($l_registrosRechazados)+__ ("\rAvisos: ")+String:C10($l_advertencias))
		If (Size of array:C274($at_entradasLog)>0)
			$t_rutaLog:=$t_rutaDirectorio+"ImportacionItemsRegistros.log"
			$h_refDocumento:=Create document:C266($t_rutaLog)
			SORT ARRAY:C229($at_entradasLog;>)
			For ($i;1;Size of array:C274($at_entradasLog))
				SEND PACKET:C103($h_refDocumento;$at_entradasLog{$i}+"\r")
			End for 
			CLOSE DOCUMENT:C267($h_refDocumento)
			CD_Dlog (0;__ ("Se detectaron algunos problemas durante la importación.\r\rPor favor consulte el archivo: ")+$t_rutaLog)
		End if 
		
		USE CHARACTER SET:C205(*;0)
	End if 
End if 