////////////////////////////////////////////////////////////////////////////////
// Copyright 2010 Michael Schmalle - Teoti Graphix, LLC
// 
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
// 
// http://www.apache.org/licenses/LICENSE-2.0 
// 
// Unless required by applicable law or agreed to in writing, software 
// distributed under the License is distributed on an "AS IS" BASIS, 
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and 
// limitations under the License
// 
// Author: Michael Schmalle, Principal Architect
// mschmalle at teotigraphix dot com
////////////////////////////////////////////////////////////////////////////////

package org.teotigraphix.ui.components
{

import flash.events.IEventDispatcher;
import flash.events.MouseEvent;

import mx.styles.IStyleClient;

import org.teotigraphix.ui.components.controlSupport.TitleBarBase;
import org.teotigraphix.ui.skins.TitleBarSkin;
import org.teotigraphix.ui.skins.controlSupport.BarBorderSkin;
import org.teotigraphix.ui.skins.controlSupport.CloseButtonSkin;
import org.teotigraphix.ui.skins.controlSupport.MaximizeButtonSkin;
import org.teotigraphix.ui.skins.controlSupport.MinimizeButtonSkin;
import org.teotigraphix.ui.utils.StyleUtil;

import spark.components.supportClasses.ButtonBase;
import spark.components.supportClasses.TextBase;
import spark.components.supportClasses.ToggleButtonBase;
import spark.primitives.BitmapImage;

//--------------------------------------
//  Styles
//--------------------------------------

/**
 * The alternate <code>skinClass</code> for the <code>borderDisplay</code>.
 * 
 * @mxml Class
 * @default undefined
 */
[Style(name="borderSkinClass",type="Class")]

/**
 * The alternate <code>skinClass</code> for the 
 * <code>minimizeButtonDisplay</code>.
 * 
 * @mxml Class
 * @default undefined
 */
[Style(name="minimizeButtonSkinClass",type="Class")]

/**
 * The alternate <code>skinClass</code> for the 
 * <code>maximizeButtonDisplay</code>.
 * 
 * @mxml Class
 * @default undefined
 */
[Style(name="maximizeButtonSkinClass",type="Class")]

/**
 * The alternate <code>skinClass</code> for the 
 * <code>closeButtonDisplay</code>.
 * 
 * @mxml Class
 * @default undefined
 */
[Style(name="closeButtonSkinClass",type="Class")]

//--------------------------------------
//  Class
//--------------------------------------

/**
 * The TitleBar class is a style-skin implementation for the 
 * <code>TitleBarBase</code> class.
 * 
 * @author Michael Schmalle
 * @copyright Teoti Graphix, LLC
 * @productversion 1.0
 * 
 * @mxml
 */
public class TitleBar extends TitleBarBase
{
	//--------------------------------------------------------------------------
	//
	//  Class :: Initialization
	//
	//--------------------------------------------------------------------------
	
	/**
	 * @private
	 */
	private static var stylesInitialized:Boolean = false;	
	
	/**
	 * Initializes the TypeSelector for the 
	 * <code>org.teotigraphix.ui.components.TitleBar</code>.
	 */
	public static function initializeClass():void
	{
		if (stylesInitialized)
			return;
		else
			stylesInitialized = true;
		
		StyleUtil.create(
			"org.teotigraphix.ui.components.TitleBar",
			function ():void {
				this.skinClass = TitleBarSkin;
				
				// ControlBase
				this.borderColor = 0xFFFFFF;
				this.borderAlpha = 1;
				
				this.backgroundColor = 0xFFFFFF;
				this.backgroundAlpha = 1;
				
				this.paddingTop = 2;
				this.paddingRight = 2;
				this.paddingBottom = 2;
				this.paddingLeft = 2;
				
				this.cornerRadius = 0;
				
				this.topLeftRadius = 0;
				this.topRightRadius = 0;
				this.bottomRightRadius = 0;
				this.bottomLeftRadius = 0;
				
				// BarBase
				this.barColors = [0xE2E2E2, 0xD9D9D9];
				this.barAlphas = [1, 1];
				this.barDividerColor = 0x242424;//0xC0C0C0;
				this.barHighlightColors = [0xFFFFFF, 0xCCCCCC];
				this.barHighlightAlphas = [1, 1];
				
				this.gap = 1;
				this.verticalAlign = "middle";
				this.horizontalAlign = "left";
			});
		
		// #borderDisplay defaults
		//StyleUtil.factory(
		//	"org.teotigraphix.ui.components.TitleBar",
		//	"borderDisplay",
		//	function ():void {
		//		this.skinClass = BarBorderSkin;
		//	});
	}
	
	//--------------------------------------------------------------------------
	//
	//  Constructor
	//
	//--------------------------------------------------------------------------
	
	/**
	 * Constructor.
	 */
	public function TitleBar()
	{
		super();
		
		initializeClass();
	}
	
	//--------------------------------------------------------------------------
	//
	//  Overridden Protected :: Methods
	//
	//--------------------------------------------------------------------------
	
	/**
	 * @private
	 */
	override protected function partAdded(partName:String, instance:Object):void
	{
		super.partAdded(partName, instance);
		
		if (instance == borderDisplay)
		{
			StyleUtil.setSkinClass(this, borderDisplay as IStyleClient);
		}
		
		if (instance == minimizeButtonDisplay)
		{
			StyleUtil.setSkinClass(this, minimizeButtonDisplay);
		}
		
		if (instance == maximizeButtonDisplay)
		{
			StyleUtil.setSkinClass(this, maximizeButtonDisplay);
		}
		
		if (instance == closeButtonDisplay)
		{
			StyleUtil.setSkinClass(this, closeButtonDisplay);
		}
	}
	
	//--------------------------------------------------------------------------
	//
	//  Overridden Public :: Methods
	//
	//--------------------------------------------------------------------------
	
	/**
	 * @private
	 */
	public override function styleChanged(styleProp:String):void
	{
		super.styleChanged(styleProp);
		
		var allStyles:Boolean = styleProp == null || styleProp == "styleName";
		
		if (allStyles || styleProp == "borderSkinClass")
		{
			StyleUtil.setSkinClass(this, borderDisplay as IStyleClient);
		}
		
		if (allStyles || styleProp == "minimizeButtonSkinClass")
		{
			StyleUtil.setSkinClass(this, minimizeButtonDisplay);
		}
		
		if (allStyles || styleProp == "minimizeButtonSkinClass")
		{
			StyleUtil.setSkinClass(this, maximizeButtonDisplay);
		}
		
		if (allStyles || styleProp == "closeButtonSkinClass")
		{
			StyleUtil.setSkinClass(this, closeButtonDisplay);
		}		
	}
}
}