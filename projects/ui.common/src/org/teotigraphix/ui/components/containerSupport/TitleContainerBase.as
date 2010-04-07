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

package org.teotigraphix.ui.components.containerSupport
{

import flash.events.IEventDispatcher;

import mx.core.UIComponent;

import org.teotigraphix.ui.api.ITitleBar;
import org.teotigraphix.ui.api.ITitleContainer;
import org.teotigraphix.ui.core.BarPlacement;
import org.teotigraphix.ui.events.TitleBarEvent;
import org.teotigraphix.ui.events.TitleContainerEvent;

import spark.components.supportClasses.ButtonBase;

//--------------------------------------
//  IconFile
//--------------------------------------

//[IconFile("TitleContainer.png")]

//--------------------------------------
//  Events
//--------------------------------------

/**
 * @eventType org.teotigraphix.ui.events.TitleContainerEvent.ICON_CLICK
 */
[Event(name="iconClick",type="org.teotigraphix.ui.events.TitleContainerEvent")]

/**
 * @eventType org.teotigraphix.ui.events.TitleContainerEvent.MINIMIZE_BUTTON_CLICK
 */
[Event(name="minimizeClick",type="org.teotigraphix.ui.events.TitleContainerEvent")]

/**
 * @eventType org.teotigraphix.ui.events.TitleContainerEvent.MAXIMIZE_BUTTON_CLICK
 */
[Event(name="maximizeClick",type="org.teotigraphix.ui.events.DisplayButtonEvent")]

/**
 * @eventType org.teotigraphix.ui.events.TitleContainerEvent.CLOSE_BUTTON_CLICK
 */
[Event(name="closeClick",type="org.teotigraphix.ui.events.TitleContainerEvent")]

/**
 * The <code>TitleContainerBase</code> class is a conent container with a 
 * <code>titleBar</code>, <code>contentGroup</code> and 
 * <code>statusBar</code> skin parts.
 * 
 * @author Michael Schmalle
 * @copyright Teoti Graphix, LLC
 * @productversion 1.0
 */
public class TitleContainerBase extends ContainerBase 
	implements ITitleContainer
{
	private var titleBarDisplayChanged:Boolean = false;
	
	private function invalidateTitleBar():void
	{
		if (titleBarDisplayChanged)
			return;
		
		titleBarDisplayChanged = true;
		invalidateProperties();
	}
	
	//--------------------------------------------------------------------------
	//
	//  Public SkinPart :: Variables
	//
	//--------------------------------------------------------------------------
	
	//----------------------------------
	//  titleBarDisplay
	//----------------------------------
	
	[SkinPart(type="org.teotigraphix.ui.api.ITitleBar", required="true")]
	
	/**
	 * The <code>ITitleBar</code> skin part.
	 */
	public var titleBarDisplay:UIComponent;
	
	//----------------------------------
	//  statusBarDisplay
	//----------------------------------
	
	//	[SkinPart(type="org.teotigraphix.ui.api.IStatusBar", required="true")]
	
	/**
	 * The <code>IStatusBar</code> skin part.
	 */
	//	public var statusBarDisplay:UIComponent;
	
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
		
		invalidateTitleBar();
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
		
		invalidateTitleBar();
	}
	
	//----------------------------------
	//  showMinimizeButton
	//----------------------------------
	
	private var buttonVisibilityChanged:Boolean = false;
	
	private function invalidateButtonVisibility():void
	{
		if (buttonVisibilityChanged)
			return;
		
		buttonVisibilityChanged = true;
		invalidateProperties();
	}
	
	/**
	 * @private
	 */
	private var _showMinimizeButton:Boolean;
	
	/**
	 * TODO Document
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
		
		invalidateButtonVisibility();
	}
	
	//----------------------------------
	//  showMaximizeButton
	//----------------------------------
	
	/**
	 * @private
	 */
	private var _showMaximizeButton:Boolean;
	
	/**
	 * TODO Document
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
		
		invalidateButtonVisibility();
	}
	
	//----------------------------------
	//  showCloseButton
	//----------------------------------
	
	/**
	 * @private
	 */
	private var _showCloseButton:Boolean;
	
	/**
	 * TODO Document
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
		
		invalidateButtonVisibility();
	}
	
	//--------------------------------------------------------------------------
	//
	//  ITitleContainer API :: Properties
	//
	//--------------------------------------------------------------------------
	
	//----------------------------------
	//  titleBar
	//----------------------------------
	
	/**
	 * @copy com.teotigraphix.ui.api.ITitleContainer#titleBar
	 */
	public function get titleBar():ITitleBar
	{
		return titleBarDisplay as ITitleBar;
	}
	
	//----------------------------------
	//  statusBar
	//----------------------------------
	
	/**
	 * @copy org.teotigraphix.ui.api.ITitleContainer#statusBar
	 */
	//	public function get statusBar():IStatusBar
	//	{
	//		return statusBarDisplay as IStatusBar;
	//	}
	
	//----------------------------------
	//  showTitleBar
	//----------------------------------
	
	/**
	 * @private
	 */
	private var _showTitleBar:Boolean = true;
	
	/**
	 * @copy org.teotigraphix.ui.api.ITitleContainer#showTitleBar
	 * @mxml
	 */
	public function get showTitleBar():Boolean
	{
		return _showTitleBar;
	}
	
	/**
	 * @private
	 */
	public function set showTitleBar(value:Boolean):void
	{
		_showTitleBar = value;
		
		invalidateTitleBar();
	}
	
	//----------------------------------
	//  showStatusBar
	//----------------------------------
	
	/**
	 * @private
	 */
	private var _showStatusBar:Boolean;
	
	/**
	 * @copy org.teotigraphix.ui.api.ITitleContainer#showStatusBar
	 * @mxml
	 */
	public function get showStatusBar():Boolean
	{
		return _showStatusBar;
	}
	
	/**
	 * @private
	 */
	public function set showStatusBar(value:Boolean):void
	{
		_showStatusBar = value;
	}
	
	//----------------------------------
	//  showContentGroup
	//----------------------------------
	
	/**
	 * @private
	 */
	private var _showContentGroup:Boolean;
	
	/**
	 * @copy org.teotigraphix.ui.api.ITitleContainer#showContentGroup
	 * @mxml
	 */
	public function get showContentGroup():Boolean
	{
		return _showContentGroup;
	}
	
	/**
	 * @private
	 */
	public function set showContentGroup(value:Boolean):void
	{
		_showContentGroup = value;
	}
	
	//----------------------------------
	//  showContentGroup
	//----------------------------------
	
	/**
	 * @private
	 */
	private var _titleBarPlacement:String = BarPlacement.TOP;
	
	/**
	 * @copy org.teotigraphix.ui.api.ITitleContainer#titleBarPlacement
	 * @mxml
	 */
	public function get titleBarPlacement():String
	{
		return _titleBarPlacement;
	}
	
	/**
	 * @private
	 */
	public function set titleBarPlacement(value:String):void
	{
		_titleBarPlacement = value;
	}
	
	//--------------------------------------------------------------------------
	//
	//  Constructor
	//
	//--------------------------------------------------------------------------
	
	/**
	 * Constructor.
	 */
	public function TitleContainerBase()
	{
		super();
	}
	
	//--------------------------------------------------------------------------
	//
	//  Overridden Protected :: Methods
	//
	//--------------------------------------------------------------------------
	
	/**
	 * Calls the commit methods during dirty states.
	 * 
	 * <p>Commits on dirty state;</p>
	 * <ul>
	 * <li><code></code></li>
	 * </ul>
	 */
	override protected function commitProperties():void
	{
		super.commitProperties();
		
		if (titleBarDisplayChanged)
		{
			commitTitleBarDisplay();
			titleBarDisplayChanged = false;
		}
		
		if (buttonVisibilityChanged)
		{
			commitButtonVisibility();
			buttonVisibilityChanged = false;
		}		
	}
	
	/**
	 * @private
	 */
	override protected function partAdded(partName:String, instance:Object):void
	{
		super.partAdded(partName, instance);
		
		// this call can happen from createChildren() or commitProperties()
		// in any case, setting the flags here will fire the methods during
		// the next commitProperties() if this is being called from createChildren()
		// if this method is called from commitProperties(), that means we are in
		// super and the next sequence is OUR commitProperties() which has
		// the flag calls, no need to call invalidateProperties() here
		if (instance == titleBarDisplay)
		{
			addTitleBarHandlers(titleBarDisplay);
			commitTitleBarDisplay();
			commitButtonVisibility();
		}
		else if (instance == contentGroup)
		{
		}
		//		else if (instance == statusBarDisplay)
		//		{
		//		}
	}
	
	/**
	 * @private
	 */
	override protected function partRemoved(partName:String, instance:Object):void
	{
		super.partRemoved(partName, instance);
		
		if (instance == titleBarDisplay)
		{
			removeTitleBarHandlers(titleBarDisplay);
			
		}
		else if (instance == contentGroup)
		{
		}
		//		else if (instance == statusBarDisplay)
		//		{
		//		}
	}
	
	//--------------------------------------------------------------------------
	//
	//  Protected Commit :: Methods
	//
	//--------------------------------------------------------------------------
	
	/**
	 * Commits the <code>titleBarDisplay</code> composite.
	 */
	protected function commitTitleBarDisplay():void
	{
		if (!titleBarDisplay)
			return;
		
		if (!_showTitleBar)
		{
			titleBarDisplay.visible = false;
			return;
		}
		
		var t:ITitleBar = titleBarDisplay as ITitleBar;
		if (t)
		{
			t.title = _title;
			t.titleIcon = _titleIcon;
		}
	}
	
	/**
	 * Commits.
	 */
	protected function commitButtonVisibility():void
	{
		if (!titleBarDisplay)
			return;
		
		var t:ITitleBar = titleBarDisplay as ITitleBar;
		if (t)
		{
			t.showMinimizeButton = _showMinimizeButton;
			t.showMaximizeButton = _showMaximizeButton;
			t.showCloseButton = _showCloseButton;
		}
	}
	
	/**
	 * Commits the <code>statusBarDisplay</code> composite.
	 */
	protected function commitStatusBarDisplay():void
	{
	}
	
	//--------------------------------------------------------------------------
	//
	//  Protected :: Methods
	//
	//--------------------------------------------------------------------------
	
	/**
	 * Add <code>TitleBarEvent</code> handlers to a button.
	 * 
	 * @param titleBar An <code>IEventDispatcher</code> button.
	 */
	protected function addTitleBarHandlers(titleBar:IEventDispatcher):void
	{
		titleBar.addEventListener(
			TitleBarEvent.BUTTON_CLICK, titleBar_buttonClickHandler);
	}
	
	/**
	 * Remove <code>TitleBarEvent</code> handlers from a button.
	 * 
	 * @param titleBar An <code>IEventDispatcher</code> button.
	 */
	protected function removeTitleBarHandlers(titleBar:IEventDispatcher):void
	{
		titleBar.removeEventListener(
			TitleBarEvent.BUTTON_CLICK, titleBar_buttonClickHandler);
	}
	
	//--------------------------------------------------------------------------
	//
	//  Protected :: Handlers
	//
	//--------------------------------------------------------------------------
	
	/**
	 * Handles the <code>TitleBarEvent.BUTTON_CLICK</code> event on the
	 * <code>titleBarDisplay</code>.
	 * 
	 * @param event A <code>TitleBarEvent</code>.
	 * @event org.teotigraphix.ui.events.TitleContainerEvent#MINIMIZE_CLICK
	 * @event org.teotigraphix.ui.events.TitleContainerEvent#MAXIMIZE_CLICK
	 * @event org.teotigraphix.ui.events.TitleContainerEvent#CLOSE_CLICK
	 */
	protected function titleBar_buttonClickHandler(event:TitleBarEvent):void
	{
		var button:ButtonBase = event.button as ButtonBase;
		
		var type:String = getTitleBarEventType(event.button);
		
		var e:TitleContainerEvent = new TitleContainerEvent(
			type, false, false, 
			event.button, event.selected);
		
		dispatchEvent(e);
		
		if (!e.isDefaultPrevented())
		{
			switch (type)
			{
				case TitleContainerEvent.MINIMIZE_CLICK:
					minimizeClick();
					break;
				case TitleContainerEvent.MAXIMIZE_CLICK:
					maximizeClick();
					break;
				case TitleContainerEvent.CLOSE_CLICK:
					closeClick();
					break;
			}
		}
	}
	
	/**
	 * Called when the <code>minimizeButtonDisplay</code> of the 
	 * <code>titleBarDisplay</code> has been clicked.
	 */
	protected function minimizeClick():void
	{
	}
	
	/**
	 * Called when the <code>maximizeButtonDisplay</code> of the 
	 * <code>titleBarDisplay</code> has been clicked.
	 */
	protected function maximizeClick():void
	{
	}
	
	/**
	 * Called when the <code>closeButtonDisplay</code> of the 
	 * <code>titleBarDisplay</code> has been clicked.
	 */
	protected function closeClick():void
	{
	}
	
	//--------------------------------------------------------------------------
	//
	//  Private :: Methods
	//
	//--------------------------------------------------------------------------
	
	/**
	 * @private
	 */
	private function getTitleBarEventType(button:ButtonBase):String
	{
		switch(button.id)
		{
			case "minimizeButtonDisplay":
				return TitleContainerEvent.MINIMIZE_CLICK;
				
			case "maximizeButtonDisplay":
				return TitleContainerEvent.MAXIMIZE_CLICK;
				
			case "closeButtonDisplay":
				return TitleContainerEvent.CLOSE_CLICK;
		}
		
		return null;
	}
}
}