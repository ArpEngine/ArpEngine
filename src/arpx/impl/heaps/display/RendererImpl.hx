package arpx.impl.heaps.display;

#if (arp_display_backend_heaps || arp_backend_display)

import h2d.Tile;
import h3d.Buffer;
import h3d.Engine;
import h3d.mat.BlendMode;
import h3d.mat.Data;
import h3d.mat.Pass;
import h3d.Matrix;
import h3d.pass.ShaderManager;
import h3d.shader.Base2d;
import hxsl.Globals;
import hxsl.RuntimeShader;
import hxsl.ShaderList;

class RendererImpl {

	var engine:Engine;

	var manager:ShaderManager;
	var pass:Pass;
	var baseShader:Base2d;
	var baseShaderList:ShaderList;
	var runtimeShader:RuntimeShader;
	var buffers:h3d.shader.Buffers;

	var fixedBuffer:h3d.Buffer;

	public function new(engine:Engine) {
		this.engine = engine;

		manager = new ShaderManager();
		pass = new Pass("", null);
		pass.depth(true, Compare.LessEqual);
		pass.culling = Face.None;
		pass.setBlendMode(BlendMode.Alpha);

		baseShader = new Base2d();
		baseShader.setPriority(100);

		baseShader.isRelative = true;
		baseShader.hasUVPos = true;
		baseShader.killAlpha = false;
		baseShader.pixelAlign = false; #if flash true #else false #end;

		baseShader.halfPixelInverse.set(0.5 / engine.width, 0.5 / engine.height);
		baseShader.viewport.set( -engine.width * 0.5, -engine.height * 0.5, 2 / engine.width, -2 / engine.height);
		baseShader.filterMatrixA.set(1, 0, 0);
		baseShader.filterMatrixB.set(0, 1, 0);

		baseShader.color.set(1, 1, 1, 1);
		baseShader.absoluteMatrixA.set(128, 0, 0, 1);
		baseShader.absoluteMatrixB.set(0, 128, 0, 1);
		baseShader.uvPos.set(0, 0, 1, 1);
		baseShader.zValue = 0.;

		baseShaderList = new ShaderList(baseShader);

		baseShader.updateConstants(manager.globals);

		runtimeShader = manager.compileShaders(baseShaderList);
		if (buffers == null) buffers = new h3d.shader.Buffers(runtimeShader) else buffers.grow(runtimeShader);
	}

	public function start():Void {
		engine.selectShader(runtimeShader);
		engine.selectMaterial(pass);

		manager.globals.set("time", 0.);
		manager.fillGlobals(buffers, runtimeShader);
		engine.uploadShaderBuffers(buffers, Globals);

		if( fixedBuffer == null || fixedBuffer.isDisposed() ) {
			fixedBuffer = new h3d.Buffer(4, 8, [BufferFlag.Quads, BufferFlag.RawFormat]);
			var k = new hxd.FloatBuffer();
			for( v in [0, 0, 0, 0, 1, 1, 1, 1, 0, 1, 0, 1, 1, 1, 1, 1, 1, 0, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1] )
				k.push(v);
			fixedBuffer.uploadVector(k, 0, 4);
		}
	}

	public function display():Void {
	}

	public function renderTile(matrix:Matrix, tile:Tile, r:Float = 1., g:Float = 1., b:Float = 1., a:Float = 1.):Void {
		baseShader.absoluteMatrixA.set(matrix._11, matrix._21, matrix._41, 1);
		baseShader.absoluteMatrixB.set(matrix._12, matrix._22, matrix._42, 1);
		baseShader.color.set(r, g, b, a);
		@:privateAccess baseShader.uvPos.set(tile.u, tile.v, tile.u2 - tile.u, tile.v2 - tile.v);
		baseShader.texture = tile.getTexture();
		manager.fillParams(buffers, runtimeShader, baseShaderList);
		engine.uploadShaderBuffers(buffers, Params);
		engine.uploadShaderBuffers(buffers, Textures);
		engine.renderQuadBuffer(fixedBuffer);
	}

}

#end
