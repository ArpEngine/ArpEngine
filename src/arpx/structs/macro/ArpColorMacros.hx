package arpx.structs.macro;

import haxe.macro.Expr;

class ArpColorMacros {
	macro public static function clamped(value:Expr):Expr return macro if ($e{value} < 0) 0 else if ($e{value} > 255) 255 else $e{value};
}


