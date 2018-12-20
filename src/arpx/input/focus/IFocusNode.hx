package arpx.input.focus;

@:noDoc @:noCompletion
interface IFocusNode<T> {
	function findFocus(other:Null<T>):Null<T>;
	function updateFocus(target:Null<T>):Void;
}
