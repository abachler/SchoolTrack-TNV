//%attributes = {}
  //ACTmnu_RecalcularSaldosAvisos
  //20130201 RCH Soporta 5 parametro para evitar el calculo de ctas

  //****DECLARACIONES****
C_DATE:C307(vd_fecha)
C_BOOLEAN:C305($vb_filtrarAvisosXFecha;$vb_recalculoBash)
C_BOOLEAN:C305($vb_noRecalcularCtas)
ARRAY LONGINT:C221(al_recNumsAvisos;0)
C_POINTER:C301($ptr1;$1)
C_BLOB:C604(xBlob)
SET BLOB SIZE:C606(xBlob;0)
vd_fecha:=!00-00-00!
$vb_filtrarAvisosXFecha:=False:C215
$ptr1:=$1
If (Count parameters:C259>=2)
	vd_fecha:=$2
End if 
If (Count parameters:C259>=3)
	$vb_filtrarAvisosXFecha:=$3
End if 
If (Count parameters:C259>=4)
	$vb_recalculoBash:=$4
End if 
If (Count parameters:C259>=5)
	$vb_noRecalcularCtas:=$5
End if 

If (vd_fecha=!00-00-00!)
	vd_fecha:=Current date:C33(*)
End if 
If ($vb_filtrarAvisosXFecha)
	READ ONLY:C145([ACT_Avisos_de_Cobranza:124])
	CREATE SELECTION FROM ARRAY:C640([ACT_Avisos_de_Cobranza:124];$ptr1->;"")
	FIRST RECORD:C50([ACT_Avisos_de_Cobranza:124])
	Case of 
		: ([ACT_Avisos_de_Cobranza:124]ID_Tercero:26#0)  //20180816 RCH
			QUERY:C277([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Tercero:26=[ACT_Avisos_de_Cobranza:124]ID_Tercero:26)
			
		: (bAvisoApoderado=1)
			QUERY:C277([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3=[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3)
		: (bAvisoAlumno=1)
			If ([ACT_Avisos_de_Cobranza:124]ID_CuentaCorrriente:2#0)
				QUERY:C277([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_CuentaCorrriente:2=[ACT_Avisos_de_Cobranza:124]ID_CuentaCorrriente:2)
			Else 
				QUERY:C277([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3=[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3)
			End if 
	End case 
	QUERY SELECTION:C341([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]LastDateRecalc:23#vd_fecha;*)
	QUERY SELECTION:C341([ACT_Avisos_de_Cobranza:124]; & ;[ACT_Avisos_de_Cobranza:124]EmitidoSegunMonedaCargo:24=True:C214)
	  //LONGINT ARRAY FROM SELECTION([ACT_Avisos_de_Cobranza];al_recNumsAvisos;"")
Else 
	  //COPY ARRAY($ptr1->;al_recNumsAvisos)
	CREATE SELECTION FROM ARRAY:C640([ACT_Avisos_de_Cobranza:124];$ptr1->;"")
End if 
ARRAY TEXT:C222($atACT_uuid;0)  //20160407 RCH Se quita arreglo con recNum
SELECTION TO ARRAY:C260([ACT_Avisos_de_Cobranza:124]Auto_UUID:32;$atACT_uuid)

  //BLOB_Variables2Blob (->xBlob;0;->al_recNumsAvisos;->vd_fecha;->$vb_noRecalcularCtas)
If (Size of array:C274($atACT_uuid)>0)  //20180816 RCH
	BLOB_Variables2Blob (->xBlob;0;->$atACT_uuid;->vd_fecha;->$vb_noRecalcularCtas)
	If ($vb_recalculoBash)
		BM_CreateRequest ("ACT_RecalculaAvisosBash";"";"";xBlob)
	Else 
		ACTmnu_RecalcSaldosAvisosOnServ (xBlob)
	End if 
End if 
ARRAY LONGINT:C221(al_recNumsAvisos;0)
SET BLOB SIZE:C606(xBlob;0)