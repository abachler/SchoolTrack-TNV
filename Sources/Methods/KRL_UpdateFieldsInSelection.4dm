//%attributes = {}
  // Método: KRL_UpdateFieldsInSelection
  //----------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 10/03/10, 19:12:38
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones


  // Código principal

  //C_POINTER($arrayPointer;$1;$fieldPointer;$2;$valuePointer;3)
  //ARRAY LONGINT($aRecNums;0)
  //$arrayPointer:=$1
  //$fieldPointer:=$2
  //$valuePointer:=$3
  //COPY ARRAY($arrayPointer->;$aRecNums)
  //TRACE
  //$tablePointer:=Table(Table($fieldPointer))
  //Case of 
  //: ((Type($fieldPointer->)=Is Alpha Field ) | (Type($fieldpointer->)=Is Text ))
  //$textValue:=$valuePointer->
  //ARRAY TEXT($aText;Size of array($aRecNums))
  //AT_Populate (->$aText;->$textValue)
  //End case 
  //
  //CREATE SELECTION FROM ARRAY($tablePointer->;$aRecNums)
  //KRL_Array2Selection (->$aText;$fieldpointer)

