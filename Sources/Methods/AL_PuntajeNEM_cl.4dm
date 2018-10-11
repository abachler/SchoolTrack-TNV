//%attributes = {}
  // AL_PuntajeNEM_cl()
  // Por: Alberto Bachler: 08/11/13, 19:28:07
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($0)
C_REAL:C285($1)
C_LONGINT:C283($2)

C_BLOB:C604($x_blob)
C_LONGINT:C283($l_codigoEnseñanza;$l_Posicion)
C_REAL:C285($r_Calificacion)
C_TEXT:C284($t_documento;$t_rutaExtras)

ARRAY LONGINT:C221($al_Puntaje_HC_adultos;0)
ARRAY LONGINT:C221($al_Puntaje_HC_diurno;0)
ARRAY LONGINT:C221($al_Puntaje_TecnicoPro;0)
ARRAY REAL:C219($ar_Notas;0)
If (False:C215)
	C_LONGINT:C283(AL_PuntajeNEM_cl ;$0)
	C_REAL:C285(AL_PuntajeNEM_cl ;$1)
	C_LONGINT:C283(AL_PuntajeNEM_cl ;$2)
End if 

$r_Calificacion:=$1
$l_codigoEnseñanza:=$2

$t_documento:=Get 4D folder:C485(Current resources folder:K5:16)+"TablaPuntajeDemreChile.pref"
DOCUMENT TO BLOB:C525($t_documento;$x_blob)
BLOB_Blob2Vars (->$x_blob;0;->$ar_Notas;->$al_Puntaje_HC_diurno;->$al_Puntaje_HC_adultos;->$al_Puntaje_TecnicoPro)

$l_Posicion:=Find in array:C230($ar_Notas;$r_Calificacion)
If ($l_Posicion>0)
	Case of 
		: ($l_codigoEnseñanza=310)
			$0:=$al_Puntaje_HC_diurno{$l_Posicion}
			
		: (($l_codigoEnseñanza>=360) & ($l_codigoEnseñanza<=363))
			$0:=$al_Puntaje_HC_adultos{$l_Posicion}
			
		: (($l_codigoEnseñanza>=410) & ($l_codigoEnseñanza<=863))
			$0:=$al_Puntaje_TecnicoPro{$l_Posicion}
	End case 
Else 
	$0:=0
	LOG_RegisterEvt ("No es posible calcular el puntaje NEM para "+[Alumnos:2]apellidos_y_nombres:40+". El promedio de notas esta fuera de rango.")
End if 
