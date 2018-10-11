//%attributes = {}
  // AS_xALP_AtributosCeldaNotaFinal()
  // Por: Alberto Bachler K.: 01-02-14, 15:16:19
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_BOOLEAN:C305($b_calificacionEditable)
C_LONGINT:C283($l_celdaEditable;$l_columnaNotaFinal;$l_error;$l_estilo;$l_estiloCelda;$l_estiloCelda_;$l_fila)

ARRAY TEXT:C222($at_ArrayNames;0)

$l_fila:=$1


$b_calificacionEditable:=Not:C34(<>vb_BloquearModifSituacionFinal)
$b_calificacionEditable:=$b_calificacionEditable & (((<>viSTR_FirmantesAutorizados=1) & (<>lUSR_RelatedTableUserID=[Asignaturas:18]profesor_firmante_numero:33)) | (<>lUSR_RelatedTableUserID=[Asignaturas:18]profesor_numero:4) | (USR_checkRights ("M";->[Alumnos_Calificaciones:208])))
$b_calificacionEditable:=$b_calificacionEditable | ((USR_IsGroupMember_by_GrpID (-15001)) | (<>lUSR_CurrentUserID<0))


$l_error:=AL_GetObjects (xALP_ASNotas;ALP_Object_Source;$at_ArrayNames)
$l_columnaNotaFinal:=Find in array:C230($at_ArrayNames;"aNtaF")


If ((vr_MinimoExRecuperatorio>=vrNTA_MinimoEscalaReferencia) & (vi_UsarExRecuperatorio=1) & AS_PromediosSonCalculados  & $b_calificacionEditable)
	  // si calificacion es editable, el examen recuperatorio es permitido, el minimo final requerido para recuperatorio es superior al mínimo de la escala y los promedios son calculados
	
	Case of 
			  // examenes normal y extraordinario evaluados
			  // la celda Nota final es ingresable para recibir el examen recuperatorio
		: ((aRealNtaEXX{$l_fila}>=vrNTA_MinimoEscalaReferencia) & (aRealNtaEX{$l_fila}>=vrNTA_MinimoEscalaReferencia) & (aRealNtaF{$l_fila}<vr_MinimoExRecuperatorio))
			$l_celdaEditable:=AL Cell entry on
			$l_estiloCelda:=Bold:K14:2+Underline:K14:4
			
			  // si el examen normal no fue rendido y el examen extraordinario fue evaluado
			  // la celda Nota final es ingresable para recibir el examen recuperatorio
		: ((aRealNtaEX{$l_fila}=-4) & (aRealNtaEXX{$l_fila}>=vrNTA_MinimoEscalaReferencia) & (aRealNtaF{$l_fila}<vr_MinimoExRecuperatorio))
			$l_celdaEditable:=AL Cell entry on
			$l_estiloCelda:=Bold:K14:2+Underline:K14:4
			
			  // si el examen normal fue evaluado y el examen extraordinario no rendido (asterisco)
			  // la celda Nota final es ingresable para recibir el examen recuperatorio
		: ((aRealNtaEX{$l_fila}>=vrNTA_MinimoEscalaReferencia) & (aRealNtaEXX{$l_fila}=-4) & (aRealNtaF{$l_fila}<vr_MinimoExRecuperatorio))
			$l_celdaEditable:=AL Cell entry on
			$l_estiloCelda:=Bold:K14:2+Underline:K14:4
			
			  // si el examen normal fue evaluado y el examen extraordinario no fueron rendidos (asterisco)
			  // la celda Nota final es ingresable para recibir el examen recuperatorio
		: ((aRealNtaEX{$l_fila}=-4) & (aRealNtaEXX{$l_fila}=-4) & (aRealNtaF{$l_fila}<vr_MinimoExRecuperatorio))
			$l_celdaEditable:=AL Cell entry on
			$l_estiloCelda:=Bold:K14:2+Underline:K14:4
			
			  // si el examen normal y el examen extraordinario no fueron rendidos (asterisco)
			  // la celda Nota final es ingresable para recibir el examen recuperatorio
		: ((aRealNtaEX{$l_fila}=-4) & (aRealNtaEXX{$l_fila}=-4))
			$l_celdaEditable:=AL Cell entry on
			$l_estiloCelda:=Bold:K14:2+Underline:K14:4
			
			  // si no hay evaluaciones para el examen final o el examen extraordinario
			  // la celda nota final no es ingresable (no se puede registrar examen recuperatorio
			  // sin haber registrado examen anual y extraordinario
		Else 
			$l_celdaEditable:=AL Cell entry off
			$l_estiloCelda:=Bold:K14:2
			
	End case 
	
	Case of 
		: (aRealEXRecuperatorio{$l_fila}>=vrNTA_MinimoEscalaReferencia)
			  //si se registró examen recuperatorio la celda nota final queda ingresable y su contenido se muestra en negrillas, subrayado y cursivas:
			  // - cursiva indica que hay recuperatorio evaluado
			  // - subrayado solo indica que es posible registrar examen recuperatorio
			  // - subrayado y cursiva indica que es posible modificar el examen recuperatorio rendido
			$l_estiloCelda:=Bold:K14:2+Underline:K14:4+Italic:K14:3
			$l_celdaEditable:=AL Cell entry on
			
		: ((aRealNtaEX{$l_fila}>=vrNTA_MinimoEscalaReferencia) & (aRealNtaEXX{$l_fila}>=vrNTA_MinimoEscalaReferencia) & (aRealEXRecuperatorio{$l_fila}=-10) & (aRealNtaF{$l_fila}<vr_MinimoExRecuperatorio))
			$l_estiloCelda:=Bold:K14:2+Underline:K14:4
			$l_celdaEditable:=AL Cell entry on
	End case 
	
Else 
	$l_estiloCelda:=Bold:K14:2
	If (AS_PromediosSonCalculados )
		$l_celdaEditable:=AL Cell entry off
	Else 
		$l_celdaEditable:=AL Cell entry on
	End if 
End if 


AL_SetCellLongProperty (xALP_ASNotas;$l_fila;$l_columnaNotaFinal;ALP_Cell_Enterable;$l_celdaEditable)
AL_SetCellLongProperty (xALP_ASNotas;$l_fila;$l_columnaNotaFinal;ALP_Cell_StyleF;$l_estiloCelda)

