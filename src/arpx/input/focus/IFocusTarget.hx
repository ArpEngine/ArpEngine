package arpx.input.focus;

/**
 * This is just a marker interface for valid focus target in RenderContext
 **/
@:noDoc @:noCompletion
interface IFocusTarget {
	var focused(get, set):Bool;
}
