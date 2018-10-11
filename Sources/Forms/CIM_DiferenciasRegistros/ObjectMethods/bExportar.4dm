  // Actualizacion11_1.Botón15()
  // Por: Alberto Bachler: 11/01/13, 18:31:24
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_TIME:C306($h_RefDoc)
C_POINTER:C301($y_diferencia;$y_nombreTabla;$y_numeroTabla;$y_registrosAntes;$y_registrosDespues)
C_TEXT:C284($t_docXLS;$t_dts;$t_Encabezados;$t_rutaConteoDespues)

Case of 
	: (Form event:C388=On Mouse Enter:K2:33)
		
	: (Form event:C388=On Clicked:K2:4)
		$y_numeroTabla:=OBJECT Get pointer:C1124(Object named:K67:5;"numeroTabla")
		$y_nombreTabla:=OBJECT Get pointer:C1124(Object named:K67:5;"nombreTabla")
		$y_registrosAntes:=OBJECT Get pointer:C1124(Object named:K67:5;"registrosAntes")
		$y_registrosDespues:=OBJECT Get pointer:C1124(Object named:K67:5;"registrosDespues")
		$y_diferencia:=OBJECT Get pointer:C1124(Object named:K67:5;"diferencia")
		
		$t_rutaConteoDespues:=Temporary folder:C486+"Comparacion registros - DTS"+$t_dts+".xls"
		$h_RefDoc:=Create document:C266($t_rutaConteoDespues)
		$t_Encabezados:="Nº Tabla\tNombre de la tabla\tRegistros antes\tRegistros despues\tDiferencia\r"
		SEND PACKET:C103($h_RefDoc;$t_Encabezados)
		$t_docXLS:=AT_Arrays2Text ("\r";"\t";$y_numeroTabla;$y_nombreTabla;$y_registrosAntes;$y_registrosDespues;$y_diferencia)
		SEND PACKET:C103($h_RefDoc;$t_docXLS)
		CLOSE DOCUMENT:C267($h_RefDoc)
		OPEN URL:C673($t_rutaConteoDespues)
		
End case 