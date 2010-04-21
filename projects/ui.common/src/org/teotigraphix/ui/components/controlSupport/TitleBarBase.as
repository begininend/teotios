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

import mx.core.IVisualElement;

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

//--------------------------------------
//  Styles
//--------------------------------------

/**
 * The gap between the titlebar's buttons.
 * 
 * @mxml 1
 */
[Style(name="buttonGap",type="int",format="Length")]

//--------------------------------------
//  Class
//--------------------------------------

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
 * <code>ComponentBase#contentGroup</code>, it's children are basically
 * chrome children with no dynamic content.</p>
 * 
 * @author Michael Schmalle
 * @copyright Teoti Graphix, LLC
 * @productversion 1.0
 * 
 * @mxml
 */
public class TitleBarBase extends MessageBarBase implements ITitleBar
{
	//--------------------------------------------------------------------------
	//
	//  Public SkinPart :: Variables
	//
	//--------------------------------------------------------------------------
	
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
	 * @copy org.teotigraphix.ui.api.ITitleBar#titleIcon
	 * @mxml null
	 */
	public function get titleIcon():Class
	{
		return super.icon;
	}
	
	/**
	 * @private
	 */
	public function set titleIcon(value:Class):void
	{
		super.icon = value;
	}
	
	//----------------------------------
	//  title
	//----------------------------------
	
	/**
	 * @copy org.teotigraphix.ui.api.ITitleBar#title
	 * @mxml
	 */
	public function get title():String
	{
		return super.label;
	}
	
	/**
	 * @private
	 */
	public function set title(value:String):void
	{
		super.label = value;
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
		
		setButtonVisibility(minimizeButtonDisplay, _showMinimizeButton);
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
		
		setButtonVisibility(maximizeButtonDisplay, _showMaximizeButton);
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
		
		setButtonVisibility(closeButtonDisplay, _showCloseButton);
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
	}
	
	/**
	 * @private
	 */
	override protected function partAdded(partName:String, instance:Object):void
	{
		super.partAdded(partName, instance);
		
		if (instance == minimizeButtonDisplay)
		{
			addOrRemoveButtonClickHandlers(minimizeButtonDisplay, true);
			setButtonVisibility(minimizeButtonDisplay, _showMinimizeButton);
		}
		else if (instance == maximizeButtonDisplay)
		{
			addOrRemoveButtonClickHandlers(maximizeButtonDisplay, true);
			setButtonVisibility(maximizeButtonDisplay, _showMaximizeButton);
		}
		else if (instance == closeButtonDisplay)
		{
			addOrRemoveButtonClickHandlers(closeButtonDisplay, true);
			setButtonVisibility(closeButtonDisplay, _showCloseButton);
		}
	}
	
	/**
	 * @private
	 */
	override protected function partRemoved(partName:String, instance:Object):void
	{
		super.partRemoved(partName, instance);
		
		if (instance == minimizeButtonDisplay)
		{
			addOrRemoveButtonClickHandlers(minimizeButtonDisplay, false);
		}
		else if (instance == maximizeButtonDisplay)
		{
			addOrRemoveButtonClickHandlers(maximizeButtonDisplay, false);
		}
		else if (instance == closeButtonDisplay)
		{
			addOrRemoveButtonClickHandlers(closeButtonDisplay, false);
		}
	}
	
	//--------------------------------------------------------------------------
	//
	//  Protected Commit :: Methods
	//
	//--------------------------------------------------------------------------
	
	/**
	 * Sets a button visibility using the show properties.
	 * 
	 * <p>Sets the <code>visble</code> and <code>includeInLayout</code> 
	 * properties of the button.</p>
	 * 
	 * @param button The button instance.
	 * @param visible A boolean indicating whether the button is added or
	 * removed from layout.
	 */
	protected function setButtonVisibility(button:IVisualElement,
										   visible:Boolean):void
	{
		if (!button)
			return;
		
		button.visible = visible;
		button.includeInLayout = visible;
	}
	
	//--------------------------------------------------------------------------
	//
	//  Protected :: Methods
	//
	//--------------------------------------------------------------------------
	
	
	/**
	 * Add or removes <code>MouseEvent</code> handlers to or from a button.
	 * 
	 * @param button An <code>IEventDispatcher</code> button.
	 * @param add A Boolean indicating whether to add or remove the handlers.
	 */
	protected function addOrRemoveButtonClickHandlers(button:IEventDispatcher,
													  add:Boolean):void
	{
		if (add)
		{
			button.addEventListener(MouseEvent.CLICK, button_clickHandler);
		}
		else
		{
			button.removeEventListener(MouseEvent.CLICK, button_clickHandler);
		}
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
	 * @event org.teotigraphix.ui.events.TitleBarEvent#BUTTON_CLICK
	 */
	protected function button_clickHandler(event:MouseEvent):void
	{
		var button:ButtonBase = event.target as ButtonBase;
		var selected:Boolean = false;
		
		if (button is ToggleButtonBase)
		{
			selected = ToggleButtonBase(button).selected;
		}
		
		// TODO (mschmalle) make BUTTON_CLICK cancelable
		var e:TitleBarEvent = new TitleBarEvent(
			TitleBarEvent.BUTTON_CLICK, false, false, 
			button, selected);
		
		dispatchEvent(e);
	}
}
}