//%attributes = {}
  //AS_OnLoad
C_LONGINT:C283(vl_EV2_calculosEnServidor)
C_LONGINT:C283(vl_ExecOnClient_Count;vl_ExecOnServer_Count)
C_LONGINT:C283(vl_ExecOnClient_ms;vl_ExecOnServer_ms)
C_LONGINT:C283(vl_ExecOnClient_average;vl_ExecOnServer_average)

modNotas:=False:C215
modTimeTable:=False:C215
modObservaciones:=False:C215
modObjetivos:=False:C215
vb_NotaOficialVisible:=False:C215
vb_AvisaSiCambioPeriodo:=True:C214
vl_TipoInformacionSesion:=0
vt_InfoSesion:=""


FirstEntry:=0
COPY ARRAY:C226(<>atSTR_ModosEvaluacion;aEvView)
ARRAY INTEGER:C220(aNtaOrden;0)
ARRAY TEXT:C222(aNtaStdNme;0)
ARRAY PICTURE:C279(aFotografias;0)
_O_ARRAY STRING:C218(5;aNtaF;0)
ARRAY TEXT:C222(aNtaObs;0)
ARRAY LONGINT:C221(aNtaIDAlumno;0)
ARRAY REAL:C219(aRealNtaF;0)
ARRAY TEXT:C222(aNtaStatus;0)
ARRAY INTEGER:C220(aNtaRegEximicion;0)
ARRAY TEXT:C222(aNtaObj;0)  //para los nuevos objetivos
ARRAY LONGINT:C221(aIdAlumnos_a_Recalcular;0)  //para guardar los registros de alumnos a los que hay que recalcular promedios si hay cambios en las notas


EV2_InitArrays 
xALSet_AS_PlanesDeClases 

vl_EV2_calculosEnServidor:=Num:C11(PREF_fGet (USR_GetUserID ;"CalculosOnServer";"0"))

If (Application type:C494=4D Local mode:K5:1)
	OBJECT SET VISIBLE:C603(*;"ExecMode";False:C215)
Else 
	OBJECT SET VISIBLE:C603(*;"ExecMode";True:C214)
End if 
