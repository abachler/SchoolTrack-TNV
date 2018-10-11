//%attributes = {}
  // ACTcfg_OpcionesPagares()
  //
  // creado por roberto: 11-09-10, 15:38:00
  // modificado por: Alberto Bachler Klein: 06-04-16, 21:00:55
  // -----------------------------------------------------------
C_TEXT:C284($0)
C_TEXT:C284($1)
C_POINTER:C301(${2})

C_BLOB:C604($xBlob)
C_BOOLEAN:C305($b_mostrarAlerta;$b_noMostrarMensaje;$b_saltarValidacion)
C_LONGINT:C283($error;$i;$l_idProceso;$l_proceso;$l_recNumInforme;$maxsize;$offset;$page;$tableNumber;$l_Column)
C_LONGINT:C283($l_existe;$l_idAlumno;$l_idApdo;$l_idCta;$l_idEstado;$l_idFDP;$l_idFormaDePago;$l_idPagare;$l_idPagareT;$l_idRegistro)
C_LONGINT:C283($l_idTipoArchivo;$l_line;$l_multiLine;$l_records;$l_row;$vlTime;$l_ACTp_BusquedaNum)
C_POINTER:C301($ptr1;$ptr2;$ptrCurrentTable;$tablePointer)
C_TEXT:C284($t_destinoImpresion;$t_expresionNombreDocumento;$t_nombreProceso;$t_rutaCarpetaPDFs;$t_accion;$t_evento;$t_nombreArchivo;$t_retorno;$t_textAlumno;$t_textApoderado)
C_TEXT:C284($t_textTercero)

ARRAY LONGINT:C221($aiACTp_Nivel;0)
ARRAY LONGINT:C221($al_Lines;0)
ARRAY LONGINT:C221($alACT_idsAvisos;0)
ARRAY LONGINT:C221($alACT_pos1;0)
ARRAY LONGINT:C221($alACT_pos2;0)
ARRAY LONGINT:C221($alACT_pos3;0)
ARRAY TEXT:C222($atACTp_Carreras;0)
ARRAY TEXT:C222($atACTp_Cursos;0)
ARRAY TEXT:C222($atACTp_Regimen;0)



If (False:C215)
	C_TEXT:C284(ACTcfg_OpcionesPagares ;$0)
	C_TEXT:C284(ACTcfg_OpcionesPagares ;$1)
	C_POINTER:C301(ACTcfg_OpcionesPagares ;${2})
End if 

If (Count parameters:C259>=1)
	$t_accion:=$1
End if 
If (Count parameters:C259>=2)
	$ptr1:=$2
End if 
If (Count parameters:C259>=3)
	$ptr2:=$3
End if 
Case of 
	: ($t_accion="")
		  //$l_line:=AL_GetLine (ALP_Carreras)
		  //$l_column:=AL_GetColumn (ALP_Carreras)
		  //AL_GetCurrCell (ALP_Carreras;$l_column;$l_line)
		  //Case of
		  //: ($l_column=5)
		  //$choice:=Find in array(atACT_Matrices;atACTp_Matrices{$l_line})
		  //If ($choice>0)
		  //atACTp_Matrices{$l_line}:=atACT_Matrices{$choice}
		  //alACTp_Matrices{$l_line}:=alACT_Matrices{$choice}
		  //arACTp_Montos{$l_line}:=arACT_Montos{$choice}
		  //End if
		  //End case
		
	: ($t_accion="OnLoad")
		C_LONGINT:C283(HL_pagares)
		C_LONGINT:C283(vlACTp_Dia;vlACTp_Cuota)
		C_TEXT:C284(vtACTp_Regimen)
		
		C_TEXT:C284(vtACT_Item;vtACT_RegimenDcto;vtACT_ItemCargo)
		C_LONGINT:C283(vlACT_Item;vlACT_ItemCargo)
		C_TEXT:C284(vtACT_RegimenCargo;vtACT_RegimenDcto)
		
		vtACT_Item:=""
		vtACT_RegimenDcto:=""
		vtACT_ItemCargo:=""
		vtACT_RegimenCargo:=""
		vtACT_RegimenDcto:=""
		
		vlACT_Item:=0
		vlACT_ItemCargo:=0
		
		ACTcfg_OpcionesPagares ("OnLoadFormConf")
		
		  //HL_pagares:=New list
		  //APPEND TO LIST(HL_pagares;"Configuración";1)
		  //APPEND TO LIST(HL_pagares;"Pagarés";2)
		
		OBJECT SET VISIBLE:C603(*;"vt_agregado1";False:C215)
		OBJECT SET VISIBLE:C603(*;"vt_eliminado1";False:C215)
		OBJECT SET VISIBLE:C603(*;"vt_agregado2";False:C215)
		OBJECT SET VISIBLE:C603(*;"vt_eliminado2";False:C215)
		OBJECT SET VISIBLE:C603(*;"vt_agregado3";False:C215)
		OBJECT SET VISIBLE:C603(*;"vt_eliminado3";False:C215)
		
		  //LISTA CARRERA / DESCUENTOS
		C_LONGINT:C283(hl_Pagina1)
		hl_Pagina1:=New list:C375
		APPEND TO LIST:C376(hl_Pagina1;"Cursos";1)
		APPEND TO LIST:C376(hl_Pagina1;"Cargos";2)
		APPEND TO LIST:C376(hl_Pagina1;"Descuentos";3)
		SELECT LIST ITEMS BY POSITION:C381(hl_Pagina1;1)
		
		ACTcfg_OpcionesPagares ("OcultaAreasCarreras_Dctos")
		
		If (cs_genPagare=0)
			cs_imprimirPagare:=0
			_O_DISABLE BUTTON:C193(cs_imprimirPagare)
		Else 
			_O_ENABLE BUTTON:C192(cs_imprimirPagare)
		End if 
		
	: ($t_accion="DeclaraArreglosALP")
		ARRAY LONGINT:C221(alACTp_Numero;0)
		ARRAY DATE:C224(adACTp_Fecha;0)
		ARRAY TEXT:C222(atACTp_Apdo;0)
		ARRAY TEXT:C222(atACTp_Cuenta;0)
		ARRAY TEXT:C222(atACTp_Carrera;0)
		ARRAY REAL:C219(arACTp_Monto;0)
		ARRAY TEXT:C222(atACTp_Estado;0)
		ARRAY LONGINT:C221(alACTp_Estado;0)
		ARRAY LONGINT:C221(alACTp_IDPagare;0)
		
	: ($t_accion="ConfiguraALP")
		
		ACTpp_OpcionesPagares ("DeclaraArreglosPagares")
		
		$l_multiLine:=$ptr1->
		
		AT_Inc (0)
		$error:=ALP_DefaultColSettings (xALP_Pagares;AT_Inc ;"alACTp_Numero";__ ("Número");42;"##########";0;0;0)
		$error:=ALP_DefaultColSettings (xALP_Pagares;AT_Inc ;"adACTp_Fecha";__ ("Fecha");42;"00/00/0000")
		$error:=ALP_DefaultColSettings (xALP_Pagares;AT_Inc ;"atACTp_Apdo";__ ("Apoderado");135)
		$error:=ALP_DefaultColSettings (xALP_Pagares;AT_Inc ;"atACTp_Cuenta";__ ("Cuenta");135;"";0;0;0)
		$error:=ALP_DefaultColSettings (xALP_Pagares;AT_Inc ;"atACTp_Carrera";__ ("Curso");100;"")
		$error:=ALP_DefaultColSettings (xALP_Pagares;AT_Inc ;"arACTp_Monto";__ ("Monto");66;"|Despliegue_ACT")
		$error:=ALP_DefaultColSettings (xALP_Pagares;AT_Inc ;"atACTp_Estado";__ ("Estado");69;"")
		$error:=ALP_DefaultColSettings (xALP_Pagares;AT_Inc ;"alACTp_Estado";__ ("ID Estado");59;"")
		$error:=ALP_DefaultColSettings (xALP_Pagares;AT_Inc ;"alACTp_IDPagare";__ ("ID Pagare");59;"")
		
		ALP_SetDefaultAppareance (xALP_Pagares;9;1;6;2;8)
		AL_SetColOpts (xALP_Pagares;1;1;1;2;0)
		AL_SetRowOpts (xALP_Pagares;$l_multiLine;1;0;0;1;0)
		AL_SetCellOpts (xALP_Pagares;0;1;1)
		AL_SetMainCalls (xALP_Pagares;"";"")
		AL_SetCallbacks (xALP_Pagares;"";"")
		AL_SetScroll (xALP_Pagares;0;-3)
		AL_SetEntryOpts (xALP_Pagares;1;0;0;0;2;<>tXS_RS_DecimalSeparator)
		AL_SetDrgOpts (xALP_Pagares;0;30;0)
		
	: ($t_accion="DeclaraVarsInterfaz1")
		C_LONGINT:C283(vlACTp_Proximo;cs_genContrato;cs_genPagare;cs_imprimirPagare)
		C_TEXT:C284(vtACTp_Periodo;vtACTp_ModPagare;vtACTp_ModContrato)
		
		C_LONGINT:C283(vlACTp_Dia;vlACTp_Cuota)
		C_TEXT:C284(vtACTp_Regimen)
		C_TEXT:C284(vtACTp_AvisoMes)
		C_LONGINT:C283(vlACTp_MatriculaYear)
		
	: ($t_accion="InitVarsInterfaz1")
		vlACTp_Proximo:=0
		cs_genContrato:=0
		cs_genPagare:=0
		cs_imprimirPagare:=0
		vtACTp_Periodo:=""
		vtACTp_ModPagare:=""
		vtACTp_ModContrato:=""
		vlACTp_Dia:=0
		vlACTp_Cuota:=0
		vtACTp_Regimen:=""
		vtACTp_AvisoMes:=<>atXS_MonthNames{Month of:C24(Current date:C33(*))}
		vlACTp_MatriculaYear:=Year of:C25(Current date:C33(*))
		
		
	: ($t_accion="DeclaraVarsInterfaz_Init")
		ACTcfg_OpcionesPagares ("DeclaraVarsInterfaz1")
		ACTcfg_OpcionesPagares ("InitVarsInterfaz1")
		
	: ($t_accion="DeclaraVarsInterfaz2")
		C_LONGINT:C283(vlACTp_BusquedaNum1;vlACTp_BusquedaNum2;vlACTp_BusquedaAC)
		C_TEXT:C284(vtACTp_BusquedaApo;vtACTp_BusquedaCta;vtACTp_BusquedaPeriodo)
		C_DATE:C307(vdACTp_BusquedaFecha;vdACTp_BusquedaFecha2)
		
	: ($t_accion="InitVarsInterfaz2")
		vlACTp_BusquedaNum1:=0
		vlACTp_BusquedaNum2:=0
		vlACTp_BusquedaAC:=0
		vtACTp_BusquedaApo:=""
		vtACTp_BusquedaCta:=""
		vdACTp_BusquedaFecha:=Current date:C33(*)
		vdACTp_BusquedaFecha2:=vdACTp_BusquedaFecha
		vtACTp_BusquedaPeriodo:=""
		
	: ($t_accion="ArreglosDiaCuotaRegimen")
		ARRAY LONGINT:C221(alACT_DiasPagares;0)
		ARRAY LONGINT:C221(alACT_CuotasPagares;0)
		ARRAY TEXT:C222(atACT_RegimenPagares;0)
		
	: ($t_accion="DeclaraArreglosALPDescuento")
		ARRAY TEXT:C222(atACTp_ItemDcto;0)
		ARRAY TEXT:C222(atACTp_RegimenDcto;0)
		ARRAY REAL:C219(arACTp_MontoDcto;0)
		ARRAY LONGINT:C221(alACTp_ItemDcto;0)
		ARRAY PICTURE:C279(apACTp_DctoNoAcum;0)
		ARRAY BOOLEAN:C223(abACTp_DctoNoAcum;0)
		
		ARRAY TEXT:C222(atACT_PItemNombreDcto;0)
		ARRAY LONGINT:C221(alACT_PItemIDDcto;0)
		
	: ($t_accion="DeclaraArreglosALPCargo")
		ARRAY TEXT:C222(atACTp_ItemCargo;0)
		ARRAY TEXT:C222(atACTp_RegimenCargo;0)
		ARRAY REAL:C219(arACTp_MontoCargo;0)
		ARRAY LONGINT:C221(alACTp_ItemCargo;0)
		ARRAY PICTURE:C279(apACTp_AvisoSeparado;0)
		ARRAY BOOLEAN:C223(abACTp_AvisoSeparado;0)
		
		ARRAY TEXT:C222(atACT_PItemNombreCargo;0)
		ARRAY LONGINT:C221(alACT_PItemIDCargo;0)
		
	: ($t_accion="ConfiguraALPCargos")
		
		AT_Inc (0)
		$error:=ALP_DefaultColSettings (ALP_PCargos;AT_Inc ;"atACTp_ItemCargo";__ ("Ítem");260;"";0;0;1)
		$error:=ALP_DefaultColSettings (ALP_PCargos;AT_Inc ;"atACTp_RegimenCargo";__ ("Régimen");70;"")
		$error:=ALP_DefaultColSettings (ALP_PCargos;AT_Inc ;"arACTp_MontoCargo";__ ("Monto Cargo");70;"|Despliegue_ACT")
		$error:=ALP_DefaultColSettings (ALP_PCargos;AT_Inc ;"apACTp_AvisoSeparado";__ ("No Incluido\ren Pagaré");80;"1")
		$error:=ALP_DefaultColSettings (ALP_PCargos;AT_Inc ;"alACTp_ItemCargo";"ID Ítem";50;"";0;0;1)
		$error:=ALP_DefaultColSettings (ALP_PCargos;AT_Inc ;"abACTp_AvisoSeparado";"No Incluido en Pagaré B";50;"";0;0;1)
		
		ALP_SetDefaultAppareance (ALP_PCargos;9;1;6;2;8)
		AL_SetColOpts (ALP_PCargos;1;1;1;2;0)
		AL_SetRowOpts (ALP_PCargos;0;1;0;0;1;0)
		AL_SetCellOpts (ALP_PCargos;0;1;1)
		AL_SetMainCalls (ALP_PCargos;"";"")
		AL_SetCallbacks (ALP_PCargos;"";"")
		AL_SetScroll (ALP_PCargos;0;-3)
		AL_SetEntryOpts (ALP_PCargos;3;0;0;0;2;<>tXS_RS_DecimalSeparator)
		AL_SetDrgOpts (ALP_PCargos;0;30;0)
		
	: ($t_accion="ConfiguraALPDescuento")
		
		AT_Inc (0)
		$error:=ALP_DefaultColSettings (ALP_Descuentos;AT_Inc ;"atACTp_ItemDcto";__ ("Ítem");260;"";0;0;1)
		$error:=ALP_DefaultColSettings (ALP_Descuentos;AT_Inc ;"atACTp_RegimenDcto";__ ("Régimen");80;"")
		$error:=ALP_DefaultColSettings (ALP_Descuentos;AT_Inc ;"arACTp_MontoDcto";__ ("Monto Descuento");80;"|Despliegue_ACT")
		$error:=ALP_DefaultColSettings (ALP_Descuentos;AT_Inc ;"apACTp_DctoNoAcum";__ ("Descuento\rNo Acum.");60;"1")
		$error:=ALP_DefaultColSettings (ALP_Descuentos;AT_Inc ;"alACTp_ItemDcto";"ID Ítem";50;"";0;0;1)
		$error:=ALP_DefaultColSettings (ALP_Descuentos;AT_Inc ;"abACTp_DctoNoAcum";"En Aviso Separado b";50;"";0;0;1)
		
		ALP_SetDefaultAppareance (ALP_Descuentos;9;1;6;2;8)
		AL_SetColOpts (ALP_Descuentos;1;1;1;2;0)
		AL_SetRowOpts (ALP_Descuentos;0;1;0;0;1;0)
		AL_SetCellOpts (ALP_Descuentos;0;1;1)
		AL_SetMainCalls (ALP_Descuentos;"";"")
		AL_SetCallbacks (ALP_Descuentos;"";"")
		AL_SetScroll (ALP_Descuentos;0;-3)
		AL_SetEntryOpts (ALP_Descuentos;3;0;0;0;2;<>tXS_RS_DecimalSeparator)
		AL_SetDrgOpts (ALP_Descuentos;0;30;0)
		
	: ($t_accion="OnLoadFormConf")
		
		ACTcfg_OpcionesPagares ("DeclaraVarsInterfaz_Init")
		ACTcfg_OpcionesPagares ("DeclaraVarsInterfaz2")
		ACTcfg_OpcionesPagares ("InitVarsInterfaz2")
		ACTcfg_OpcionesPagares ("ArreglosDiaCuotaRegimen")
		
		ACTcfg_OpcionesPagares ("DeclaraArreglosALPDescuento")
		ACTcfg_OpcionesPagares ("ConfiguraALPDescuento")
		ACTcfg_OpcionesPagares ("DeclaraArreglosALPCargo")
		ACTcfg_OpcionesPagares ("ConfiguraALPCargos")
		
		READ ONLY:C145([ACT_Pagares:184])
		READ ONLY:C145([ACT_Avisos_de_Cobranza:124])
		READ ONLY:C145([Personas:7])
		READ ONLY:C145([ACT_CuentasCorrientes:175])
		READ ONLY:C145([Alumnos:2])
		READ ONLY:C145([ACT_Documentos_de_Cargo:174])
		
		READ ONLY:C145([xxACT_Items:179])
		
		READ ONLY:C145([ACT_Matrices:177])
		ARRAY TEXT:C222(atACT_Matrices;0)
		ARRAY LONGINT:C221(alACT_Matrices;0)
		ARRAY REAL:C219(arACT_Montos;0)
		ALL RECORDS:C47([ACT_Matrices:177])
		SELECTION TO ARRAY:C260([ACT_Matrices:177]Nombre_matriz:2;atACT_Matrices;[ACT_Matrices:177]ID:1;alACT_Matrices;[ACT_Matrices:177]Monto_total:5;arACT_Montos)
		AT_Insert (1;1;->atACT_Matrices;->alACT_Matrices;->arACT_Montos)
		atACT_Matrices{1}:="Ninguna"
		alACT_Matrices{1}:=0
		arACT_Montos{1}:=0
		
		ACTcfg_OpcionesPagares ("DeclaraArreglosALP_Carreras")
		ACTcfg_OpcionesPagares ("ConfiguraALPCarreras")
		
		AL_UpdateArrays (ALP_Descuentos;0)
		AL_UpdateArrays (ALP_PCargos;0)
		AL_UpdateArrays (ALP_Carreras;0)
		ACTcfg_OpcionesPagares ("LeeBlobs")
		
		ACTcfg_OpcionesPagares ("CargaArreglosCarreras")
		
		AL_UpdateArrays (ALP_Descuentos;-2)
		AL_UpdateArrays (ALP_PCargos;-2)
		AL_UpdateArrays (ALP_Carreras;-2)
		ACTcfg_OpcionesPagares ("SetEstadoTacho")
		
		  //copia arreglo jornadas
		COPY ARRAY:C226(atACTp_Regimen;atACT_RegimenPagares)
		AT_DistinctsArrayValues (->atACT_RegimenPagares)
		
		ACTqry_Items ("NoEspeciales")
		QUERY SELECTION:C341([xxACT_Items:179];[xxACT_Items:179]EsDescuento:6=True:C214)
		SELECTION TO ARRAY:C260([xxACT_Items:179]Glosa:2;atACT_PItemNombreDcto;[xxACT_Items:179]ID:1;alACT_PItemIDDcto)
		SORT ARRAY:C229(atACT_PItemNombreDcto;alACT_PItemIDDcto;>)
		
		ACTqry_Items ("NoEspeciales")
		QUERY SELECTION:C341([xxACT_Items:179];[xxACT_Items:179]EsDescuento:6=False:C215)
		SELECTION TO ARRAY:C260([xxACT_Items:179]Glosa:2;atACT_PItemNombreCargo;[xxACT_Items:179]ID:1;alACT_PItemIDCargo)
		SORT ARRAY:C229(atACT_PItemNombreCargo;alACT_PItemIDCargo;>)
		
	: ($t_accion="CargaArreglosCarreras")
		READ ONLY:C145([Cursos:3])
		
		ALL RECORDS:C47([Cursos:3])
		SELECTION TO ARRAY:C260([Cursos:3]Curso:1;$atACTp_Cursos;[Cursos:3]Sede:19;$atACTp_Carreras;[Cursos:3]Sala:3;$atACTp_Regimen;[Cursos:3]Nivel_Numero:7;$aiACTp_Nivel)
		For ($i;1;Size of array:C274($atACTp_Carreras))
			$l_existe:=Find in array:C230(atACTp_Cursos;$atACTp_Cursos{$i})
			If ($l_existe=-1)
				AT_Insert (1;1;->alACTp_Nivel;->atACTp_Cursos;->atACTp_Carreras;->atACTp_Regimen;->atACTp_Matrices;->arACTp_Montos;->alACTp_Matrices)
				$l_existe:=1
			End if 
			atACTp_Cursos{$l_existe}:=$atACTp_Cursos{$i}
			atACTp_Carreras{$l_existe}:=$atACTp_Carreras{$i}
			atACTp_Regimen{$l_existe}:=$atACTp_Regimen{$i}
			alACTp_Nivel{$l_existe}:=$aiACTp_Nivel{$i}
			
		End for 
		SORT ARRAY:C229(alACTp_Nivel;atACTp_Cursos;atACTp_Carreras;atACTp_Regimen;atACTp_Matrices;arACTp_Montos;alACTp_Matrices;>)
		
	: ($t_accion="CargaArreglosALP")
		If (Not:C34(Is nil pointer:C315($ptr1)))
			$b_noMostrarMensaje:=$ptr1->
		End if 
		AL_UpdateArrays (xALP_Pagares;0)
		ACTcfg_OpcionesPagares ("DeclaraArreglosALP")
		If (Records in selection:C76([ACT_Pagares:184])>0)
			ORDER BY:C49([ACT_Pagares:184];[ACT_Pagares:184]Numero_Pagare:11;>;[ACT_Pagares:184]Fecha_Generacion:9;>)
			While (Not:C34(End selection:C36([ACT_Pagares:184])))
				  //QUERY([ACT_Avisos_de_Cobranza];[ACT_Avisos_de_Cobranza]ID_Pagare=[ACT_Pagares]ID)
				  //QUERY([ACT_CuentasCorrientes];[ACT_CuentasCorrientes]ID=[ACT_Avisos_de_Cobranza]ID_CuentaCorrriente)
				APPEND TO ARRAY:C911(alACTp_Numero;[ACT_Pagares:184]Numero_Pagare:11)
				APPEND TO ARRAY:C911(adACTp_Fecha;[ACT_Pagares:184]Fecha_Generacion:9)
				APPEND TO ARRAY:C911(atACTp_Apdo;KRL_GetTextFieldData (->[Personas:7]No:1;->[ACT_Pagares:184]ID_Apdo:17;->[Personas:7]Apellidos_y_nombres:30))
				APPEND TO ARRAY:C911(atACTp_Cuenta;KRL_GetTextFieldData (->[Alumnos:2]numero:1;->[ACT_Pagares:184]ID_Cta:18;->[Alumnos:2]apellidos_y_nombres:40))
				APPEND TO ARRAY:C911(atACTp_Carrera;[ACT_Pagares:184]Carrera:7)
				APPEND TO ARRAY:C911(arACTp_Monto;[ACT_Pagares:184]Monto:8)
				APPEND TO ARRAY:C911(alACTp_Estado;[ACT_Pagares:184]ID_Estado:6)
				APPEND TO ARRAY:C911(alACTp_IDPagare;[ACT_Pagares:184]ID:12)
				APPEND TO ARRAY:C911(atACTp_Estado;ACTcfg_OpcionesPagares ("ObtieneEstadoXID";->alACTp_Estado{Size of array:C274(alACTp_Estado)}))
				NEXT RECORD:C51([ACT_Pagares:184])
			End while 
			
			  //For ($i;1;Size of array(alACTp_Estado))
			  //$l_idEstado:=alACTp_Estado{$i}
			  //APPEND TO ARRAY(atACTp_Estado;ACTcfg_OpcionesPagares ("ObtieneEstadoXID";->$l_idEstado))
			  //End for
		Else 
			If (Not:C34($b_noMostrarMensaje))
				CD_Dlog (0;"No hay registros que cumplan con el criterio de búsqueda.")
			End if 
		End if 
		AL_UpdateArrays (xALP_Pagares;-2)
		ACTcfg_OpcionesPagares ("SetEstilos")
		
	: ($t_accion="BuscarPorNumero")
		READ ONLY:C145([ACT_Pagares:184])
		If (vlACTp_BusquedaNum2=0)
			$l_ACTp_BusquedaNum:=MAXLONG:K35:2
		Else 
			If (vlACTp_BusquedaNum1>vlACTp_BusquedaNum2)
				vlACTp_BusquedaNum2:=vlACTp_BusquedaNum1
			End if 
			$l_ACTp_BusquedaNum:=vlACTp_BusquedaNum2
		End if 
		QUERY:C277([ACT_Pagares:184];[ACT_Pagares:184]Numero_Pagare:11>=vlACTp_BusquedaNum1;*)
		QUERY:C277([ACT_Pagares:184]; & ;[ACT_Pagares:184]Numero_Pagare:11<=$l_ACTp_BusquedaNum)
		ACTcfg_OpcionesPagares ("CargaArreglosALP")
		
	: ($t_accion="BuscarPorApoderado")
		READ ONLY:C145([ACT_Pagares:184])
		READ ONLY:C145([Personas:7])
		
		QUERY:C277([Personas:7];[Personas:7]Apellidos_y_nombres:30=vtACTp_BusquedaApo)
		QUERY:C277([ACT_Pagares:184];[ACT_Pagares:184]ID_Apdo:17=[Personas:7]No:1)
		ACTcfg_OpcionesPagares ("CargaArreglosALP")
		
	: ($t_accion="BuscarPorCtaCte")
		READ ONLY:C145([ACT_Pagares:184])
		READ ONLY:C145([Alumnos:2])
		READ ONLY:C145([ACT_CuentasCorrientes:175])
		
		QUERY:C277([Alumnos:2];[Alumnos:2]apellidos_y_nombres:40=vtACTp_BusquedaCta)
		QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID_Alumno:3=[Alumnos:2]numero:1)
		QUERY:C277([ACT_Pagares:184];[ACT_Pagares:184]ID_Cta:18=[ACT_CuentasCorrientes:175]ID:1)
		ACTcfg_OpcionesPagares ("CargaArreglosALP")
		
	: ($t_accion="BuscarPorNumAC")
		READ ONLY:C145([ACT_Pagares:184])
		READ ONLY:C145([ACT_Avisos_de_Cobranza:124])
		QUERY:C277([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Aviso:1=vlACTp_BusquedaAC)
		QUERY:C277([ACT_Pagares:184];[ACT_Pagares:184]ID:12=[ACT_Avisos_de_Cobranza:124]ID_Pagare:30)
		ACTcfg_OpcionesPagares ("CargaArreglosALP")
		
	: ($t_accion="BuscarPorFechaPagare")
		READ ONLY:C145([ACT_Pagares:184])
		If (vdACTp_BusquedaFecha2>vdACTp_BusquedaFecha)
			vdACTp_BusquedaFecha2:=vdACTp_BusquedaFecha
			BEEP:C151
		End if 
		QUERY:C277([ACT_Pagares:184];[ACT_Pagares:184]Fecha_Generacion:9>=vdACTp_BusquedaFecha;*)
		QUERY:C277([ACT_Pagares:184]; & ;[ACT_Pagares:184]Fecha_Generacion:9<=vdACTp_BusquedaFecha2)
		ACTcfg_OpcionesPagares ("CargaArreglosALP")
		
	: ($t_accion="BuscarPorPeriodoP")
		READ ONLY:C145([ACT_Pagares:184])
		QUERY:C277([ACT_Pagares:184];[ACT_Pagares:184]Periodo:5=vtACTp_BusquedaPeriodo+"@")
		ACTcfg_OpcionesPagares ("CargaArreglosALP")
		
	: ($t_accion="ObtieneDatosAnulacion")
		[ACT_Pagares:184]ID_Estado:6:=-102
		[ACT_Pagares:184]Anulado_Por:16:=<>tUSR_CurrentUser
		[ACT_Pagares:184]Fecha_Anulacion:13:=Current date:C33(*)
		
	: ($t_accion="AnulaPagare")
		$l_idPagare:=$ptr1->
		KRL_FindAndLoadRecordByIndex (->[ACT_Pagares:184]ID:12;->$l_idPagare;True:C214)
		If (ok=1)
			ACTcfg_OpcionesGeneracionP ("CalculaMontoPagare";->$l_idPagare)
			KRL_FindAndLoadRecordByIndex (->[ACT_Pagares:184]ID:12;->$l_idPagare;True:C214)
			ACTcfg_OpcionesPagares ("ObtieneDatosAnulacion")
			ACTpagares_fSave 
			$t_evento:="Anulación de Pagaré."
			ACTcfg_OpcionesPagares ("Log";->$t_evento)
			
			READ ONLY:C145([ACT_Avisos_de_Cobranza:124])
			QUERY:C277([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Pagare:30=$l_idPagare)
			SELECTION TO ARRAY:C260([ACT_Avisos_de_Cobranza:124]ID_Aviso:1;$alACT_idsAvisos)
			$l_idPagareT:=0
			$b_saltarValidacion:=True:C214
			ACTcfg_OpcionesGeneracionP ("AsignaIDPagareAAC1";->$l_idPagareT;->$alACT_idsAvisos;->$b_saltarValidacion)
			FLUSH CACHE:C297
		End if 
		KRL_FindAndLoadRecordByIndex (->[ACT_Pagares:184]ID:12;->$l_idPagare;True:C214)
		
	: ($t_accion="ValidaEliminacion")
		$l_idPagare:=$ptr1->
		$b_mostrarAlerta:=$ptr2->
		KRL_FindAndLoadRecordByIndex (->[ACT_Pagares:184]ID:12;->$l_idPagare)
		If ([ACT_Pagares:184]ID_Estado:6#-102)
			If ($b_mostrarAlerta)
				CD_Dlog (0;__ ("Antes de eliminar un pagaré, usted debe anularlo.")+" "+__ ("El documento no puede ser eliminado."))
			End if 
			$t_retorno:="2"  // pagare no nulo
		Else 
			If (Locked:C147([ACT_Pagares:184]))
				If ($b_mostrarAlerta)
					CD_Dlog (0;__ ("El registro se encuentra bloqueado por otro proceso.")+" "+__ ("El documento no puede ser eliminado."))
				End if 
				$t_retorno:="3"  // registro bloqueado
			Else 
				$t_retorno:="1"
			End if 
		End if 
		
	: ($t_accion="EliminaPagare")
		$l_idPagare:=$ptr1->
		KRL_FindAndLoadRecordByIndex (->[ACT_Pagares:184]ID:12;->$l_idPagare;True:C214)
		If (ok=1)
			If ([ACT_Pagares:184]ID_Estado:6=-102)
				$t_evento:="Eliminación de Pagaré."
				ACTcfg_OpcionesPagares ("Log";->$t_evento)
				
				$l_idTipoArchivo:=1
				$l_idCta:=0
				$l_idApdo:=0
				$l_idRegistro:=[ACT_Pagares:184]ID:12
				$t_nombreArchivo:=""
				ACTio_OpcionesArchivos ("EliminaPagares";->$l_idTipoArchivo;->$l_idCta;->$l_idApdo;->$l_idRegistro;->$t_nombreArchivo)
				
				DELETE RECORD:C58([ACT_Pagares:184])
			End if 
		End if 
		KRL_UnloadReadOnly (->[ACT_Pagares:184])
		
	: ($t_accion="AnularPagares")
		COPY ARRAY:C226($ptr1->;$al_Lines)
		For ($i;1;Size of array:C274($al_Lines))
			$l_idPagare:=alACTp_IDPagare{$al_Lines{$i}}
			ACTcfg_OpcionesPagares ("AnulaPagare";->$l_idPagare)
			KRL_UnloadReadOnly (->[ACT_Pagares:184])
			
			alACTp_Estado{$al_Lines{$i}}:=KRL_GetNumericFieldData (->[ACT_Pagares:184]ID:12;->$l_idPagare;->[ACT_Pagares:184]ID_Estado:6)
			$l_idEstado:=alACTp_Estado{$al_Lines{$i}}
			atACTp_Estado{$al_Lines{$i}}:=ACTcfg_OpcionesPagares ("ObtieneEstadoXID";->$l_idEstado)
			
		End for 
		
	: ($t_accion="SetEstilos")
		For ($i;1;Size of array:C274(alACTp_IDPagare))
			If (alACTp_Estado{$i}=-2)
				AL_SetRowColor (xALP_Pagares;$i;"";15*16+8)
				AL_SetRowStyle (xALP_Pagares;$i;2)
			Else 
				AL_SetRowColor (xALP_Pagares;$i;"";16)
				AL_SetRowStyle (xALP_Pagares;$i;0)
			End if 
		End for 
		AL_UpdateArrays (xALP_Pagares;-1)
		
	: ($t_accion="DeclaraArreglosALP_Carreras")
		ARRAY TEXT:C222(atACTp_Cursos;0)
		ARRAY LONGINT:C221(alACTp_Nivel;0)
		ARRAY TEXT:C222(atACTp_Carreras;0)
		ARRAY TEXT:C222(atACTp_Regimen;0)
		ARRAY TEXT:C222(atACTp_Matrices;0)
		ARRAY REAL:C219(arACTp_Montos;0)
		ARRAY LONGINT:C221(alACTp_Matrices;0)
		
	: ($t_accion="ConfiguraALPCarreras")
		
		AT_Inc (0)
		$error:=ALP_DefaultColSettings (ALP_Carreras;AT_Inc ;"atACTp_Cursos";__ ("Curso");60;"")
		$error:=ALP_DefaultColSettings (ALP_Carreras;AT_Inc ;"alACTp_Nivel";__ ("Nivel");30;"##0")
		$error:=ALP_DefaultColSettings (ALP_Carreras;AT_Inc ;"atACTp_Carreras";__ ("Sede");160;"")
		$error:=ALP_DefaultColSettings (ALP_Carreras;AT_Inc ;"atACTp_Regimen";__ ("Régimen");50;"")
		$error:=ALP_DefaultColSettings (ALP_Carreras;AT_Inc ;"atACTp_Matrices";__ ("Matriz");120)
		$error:=ALP_DefaultColSettings (ALP_Carreras;AT_Inc ;"arACTp_Montos";__ ("Monto");60;"|Despliegue_ACT")
		$error:=ALP_DefaultColSettings (ALP_Carreras;AT_Inc ;"alACTp_Matrices";"id_Matriz";47;"")
		
		AL_SetEnterable (ALP_Carreras;5;2;atACT_Matrices)
		
		ALP_SetDefaultAppareance (ALP_Carreras;9;1;6;2;8)
		AL_SetColOpts (ALP_Carreras;1;1;1;1;0)
		AL_SetRowOpts (ALP_Carreras;0;1;0;0;1;0)
		AL_SetCellOpts (ALP_Carreras;0;1;1)
		AL_SetMainCalls (ALP_Carreras;"";"")
		AL_SetCallbacks (ALP_Carreras;"";"xALP_ACT_CB_Pagares")
		AL_SetScroll (ALP_Carreras;0;-3)
		AL_SetEntryOpts (ALP_Carreras;0;0;0;0;2;<>tXS_RS_DecimalSeparator;1)
		AL_SetDrgOpts (ALP_Carreras;0;30;0)
		AL_SetSortOpts (ALP_Carreras;0;0;0;"";0;0)
		ACTcfg_OpcionesPagares ("SetEstadoTacho")
		
	: ($t_accion="EliminaLineaALPCarreras")
		$l_line:=AL_GetLine (ALP_Carreras)
		AL_UpdateArrays (ALP_Carreras;0)
		AT_Delete ($l_line;1;->atACTp_Carreras;->atACTp_Regimen;->atACTp_Matrices;->arACTp_Montos;->alACTp_Matrices)
		AL_UpdateArrays (ALP_Carreras;-2)
		ACTcfg_OpcionesPagares ("SetEstadoTacho")
		
	: ($t_accion="SetEstadoTacho")
		$l_line:=AL_GetLine (ALP_Carreras)
		If ($l_line>0)
			_O_ENABLE BUTTON:C192(bDelCarrera)
		Else 
			_O_DISABLE BUTTON:C193(bDelCarrera)
		End if 
		
	: ($t_accion="OcultaAreasCarreras_Dctos")
		If (Is a list:C621(hl_Pagina1))
			$page:=Selected list items:C379(hl_Pagina1)
			
			OBJECT SET VISIBLE:C603(*;"carrera@";False:C215)
			OBJECT SET VISIBLE:C603(*;"descuento@";False:C215)
			OBJECT SET VISIBLE:C603(*;"cargo@";False:C215)
			AL_SetScroll (ALP_Carreras;0;0)
			AL_SetScroll (ALP_PCargos;0;0)
			AL_SetScroll (ALP_Descuentos;0;0)
			Case of 
				: ($page=1)
					AL_SetScroll (ALP_Carreras;0;-3)
					OBJECT SET VISIBLE:C603(*;"carrera@";True:C214)
				: ($page=2)
					AL_SetScroll (ALP_PCargos;0;-3)
					OBJECT SET VISIBLE:C603(*;"cargo@";True:C214)
				: ($page=3)
					AL_SetScroll (ALP_Descuentos;0;-3)
					OBJECT SET VISIBLE:C603(*;"descuento@";True:C214)
			End case 
			REDRAW WINDOW:C456
		End if 
		
	: ($t_accion="SetEstadoTachoDctos")
		$l_line:=AL_GetLine (ALP_Descuentos)
		If ($l_line>0)
			_O_ENABLE BUTTON:C192(bDelDescuento)
		Else 
			_O_DISABLE BUTTON:C193(bDelDescuento)
		End if 
		
		$l_line:=AL_GetLine (ALP_PCargos)
		If ($l_line>0)
			_O_ENABLE BUTTON:C192(bDelCargo)
		Else 
			_O_DISABLE BUTTON:C193(bDelCargo)
		End if 
		
	: ($t_accion="InsertaLineaALPDescuentos")
		
		alACTp_ItemDcto{0}:=vlACT_Item
		AT_SearchArray (->alACTp_ItemDcto;"=";->$alACT_pos1)
		atACTp_RegimenDcto{0}:=vtACT_RegimenDcto
		AT_SearchArray (->atACTp_RegimenDcto;"=";->$alACT_pos2)
		AT_intersect (->$alACT_pos1;->$alACT_pos2;->$alACT_pos3)
		
		If (Size of array:C274($alACT_pos3)=0)
			AT_Insert (1;1;->atACTp_ItemDcto;->atACTp_RegimenDcto;->arACTp_MontoDcto;->alACTp_ItemDcto;->abACTp_DctoNoAcum;->apACTp_DctoNoAcum)
			atACTp_ItemDcto{1}:=vtACT_Item
			atACTp_RegimenDcto{1}:=vtACT_RegimenDcto
			arACTp_MontoDcto{1}:=KRL_GetNumericFieldData (->[xxACT_Items:179]ID:1;->vlACT_Item;->[xxACT_Items:179]Monto:7)
			alACTp_ItemDcto{1}:=vlACT_Item
			abACTp_DctoNoAcum{1}:=True:C214
			ACTat_LLenaArregloPict (->abACTp_DctoNoAcum;->apACTp_DctoNoAcum)
		Else 
			BEEP:C151
		End if 
		
	: ($t_accion="InsertaLineaALPCargos")
		alACTp_ItemCargo{0}:=vlACT_ItemCargo
		AT_SearchArray (->alACTp_ItemCargo;"=";->$alACT_pos1)
		atACTp_RegimenCargo{0}:=vtACT_RegimenCargo
		AT_SearchArray (->atACTp_RegimenCargo;"=";->$alACT_pos2)
		AT_intersect (->$alACT_pos1;->$alACT_pos2;->$alACT_pos3)
		If (Size of array:C274($alACT_pos3)=0)
			AT_Insert (1;1;->atACTp_ItemCargo;->atACTp_RegimenCargo;->arACTp_MontoCargo;->alACTp_ItemCargo;->apACTp_AvisoSeparado;->abACTp_AvisoSeparado)
			atACTp_ItemCargo{1}:=vtACT_ItemCargo
			atACTp_RegimenCargo{1}:=vtACT_RegimenCargo
			arACTp_MontoCargo{1}:=KRL_GetNumericFieldData (->[xxACT_Items:179]ID:1;->vlACT_ItemCargo;->[xxACT_Items:179]Monto:7)
			alACTp_ItemCargo{1}:=vlACT_ItemCargo
			  //apACTp_AvisoSeparado{1}:=
			abACTp_AvisoSeparado{1}:=False:C215
			ACTat_LLenaArregloPict (->abACTp_AvisoSeparado;->apACTp_AvisoSeparado)
		Else 
			BEEP:C151
		End if 
		
	: ($t_accion="EliminaLineaALPDescuentos")
		AT_Delete ($ptr1->;1;->atACTp_ItemDcto;->atACTp_RegimenDcto;->arACTp_MontoDcto;->alACTp_ItemDcto;->abACTp_DctoNoAcum;->apACTp_DctoNoAcum)
		
	: ($t_accion="EliminaLineaALPCargos")
		AT_Delete ($ptr1->;1;->atACTp_ItemCargo;->atACTp_RegimenCargo;->arACTp_MontoCargo;->alACTp_ItemCargo;->apACTp_AvisoSeparado;->abACTp_AvisoSeparado)
		
	: ($t_accion="GuardaBlobFolio")
		If (Not:C34(Semaphore:C143("ACT_NumeroPagare";120)))
			$offset:=BLOB_Variables2Blob (->$xBlob;0;->vlACTp_Proximo)
			PREF_SetBlob (0;"ACT_ConfPagares1";$xBlob)
			CLEAR SEMAPHORE:C144("ACT_NumeroPagare")
			$t_retorno:="1"
		Else 
			$t_retorno:="0"
		End if 
		
	: ($t_accion="CargaArregloEstadosPagares")
		ACTpagares_CargaArregloEstados 
		
	: ($t_accion="ObtieneEstadoXID")
		  //ARRAY LONGINT($alACT_IdsEstados;0)
		  //ARRAY TEXT($atACT_Estados;0)
		  //APPEND TO ARRAY($alACT_IdsEstados;-102)
		  //APPEND TO ARRAY($alACT_IdsEstados;-103)
		  //APPEND TO ARRAY($alACT_IdsEstados;-104)
		  //APPEND TO ARRAY($alACT_IdsEstados;-105)
		  //APPEND TO ARRAY($alACT_IdsEstados;-101)
		  //
		  //APPEND TO ARRAY($atACT_Estados;__ ("Anulado"))  //
		  //APPEND TO ARRAY($atACT_Estados;__ ("Vigente"))  //
		  //APPEND TO ARRAY($atACT_Estados;__ ("Por Devolver"))  //
		  //APPEND TO ARRAY($atACT_Estados;__ ("Devuelto"))  //
		  //APPEND TO ARRAY($atACT_Estados;__ ("Protestado"))  //
		  //
		  //$l_existe:=Find in array($alACT_IdsEstados;$ptr1->)
		  //If ($l_existe#-1)
		  //$t_retorno:=$atACT_Estados{$l_existe}
		  //End if
		$l_idFDP:=-16
		$t_retorno:=ACTcfg_OpcionesEstadosPagos ("ObtieneEstado";->$l_idFDP;$ptr1)
		
	: ($t_accion="SetObjetosPag2")
		  //ACTcfg_OpcionesPagares ("SetObjetosPag2")
		If (([ACT_Pagares:184]ID_Estado:6=-101) | ([ACT_Pagares:184]ID_Estado:6=-105) | ([ACT_Pagares:184]ID_Estado:6=-102))
			_O_ENABLE BUTTON:C192(bCalendar)
		Else 
			_O_DISABLE BUTTON:C193(bCalendar)
		End if 
		
		  //If (cs_protestado=1)
		  //ENABLE BUTTON(bCalendarP)
		  //Else
		  //DISABLE BUTTON(bCalendarP)
		  //End if
		  //If (cs_devuelto=1)
		  //ENABLE BUTTON(bCalendarD)
		  //Else
		  //DISABLE BUTTON(bCalendarD)
		  //End if
		  //If (cs_anulado=1)
		  //ENABLE BUTTON(bCalendarA)
		  //Else
		  //DISABLE BUTTON(bCalendarA)
		  //End if
		vtACT_Estado:=ACTcfg_OpcionesPagares ("ObtieneEstadoXID";->[ACT_Pagares:184]ID_Estado:6)
		LISTBOX GET CELL POSITION:C971(lb_adjuntos;$l_Column;$l_row)
		If ($l_row>0)
			_O_ENABLE BUTTON:C192(*;"btn_endis@")
		Else 
			_O_DISABLE BUTTON:C193(*;"btn_endis@")
		End if 
		
	: ($t_accion="Log")
		$t_evento:=$ptr1->
		$l_idCta:=[ACT_Pagares:184]ID_Cta:18
		
		$t_textAlumno:=""
		$t_textApoderado:=""
		$t_textTercero:=""
		If ([ACT_Pagares:184]ID_Cta:18#0)
			$l_idAlumno:=KRL_GetNumericFieldData (->[ACT_CuentasCorrientes:175]ID:1;->$l_idCta;->[ACT_CuentasCorrientes:175]ID_Alumno:3)
			$t_textAlumno:=", Alumno: "+KRL_GetTextFieldData (->[Alumnos:2]numero:1;->$l_idAlumno;->[Alumnos:2]apellidos_y_nombres:40)
		End if 
		If ([ACT_Pagares:184]ID_Apdo:17#0)
			$t_textApoderado:=", Apoderado: "+KRL_GetTextFieldData (->[Personas:7]No:1;->[ACT_Pagares:184]ID_Apdo:17;->[Personas:7]Apellidos_y_nombres:30)
		End if 
		If ([ACT_Pagares:184]ID_Tercero:22#0)
			$t_textTercero:=", Tercero: "+KRL_GetTextFieldData (->[ACT_Terceros:138]Id:1;->[ACT_Pagares:184]ID_Tercero:22;->[ACT_Terceros:138]Nombre_Completo:9)
		End if 
		LOG_RegisterEvt ($t_evento+" Pagaré número: "+String:C10([ACT_Pagares:184]Numero_Pagare:11)+", ID: "+String:C10([ACT_Pagares:184]ID:12)+$t_textAlumno+$t_textApoderado+$t_textTercero+".")
		
	: ($t_accion="MaxIDMatriz")
		$t_retorno:="-100"
		
	: ($t_accion="Print")
		
		If ((cs_imprimirPagareC=1) | (cs_genContratoC=1))
			READ ONLY:C145([xShell_Reports:54])
			QUERY:C277([xShell_Reports:54];[xShell_Reports:54]MainTable:3;=;Table:C252(->[ACT_CuentasCorrientes:175]);*)
			QUERY:C277([xShell_Reports:54]; & ;[xShell_Reports:54]ReportName:26=$ptr1->)
			QUERY SELECTION:C341([xShell_Reports:54];[xShell_Reports:54]isOneRecordReport:11;=;True:C214)
			
			If (Records in selection:C76([xShell_Reports:54])=1)
				$l_recNumInforme:=Record number:C243([xShell_Reports:54])
				$t_nombreProceso:="Impresión de: "+[xShell_Reports:54]ReportName:26
				
				$ptrCurrentTable:=yBWR_currentTable
				READ ONLY:C145(*)
				$tableNumber:=[xShell_Reports:54]MainTable:3
				$tablePointer:=Table:C252($tableNumber)
				yBWR_currentTable:=$tablePointer
				
				  //COPY NAMED SELECTION([ACT_CuentasCorrientes];"◊Editions")
				CUT NAMED SELECTION:C334([ACT_CuentasCorrientes:175];"◊Editions")  //20170315 RCH
				<>vlACTp_IDPagare:=[ACT_Pagares:184]ID:12
				
				If (<>vlACTp_IDPagare#0)
					$t_destinoImpresion:="printer"
					Case of 
						: ([xShell_Reports:54]ReportType:2="4DFO")
							$l_idProceso:=New process:C317("QR_ImprimeFormulario";Pila_256K;$t_nombreProceso;$l_recNumInforme;$t_destinoImpresion;$t_rutaCarpetaPDFs;$t_expresionNombreDocumento)
							
						: ([xShell_Reports:54]ReportType:2="4DSE")
							$l_idProceso:=New process:C317("QR_ImprimeInformeColumnas";Pila_256K;$t_nombreProceso;$l_recNumInforme;$t_destinoImpresion;$t_rutaCarpetaPDFs;$t_expresionNombreDocumento)
							
						: ([xShell_Reports:54]ReportType:2="4DET")
							$l_idProceso:=New process:C317("QR_ImprimeEtiquetas";Pila_256K;$t_nombreProceso;$l_recNumInforme;$t_destinoImpresion;$t_rutaCarpetaPDFs;$t_expresionNombreDocumento)
							
						: ([xShell_Reports:54]ReportType:2="4DWR")
							$l_idProceso:=New process:C317("QR_ImprimeDocumento4DWrite";Pila_256K;$t_nombreProceso;$l_recNumInforme;$t_destinoImpresion;$t_rutaCarpetaPDFs;$t_expresionNombreDocumento)
							
						: ([xShell_Reports:54]ReportType:2="gSR2")
							$l_proceso:=New process:C317("QR_ImprimeInformeSRP";Pila_512K;$t_nombreProceso;$l_recNumInforme;$t_destinoImpresion;$t_rutaCarpetaPDFs;$t_expresionNombreDocumento)
					End case 
					
					
					  //con esto espero para que no aparezca error diciendo que la seleccion no pudo ser eliminada.
					$vlTime:=Milliseconds:C459
					While ((Process state:C330($l_proceso)>=0) & ($vlTime-Milliseconds:C459<=20000))
						IDLE:C311
						DELAY PROCESS:C323(Current process:C322;20)
					End while 
					
					
				Else 
					BEEP:C151
				End if 
				yBWR_currentTable:=$ptrCurrentTable
			Else 
				CD_Dlog (0;"El modelo seleccionado ha sido eliminado por otro usuario.")
			End if 
		End if 
		
	: ($t_accion="GuardaBlobs")
		If (vlACTp_Proximo=0)
			  //TRACE
		End if 
		ACTcfg_OpcionesPagares ("GuardaBlobFolio")
		
		SET BLOB SIZE:C606($xBlob;0)
		$offset:=BLOB_Variables2Blob (->$xBlob;0;->vtACTp_Periodo;->cs_genPagare;->cs_imprimirPagare;->cs_genContrato;->vtACTp_ModPagare;->vtACTp_ModContrato)
		PREF_SetBlob (0;"ACT_ConfPagares2";$xBlob)
		
		SET BLOB SIZE:C606($xBlob;0)
		$offset:=BLOB_Variables2Blob (->$xBlob;0;->vlACTp_Dia;->vlACTp_Cuota;->vtACTp_Regimen;->alACT_DiasPagares;->alACT_CuotasPagares;->atACT_RegimenPagares;->vtACTp_AvisoMes;->vlACTp_MatriculaYear)
		PREF_SetBlob (0;"ACT_ConfPagares3";$xBlob)
		
		SET BLOB SIZE:C606($xBlob;0)
		$offset:=BLOB_Variables2Blob (->$xBlob;0;->atACTp_ItemCargo;->atACTp_RegimenCargo;->arACTp_MontoCargo;->alACTp_ItemCargo;->apACTp_AvisoSeparado;->abACTp_AvisoSeparado)
		PREF_SetBlob (0;"ACT_ConfPagares4";$xBlob)
		
		SET BLOB SIZE:C606($xBlob;0)
		$offset:=BLOB_Variables2Blob (->$xBlob;0;->atACTp_ItemDcto;->atACTp_RegimenDcto;->arACTp_MontoDcto;->alACTp_ItemDcto;->abACTp_DctoNoAcum;->apACTp_DctoNoAcum)
		PREF_SetBlob (0;"ACT_ConfPagares5";$xBlob)
		
		SET BLOB SIZE:C606($xBlob;0)
		$offset:=BLOB_Variables2Blob (->$xBlob;0;->atACTp_Cursos;->alACTp_Nivel;->atACTp_Carreras;->atACTp_Regimen;->atACTp_Matrices;->arACTp_Montos;->alACTp_Matrices)
		PREF_SetBlob (0;"ACT_ConfPagares6";$xBlob)
		
	: ($t_accion="LeeBlobFolio")
		$offset:=BLOB_Variables2Blob (->$xBlob;0;->vlACTp_Proximo)
		$xBlob:=PREF_fGetBlob (0;"ACT_ConfPagares1";$xBlob)
		$offset:=BLOB_Blob2Vars (->$xBlob;0;->vlACTp_Proximo)
		
	: ($t_accion="ProtestaDocumento")
		If (([ACT_Pagares:184]Fecha_Devolucion:14=!00-00-00!) & ([ACT_Pagares:184]Fecha_Anulacion:13=!00-00-00!))
			[ACT_Pagares:184]Fecha_Protesto:20:=Current date:C33(*)
			[ACT_Pagares:184]Protestado_Por:21:=<>tUSR_CurrentUser
			[ACT_Pagares:184]ID_Estado:6:=-101
			$t_retorno:="1"
		Else 
			BEEP:C151
			$t_retorno:="0"
		End if 
		
	: ($t_accion="DesProtestaDocumento")
		[ACT_Pagares:184]Fecha_Protesto:20:=!00-00-00!
		[ACT_Pagares:184]Protestado_Por:21:=""
		  //ACTcfg_OpcionesPagares ("AsignaEstadoPorDefecto")
		
	: ($t_accion="DevuelveDocumento")
		If (([ACT_Pagares:184]Fecha_Protesto:20=!00-00-00!) & ([ACT_Pagares:184]Fecha_Anulacion:13=!00-00-00!))
			[ACT_Pagares:184]Fecha_Devolucion:14:=Current date:C33(*)
			[ACT_Pagares:184]Devuelto_Por:15:=<>tUSR_CurrentUser
			[ACT_Pagares:184]ID_Estado:6:=-105
			$t_retorno:="1"
		Else 
			BEEP:C151
			$t_retorno:="0"
		End if 
		
	: ($t_accion="NoDevuelveDocumento")
		[ACT_Pagares:184]Fecha_Devolucion:14:=!00-00-00!
		[ACT_Pagares:184]Devuelto_Por:15:=""
		  //ACTcfg_OpcionesPagares ("AsignaEstadoPorDefecto")
		
	: ($t_accion="AnulaDocumento")
		
		
	: ($t_accion="NoAnulaDocumento")
		[ACT_Pagares:184]Anulado_Por:16:=""
		[ACT_Pagares:184]Fecha_Anulacion:13:=!00-00-00!
		  //ACTcfg_OpcionesPagares ("AsignaEstadoPorDefecto")
		
	: ($t_accion="CargaDatosEstado")
		
		Case of 
			: ([ACT_Pagares:184]ID_Estado:6=-101)
				$ptr1->:=[ACT_Pagares:184]Fecha_Protesto:20
				$ptr2->:=[ACT_Pagares:184]Protestado_Por:21
			: ([ACT_Pagares:184]ID_Estado:6=-105)
				$ptr1->:=[ACT_Pagares:184]Fecha_Devolucion:14
				$ptr2->:=[ACT_Pagares:184]Devuelto_Por:15
			: ([ACT_Pagares:184]ID_Estado:6=-102)
				$ptr1->:=[ACT_Pagares:184]Fecha_Anulacion:13
				$ptr2->:=[ACT_Pagares:184]Anulado_Por:16
			Else 
				$ptr1->:=!00-00-00!
				$ptr2->:=""
		End case 
		
	: ($t_accion="AsignaEstadoPorDefecto")
		$l_idFormaDePago:=-16
		[ACT_Pagares:184]ID_Estado:6:=Num:C11(ACTcfg_OpcionesEstadosPagos ("ObtieneIDEstadoPagoXDef";->$l_idFormaDePago))
		ACTcfg_OpcionesPagares ("ActualizaDatosEstados")
		
	: ($t_accion="ActualizaDatosEstados")
		If ([ACT_Pagares:184]ID_Estado:6=-101)
			ACTcfg_OpcionesPagares ("ProtestaDocumento")
		End if 
		If ([ACT_Pagares:184]ID_Estado:6=-102)
			ACTcfg_OpcionesPagares ("ObtieneDatosAnulacion")
		End if 
		If ([ACT_Pagares:184]ID_Estado:6=-105)
			ACTcfg_OpcionesPagares ("DevuelveDocumento")
		End if 
		
		
	: ($t_accion="LeeBlobs")
		
		ACTcfg_OpcionesPagares ("DeclaraVarsInterfaz_Init")
		ACTcfg_OpcionesPagares ("DeclaraArreglosALPCargo")
		ACTcfg_OpcionesPagares ("DeclaraArreglosALPDescuento")
		ACTcfg_OpcionesPagares ("DeclaraArreglosALP")
		ACTcfg_OpcionesPagares ("DeclaraArreglosALP_Carreras")
		ACTcfg_OpcionesPagares ("ArreglosDiaCuotaRegimen")
		
		ACTcfg_OpcionesPagares ("LeeBlobFolio")
		
		  //20120724 RCH Se pasa a caso...
		  //SET BLOB SIZE($xBlob;0)
		  //$offset:=BLOB_Variables2Blob (->$xBlob;0;->vtACTp_Periodo;->cs_genPagare;->cs_imprimirPagare;->cs_genContrato;->vtACTp_ModPagare;->vtACTp_ModContrato)
		  //$xBlob:=PREF_fGetBlob (0;"ACT_ConfPagares2";$xBlob)
		  //$offset:=BLOB_Blob2Vars (->$xBlob;0;->vtACTp_Periodo;->cs_genPagare;->cs_imprimirPagare;->cs_genContrato;->vtACTp_ModPagare;->vtACTp_ModContrato)
		ACTcfg_OpcionesPagares ("LeeConfiguracion")
		
		SET BLOB SIZE:C606($xBlob;0)
		$offset:=BLOB_Variables2Blob (->$xBlob;0;->vlACTp_Dia;->vlACTp_Cuota;->vtACTp_Regimen;->alACT_DiasPagares;->alACT_CuotasPagares;->atACT_RegimenPagares;->vtACTp_AvisoMes;->vlACTp_MatriculaYear)
		$xBlob:=PREF_fGetBlob (0;"ACT_ConfPagares3";$xBlob)
		$offset:=BLOB_Blob2Vars (->$xBlob;0;->vlACTp_Dia;->vlACTp_Cuota;->vtACTp_Regimen;->alACT_DiasPagares;->alACT_CuotasPagares;->atACT_RegimenPagares;->vtACTp_AvisoMes;->vlACTp_MatriculaYear)
		
		SET BLOB SIZE:C606($xBlob;0)
		$offset:=BLOB_Variables2Blob (->$xBlob;0;->atACTp_ItemCargo;->atACTp_RegimenCargo;->arACTp_MontoCargo;->alACTp_ItemCargo;->apACTp_AvisoSeparado;->abACTp_AvisoSeparado)
		$xBlob:=PREF_fGetBlob (0;"ACT_ConfPagares4";$xBlob)
		$offset:=BLOB_Blob2Vars (->$xBlob;0;->atACTp_ItemCargo;->atACTp_RegimenCargo;->arACTp_MontoCargo;->alACTp_ItemCargo;->apACTp_AvisoSeparado;->abACTp_AvisoSeparado)
		
		$maxsize:=AT_ReturnMaxSize (->atACTp_ItemCargo;->atACTp_RegimenCargo;->arACTp_MontoCargo;->alACTp_ItemCargo;->apACTp_AvisoSeparado;->abACTp_AvisoSeparado)
		AT_RedimArrays ($maxsize;->atACTp_ItemCargo;->atACTp_RegimenCargo;->arACTp_MontoCargo;->alACTp_ItemCargo;->apACTp_AvisoSeparado;->abACTp_AvisoSeparado)
		ACTat_LLenaArregloPict (->abACTp_AvisoSeparado;->apACTp_AvisoSeparado)
		
		SET BLOB SIZE:C606($xBlob;0)
		$offset:=BLOB_Variables2Blob (->$xBlob;0;->atACTp_ItemDcto;->atACTp_RegimenDcto;->arACTp_MontoDcto;->alACTp_ItemDcto;->abACTp_DctoNoAcum;->apACTp_DctoNoAcum)
		$xBlob:=PREF_fGetBlob (0;"ACT_ConfPagares5";$xBlob)
		$offset:=BLOB_Blob2Vars (->$xBlob;0;->atACTp_ItemDcto;->atACTp_RegimenDcto;->arACTp_MontoDcto;->alACTp_ItemDcto;->abACTp_DctoNoAcum;->apACTp_DctoNoAcum)
		
		$maxsize:=AT_ReturnMaxSize (->atACTp_ItemDcto;->atACTp_RegimenDcto;->arACTp_MontoDcto;->alACTp_ItemDcto;->abACTp_DctoNoAcum;->apACTp_DctoNoAcum)
		AT_RedimArrays ($maxsize;->atACTp_ItemDcto;->atACTp_RegimenDcto;->arACTp_MontoDcto;->alACTp_ItemDcto;->abACTp_DctoNoAcum;->apACTp_DctoNoAcum)
		ACTat_LLenaArregloPict (->abACTp_DctoNoAcum;->apACTp_DctoNoAcum)
		
		SET BLOB SIZE:C606($xBlob;0)
		$offset:=BLOB_Variables2Blob (->$xBlob;0;->atACTp_Cursos;->alACTp_Nivel;->atACTp_Carreras;->atACTp_Regimen;->atACTp_Matrices;->arACTp_Montos;->alACTp_Matrices)
		$xBlob:=PREF_fGetBlob (0;"ACT_ConfPagares6";$xBlob)
		$offset:=BLOB_Blob2Vars (->$xBlob;0;->atACTp_Cursos;->alACTp_Nivel;->atACTp_Carreras;->atACTp_Regimen;->atACTp_Matrices;->arACTp_Montos;->alACTp_Matrices)
		
	: ($t_accion="LeeConfiguracion")
		ACTcfg_OpcionesPagares ("DeclaraVarsInterfaz1")
		SET BLOB SIZE:C606($xBlob;0)
		$offset:=BLOB_Variables2Blob (->$xBlob;0;->vtACTp_Periodo;->cs_genPagare;->cs_imprimirPagare;->cs_genContrato;->vtACTp_ModPagare;->vtACTp_ModContrato)
		$xBlob:=PREF_fGetBlob (0;"ACT_ConfPagares2";$xBlob)
		$offset:=BLOB_Blob2Vars (->$xBlob;0;->vtACTp_Periodo;->cs_genPagare;->cs_imprimirPagare;->cs_genContrato;->vtACTp_ModPagare;->vtACTp_ModContrato)
		
	: ($t_accion="VerificaUtilizacionEstado")
		$l_idEstado:=$ptr1->
		If ($l_idEstado#0)
			SET QUERY DESTINATION:C396(Into variable:K19:4;$l_records)
			QUERY:C277([ACT_Pagares:184];[ACT_Pagares:184]ID_Estado:6=$l_idEstado)
			SET QUERY DESTINATION:C396(Into current selection:K19:1)
			$t_retorno:=String:C10($l_records)
			
		End if 
		
	Else 
		  // nunca deberia entrar aqui...
		TRACE:C157
		
End case 

$0:=$t_retorno