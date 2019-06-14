package arpx.input.focus;

/**
 * Prioritized Input receiver candidates
 **/
interface IInputLayer<T> extends IInteractable {
	var priority(get, set):Int;
	function collectInputLayers(layers:Array<T>):Void;
}
