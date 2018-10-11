//%attributes = {}
  //Metodo: Periodos_LeeDatosHistoricos
  //Por abachler
  //Creada el 03/08/2008, 11:41:55
  // ----------------------------------------------------
  // Descripción
  // 
  //
  // ----------------------------------------------------
  // Parámetros
  // 
  // ----------------------------------------------------

  //DECLARACIONES & INICIALIZACIONES
C_LONGINT:C283($1;$nivel;$2;$año;$3;$idInstitucion)
C_BLOB:C604($blob)
$nivel:=$1
$año:=$2
$id_institucion:=0
If (Count parameters:C259=3)
	$id_institucion:=$3
End if 

vdSTR_Periodos_InicioEjercicio:=!00-00-00!
vdSTR_Periodos_FinEjercicio:=!00-00-00!
viSTR_Periodos_DiasAgno:=0
viSTR_Periodos_NumeroPeriodos:=0
ARRAY INTEGER:C220(aiSTR_Periodos_Numero;0)
ARRAY TEXT:C222(atSTR_Periodos_Nombre;0)
ARRAY DATE:C224(adSTR_Periodos_Desde;0)
ARRAY DATE:C224(adSTR_Periodos_Hasta;0)
ARRAY DATE:C224(adSTR_Periodos_Cierre;0)
ARRAY INTEGER:C220(aiSTR_Periodos_Dias;0)

  //CUERPO
PERIODOS_Init 
vlSTR_Periodos_CurrentRef:=0  //inicializo la referencia a la configuración de períodos actuales para evitar conflicto con datos de períodos del ciclo escolar corriente

$key:=String:C10($id_institucion)+"."+String:C10($nivel)+"."+String:C10($año)
$blob:=KRL_GetBlobFieldData (->[xxSTR_HistoricoNiveles:191]LlavePrimaria:11;->$key;->[xxSTR_HistoricoNiveles:191]xConfiguracionPeriodos:7)
If (BLOB size:C605($blob)>32)
	$OTref_Periodos:=OT BLOBToObject ($blob)
	OT GetArray ($OTref_Periodos;"aiSTR_Periodos_Numero";aiSTR_Periodos_Numero)
	OT GetArray ($OTref_Periodos;"atSTR_Periodos_Nombre";atSTR_Periodos_Nombre)
	OT GetArray ($OTref_Periodos;"adSTR_Periodos_Desde";adSTR_Periodos_Desde)
	OT GetArray ($OTref_Periodos;"adSTR_Periodos_Hasta";adSTR_Periodos_Hasta)
	OT GetArray ($OTref_Periodos;"adSTR_Periodos_Cierre";adSTR_Periodos_Cierre)
	OT GetArray ($OTref_Periodos;"aiSTR_Periodos_Dias";aiSTR_Periodos_Dias)
	OT Clear ($OTref_Periodos)
	
	For ($i;1;Size of array:C274(aiSTR_Periodos_Numero))
		aiSTR_Periodos_Numero{$i}:=$i
	End for 
	
	If (Size of array:C274(atSTR_Periodos_Nombre)>0)
		vdSTR_Periodos_InicioEjercicio:=adSTR_Periodos_Desde{1}
		vdSTR_Periodos_FinEjercicio:=adSTR_Periodos_Hasta{Size of array:C274(aiSTR_Periodos_Numero)}
		viSTR_Periodos_DiasAgno:=AT_GetSumArray (->aiSTR_Periodos_Dias)
		viSTR_Periodos_NumeroPeriodos:=Size of array:C274(atSTR_Periodos_Nombre)
	End if 
End if 

If ((Size of array:C274(atSTR_Periodos_Nombre)=0) & (viSTR_Periodos_NumeroPeriodos=0))
	viSTR_Periodos_NumeroPeriodos:=5
	vdSTR_Periodos_InicioEjercicio:=!00-00-00!
	vdSTR_Periodos_FinEjercicio:=!00-00-00!
End if 


  //LIMPIEZA
SET BLOB SIZE:C606($blob;0)


