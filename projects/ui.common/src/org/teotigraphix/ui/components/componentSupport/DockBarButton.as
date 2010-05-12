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

import mx.core.IVisualElement;

import org.teotigraphix.ui.utils.IconUtil;

import spark.components.ButtonBarButton;

/**
 * The button item renderer for the <code>DockBar</code>.
 * 
 * @author Michael Schmalle
 * @copyright Teoti Graphix, LLC
 * @productversion 1.0
 */
public class DockBarButton extends ButtonBarButton
{
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
	 * The skin part that displays the <code>icon</code>.
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
	 * The icon image used for the button's icon.
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
	
	//--------------------------------------------------------------------------
	//
	//  Constructor
	//
	//--------------------------------------------------------------------------
	
	/**
	 * Constructor.
	 */
	public function DockBarButton()
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
	override protected function partAdded(partName:String, instance:Object):void
	{
		super.partAdded(partName, instance);
		
		if (instance == iconDisplay)
		{
			commitIcon();
		}
	}
	
	/**
	 * @private
	 */
	override protected function partRemoved(partName:String, instance:Object):void
	{
		super.partRemoved(partName, instance);
		
		if (instance == iconDisplay)
		{
			IconUtil.setSource(iconDisplay, null);
		}		
	}
	
	//--------------------------------------------------------------------------
	//
	//  Overridden Protected :: Methods
	//
	//--------------------------------------------------------------------------
	
	/**
	 * Commits this <code>icon</code> property to the <code>iconDisplay</code>.
	 */
	protected function commitIcon():void
	{
		if (!iconDisplay)
			return;
		
		IconUtil.setSource(iconDisplay, _icon);
	}
}
}