//%attributes = {}
  // Método: ACTcfg_LoadMatrix
  //----------------------------------------------
  // Usuario (OS): roberto
  // Fecha: 11-09-10, 15:56:03
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones


  // Código principal




  //ACTcfg_LoadMatrix 

ARRAY TEXT:C222(atACT_NombreMatriz;0)
ARRAY TEXT:C222(atACT_MonedaMatriz;0)
ARRAY LONGINT:C221(alACT_IdMatriz;0)

READ ONLY:C145([ACT_Matrices:177])
ALL RECORDS:C47([ACT_Matrices:177])
SELECTION TO ARRAY:C260([ACT_Matrices:177]ID:1;alACT_IdMatriz;[ACT_Matrices:177]Nombre_matriz:2;atACT_NombreMatriz;[ACT_Matrices:177]Moneda:9;atACT_MonedaMatriz)
SORT ARRAY:C229(atACT_NombreMatriz;alACT_IdMatriz;atACT_MonedaMatriz;>)