//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Adrian Sepulveda 
  // Fecha y hora: 03-10-18, 11:27:40
  // ----------------------------------------------------
  // Método: UD_CreaObjetoDesdeOT
  // Descripción
  // 
  //
  // Parámetros
  // ----------------------------------------------------


C_BOOLEAN:C305($b_valoPicture;$b_valorBoolean)
C_DATE:C307($d_valorDate)
C_LONGINT:C283($l_indiceObjOt;$l_OTref;$l_refObjeto;$l_tipoItem;$l_valorLongint)
C_TIME:C306($h_valorTime)
C_POINTER:C301($y_punteroValor)
C_REAL:C285($r_valorReal)
C_TEXT:C284($t_valorTexto)
C_OBJECT:C1216($o_nuevoObjeto;$o_temporal)

ARRAY LONGINT:C221($al_tipoItems;0)
ARRAY TEXT:C222($at_NombreItems;0)
CLEAR VARIABLE:C89($o_temporal)

$l_OTref:=$1
OT GetAllNamedProperties ($l_otRef;"";$at_NombreItems;$al_tipoItems)

For ($l_indiceObjOt;1;Size of array:C274($at_NombreItems))
	Case of 
		: (($al_tipoItems{$l_indiceObjOt}=Is real:K8:4) | ($al_tipoItems{$l_indiceObjOt}=1))  //real
			$r_valorReal:=OT GetReal ($l_otRef;$at_NombreItems{$l_indiceObjOt})
			$y_punteroValor:=->$r_valorReal
			
		: (($al_tipoItems{$l_indiceObjOt}=Is longint:K8:6) | ($al_tipoItems{$l_indiceObjOt}=9))  // longint
			$l_valorLongint:=OT GetLong ($l_otRef;$at_NombreItems{$l_indiceObjOt})
			$y_punteroValor:=->$l_valorLongint
			
		: (($al_tipoItems{$l_indiceObjOt}=114) | ($al_tipoItems{$l_indiceObjOt}=Is object:K8:27))  //Objeto
			
			$l_refObjeto:=OT GetObject ($l_otRef;$at_NombreItems{$l_indiceObjOt})
			$o_nuevoObjeto:=UD_CreaObjetoDesdeOT ($l_refObjeto)
			$y_punteroValor:=->$o_nuevoObjeto
			
			
		: ($l_tipoItem=Is date:K8:7)
			$d_valorDate:=OT GetDate ($l_otRef;$at_NombreItems{$l_indiceObjOt})
			$y_punteroValor:=->$d_valorDate
			
		: ($l_tipoItem=Is time:K8:8)
			$h_valorTime:=OT GetTime ($l_otRef;$at_NombreItems{$l_indiceObjOt})
			$y_punteroValor:=->$h_valorTime
			
			  //: ($l_tipoItem=Is Boolean)
			  //$b_valorBoolean:=OT GetBoolean ($l_otRef;$at_NombreItems{$l_indiceObjOt})
			  //$y_punteroValor:=->$b_valorBoolean
			
			  //: ($l_tipoItem=Is picture)
			  //$b_valoPicture:=OT GetPicture ($l_otRef;$at_NombreItems{$l_indiceObjOt})
			  //$y_punteroValor:=->$b_valoPicture
			
		: ($l_tipoItem=Is text:K8:3)
			$t_valorTexto:=OT GetText ($l_otRef;$at_NombreItems{$l_indiceObjOt})
			$y_punteroValor:=->$t_valorTexto
			
	End case 
	OB SET:C1220($o_temporal;$at_NombreItems{$l_indiceObjOt};$y_punteroValor->)
End for 

$0:=$o_temporal