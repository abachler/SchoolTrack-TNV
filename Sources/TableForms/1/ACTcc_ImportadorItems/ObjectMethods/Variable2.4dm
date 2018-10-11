$line:=AL_GetLine (xALP_PreImportItem)
If ($line>0)
	AL_UpdateArrays (xALP_PreImportItem;0)
	AT_Delete ($line;1;->at_glosa;->at_moneda;->at_monto;->at_EsRelativo;->at_AfectoIva;->at_EnDocTributarios;->at_EsDcto;->at_AfectoDcto;->at_DctoxCta;->at_ItemGlobal;->at_ImputacionUnica;->at_Pcuenta;->at_glosaCta)
	AT_Delete ($line;1;->at_Cauxiliar;->at_Ccosto;->at_CPcuenta;->at_glosaCCta;->at_CCauxiliar;->at_CCcosto;->at_AfectoInteres;->at_TipoInteres;->at_TasaMensual;->at_Observacion;->at_VentaDirecta;->at_afectoRecargosAut;->at_MesesActivos)
	AT_Delete ($line;1;->at_Dctoxhijo;->at_Dctoxcargastotales;->at_RazonSocial)
	
	  //AT_Delete ($line;1;->at_Dctoxhijo;->at_Dctoxcargastotales;->at_RazonSocial) //20150609 RCH
	
	AT_Delete ($line;1;->at_periodoItems;->at_cccN1;->at_cccN2;->at_cccN3;->at_cccN4;->at_cccN5;->at_cccN6;->at_cccN7;->at_cccN8;->at_cccN9;->at_cccN10;->at_cccN11;->at_cccN12;->at_cccN13;->at_cccN14;->at_cccN15;->at_ccccN1;->at_ccccN2;->at_ccccN3;->at_ccccN4;->at_ccccN5;->at_ccccN6;->at_ccccN7;->at_ccccN8;->at_ccccN9;->at_ccccN10;->at_ccccN11;->at_ccccN12;->at_ccccN13;->at_ccccN14;->at_ccccN15)
	
	AL_UpdateArrays (xALP_PreImportItem;-2)
End if 