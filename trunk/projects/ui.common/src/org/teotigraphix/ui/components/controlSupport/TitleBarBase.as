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

import flash.events.IEventDispatcher;
import flash.events.MouseEvent;

import org.teotigraphix.ui.api.ITitleBar;
import org.teotigraphix.ui.events.TitleBarEvent;

import spark.components.supportClasses.ButtonBase;
import spark.components.supportClasses.TextBase;
import spark.components.supportClasses.ToggleButtonBase;
import spark.primitives.BitmapImage;

//--------------------------------------
//  Events
//--------------------------------------

/**
 * @eventType org.teotigraphix.ui.events.TitleBarEvent#BUTTON_CLICK
 */
[Event(name="buttonClick",type="org.teotigraphix.ui.events.TitleBarEvent")]

/**
 * The TitleBarBase class is a concrete implementation of the 
 * <code>ITitleBar</code> interface and a starting point for developers that 
 * want to subclass the TitleBar implementation without linking styles and 
 * skins into their new subclass.
 * 
 * <p>If the linking of styles and skins does not matter, subclassing the 
 * TitleBar will give greater flexibility with styling and skinning.</p>
 * 
 * <p>The TitleBarBase class does not implement the 
 * <code>ControlBarBase#contentGroup</code>, it's children are basically
 * chrome children with no dynamic content.</p>
 * 
 * @author Michael Schmalle
 * @copyright Teoti Graphix, LLC
 * @productversion 1.0
 * @mxml
 */
public class TitleBarBase extends BarBase implements ITitleBar
{
	//--------------------------------------------------------------------------
	//
	//  Private :: Variables
	//
	//--------------------------------------------------------------------------
	
	/**
	 * @private
	 */
	private var titlePropertiesChanged:Boolean = false;
	
	/**
	 * @private
	 */
	private var buttonsChanged:Boolean = false;
	
	//--------------------------------------------------------------------------
	//
	//  Public SkinPart :: Variables
	//
	//--------------------------------------------------------------------------
	
	//----------------------------------
	//  titleIconDisplay
	//----------------------------------
	
	[SkinPart(required="false")]
	
	/**
	 * The <code>BitmapImage</code> skin part that displays the 
	 * <code>titleIcon</code> Class.
	 */
	public var titleIconDisplay:BitmapImage;
	
	//----------------------------------
	//  titleDisplay
	//----------------------------------
	
	[SkinPart(required="true")]
	
	/**
	 * The <code>TextBase</code> skin part that displays the <code>title</code> 
	 * string.
	 */
	public var titleDisplay:TextBase;
	
	//----------------------------------
	//  minimizeButtonDisplay
	//----------------------------------
	
	[SkinPart(required="false")]
	
	/**
	 * The <code>ButtonBase</code> skin part that displays the minimizable action
	 * control.
	 */
	public var minimizeButtonDisplay:ToggleButtonBase;
	
	//----------------------------------
	//  maximizeButtonDisplay
	//----------------------------------
	
	[SkinPart(required="false")]
	
	/**
	 * The <code>ButtonBase</code> skin part that displays the maximizable action
	 * control.
	 */
	public var maximizeButtonDisplay:ToggleButtonBase;
	
	//----------------------------------
	//  closeButtonDisplay
	//----------------------------------
	
	[SkinPart(required="false")]
	
	/**
	 * The <code>ButtonBase</code> skin part that displays the closable action
	 * control.
	 */
	public var closeButtonDisplay:ButtonBase;
	
	//--------------------------------------------------------------------------
	//
	//  ITitleBar API :: Properties
	//
	//--------------------------------------------------------------------------
	
	//----------------------------------
	//  titleIcon
	//----------------------------------
	
	/**
	 * @private
	 */
	private var _titleIcon:Class;
	
	/**
	 * @copy org.teotigraphix.ui.api.ITitleBar#titleIcon
	 * @mxml null
	 */
	public function get titleIcon():Class
	{
		return _titleIcon;
	}
	
	/**
	 * @private
	 */
	public function set titleIcon(value:Class):void
	{
		if (_titleIcon == value)
			return;
		
		_titleIcon = value;
		
		titlePropertiesChanged = true;
		invalidateProperties();
	}
	
	//----------------------------------
	//  title
	//----------------------------------
	
	/**
	 * @private
	 */
	private var _title:String;
	
	/**
	 * @copy org.teotigraphix.ui.api.ITitleBar#title
	 * @mxml
	 */
	public function get title():String
	{
		return _title;
	}
	
	/**
	 * @private
	 */
	public function set title(value:String):void
	{
		if (_title == value)
			return;
		
		_title = value;
		
		titlePropertiesChanged = true;
		invalidateProperties();
	}
	
	//----------------------------------
	//  showMinimizeButton
	//----------------------------------
	
	/**
	 * @private
	 */
	private var _showMinimizeButton:Boolean;
	
	/**
	 * @copy org.teotigraphix.ui.api.ITitleBar#showMinimizeButton
	 * @mxml 
	 */
	public function get showMinimizeButton():Boolean
	{
		return _showMinimizeButton;
	}
	
	/**
	 * @private
	 */
	public function set showMinimizeButton(value:Boolean):void
	{
		if (_showMinimizeButton == value)
			return;
		
		_showMinimizeButton = value;
		
		buttonsChanged = true;
		invalidateProperties();
	}
	
	//----------------------------------
	//  showMaximizeButton
	//----------------------------------
	
	/**
	 * @private
	 */
	private var _showMaximizeButton:Boolean;
	
	/**
	 * @copy org.teotigraphix.ui.api.ITitleBar#showMaximizeButton
	 * @mxml
	 */
	public function get showMaximizeButton():Boolean
	{
		return _showMaximizeButton;
	}
	
	/**
	 * @private
	 */
	public function set showMaximizeButton(value:Boolean):void
	{
		if (_showMaximizeButton == value)
			return;
		
		_showMaximizeButton = value;
		
		buttonsChanged = true;
		invalidateProperties();
	}
	
	//----------------------------------
	//  showCloseButton
	//----------------------------------
	
	/**
	 * @private
	 */
	private var _showCloseButton:Boolean;
	
	/**
	 * @copy org.teotigraphix.ui.api.ITitleBar#showCloseButton
	 * @mxml
	 */
	public function get showCloseButton():Boolean
	{
		return _showCloseButton;
	}
	
	/**
	 * @private
	 */
	public function set showCloseButton(value:Boolean):void
	{
		if (_showCloseButton == value)
			return;
		
		_showCloseButton = value;
		
		buttonsChanged = true;
		invalidateProperties();
	}
	
	//--------------------------------------------------------------------------
	//
	//  Constructor
	//
	//--------------------------------------------------------------------------
	
	/**
	 * Constructor.
	 */
	public function TitleBarBase()
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
	override protected function commitProperties():void
	{
		super.commitProperties();
		
		if (titlePropertiesChanged)
		{
			commitTitleProperties();
			titlePropertiesChanged = false;
		}
		
		if (buttonsChanged)
		{
			commitButtonVisibilities();
			buttonsChanged = false;
		}		
	}
	
	/**
	 * @private
	 */
	override protected function partAdded(partName:String, instance:Object):void
	{
		super.partAdded(partName, instance);
		
		if (instance == titleIconDisplay || instance == titleDisplay)
		{
			commitTitleProperties();
		}
		else if (instance == minimizeButtonDisplay)
		{
			addButtonClickHandlers(minimizeButtonDisplay);
			commitButtonVisibilities();
		}
		else if (instance == maximizeButtonDisplay)
		{
			addButtonClickHandlers(maximizeButtonDisplay);
			commitButtonVisibilities();
		}
		else if (instance == closeButtonDisplay)
		{
			addButtonClickHandlers(closeButtonDisplay);
			commitButtonVisibilities();
		}
	}
	
	/**
	 * @private
	 */
	override protected function partRemoved(partName:String, instance:Object):void
	{
		super.partRemoved(partName, instance);
		
		if (instance == titleIconDisplay)
		{
		}
		else if (instance == titleDisplay)
		{
		}
		else if (instance == minimizeButtonDisplay)
		{
			removeButtonClickHandlers(minimizeButtonDisplay);
		}
		else if (instance == maximizeButtonDisplay)
		{
			removeButtonClickHandlers(maximizeButtonDisplay);
		}
		else if (instance == closeButtonDisplay)
		{
			removeButtonClickHandlers(closeButtonDisplay);
		}
	}
	
	//--------------------------------------------------------------------------
	//
	//  Protected Commit :: Methods
	//
	//--------------------------------------------------------------------------
	
	protected function commitTitleProperties():void
	{
		if (titleIconDisplay)
		{
			titleIconDisplay.source = _titleIcon;
			
			var show:Boolean = (_titleIcon != null);
			titleIconDisplay.visible = show;
			titleIconDisplay.includeInLayout = show;
		}
		
		if (titleDisplay)
		{
			titleDisplay.text = _title;
		}
	}	
	
	protected function commitButtonVisibilities():void
	{
		if (minimizeButtonDisplay)
		{
			minimizeButtonDisplay.visible = _showMinimizeButton;
			minimizeButtonDisplay.includeInLayout = _showMinimizeButton;
		}
		
		if (maximizeButtonDisplay)
		{
			maximizeButtonDisplay.visible = _showMaximizeButton;
			maximizeButtonDisplay.includeInLayout = _showMaximizeButton;
		}
		
		if (closeButtonDisplay)
		{
			closeButtonDisplay.visible = _showCloseButton;
			closeButtonDisplay.includeInLayout = _showCloseButton;
		}
	}
	
	//--------------------------------------------------------------------------
	//
	//  Protected :: Methods
	//
	//--------------------------------------------------------------------------
	
	/**
	 * Add <code>MouseEvent</code> handlers to a button.
	 * 
	 * @param button An <code>IEventDispatcher</code> button.
	 */
	protected function addButtonClickHandlers(button:IEventDispatcher):void
	{
		button.addEventListener(MouseEvent.CLICK, button_clickHandler);
	}
	
	/**
	 * Remove <code>MouseEvent</code> handlers from a button.
	 * 
	 * @param button An <code>IEventDispatcher</code> button.
	 */
	protected function removeButtonClickHandlers(button:IEventDispatcher):void
	{
		button.removeEventListener(MouseEvent.CLICK, button_clickHandler);
	}
	
	//--------------------------------------------------------------------------
	//
	//  Protected :: Handlers
	//
	//--------------------------------------------------------------------------
	
	/**
	 * Handles the <code>MouseEvent.CLICK</code> event on a button.
	 * 
	 * @param event A <code>MouseEvent</code>.
	 * @event com.teotigraphix.ui.events.TitleBarEvent#BUTTON_CLICK
	 */
	protected function button_clickHandler(event:MouseEvent):void
	{
		var button:ButtonBase = event.target as ButtonBase;
		var selected:Boolean = false;
		
		if (button is ToggleButtonBase)
		{
			selected = ToggleButtonBase(button).selected;
		}
		
		var e:TitleBarEvent = new TitleBarEvent(
			TitleBarEvent.BUTTON_CLICK, false, false, 
			button, selected);
		
		dispatchEvent(e);
	}
}
}