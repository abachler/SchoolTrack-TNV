//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Saul Ponce
  // Fecha y hora: 05/10/17, 11:10:49
  // ----------------------------------------------------
  // Método: ACT_CreaRegistroImportacion
  // Descripción
  // 
  //
  // Parámetros
  // ----------------------------------------------------



C_REAL:C285($3;$vr_valorUF)
C_DATE:C307($5;$vd_fechaPago)
C_LONGINT:C283($2;$vl_idFormaPago)
C_OBJECT:C1216($4;$ob_detalle;$1;$ob_proArchivo)


If (Count parameters:C259>=1)
	$ob_proArchivo:=$1
End if 
If (Count parameters:C259>=2)
	$vl_idFormaPago:=$2
End if 
If (Count parameters:C259>=3)
	$vr_valorUF:=$3
End if 
If (Count parameters:C259>=4)
	$ob_detalle:=$4
End if 
If (Count parameters:C259>=5)
	$vd_fechaPago:=$5
Else 
	$vd_fechaPago:=Current date:C33(*)
End if 

READ WRITE:C146([ACT_RegistroImportaciones:157])

CREATE RECORD:C68([ACT_RegistroImportaciones:157])

[ACT_RegistroImportaciones:157]ID:1:=SQ_SeqNumber (->[ACT_RegistroImportaciones:157]ID:1)
  //[ACT_RegistroImportaciones]Auto_UUID:=Generate UUID
[ACT_RegistroImportaciones:157]DTS_Fecha_Importacion:4:=Timestamp:C1445

[ACT_RegistroImportaciones:157]Fecha_Pago:8:=$vd_fechaPago
[ACT_RegistroImportaciones:157]ID_Forma_Pago:5:=$vl_idFormaPago
[ACT_RegistroImportaciones:157]Propiedades_Archivo:3:=$ob_proArchivo
[ACT_RegistroImportaciones:157]OB_Detalle:6:=$ob_detalle
[ACT_RegistroImportaciones:157]Valor_UF:7:=$vr_valorUF

SAVE RECORD:C53([ACT_RegistroImportaciones:157])

KRL_UnloadReadOnly (->[ACT_RegistroImportaciones:157])


