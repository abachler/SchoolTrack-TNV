C_LONGINT:C283($vl_Column;$vl_row)
C_TEXT:C284($vt_fileName)
LISTBOX GET CELL POSITION:C971(lb_adjuntos;$vl_Column;$vl_row)

If ($vl_row>0)
	$vt_fileName:=atACT_AdjuntosNombre{$vl_row}
	$vl_resp:=CD_Dlog (0;__ ("El archivo")+" "+ST_Qte ($vt_fileName)+" "+__ ("será eliminado.")+"\r\r"+__ ("¿Desea continuar?");"";__ ("Si");__ ("No"))
	If ($vl_resp=1)
		$vl_idTipoArchivo:=1
		$vl_idCta:=0
		$vl_idApdo:=0
		$vl_idRegistro:=[ACT_Pagares:184]ID:12
		$vt_nombreArchivo:=$vt_fileName
		$vl_ok:=Num:C11(ACTio_OpcionesArchivos ("EliminaPagares";->$vl_idTipoArchivo;->$vl_idCta;->$vl_idApdo;->$vl_idRegistro;->$vt_nombreArchivo))
		If ($vl_ok=1)
			ACTio_OpcionesArchivos ("CargaPagaresDesdeFicha")
		Else 
			CD_Dlog (0;__ ("Se produjo un error al eliminar el archivo."))
		End if 
		ACTcfg_OpcionesPagares ("SetObjetosPag2")
	End if 
End if 