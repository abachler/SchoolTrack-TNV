//%attributes = {}
  //xALSet_AL_AreasFamilia
C_LONGINT:C283(cb_SepararCargosXPct;cb_SepararDTsXPct)

ARRAY TEXT:C222(aBthrName;0)
ARRAY TEXT:C222(aBthrCurso;0)
ARRAY LONGINT:C221(aBthrID;0)
ARRAY LONGINT:C221(aBrotherNumber;0)

ARRAY LONGINT:C221(aPersID;0)
ARRAY TEXT:C222(aParentesco;0)
ARRAY TEXT:C222(aRelName;0)
ARRAY TEXT:C222(aApoderado;0)
ARRAY TEXT:C222(aTelDom;0)
ARRAY TEXT:C222(aCellPhone;0)
ARRAY TEXT:C222(aTelOF;0)
ARRAY REAL:C219(arACT_PctEmision;0)

  //  // RELACIONES
If ((cb_SepararCargosXPct=1) | (cb_SepararDTsXPct=1))
	$err:=AL_SetArraysNam (xALP_Familia;1;8;"aParentesco";"aRelName";"aApoderado";"aCellPhone";"aTelDom";"aTelOF";"arACT_PctEmision";"aPersID")
	AL_SetHeaders (xALP_Familia;1;7;__ ("Relación");__ ("Nombre");__ ("Apoderado");__ ("Celular");__ ("Tel. Domicilio");__ ("Tel. Oficina");__ ("%"))
	AL_SetWidths (xALP_Familia;1;7;60;240;60;100;100;100;50)
Else 
	$err:=AL_SetArraysNam (xALP_Familia;1;7;"aParentesco";"aRelName";"aApoderado";"aCellPhone";"aTelDom";"aTelOF";"aPersID")
	AL_SetHeaders (xALP_Familia;1;6;__ ("Relación");__ ("Nombre");__ ("Apoderado");__ ("Celular");__ ("Tel. Domicilio");__ ("Tel. Oficina"))
	AL_SetWidths (xALP_Familia;1;6;60;250;70;110;110;110)
End if 
ALP_SetDefaultAppareance (xALP_Familia;9;1;6;1;8)
AL_SetMiscOpts (xALP_Familia;0;0;"'";0;1)
AL_SetRowOpts (xALP_Familia;0;1;0;0;0)
AL_SetLine (xALP_Familia;0)
AL_SetColOpts (xALP_Familia;1;1;0;1;0;0;0)
AL_SetSortOpts (xALP_Familia;0;0;0;"";0)
AL_SetScroll (xALP_Familia;0;-3)
AL_SetFormat (xALP_Familia;0;"";0;2;0;0)

  // HERMANOS
$err:=AL_SetArraysNam (xALP_Hermano;1;4;"aBthrName";"aBthrCurso";"aBrotherNumber";"aBthrID")
AL_SetHeaders (xALP_Hermano;1;3;__ ("Nombre");__ ("Curso");__ ("Nº en Familia"))
ALP_SetDefaultAppareance (xALP_Hermano;9;1;6;1;8)
AL_SetMiscOpts (xALP_Hermano;0;0;"'";0;1)
AL_SetRowOpts (xALP_Hermano;0;1;0;0;0)
AL_SetLine (xALP_Hermano;0)
AL_SetColOpts (xALP_Hermano;1;1;0;1;0;0;0)
AL_SetWidths (xALP_Hermano;1;3;210;70;75)
AL_SetSortOpts (xALP_Hermano;0;0;0;"";0)
AL_SetScroll (xALP_Hermano;0;-3)
AL_SetFormat (xALP_Hermano;1;"";0;2;0;0)
AL_SetFormat (xALP_Hermano;2;"";0;2;0;0)
AL_SetFormat (xALP_Hermano;3;"####";0;2;0;0)