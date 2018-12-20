package arpx;

enum ArpEngineShellBufferMode {
	/**
	 * Selects most optimal buffer size. Logical on flash, Device on most targets
	 **/
	Automatic;

	/**
	 * Render buffer pixel size corresponds to logical screen size unit. Most blurry.
	 **/
	Logical;

	/**
	 * Render buffer pixel size corresponds to OS screen size unit. May not be most optimal on Retina desktops.
	 **/
	Screen;

	/**
	 * Render buffer pixel size corresponds to device screen size pixel. Always try to be pixel perfect.
	 **/
	Device;
}
