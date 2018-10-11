//%attributes = {}
  // MPAcfg_Dim_Propiedades()
  //
  //
  //
  // ---------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 07/07/12, 13:52:22
  // ---------------------------------------------
C_LONGINT:C283($1)

C_LONGINT:C283($l_recNumDimension)

If (False:C215)
	C_LONGINT:C283(MPAcfg_Dim_Propiedades ;$1)
End if 

  // CÓDIGO
$l_recNumDimension:=$1
READ WRITE:C146([MPA_DefinicionDimensiones:188])
GOTO RECORD:C242([MPA_DefinicionDimensiones:188];$l_recNumDimension)
WDW_OpenFormWindow (->[MPA_DefinicionDimensiones:188];"Propiedades";-1;8)
KRL_ModifyRecord (->[MPA_DefinicionDimensiones:188];"Propiedades")

MPAcfg_ContenidoAreas 