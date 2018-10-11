//%attributes = {}
  // BBLdbu_ResuelveDuplicasBarcodes()
  // Por: Alberto Bachler K.: 01-12-13, 19:03:49
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------
_O_C_INTEGER:C282($i_duplicados)
C_LONGINT:C283($l_idRegistro)
C_TEXT:C284($t_descripcion;$t_Encabezado;$t_uuid)

ARRAY LONGINT:C221($al_Colores;0)
ARRAY LONGINT:C221($al_estilos;0)
ARRAY LONGINT:C221($al_recNumsDuplicados;0)
ARRAY TEXT:C222($at_codigoBarraAnterior;0)
ARRAY TEXT:C222($at_codigoBarraNuevo;0)
ARRAY TEXT:C222($at_errores;0)
ARRAY TEXT:C222($at_numeroCopia;0)
ARRAY TEXT:C222($at_tituloItem;0)
ARRAY TEXT:C222($at_TitulosColumnas;0)

ALL RECORDS:C47([BBL_Registros:66])
KRL_ValoresDuplicados (->[BBL_Registros:66]ID:3;->$al_recNumsDuplicados)
For ($i_duplicados;1;Size of array:C274($al_recNumsDuplicados))
	READ ONLY:C145([BBL_Registros:66])
	GOTO RECORD:C242([BBL_Registros:66];$al_recNumsDuplicados{$i_duplicados})
	$l_idRegistro:=[BBL_Registros:66]ID:3
	If ($i_duplicados<Size of array:C274($al_recNumsDuplicados))
		$i_duplicados:=$i_duplicados+1
		READ WRITE:C146([BBL_Registros:66])
		GOTO RECORD:C242([BBL_Registros:66];$al_recNumsDuplicados{$i_duplicados})
		While ([BBL_Registros:66]ID:3=$l_idRegistro)
			[BBL_Registros:66]ID:3:=SQ_SeqNumber (->[BBL_Registros:66]ID:3)
			If (Old:C35([BBL_Registros:66]ID:3)=[BBL_Registros:66]No_Registro:25)
				[BBL_Registros:66]No_Registro:25:=[BBL_Registros:66]ID:3
				[BBL_Registros:66]Código_de_barra:20:=""
				BBLreg_GeneraCodigoBarra 
				APPEND TO ARRAY:C911($at_errores;"Barcode duplicado")
				APPEND TO ARRAY:C911($at_tituloItem;KRL_GetTextFieldData (->[BBL_Items:61]Numero:1;->[BBL_Registros:66]Número_de_item:1;->[BBL_Items:61]Primer_título:4))
				APPEND TO ARRAY:C911($at_numeroCopia;String:C10([BBL_Registros:66]Número_de_copia:2))
				APPEND TO ARRAY:C911($at_codigoBarraAnterior;Old:C35([BBL_Registros:66]Código_de_barra:20))
				APPEND TO ARRAY:C911($at_codigoBarraNuevo;[BBL_Registros:66]Código_de_barra:20)
				APPEND TO ARRAY:C911($al_estilos;Plain:K14:1)
				APPEND TO ARRAY:C911($al_Colores;Green:K11:9)
			End if 
			SAVE RECORD:C53([BBL_Registros:66])
			If ($i_duplicados<Size of array:C274($al_recNumsDuplicados))
				$i_duplicados:=$i_duplicados+1
				READ WRITE:C146([BBL_Registros:66])
				GOTO RECORD:C242([BBL_Registros:66];$al_recNumsDuplicados{$i_duplicados})
				$i_duplicados:=$i_duplicados-1
			End if 
		End while 
	End if 
End for 

If (Size of array:C274($at_errores)>0)
	APPEND TO ARRAY:C911($at_TitulosColumnas;"Advertencia")
	APPEND TO ARRAY:C911($at_TitulosColumnas;"Item")
	APPEND TO ARRAY:C911($at_TitulosColumnas;"Copia #")
	APPEND TO ARRAY:C911($at_TitulosColumnas;"Barcode anterior")
	APPEND TO ARRAY:C911($at_TitulosColumnas;"Barcode nuevo")
	$t_Encabezado:="Se detectaron ^0 documentos con código de barra duplicado"
	$t_descripcion:=__ ("La duplicación de códigos de barra no es permitida.\rSe reasignaron nuevos números de registro y se generaron nuevos códigos de barra.\r.Debe cambiar físicamente los códigos de barra en los documentos listados a continuación.")
	$t_Encabezado:=Replace string:C233($t_Encabezado;"^0";String:C10(Size of array:C274($at_errores)))
	$t_uuid:=NTC_CreaMensaje ("MediaTrack";$t_Encabezado;$t_descripcion)
	NTC_Mensaje_Arreglos ($t_uuid;->$at_TitulosColumnas;->$at_errores;->$at_tituloItem;->$at_numeroCopia;->$at_codigoBarraAnterior;->$at_codigoBarraNuevo)
	NTC_Mensaje_EstilosColores ($t_uuid;->$al_estilos;->$al_Colores)
	NTC_Mensaje_DatosExplorador ($t_uuid;"MediaTrack";Table:C252(->[BBL_Items:61]);->$al_recNumsDuplicados)
End if 

