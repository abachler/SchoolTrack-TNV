//%attributes = {}
  // UD_v20140223_Ob_Firmantes()
  // Por: Alberto Bachler K.: 23-02-14, 05:37:25
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_BLOB:C604($blob)
C_LONGINT:C283($i_profesores;$i_registros;$l_idProfesor;$l_idTermometro;$l_items;$l_otRef;$l_resultado;$l_tamaño)
C_OBJECT:C1216($o_firmantes)

ARRAY LONGINT:C221($al_RecNums;0)
ARRAY LONGINT:C221($aObject1_ItemDataSizes;0)
ARRAY LONGINT:C221($aObject1_ItemSizes;0)
ARRAY LONGINT:C221($aObject1_ItemTypes;0)
ARRAY LONGINT:C221($aObject2_ItemDataSizes;0)
ARRAY LONGINT:C221($aObject2_ItemSizes;0)
ARRAY LONGINT:C221($aObject2_ItemTypes;0)
ARRAY TEXT:C222($aObject1_ItemNames;0)
ARRAY TEXT:C222($aObject2_ItemNames;0)
ARRAY TEXT:C222($at_Asg2;0)
ARRAY TEXT:C222($at_AsgCode;0)
ARRAY TEXT:C222($at_PrfAut;0)
ARRAY TEXT:C222($at_PrfAut2;0)
ARRAY TEXT:C222($at_PrfNam;0)
ARRAY TEXT:C222($at_PrfNam2;0)
ARRAY TEXT:C222($at_RUNProfesor;0)
ARRAY TEXT:C222($at_StringPrfID;0)
ARRAY TEXT:C222($at_UUIDProfesor;0)

ALL RECORDS:C47([Cursos:3])

LONGINT ARRAY FROM SELECTION:C647([Cursos:3];$al_RecNums;"")
$l_idTermometro:=IT_Progress (1;0;0;"Convirtiendo objeto fimantes en actas...")
For ($i_registros;1;Size of array:C274($al_RecNums))
	READ WRITE:C146([Cursos:3])
	GOTO RECORD:C242([Cursos:3];$al_RecNums{$i_registros})
	$blob:=PREF_fGetBlob (0;"Firmantes en "+String:C10([Cursos:3]Numero_del_curso:6);$blob)
	If (BLOB size:C605($blob)#0)
		$l_otRef:=OT BLOBToObject ($blob)
		If ($l_otRef#0)
			If (OT IsObject ($l_otRef)=1)
				OT GetAllProperties ($l_otRef;$aObject1_ItemNames)
				
				If (Size of array:C274($aObject1_ItemNames)>0)
					OT GetArray ($l_otRef;"Asignatura";$at_Asg2)
					If (Size of array:C274($at_Asg2)>0)
						OT GetArray ($l_otRef;"Nombres profesores";$at_PrfNam2)
						OT GetArray ($l_otRef;"Autorizaciones";$at_PrfAut2)
						OT GetArray ($l_otRef;"ID Profesores";$at_StringPrfID)
						OT GetArray ($l_otRef;"Codigos asignaturas";$at_AsgCode)
						OT GetArray ($l_otRef;"RUN profesores";$at_RUNProfesor)
						OT Clear ($l_otRef)
					End if 
				End if 
			End if 
			
			AT_RedimArrays (Size of array:C274($at_Asg2);->$at_PrfNam2;->$at_PrfAut2;->$at_StringPrfID;->$at_AsgCode;->$at_RUNProfesor;->$at_UUIDProfesor)
			For ($i_profesores;1;Size of array:C274($at_Asg2))
				$l_idProfesor:=Num:C11($at_StringPrfID{$i_profesores})
				$at_UUIDProfesor{$i_profesores}:=KRL_GetTextFieldData (->[Profesores:4]Numero:1;->$l_idProfesor;->[Profesores:4]Auto_UUID:41)
			End for 
		End if 
	End if 
	OB SET ARRAY:C1227($o_firmantes;"asignaturas";$at_Asg2)
	OB SET ARRAY:C1227($o_firmantes;"nombresProfesores";$at_PrfNam2)
	OB SET ARRAY:C1227($o_firmantes;"uuidProfesores";$at_UUIDProfesor)
	OB SET ARRAY:C1227($o_firmantes;"autorizacionProfesores";$at_PrfAut2)
	OB SET ARRAY:C1227($o_firmantes;"rutProfesores";$at_RUNProfesor)
	OB SET ARRAY:C1227($o_firmantes;"codigoAsignaturas";$at_AsgCode)
	OB SET:C1220($o_firmantes;"nombresApellidos";0)
	
	$l_resultado:=OB_ObjectToBlob (->$o_firmantes;->[Cursos:3]xoFirmantesActas_cl:8)
	
	
	SAVE RECORD:C53([Cursos:3])
	$l_idTermometro:=IT_Progress (0;$l_idTermometro;$i_registros/Size of array:C274($al_RecNums))
End for 
$l_idTermometro:=IT_Progress (-1;$l_idTermometro;$i_registros/Size of array:C274($al_RecNums))
KRL_UnloadReadOnly (->[Cursos:3])





