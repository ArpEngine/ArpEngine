package arpx.input.focus;

@:noDoc @:noCompletion
interface IFocusNode<T> extends IFocusTarget {

	/**
	 * Pass current focusable candidate and return new focusable candidate regarding this focusable tree.
	 **/
	function findFocus(other:Null<T>):Null<T>;
}
