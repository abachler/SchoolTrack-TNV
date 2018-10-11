Case of 
	: (Form event:C388=On Load:K2:1)
		
		  //28.03.2014 -  Modificación para el ticket N° 130747 - Saúl Ponce O.
		  //Reemplacé el ListBox por el PrintList. Anteriormente, se imprimían solo los documentos que alcanzaban en el tamaño
		  //definido para el control ListBox. El PrintList permite que se impriman todos los necesarios.
		
		  //02.04.2014 - Saúl Ponce Ortega - Ticket Nº 130747
		  //Modifiqué las secciones del formulario, Se aumenta el tamaño de la fuente, Se modifica el ancho de las columnas
		
		$err:=PL_SetArraysNam (pl_docReempl;1;5;"alACT_idPago";"atACT_Apdo";"atACT_TipoDoc";"arACT_Monto";"atACT_Dato")
		PL_SetWidths (pl_docReempl;1;5;40;200;40;60;50)
		PL_SetHeaders (pl_docReempl;1;5;"ID";"Titular";"Tipo Doc.";"Monto";"Serie/Num Doc.")
		PL_SetSort (pl_docReempl;1;1)
		PL_SetFormat (pl_docReempl;1;"|Entero";1;0;0)
		PL_SetFormat (pl_docReempl;4;"|Despliegue_ACT";1;0;0)
		
		
		PL_SetStyle (pl_docReempl;0;"Tahoma";9;0)
		PL_SetHdrStyle (pl_docReempl;0;"Tahoma";9;1)
		PL_SetHdrOpts (pl_docReempl;2)
		PL_SetHeight (pl_docReempl;2;1;0;4)
		PL_SetDividers (pl_docReempl;0.5;"Black";"Black";0;0.5;"Black";"Black";0)
		PL_SetFrame (pl_docReempl;0.5;"Black";"Black";0;0.5;"Black";"Black";0)
		
	: (Form event:C388=On Printing Detail:K2:18)
		
End case 