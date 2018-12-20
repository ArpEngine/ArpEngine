package arpx;

#if macro

import haxe.macro.Compiler;
import haxe.macro.Context;
import haxe.macro.Expr;

class ArpEngineMacros {

	private static var instance:ArpEngineMacros;

	public static function init():Array<Field> {
		if (instance == null) instance = new ArpEngineMacros();
		return null;
	}

	private function new() {
		Sys.println('Initializing ArpEngine');
		var components:Array<ArpEngineBackend> = [];
		components.push(ArpEngineBackend.flat("arp_display_backend", ["heaps", "flash", "openfl", "sys", "stub"]));
		components.push(ArpEngineBackend.flat("arp_input_backend", ["heaps", "flash", "openfl", "js", "sys", "stub"]));
		components.push(ArpEngineBackend.flat("arp_audio_backend", ["heaps", "flash", "openfl", "js", "sys", "stub"]));
		components.push(ArpEngineBackend.flat("arp_socket_backend", ["flash", "openfl", "sys", "stub"]));
		components.push(ArpEngineBackend.flat("arp_storage_backend", ["flash", "openfl", "js", "sys", "stub"]));

		var root:ArpEngineBackend = ArpEngineBackend.complex("arp_backend", [
			{ name: "heaps" },
			{ name: "flash" },
			{ name: "openfl", selector: _ -> "flash" },
			{ name: "sys" },
			{ name: "stub" }
		]);
		var rootTarget:Target = root.guessTarget(null);

		for (component in components) component.guessTarget(rootTarget);
		return;
	}
}

typedef TargetDef = {
	var name:String;
	@:optional var selector:(categoryName:String)->String;
}

class Target {

	private var category:String;
	public var name(default, null):String;

	public var prettyName(get, never):String;
	private function get_prettyName():String return '${category} ${name}';

	public var defineName(get, never):String;
	private function get_defineName():String return '${category}_${name}';

	dynamic public function guessSubTargetName(categoryName:String) return name;

	public function new(category:String, name:String, selector:(categoryName:String)->String = null) {
		this.category = category;
		this.name = name;
		if (selector != null) this.guessSubTargetName = selector;
	}
}

class ArpEngineBackend {

	private var category:String;
	private var target:Target;
	private var targets:Array<Target>;

	private function new(category:String, targets:Array<Target>) {
		this.category = category;
		this.targets = targets;
		this.consumeDefines();
	}

	public static function flat(category:String, targetNames:Array<String>) {
		return new ArpEngineBackend(category, targetNames.map(name -> new Target(category, name)));
	}

	public static function complex(category:String, targetDefs:Array<TargetDef>) {
		return new ArpEngineBackend(category, targetDefs.map(targetDef -> new Target(category, targetDef.name, targetDef.selector)));
	}

	private function consumeDefines() {
		var definedTargets:Array<Target> = [];
		for (target in this.targets) {
			if (Context.defined(target.defineName)) definedTargets.push(target);
		}
		switch (definedTargets.length) {
			case 0:
			case 1: this.target = definedTargets[0];
			case _: throw 'Compiler flag conflict: Backends cannot coexist: ${category}: ${definedTargets.map(t -> t.name).join(",")}';
		}
	}

	private function trySelectTarget(filter:Target->Bool):Target {
		for (target in targets) {
			if (filter(target)) return this.target = target;
		}
		return null;
	}

	public function guessTarget(rootTarget:Target):Target {
		if (this.target != null) {
			Sys.println('Using ${this.target.prettyName}');
			return this.target;
		}

		if (this.target == null && rootTarget != null) {
			// use root provided target
			var provided = rootTarget.guessSubTargetName(this.category);
			trySelectTarget(target -> target.name == provided);
		}
		if (this.target == null) {
			// use first available target, guess by native defines
			trySelectTarget(target -> Context.defined(target.name));
		}
		if (this.target == null) {
			// use stub
			this.target = targets[targets.length - 1];
		}

		if (this.target != null) {
			Sys.println('Using ${this.target.prettyName} (auto defined ${target.defineName})');
			Compiler.define(target.defineName);
		}
		return this.target;
	}
}
#end
