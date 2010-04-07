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

package org.teotigraphix.ui.events
{

import flash.events.Event;

import spark.components.supportClasses.ButtonBase;

/**
 * The TitleBarEvent class is used with the <code>TitleContainer</code> component.
 * 
 * @author Michael Schmalle
 * @copyright Teoti Graphix, LLC
 * @productversion 1.0
 * 
 * @see org.teotigraphix.ui.components.TitleContainer
 */
public class TitleContainerEvent extends Event
{
	//--------------------------------------------------------------------------
	//
	//  Public Class :: Properties
	//
	//--------------------------------------------------------------------------
	
	/**
	 * Dispatched when the <code>titleBar.titleIconDisplay</code> 
	 * has been clicked.
	 * 
	 * @eventType iconClick
	 */
	public static const ICON_CLICK:String = "iconClick";
	
	/**
	 * Dispatched when the <code>titleBar.minimizeButtonDisplay</code> 
	 * has been clicked.
	 * 
	 * @eventType minimizeClick
	 */
	public static const MINIMIZE_CLICK:String = "minimizeClick";
	
	/**
	 * Dispatched when the <code>titleBar.maximizeButtonDisplay</code> 
	 * has been clicked.
	 * 
	 * @eventType maximizeClick
	 */
	public static const MAXIMIZE_CLICK:String = "maximizeClick";
	
	/**
	 * Dispatched when the <code>titleBar.closeButtonDisplay</code> 
	 * has been clicked.
	 * 
	 * @eventType closeClick
	 */
	public static const CLOSE_CLICK:String = "closeClick";
	
	//--------------------------------------------------------------------------
	//
	//  Public :: Variables
	//
	//--------------------------------------------------------------------------
	
	//----------------------------------
	//  button
	//----------------------------------
	
	/**
	 * The button that is the source of this title bar event.
	 */
	public var button:ButtonBase;
	
	//----------------------------------
	//  selected
	//----------------------------------
	
	/**
	 * The selection state of the button that is the source of this 
	 * title bar event.
	 */
	public var selected:Boolean;
	
	//--------------------------------------------------------------------------
	//
	//  Constructor
	//
	//--------------------------------------------------------------------------
	
	/**
	 * Creates a new TitleContainerEvent event instance.
	 * 
	 * @param type The String event type.
	 * @param bubbles Whether the event bubbles on the display list.
	 * @param cancelable Whether the event's default behavior is cancelable.
	 * @param button The event source button.
	 * @param selected The event source button's selection state.
	 */
	public function TitleContainerEvent(type:String, 
										bubbles:Boolean = false, 
										cancelable:Boolean = false,
										button:ButtonBase = null,
										selected:Boolean = false)
	{
		super(type, bubbles, cancelable);
		
		this.button = button;
		this.selected = selected;
	}
	
	//--------------------------------------------------------------------------
	//
	//  Overridden Public :: Methods
	//
	//--------------------------------------------------------------------------
	
	/**
	 * The clone() implementation.
	 * 
	 * @return A new stateful TitleContainerEvent instance.
	 */
	override public function clone():Event
	{
		return new TitleContainerEvent(type, bubbles, cancelable, button, selected);
	}
}
}