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

package org.teotigraphix.ui.skins.componentSupport
{

import mx.core.UIComponent;
import mx.graphics.BitmapFill;
import mx.graphics.RectangularDropShadow;
import mx.graphics.SolidColor;
import mx.graphics.SolidColorStroke;
import mx.styles.IStyleClient;

import spark.components.supportClasses.Skin;
import spark.primitives.Rect;
import spark.skins.spark.BorderContainerSkin;

/**
 * An encapsulated border class for SkinnableComponent skins.
 * 
 * <p>This class creates a base functionality to allow the 
 * <code>ComponentBorder</code> class to render a skin that can be styled 
 * and swapped at runtime.</p>
 * 
 * <p>The class uses a border, background and dropShadow instance. These skin
 * "parts" need to be availible in the actual Skin implementation.</p>
 * 
 * @author Michael Schmalle
 * @copyright Teoti Graphix, LLC
 * @productversion 1.0
 */
public class ComponentBorderSkinBase extends Skin
{
	//--------------------------------------------------------------------------
	//
	//  Public Part :: Variables
	//
	//--------------------------------------------------------------------------
	
	/**
	 * The border Rect instance.
	 */
	public var border:Rect;
	
	/**
	 * The background Rect instance.
	 */	
	public var background:Rect;
	
	/**
	 * The drop shadow instance if visible.
	 */
	public var dropShadow:RectangularDropShadow;
	
	//--------------------------------------------------------------------------
	//
	//  Constructor
	//
	//--------------------------------------------------------------------------
	
	/**
	 * Constructor.
	 */
	public function ComponentBorderSkinBase()
	{
		super();
	}
	
	//--------------------------------------------------------------------------
	//
	//  Overridden Protected :: Methods
	//
	//--------------------------------------------------------------------------
	
	/**
	 * @private
	 */
	override protected function updateDisplayList(unscaledWidth:Number, 
												  unscaledHeight:Number):void
	{
		visible = includeInLayout = getStyle("borderVisible");
		
		// if we are not visible, no need to render anything
		if (!visible)
			return;
		
		var cornerRadius:Number = getStyle("cornerRadius");
		var backgroundImage:Object = getStyle("backgroundImage");
		
		if (backgroundImage)
		{
			var bitmapFill:BitmapFill = new BitmapFill();
			
			bitmapFill.source = backgroundImage;
			bitmapFill.fillMode = getStyle("backgroundImageResizeMode");
			bitmapFill.alpha = getStyle("backgroundAlpha");
			
			background.fill = bitmapFill;
		}
		else
		{
			var bkgdColor:Number = getStyle("backgroundColor");
			var bkgdAlpha:Number = getStyle("backgroundAlpha");
			
			if (isNaN(bkgdAlpha))
				bkgdAlpha = 1;
			
			if (!isNaN(bkgdColor))
				background.fill = new SolidColor(bkgdColor, bkgdAlpha);
			else
				background.fill = new SolidColor(0, 0);
			
			background.radiusX = cornerRadius;
			background.radiusY = cornerRadius;
		}
		
		var borderColor:Number = getStyle("borderColor");
		var borderAlpha:Number = getStyle("borderAlpha");
		var borderWeight:Number = getStyle("borderWeight");
		
		if (isNaN(borderAlpha))
			borderAlpha = 1;
		
		if (!isNaN(borderColor))
			border.stroke = new SolidColorStroke(borderColor, borderWeight, borderAlpha);
		else
			border.stroke = new SolidColorStroke(0, 0, 0);
		
		border.radiusX = cornerRadius;
		border.radiusY = cornerRadius;
		
		super.updateDisplayList(unscaledWidth, unscaledHeight);
		
		if (getStyle("dropShadowVisible") == true)
		{
			if (!dropShadow)
				dropShadow = new RectangularDropShadow();
			
			dropShadow.alpha = 0.4;
			dropShadow.angle = 90;
			dropShadow.color = 0x000000;
			dropShadow.distance = 5;
			
			dropShadow.tlRadius = cornerRadius;
			dropShadow.trRadius = cornerRadius;
			dropShadow.blRadius = cornerRadius;
			dropShadow.brRadius = cornerRadius;
			
			graphics.lineStyle();
			dropShadow.drawShadow(graphics, 0, 0, unscaledWidth, unscaledHeight);
		}	
	}
	
	//--------------------------------------------------------------------------
	//
	//  Overridden Public :: Methods
	//
	//--------------------------------------------------------------------------
	
	/**
	 * Since we don't want a bunch of inheriting styles, the default behavior
	 * of the ComponentBorder's skin is to automatically use the owner's styles.
	 */
	override public function getStyle(styleProp:String):*
	{
		return IStyleClient(UIComponent(parent).owner).getStyle(styleProp);
	}		
}
}