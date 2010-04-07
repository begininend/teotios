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

package org.teotigraphix.ui.components.componentSupport
{

import flash.utils.Dictionary;

import mx.core.IVisualElement;

import spark.components.Group;
import spark.components.supportClasses.SkinnableComponent;

//--------------------------------------
//  Styles
//--------------------------------------

//  Border Styles

/**
 *  Alpha level of the color defined by the <code>backgroundColor</code>
 *  property, or the image file defined by the <code>backgroundImage</code>
 *  style.
 *  Valid values range from 0.0 to 1.0. 
 *  
 *  @default 1.0
 */
[Style(name="backgroundAlpha", type="backgroundImage", inherit="no")]

/**
 *  Background color of the container.
 *  
 *  The default value is <code>undefined</code>, which means it is not set.
 *  If both this style and the <code>backgroundImage</code> style
 *  are <code>undefined</code>, the component has a transparent background.
 */
[Style(name="backgroundColor", type="uint", format="Color", inherit="no")]

/**
 *  Background image of a container.  This can be an absolute or relative
 *  URL or class.  You can either have both a <code>backgroundColor</code> and a
 *  <code>backgroundImage</code> set at the same time. The background image is displayed
 *  on top of the background color.
 *  The default value is <code>undefined</code>, meaning "not set".
 *  If this style and the <code>backgroundColor</code> style are undefined,
 *  the component has a transparent background.
 */
[Style(name="backgroundImage", type="Object", format="File", inherit="no")]

/**
 *  The resizeMode determines how the background image fills in the dimensions. If you set the value
 *  of this property in a tag, use the string (such as "repeat"). If you set the value of 
 *  this property in ActionScript, use the constant (such as <code>BitmapResizeMode.NOSCALE</code>).
 * 
 *  When set to <code>BitmapResizeMode.NOSCALE</code> ("noScale"), the image
 *  ends at the edge of the region.
 * 
 *  When set to <code>BitmapResizeMode.REPEAT</code> ("repeat"), the image 
 *  repeats to fill the region.
 *
 *  When set to <code>BitmapResizeMode.SCALE</code> ("scale"), the image
 *  stretches to fill the region.
 * 
 *  @default scale
 */
[Style(name="backgroundImageResizeMode", type="String", enumeration="scale,noScale,repeat", inherit="no")]

/**
 *  Alpha level of the color defined by the <code>borderColor</code> style.
 *  
 *  Valid values range from 0.0 to 1.0. 
 *  
 *  @default 1.0
 */
[Style(name="borderAlpha", type="backgroundImage", inherit="no")]

/**
 *  Color of the border.
 *  The default value depends on the component class;
 *  if not overridden for the class, the default value is <code>0xB7BABC</code>.
 */
[Style(name="borderColor", type="uint", format="Color", inherit="no")]

/**
 *  Bounding box style.
 *  The possible values are <code>"solid"</code> and <code>"inset"</code>.
 * 
 *  @default solid
 */
[Style(name="borderStyle", type="String", enumeration="inset,solid", inherit="no")]

/**
 *  Determines if the border is visible or not. If true, then no border will be visible,
 *  except a border set via the borderStroke property. 
 *   
 *  @default true
 */
[Style(name="borderVisible", type="Boolean", inherit="no")]

/**
 *  The stroke weight for the border. 
 *
 *  @default 1
 */
[Style(name="borderWeight", type="backgroundImage", format="Length", inherit="no")]

/**
 *  Boolean property that specifies whether the container has a visible
 *  drop shadow.
 *  
 *  @default false
 */
[Style(name="dropShadowVisible", type="Boolean", inherit="no")]

//  Padding Styles

/**
 * The layout padding top.
 * 
 * @default 0
 */
[Style(name="paddingTop",type="backgroundImage")]

/**
 * The layout padding right.
 * 
 * @default 0
 */
[Style(name="paddingRight",type="backgroundImage")]

/**
 * The layout padding bottom.
 * 
 * @default 0
 */
[Style(name="paddingBottom",type="backgroundImage")]

/**
 * The layout padding left.
 * 
 * @default 0
 */
[Style(name="paddingLeft",type="backgroundImage")]

//  Radius Styles

/**
 * The corner radius of the background.
 * 
 * @default 0
 */
[Style(name="cornerRadius", type="backgroundImage", inherit="no")]

/**
 * The top left corner radius of the background.
 * 
 * @default 0
 */
[Style(name="topLeftRadius", type="backgroundImage", inherit="no")]

/**
 * The top right corner radius of the background.
 * 
 * @default 0
 */
[Style(name="topRightRadius", type="backgroundImage", inherit="no")]

/**
 * The bottom left corner radius of the background.
 * 
 * @default 0
 */
[Style(name="bottomLeftRadius", type="backgroundImage", inherit="no")]

/**
 * The bottom right corner radius of the background.
 * 
 * @default 0
 */
[Style(name="bottomRightRadius", type="backgroundImage", inherit="no")]

//--------------------------------------
//  States
//--------------------------------------

/**
 * The enabled state of the control bar.
 */
[SkinState("normal")]

/**
 * The disabled state of the control bar <code>enabled = false</code>.
 */
[SkinState("disabled")]

//--------------------------------------
//  Class
//--------------------------------------

/**
 * @author Michael Schmalle
 * @copyright Teoti Graphix, LLC
 * @productversion 1.0
 */
public class ComponentBase extends SkinnableComponent
{
	//--------------------------------------------------------------------------
	//
	//  Public SkinPart :: Variables
	//
	//--------------------------------------------------------------------------
	
	//----------------------------------
	//  borderDisplay
	//----------------------------------
	
	[SkinPart(required="false")]
	
	/**
	 * The skin part used to render the component's border.
	 */
	public var borderDisplay:IVisualElement;
	
	//----------------------------------
	//  contentDisplay
	//----------------------------------
	
	[SkinPart(required="false")]
	
	/**
	 * The <code>Group</code> that contains children other than the chrome
	 * children.
	 */
	public var contentDisplay:Group;
	
	//--------------------------------------------------------------------------
	//
	//  Constructor
	//
	//--------------------------------------------------------------------------
	
	/**
	 * Constructor.
	 */
	public function ComponentBase()
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
	override protected function getCurrentSkinState():String
	{
		if (!enabled)
			return "disabled";
		
		return "normal";
	}
}
}