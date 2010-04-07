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

import spark.components.supportClasses.TextBase;
import spark.primitives.BitmapImage;

/**
 * The MessageBarBase class is a common base for controls with borders and 
 * an icon and label.
 * 
 * @author Michael Schmalle
 * @copyright Teoti Graphix, LLC
 * @productversion 1.0
 * 
 * @mxml
 */
public class MessageBarBase extends BarBase
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
	 * The <code>BitmapImage</code> skin part that displays the 
	 * <code>icon</code> Class.
	 */
	public var iconDisplay:BitmapImage; // change type to IVisualElement
	
	//----------------------------------
	//  labelDisplay
	//----------------------------------
	
	[SkinPart(required="true")]
	
	/**
	 * The <code>TextBase</code> skin part that displays the <code>label</code> 
	 * string.
	 */
	public var labelDisplay:TextBase;
	
	//--------------------------------------------------------------------------
	//
	//  Public :: Properties
	//
	//--------------------------------------------------------------------------
	
	//----------------------------------
	//  titleIcon
	//----------------------------------
	
	/**
	 * @private
	 */
	private var _icon:Class;
	
	/**
	 * The message icon.
	 * 
	 * @mxml null
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
		
		// synchronous push
		commitIcon();
	}
	
	//----------------------------------
	//  title
	//----------------------------------
	
	/**
	 * @private
	 */
	private var _label:String;
	
	/**
	 * The message label.
	 * 
	 * @mxml
	 */
	public function get label():String
	{
		return _label;
	}
	
	/**
	 * @private
	 */
	public function set label(value:String):void
	{
		if (_label == value)
			return;
		
		_label = value;
		
		// synchronous push
		commitLabel();
	}
	
	//--------------------------------------------------------------------------
	//
	//  Constructor
	//
	//--------------------------------------------------------------------------
	
	/**
	 * Constructor.
	 */
	public function MessageBarBase()
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
		else if (instance == labelDisplay)
		{
			commitLabel();
		}		
	}
	
	//--------------------------------------------------------------------------
	//
	//  Protected Commit :: Methods
	//
	//--------------------------------------------------------------------------
	
	/**
	 * Commits the <code>label</code> property.
	 */
	protected function commitLabel():void
	{
		if (!labelDisplay)
			return;
		
		labelDisplay.text = _label;
	}
	
	/**
	 * Commits the <code>icon</code> property.
	 */
	protected function commitIcon():void
	{
		if (!iconDisplay)
			return;
		
		iconDisplay.source = _icon;
		
		// XXX Use IconUtil.setSource()
		var show:Boolean = (_icon != null);
		iconDisplay.visible = show;
		iconDisplay.includeInLayout = show;
	}	
}
}