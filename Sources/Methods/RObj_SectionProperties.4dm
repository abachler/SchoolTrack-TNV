//%attributes = {}
  // Método: RObj_SectionProperties
  //----------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 24/12/10, 20:03:07
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones


  // Código principal

vlSR_SectionRef:=$1
C_POINTER:C301($nilPointer)
WDW_OpenFormWindow ($nilPointer;"SR_SectionProperties";8;-1)
DIALOG:C40("SR_SectionProperties")
CLOSE WINDOW:C154
