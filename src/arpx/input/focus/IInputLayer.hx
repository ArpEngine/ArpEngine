package arpx.input.focus;

/**
 * Prioritized Input receiver candidates
 **/
@:noDoc @:noCompletion
interface IInputLayer<T> {
	var priority(get, set):Int;
	function collectInputLayers(layers:Array<T>):Void;
}
