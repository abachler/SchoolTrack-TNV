//%attributes = {}
  //CARD_ReadBuffer

  //$text2:=""
  //$acc:=""
  //$reception:=""
  //$reception_i:=""
  //
  //$delimiter:="\r"+Char(10)
  //
  //ARRAY TEXT($1->;0)
  //ARRAY TEXT($2->;0)
  //ARRAY TEXT($3->;0)
  //ARRAY TEXT($4->;0)
  //
  //RECEIVE BUFFER($text)
  //If ($text#"")
  //$acc:=$text
  //$text2:=""
  //While (Position(Char(10);$acc)=0)
  //RECEIVE BUFFER($text2)
  //$acc:=$acc+$text2
  //End while 
  //$reception:=$acc
  //End if 
  //If ($reception#"")
  //$reception:=Substring($reception;2)
  //$cuantos:=ST_CountWords ($reception;0;":")
  //For ($i;1;$cuantos)
  //$reception_i:=ST_GetWord ($reception;$i;":")
  //$reception_i:=Replace string($reception_i;$delimiter;"")
  //
  //AT_Insert (0;1;$1;$2;$3;$4)
  //
  //$1->{Size of array($1->)}:=Substring($reception_i;1;2)
  //$2->{Size of array($2->)}:=Substring($reception_i;3;2)
  //$3->{Size of array($3->)}:=Substring($reception_i;5;2)
  //$4->{Size of array($4->)}:=Substring($reception_i;7)
  //End for 
  //$reception:=""
  //End if 