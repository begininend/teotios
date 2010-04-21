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

package org.teotigraphix.ui.components.controlSupport
{

import mx.core.IFactory;
import mx.core.IVisualElement;

import org.teotigraphix.ui.api.control.IBar;
import org.teotigraphix.ui.components.componentSupport.ComponentBase;

import spark.components.Group;
import spark.components.supportClasses.Skin;

//--------------------------------------
//  Styles
//--------------------------------------

/**
 * The header colors, if not defined the <code>backgroundColor</code>
 * will be used.
 * 
 * @mxml
 */
[Style(name="barColors",type="Array",arrayType="uint")]

/**
 * The header alphas, if not defined the <code>backgroundAlpha</code>
 * will be used.
 * 
 * @mxml
 */
[Style(name="barAlphas",type="Array",arrayType="backgroundImage")]

/**
 * The divider bar color.
 * 
 * @mxml
 */
[Style(name="barDividerColor",type="uint",format="Color")]

/**
 * The bar highlight alphas.
 * 
 * @mxml
 */
[Style(name="barHighlightAlphas",type="Array",arrayType="Number")]

/**
 * The bar highlight colors.
 * 
 * @mxml
 */
[Style(name="barHighlightColors",type="Array",arrayType="uint")]

/**
 * The layout gap of the contentGroup.
 * 
 * @mxml 2
 */
[Style(name="gap",type="backgroundImage")]

/**
 * The vertical alignment of the contentGroup.
 *  
 * @mxml top|middle|bottom|contentJustify|justify
 * @default middle
 */
[Style(name="verticalAlign",type="String",enumeration="top,middle,bottom,contentJustify,justify")]

/**
 * The horizontal alignment of the contentGroup.
 * 
 * @mxml left|center|right|contentJustify|justify
 * @default left
 */
[Style(name="horizontalAlign",type="String",enumeration="left,center,right,contentJustify,justify")]

//--------------------------------------
//  SkinStates
//--------------------------------------

// The "normal" state is "top"

/**
 * The right layout state.
 */
[SkinState("right")]

/**
 * The bottom layout state.
 */
[SkinState("bottom")]

/**
 * The left layout state.
 */
[SkinState("left")]

//--------------------------------------
//  Class
//--------------------------------------

/**
 * @author Michael Schmalle
 * @copyright Teoti Graphix, LLC
 * @productversion 1.0
 */
public class BarBase extends ComponentBase implements IBar
{
	//--------------------------------------------------------------------------
	//
	//  Public SkinPart :: Variables
	//
	//--------------------------------------------------------------------------
	
	//----------------------------------
	//  leftAdditions
	//----------------------------------
	
	[SkinPart(required="false")]
	
	/**
	 * Content for the <code>left</code> or <code>top</code> of the bar.
	 */
	public var leftAdditionsDisplay:Group;
	
	//----------------------------------
	//  contentDisplay
	//----------------------------------
	
	[SkinPart(required="false")]
	
	/**
	 * Content for the <code>center</code> of the bar.
	 */
	public var centerAdditionsDisplay:Group;
	
	//----------------------------------
	//  rightAdditions
	//----------------------------------
	
	[SkinPart(required="false")]
	
	/**
	 * Content for the <code>right</code> or <code>bottom</code> of the bar.
	 */
	public var rightAdditionsDisplay:Group;
	
	//--------------------------------------------------------------------------
	//
	//  IBar API :: Properties
	//
	//--------------------------------------------------------------------------
	
	//----------------------------------
	//  placement
	//----------------------------------
	
	[Inspectable(category="Layout Constraints",enumeration="top,right,bottom,left")]
	
	/**
	 * @private
	 */
	private var _placement:String;
	
	/**
	 * @copy org.teotigraphix.ui.api.control.IBar#placement
	 * 
	 * @default top
	 * @mxml top|right|bottom|left
	 */
	public function get placement():String
	{
		return _placement;
	}
	
	/**
	 * @private
	 */	
	public function set placement(value:String):void
	{
		if (_placement == value)
			return;
		
		_placement = value;
		
		if (skin)
		{
			skin.invalidateSize();
			skin.invalidateDisplayList();
		}
		
		invalidateSkinState();
	}
	
	//--------------------------------------------------------------------------
	//
	//  Public :: Properties
	//
	//--------------------------------------------------------------------------
	
	//----------------------------------
	//  leftAdditions
	//----------------------------------
	
	[ArrayElementType("mx.core.IVisualElement")]
	
	/**
	 * @private
	 */
	private var _leftAdditions:Array;
	
	/**
	 * An Array of IVisualElements to add to the <code>leftAdditionsGroup</code> 
	 * group.
	 */
	public function get leftAdditions():Array
	{
		return _leftAdditions;
	}
	
	/**
	 * @private
	 */
	public function set leftAdditions(value:Array):void
	{
		_leftAdditions = value;
		// TODO (mschmalle) remove and add addition content
	}
	
	//----------------------------------
	//  rightAdditions
	//----------------------------------
	
	[ArrayElementType("mx.core.IVisualElement")]
	
	/**
	 * @private
	 */
	private var _rightAdditions:Array;	
	
	/**
	 * An Array of IVisualElements to add to the <code>rightAdditionsGroup</code> 
	 * group.
	 */
	public function get rightAdditions():Array
	{
		return _rightAdditions;
	}
	
	/**
	 * @private
	 */
	public function set rightAdditions(value:Array):void
	{
		_rightAdditions = value;
		// TODO (mschmalle) remove and add addition content
	}
	
	//--------------------------------------------------------------------------
	//
	//  Constructor
	//
	//--------------------------------------------------------------------------
	
	/**
	 * Constructor.
	 */
	public function BarBase()
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
	protected override function createChildren():void
	{
		super.createChildren();
		
		addAdditions();
	}
	
	/**
	 * @private
	 */
	override protected function partAdded(partName:String, instance:Object):void
	{
		super.partAdded(partName, instance);
	}
	
	/**
	 * @private
	 */
	override protected function partRemoved(partName:String, instance:Object):void
	{
		super.partRemoved(partName, instance);
	}
	
	/**
	 * @private
	 */
	override protected function getCurrentSkinState():String
	{
		if (!enabled)
			return "disabled";
		
		if (_placement == "top")
			return "normal";
		
		return _placement;
	}	
	
	//--------------------------------------------------------------------------
	//
	//  Public :: Methods
	//
	//--------------------------------------------------------------------------
	
	/**
	 * Adds an addition to the bar in the <strong>left</strong> or 
	 * <strong>right</strong> placement.
	 * 
	 * @param instance The visual element to add.
	 * @param position The additions position (<strong>left</strong> |
	 * <strong>right</strong>).
	 */
	public function addAddition(instance:IVisualElement, 
								position:String):void
	{
		if (position == "left")
		{
			leftAdditionsDisplay.includeInLayout = true;
			leftAdditionsDisplay.addElement(instance);
		}
		else if (position == "right")
		{
			rightAdditionsDisplay.includeInLayout = true;
			rightAdditionsDisplay.addElement(instance);
		}
	}
	
	/**
	 * @private
	 */
	public function removeAddition(instance:IVisualElement):void
	{
		// TODO (mschmalle) implement removeAddition()
	}
	
	//--------------------------------------------------------------------------
	//
	//  Protected :: Methods
	//
	//--------------------------------------------------------------------------
	
	/**
	 * @private
	 */
	protected function addAdditions():void
	{
		var i:int;
		var element:IVisualElement;
		
		if (rightAdditions)
		{
			for (i = 0; i < rightAdditions.length; i++)
			{
				element = rightAdditions[i] as IVisualElement;
				addAddition(element, "right");
			}
		}
		
		if (leftAdditions)
		{
			for (i = 0; i < leftAdditions.length; i++)
			{
				element = leftAdditions[i] as IVisualElement;
				addAddition(element, "left");
			}
		}
	}	
}
}