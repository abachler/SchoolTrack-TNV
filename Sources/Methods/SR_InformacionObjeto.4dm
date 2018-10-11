//%attributes = {}
  // SR_InformacionObjeto()
  // Por: Alberto Bachler K.: 14-08-15, 12:08:57
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($error;$l_IdObjeto;$l_refArea;$l_SRfixH;$l_SRfixV;$l_SRObjBottom;$l_SRObjLeft;$l_SRObjRight;$l_SRObjTop;$l_SROrder)
C_LONGINT:C283($l_SRRepeatH;$l_SRRepeatV;$l_SRSelected;$l_SRvarSize_H;$l_SRvarSize_V)
C_TEXT:C284($t_SRObjName;$t_SRObjType)

$l_refArea:=$1
$l_IdObjeto:=$2

$error:=SR_GetPtrProperty ($l_refArea;$l_IdObjeto;SRP_Object_Kind;->$t_SRObjType)
$error:=SR_GetPtrProperty ($l_refArea;$l_IdObjeto;SRP_Object_Name;->$t_SRObjName)
$error:=SR_GetPtrProperty ($l_refArea;$l_IdObjeto;SRP_Object_PosTop;->$l_SRObjTop)  //top position
$error:=SR_GetPtrProperty ($l_refArea;$l_IdObjeto;SRP_Object_PosLeft;->$l_SRObjLeft)  //left position
$error:=SR_GetPtrProperty ($l_refArea;$l_IdObjeto;SRP_Object_PosBottom;->$l_SRObjBottom)  //bottom position
$error:=SR_GetPtrProperty ($l_refArea;$l_IdObjeto;SRP_Object_PosRight;->$l_SRObjRight)  //right position

$error:=SR_GetPtrProperty ($l_refArea;$l_IdObjeto;SRP_Object_FixH;->$l_SRfixH)  //fixed horizontal position
$error:=SR_GetPtrProperty ($l_refArea;$l_IdObjeto;SRP_Object_FixV;->$l_SRfixV)  //fixed vertical position

$error:=SR_GetPtrProperty ($l_refArea;$l_IdObjeto;SRP_Object_VariableSizeH;->$l_SRvarSize_H)  //can grow or shrink horizontally
$error:=SR_GetPtrProperty ($l_refArea;$l_IdObjeto;SRP_Object_VariableSizeV;->$l_SRvarSize_V)  //can grow or shrink vertically

$error:=SR_GetPtrProperty ($l_refArea;$l_IdObjeto;SRP_Object_Order;->$l_SROrder)  //print order
$error:=SR_GetPtrProperty ($l_refArea;$l_IdObjeto;SRP_Object_Selected;->$l_SRSelected)  //selected object

$error:=SR_GetPtrProperty ($l_refArea;$l_IdObjeto;SRP_Variable_RepeatOffset;->$l_SRRepeatH)  //repeat offset (128 max)
$error:=SR_GetPtrProperty ($l_refArea;$l_IdObjeto;SRP_Variable_RepeatOffset;->$l_SRRepeatV)