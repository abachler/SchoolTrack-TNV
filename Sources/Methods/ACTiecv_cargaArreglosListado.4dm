//%attributes = {}
  //ACTiecv_cargaArreglosListado

C_TEXT:C284($1;$t_accion)
C_POINTER:C301($y_pointer1;$y_pointer2)

$t_accion:=$1
If (Count parameters:C259>=2)
	$y_pointer1:=$2
End if 
If (Count parameters:C259>=3)
	$y_pointer2:=$3
End if 

Case of 
	: ($t_accion="DeclaraArreglos")
		ARRAY LONGINT:C221(alACTiecv_idDTE;0)
		ARRAY TEXT:C222(atACTiecv_dts;0)
		ARRAY TEXT:C222(atACTiecv_rut;0)
		ARRAY TEXT:C222(atACTiecv_periodo;0)
		ARRAY TEXT:C222(alACTiecv_operacion;0)
		ARRAY TEXT:C222(atACTiecv_glosa;0)
		ARRAY PICTURE:C279(apACTiecv_xml;0)
		ARRAY PICTURE:C279(apACTiecv_sii;0)
		ARRAY LONGINT:C221(alACTiecv_id;0)
		ARRAY TEXT:C222(atACTiecv_codReemplazo;0)
		
	: ($t_accion="CargaArreglos")
		C_LONGINT:C283($i;vrACTiecv_muestraTodos)
		ACTiecv_cargaArreglosListado ("DeclaraArreglos")
		
		ARRAY LONGINT:C221($alACTiecv_id;0)
		ARRAY LONGINT:C221($alACTiecv_rut;0)
		ARRAY LONGINT:C221($alACTiecv_glosa;0)
		ARRAY TEXT:C222($atACTiecv_glosa;0)
		
		vrACTiecv_muestraTodos:=Num:C11(PREF_fGet (0;"ACT_IECV_MOSTRAR_TODOS";"1"))
		
		READ ONLY:C145([ACT_IECV:253])
		ALL RECORDS:C47([ACT_IECV:253])
		If (vrACTiecv_muestraTodos=0)
			CREATE EMPTY SET:C140([ACT_IECV:253];"setLibros")
			ARRAY LONGINT:C221($alACTiecv_tipoOp;0)
			ARRAY TEXT:C222($atACTiecv_periodo;0)
			DISTINCT VALUES:C339([ACT_IECV:253]tipo_operacion:5;$alACTiecv_tipoOp)
			For ($l_indiceTipo;1;Size of array:C274($alACTiecv_tipoOp))
				QUERY:C277([ACT_IECV:253];[ACT_IECV:253]tipo_operacion:5=$alACTiecv_tipoOp{$l_indiceTipo})
				DISTINCT VALUES:C339([ACT_IECV:253]periodo:6;$atACTiecv_periodo)
				SORT ARRAY:C229($atACTiecv_periodo;<)
				QUERY SELECTION:C341([ACT_IECV:253];[ACT_IECV:253]periodo:6=$atACTiecv_periodo{1})
				CREATE SET:C116([ACT_IECV:253];"setTipo")
				UNION:C120("setLibros";"setTipo";"setLibros")
			End for 
			USE SET:C118("setLibros")
			SET_ClearSets ("setLibros";"setTipo")
		End if 
		
		ORDER BY:C49([ACT_IECV:253];[ACT_IECV:253]tipo_operacion:5;>;[ACT_IECV:253]periodo:6;<)
		SELECTION TO ARRAY:C260([ACT_IECV:253]id:1;alACTiecv_id;[ACT_IECV:253]id_iecv_dtenet:4;alACTiecv_idDTE;[ACT_IECV:253]fecha_generacion_dts:2;atACTiecv_dts;[ACT_IECV:253]periodo:6;atACTiecv_periodo;[ACT_IECV:253]tipo_operacion:5;$alACTiecv_id;[ACT_IECV:253]glosa_procesamiento_dtenet:12;$atACTiecv_glosa;[ACT_IECV:253]id_razon_social:15;$alACTiecv_rut;[ACT_IECV:253]estado:14;$alACTiecv_glosa;[ACT_IECV:253]codigo_reemplazo_libro:11;atACTiecv_codReemplazo)
		For ($i;1;Size of array:C274($alACTiecv_id))
			AT_Insert (0;1;->alACTiecv_operacion;->apACTiecv_xml;->apACTiecv_sii;->atACTiecv_rut;->atACTiecv_glosa)
			alACTiecv_operacion{Size of array:C274(alACTiecv_operacion)}:=ACTdte_RetornaTextos ("IECV_tipoOperacion";->$alACTiecv_id{$i})
			atACTiecv_dts{$i}:=DTS_GetDateTimeString (atACTiecv_dts{$i})
			
			GET PICTURE FROM LIBRARY:C565(2080;apACTiecv_xml{Size of array:C274(apACTiecv_xml)})
			GET PICTURE FROM LIBRARY:C565(31983;apACTiecv_sii{Size of array:C274(apACTiecv_sii)})
			
			atACTiecv_rut{$i}:=KRL_GetTextFieldData (->[ACT_RazonesSociales:279]id:1;->$alACTiecv_rut{$i};->[ACT_RazonesSociales:279]RUT:3)
			atACTiecv_rut{$i}:=ACTdte_GeneraArchivo ("GetRutConFormato";->atACTiecv_rut{$i})
			
			ACTiecv_cargaArreglosListado ("ActualizaGlosaArreglo";->alACTiecv_id{$i};->$i)
			
		End for 
		
	: ($t_accion="ActualizaGlosaArreglo")
		C_LONGINT:C283($l_id;$l_fila)
		$l_id:=$y_pointer1->
		$l_fila:=$y_pointer2->
		
		READ ONLY:C145([ACT_IECV:253])
		KRL_FindAndLoadRecordByIndex (->[ACT_IECV:253]id:1;->$l_id)
		atACTiecv_glosa{$l_fila}:=ACTdte_RetornaTextos ("IECV_estado";->[ACT_IECV:253]estado:14)
		alACTiecv_idDTE{$l_fila}:=[ACT_IECV:253]id_iecv_dtenet:4
		If (([ACT_IECV:253]estado:14 ?? 2) & (Not:C34([ACT_IECV:253]estado:14 ?? 3)))
			atACTiecv_glosa{$l_fila}:=atACTiecv_glosa{$l_fila}+": "+[ACT_IECV:253]glosa_procesamiento_dtenet:12
		End if 
		
	: ($t_accion="SalidaFormulario")
		READ ONLY:C145([ACT_IECV:253])
		QUERY BY FORMULA:C48([ACT_IECV:253];[ACT_IECV:253]estado:14 ?? 3)
		QUERY SELECTION BY FORMULA:C207([ACT_IECV:253];Not:C34([ACT_IECV:253]estado:14 ?? 4))
		If (Records in selection:C76([ACT_IECV:253])>0)
			$l_resp:=CD_Dlog (0;"Hay "+String:C10(Records in selection:C76([ACT_IECV:253]))+" libro(s) emitido(s) no enviado(s) al SII."+"\r\r"+"¿Está seguro que desea salir?";"";"Si";"No")
		Else 
			$l_resp:=1
		End if 
		If ($l_resp=1)
			ACTiecv_cargaArreglosListado ("DeclaraArreglos")
			CANCEL:C270
		End if 
		
End case 