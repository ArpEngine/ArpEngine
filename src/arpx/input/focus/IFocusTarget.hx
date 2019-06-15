package arpx.input.focus;

/**
 * This is mostly just a marker interface for valid focus target in RenderContext
 **/
interface IFocusTarget extends IInteractable {
	var focused(get, set):Bool;
}
