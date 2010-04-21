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

// TODO (mschmalle) Make the ToggleButton, anyway to share the logic?

import mx.core.IVisualElement;

import org.teotigraphix.ui.skins.ButtonSkin;
import org.teotigraphix.ui.utils.IconUtil;
import org.teotigraphix.ui.utils.StyleUtil;

import spark.components.Button;

//--------------------------------------
//  Styles
//--------------------------------------

/**
 * The gap between the icon and label.
 * 
 * @mxml 2
 */
[Style(name="gap",type="int",format="Length")]

/**
 * The layout padding top.
 * 
 * @mxml 2
 */
[Style(name="paddingTop",type="Number")]

/**
 * The layout padding right.
 * 
 * @mxml 10
 */
[Style(name="paddingRight",type="Number")]

/**
 * The layout padding bottom.
 * 
 * @mxml 10
 */
[Style(name="paddingBottom",type="Number")]

/**
 * The layout padding left.
 * 
 * @mxml 2
 */
[Style(name="paddingLeft",type="Number")]

//--------------------------------------
//  Class
//--------------------------------------

/**
 * The advanced Button implementation that adds an icon and labelPlacement.
 * 
 * @author Michael Schmalle
 * @copyright Teoti Graphix, LLC
 * @productversion 1.0
 */
public class Button extends spark.components.Button
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
	 * @private
	 */
	private static function initializeStyles():void
	{
		if (stylesInitialized)
			return;
		else
			stylesInitialized = true;
		
		StyleUtil.create(
			"org.teotigraphix.ui.components.Button",
			function ():void {
				this.skinClass = ButtonSkin;
				
				this.gap = 2;
				
				this.paddingTop = 2;
				this.paddingRight = 10;
				this.paddingBottom = 2;
				this.paddingLeft = 10;
			});
	}
	
	//--------------------------------------------------------------------------
	//
	//  Public SkinPart :: Variables
	//
	//--------------------------------------------------------------------------
	
	//----------------------------------
	//  iconDisplay
	//----------------------------------
	
	[SkinPart(required="false")]
	
	/**
	 * The skin part that will display the <code>icon</code> graphic.
	 */
	public var iconDisplay:IVisualElement;
	
	//--------------------------------------------------------------------------
	//
	//  Public :: Properties
	//
	//--------------------------------------------------------------------------
	
	//----------------------------------
	//  icon
	//----------------------------------
	
	/**
	 * @private
	 */
	private var _icon:Class;
	
	/**
	 * The Class icon graphic.
	 * 
	 * @mxml Class
	 * @default null
	 */
	public function get icon():Class
	{
		return _icon;
	}
	
	/**
	 * @private
	 */	
	public function set icon(value:Class):void
	{
		if (_icon == value)
			return;
		
		_icon = value;
		
		commitIcon();
	}
	
	//----------------------------------
	//  labelPlacement
	//----------------------------------
	
	/**
	 * @private
	 */
	private var _labelPlacement:String;
	
	/**
	 * The placement of the label reletive to icon (if present).
	 * 
	 * @mxml top|right|bottom|left
	 * @default right
	 */
	public function get labelPlacement():String
	{
		return _labelPlacement;
	}
	
	/**
	 * @private
	 */	
	public function set labelPlacement(value:String):void
	{
		if (_labelPlacement == value)
			return;
		
		_labelPlacement = value;
		
		if (skin)
		{
			skin.invalidateSize();
			skin.invalidateDisplayList();
		}
	}
	
	//--------------------------------------------------------------------------
	//
	//  Constructor
	//
	//--------------------------------------------------------------------------
	
	/**
	 * Constructor.
	 */
	public function Button()
	{
		super();
		
		initializeStyles();
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
		
		if (instance == iconDisplay)
		{
			commitIcon();
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
		
		//StyleUtil.instance.styleToProperty(this, "icon");
		
		var allStyles:Boolean = styleProp == null || styleProp == "styleName";
		
		if (allStyles || styleProp == "icon")
		{
			var cls:Class = getStyle("icon");
			if (cls != null)
				icon = cls;
		}
		
		if (allStyles || styleProp == "labelPlacement")
		{
			var placement:String = getStyle("labelPlacement");
			if (placement != null)
				labelPlacement = placement;
		}		
	}
	
	//--------------------------------------------------------------------------
	//
	//  Protected :: Methods
	//
	//--------------------------------------------------------------------------
		
	/**
	 * Commits the <code>icon</code> property.
	 */
	protected function commitIcon():void
	{
		IconUtil.setSource(iconDisplay, _icon, true);
	}	
}
}