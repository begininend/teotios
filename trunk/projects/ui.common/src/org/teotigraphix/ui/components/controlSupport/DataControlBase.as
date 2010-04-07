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

import mx.core.IDataRenderer;
import mx.core.IVisualElement;
import mx.events.FlexEvent;

import org.teotigraphix.ui.api.control.IControlRenderer;
import org.teotigraphix.ui.utils.IconUtil;

import spark.components.supportClasses.SkinnableComponent;
import spark.components.supportClasses.TextBase;
import spark.utils.LabelUtil;

//--------------------------------------
//  SkinStates
//--------------------------------------

/**
 * The normal skin state.
 */
[SkinState("normal")]

/**
 * The disabled skin state.
 */
[SkinState("disabled")]

//--------------------------------------
//  Class
//--------------------------------------

/**
 * The DataControlBase class takes a data object and passes the value 
 * to the <code>dataRenderer</code> skin part which is an 
 * <code>IDataRenderer</code>.
 * 
 * <p>Consider this class abstract, there is no default skin.</p>
 * 
 * @author Michael Schmalle
 * @copyright Teoti Graphix, LLC
 * @productversion 1.0
 * 
 * @mxml
 */
public class DataControlBase extends SkinnableComponent
	implements IControlRenderer
{
	//--------------------------------------------------------------------------
	//
	//  Public SkinPart :: Variables
	//
	//--------------------------------------------------------------------------
	
	//----------------------------------
	//  dataRenderer
	//----------------------------------
	
	[SkinPart(required="false")]
	
	/**
	 * The dataRenderer is the default control that will render the data 
	 * passed to this component.
	 */
	public var dataRenderer:IDataRenderer;
	
	//----------------------------------
	//  labelDisplay
	//----------------------------------
	
	[SkinPart(required="false")]
	
	/**
	 * The skin part that displays the label property.
	 */
	public var labelDisplay:TextBase;
	
	//----------------------------------
	//  iconDisplay
	//----------------------------------
	
	[SkinPart(required="false")]
	
	/**
	 * The skin part that displays the icon property.
	 */
	public var iconDisplay:IVisualElement;
	
	//--------------------------------------------------------------------------
	//
	//  IControlRenderer API :: Properties
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
	 * @copy org.teotigraphix.ui.api.control.IControlRenderer#icon
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
		
		if (iconDisplay)
			IconUtil.setSource(iconDisplay, _icon, true);
	}
	
	//----------------------------------
	//  label
	//----------------------------------
	
	/**
	 * @private
	 */
	private var _label:String;
	
	/**
	 * @copy org.teotigraphix.ui.api.control.IControlRenderer#label
	 * 
	 * @mxml 
	 * @default ""
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
		
		if (labelDisplay)
			labelDisplay.text = _label;
	}
	
	//--------------------------------------------------------------------------
	//
	//  IDataRenderer API :: Properties
	//
	//--------------------------------------------------------------------------
	
	//----------------------------------
	//  data
	//----------------------------------
	
	/**
	 * @private
	 */
	private var _data:Object;
	
	[Bindable("dataChange")]
	
	/**
	 * The data to render or edit.
	 */
	public function get data():Object
	{
		return _data;
	}
	
	/**
	 * @private
	 */	
	public function set data(value:Object):void
	{
		_data = value;
		
		label = LabelUtil.itemToLabel(_data);
		icon = IconUtil.itemToIcon(_data) as Class;		
		
		dispatchEvent(new FlexEvent(FlexEvent.DATA_CHANGE));
	}
	
	//--------------------------------------------------------------------------
	//
	//  Constructor
	//
	//--------------------------------------------------------------------------
	
	/**
	 * Constructor.
	 */
	public function DataControlBase()
	{
		super();
	}
	
	//--------------------------------------------------------------------------
	//
	//  Overriden Protected :: Methods
	//
	//--------------------------------------------------------------------------
	
	/**
	 * @private
	 */
	override protected function partAdded(partName:String, instance:Object):void
	{
		super.partAdded(partName, instance);
		
		// catch all controls that can digest the data property
		if (instance == dataRenderer)
		{
			dataRenderer.data = _data;
		}
		
		if (instance == iconDisplay)
		{
			IconUtil.setSource(iconDisplay, _icon, true);
		}
		
		if (instance == labelDisplay)
		{
			labelDisplay.text = _label;
		}		
	}
	
	/**
	 * @private
	 */
	override protected function partRemoved(partName:String, instance:Object):void
	{
		super.partRemoved(partName, instance);
		
		if (instance == dataRenderer)
		{
			dataRenderer.data = null;
		}
	}
}
}