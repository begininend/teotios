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

import mx.core.IVisualElement;
import mx.core.UIComponent;

import org.teotigraphix.ui.api.IStatusBar;
import org.teotigraphix.ui.api.ITitleBar;
import org.teotigraphix.ui.api.ITitleContainer;
import org.teotigraphix.ui.api.control.IBar;
import org.teotigraphix.ui.core.BarPlacement;
import org.teotigraphix.ui.events.TitleBarEvent;
import org.teotigraphix.ui.events.TitleContainerEvent;

import spark.components.supportClasses.ButtonBase;

//--------------------------------------
//  Events
//--------------------------------------

/**
 * @eventType com.teotigraphix.ui.events.TitleContainerEvent.ICON_CLICK
 */
[Event(name="iconClick",type="org.teotigraphix.ui.events.TitleContainerEvent")]

/**
 * @eventType com.teotigraphix.ui.events.TitleContainerEvent.MINIMIZE_BUTTON_CLICK
 */
[Event(name="minimizeClick",type="org.teotigraphix.ui.events.TitleContainerEvent")]

/**
 * @eventType com.teotigraphix.ui.events.TitleContainerEvent.MAXIMIZE_BUTTON_CLICK
 */
[Event(name="maximizeClick",type="org.teotigraphix.ui.events.TitleContainerEvent")]

/**
 * @eventType com.teotigraphix.ui.events.TitleContainerEvent.CLOSE_BUTTON_CLICK
 */
[Event(name="closeClick",type="org.teotigraphix.ui.events.TitleContainerEvent")]

//--------------------------------------
//  Class
//--------------------------------------

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
	//--------------------------------------------------------------------------
	//
	//  Private :: Variables
	//
	//--------------------------------------------------------------------------
	
	/**
	 * @private
	 */
	private var titleBarPropertiesChanged:Boolean = false;
	
	/**
	 * @private
	 */
	private var statusBarPropertiesChanged:Boolean = false;
	
	/**
	 * @private
	 */
	private var buttonVisibilityChanged:Boolean = false;
	
	//--------------------------------------------------------------------------
	//
	//  Public SkinPart :: Variables
	//
	//--------------------------------------------------------------------------
	
	//----------------------------------
	//  titleBarDisplay
	//----------------------------------
	
	[SkinPart(required="true")]
	
	/**
	 * The <code>ITitleBar</code> skin part.
	 */
	public var titleBarDisplay:IVisualElement;
	
	//----------------------------------
	//  statusBarDisplay
	//----------------------------------
	
	[SkinPart(required="false")]
	
	/**
	 * The <code>IStatusBar</code> skin part.
	 */
	public var statusBarDisplay:IVisualElement;
	
	//--------------------------------------------------------------------------
	//
	//  ITitleBar API :: Properties
	//
	//--------------------------------------------------------------------------
	
	//----------------------------------
	//  titleIcon
	//----------------------------------
	
	[Inspectable(category="General")]
	
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
	
	[Inspectable(category="General")]
	
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
	
	/**
	 * @private
	 */
	private var _showMinimizeButton:Boolean;
	
	[Inspectable(category="General")]
	
	/**
	 * Shows or hides the <code>minimizeButtonDisplay</code> on the
	 * <code>titleBarDisplay</code> skin part.
	 * 
	 * @mxml
	 * @default false
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
	
	[Inspectable(category="General")]
	
	/**
	 * Shows or hides the <code>maximizeButtonDisplay</code> on the
	 * <code>titleBarDisplay</code> skin part.
	 * 
	 * @mxml
	 * @default false
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
	
	[Inspectable(category="General")]
	
	/**
	 * Shows or hides the <code>closeButtonDisplay</code> on the
	 * <code>titleBarDisplay</code> skin part.
	 * 
	 * @mxml
	 * @default false
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
	//  IStatusBar API :: Properties
	//
	//--------------------------------------------------------------------------
	
	//----------------------------------
	//  statusIcon
	//----------------------------------
	
	[Inspectable(category="General")]
	
	/**
	 * @private
	 */
	private var _statusIcon:Class;
	
	/**
	 * @copy org.teotigraphix.ui.api.IStatusBar#statusIcon
	 * @mxml null
	 */
	public function get statusIcon():Class
	{
		return _statusIcon;
	}
	
	/**
	 * @private
	 */
	public function set statusIcon(value:Class):void
	{
		if (_statusIcon == value)
			return;
		
		_statusIcon = value;
		
		invalidateStatusBar();
	}
	
	//----------------------------------
	//  status
	//----------------------------------
	
	/**
	 * @private
	 */
	private var _status:String;
	
	[Inspectable(category="General")]
	
	/**
	 * @copy org.teotigraphix.ui.api.IStatusBar#status
	 * @mxml
	 */
	public function get status():String
	{
		return _status;
	}
	
	/**
	 * @private
	 */
	public function set status(value:String):void
	{
		if (_status == value)
			return;
		
		_status = value;
		
		invalidateStatusBar();
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
	 * @copy org.teotigraphix.ui.api.ITitleContainer#titleBar
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
	public function get statusBar():IStatusBar
	{
		return statusBarDisplay as IStatusBar;
	}
	
	//----------------------------------
	//  showTitleBar
	//----------------------------------
	
	/**
	 * @private
	 */
	private var _showTitleBar:Boolean = true;
	
	[Inspectable(category="General")]
	
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
	
	[Inspectable(category="General")]
	
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
		
		invalidateStatusBar();
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
	//  titleBarPlacement
	//----------------------------------
	
	/**
	 * @private
	 */
	private var _titleBarPlacement:String = BarPlacement.TOP;
	
	[Inspectable(category="General",enumeration="top,right,bottom,left")]
	
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
		if (_titleBarPlacement == value)
			return;
		
		_titleBarPlacement = value;
		
		commitTitleBarPlacement();
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
	 * @inheritDoc
	 * 
	 * @see #commitTitleBarProperties()
	 * @see #commitButtonVisibility()
	 * @see #commitStatusBarProperties()
	 */
	override protected function commitProperties():void
	{
		super.commitProperties();
		
		if (titleBarPropertiesChanged)
		{
			commitTitleBarProperties();
			titleBarPropertiesChanged = false;
		}
		
		if (buttonVisibilityChanged)
		{
			commitButtonVisibility();
			buttonVisibilityChanged = false;
		}
		
		if (statusBarPropertiesChanged)
		{
			commitStatusBarProperties();
			statusBarPropertiesChanged = false;
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
			addOrRemoveTitleBarHandlers(titleBarDisplay, true);
			commitTitleBarProperties();
			commitButtonVisibility();
			commitTitleBarPlacement();
		}
		else if (instance == contentGroup)
		{
		}
		else if (instance == statusBarDisplay)
		{
			commitStatusBarProperties();
		}
	}
	
	/**
	 * @private
	 */
	override protected function partRemoved(partName:String, instance:Object):void
	{
		super.partRemoved(partName, instance);
		
		if (instance == titleBarDisplay)
		{
			addOrRemoveTitleBarHandlers(titleBarDisplay, false);
		}
		else if (instance == contentGroup)
		{
		}
		else if (instance == statusBarDisplay)
		{
		}
	}
	
	//--------------------------------------------------------------------------
	//
	//  Protected Commit :: Methods
	//
	//--------------------------------------------------------------------------
	
	/**
	 * Commits the <code>titleBarDisplay</code> composite.
	 * 
	 * @see #showTitleBar
	 * @see #title
	 * @see #titleIcon
	 */
	protected function commitTitleBarProperties():void
	{
		if (!titleBarDisplay)
			return;
		
		var show:Boolean = _showTitleBar;
		titleBarDisplay.visible = show;
		titleBarDisplay.includeInLayout = show;		
		
		var t:ITitleBar = titleBar;
		if (t)
		{
			t.title = _title;
			t.titleIcon = _titleIcon;
		}
	}
	
	/**
	 * Commits the titlebar's button visibility.
	 * 
	 * @see #showMinimizeButton
	 * @see #showMaximizeButton
	 * @see #showCloseButton
	 */
	protected function commitButtonVisibility():void
	{
		if (!titleBarDisplay)
			return;
		
		var t:ITitleBar = titleBar;
		if (t)
		{
			t.showMinimizeButton = _showMinimizeButton;
			t.showMaximizeButton = _showMaximizeButton;
			t.showCloseButton = _showCloseButton;
		}
	}
	
	/**
	 * Commits the <code>titleBarPlacement</code> property.
	 * 
	 * @see #titleBarPlacement
	 * @see org.teotigraphix.ui.api.control.IBar#placement
	 */
	protected function commitTitleBarPlacement():void
	{
		if (!titleBarDisplay)
			return;
		
		if (titleBarDisplay is IBar)
			IBar(titleBarDisplay).placement = _titleBarPlacement;
		
		if (skin)
		{
			skin.invalidateSize();
			skin.invalidateDisplayList();
		}
	}
	
	/**
	 * Commits the <code>statusBarDisplay</code> composite.
	 * 
	 * @see #showStatusBar
	 * @see #status
	 * @see #statusIcon
	 */
	protected function commitStatusBarProperties():void
	{
		if (!statusBarDisplay)
			return;
		
		var show:Boolean = _showStatusBar;
		statusBarDisplay.visible = show;
		statusBarDisplay.includeInLayout = show;
		
		var s:IStatusBar = statusBar;
		if (s)
		{
			s.status = _status;
			s.statusIcon = _statusIcon;
		}		
	}
	
	//--------------------------------------------------------------------------
	//
	//  Protected :: Methods
	//
	//--------------------------------------------------------------------------
	
	/**
	 * @private
	 */
	protected function invalidateTitleBar():void
	{
		if (titleBarPropertiesChanged)
			return;
		
		titleBarPropertiesChanged = true;
		invalidateProperties();
	}
	
	/**
	 * @private
	 */	
	protected function invalidateButtonVisibility():void
	{
		if (buttonVisibilityChanged)
			return;
		
		buttonVisibilityChanged = true;
		invalidateProperties();
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
	
	/**
	 * Add or removes <code>TitleBarEvent</code> handlers to or from a button.
	 * 
	 * @param titleBar An <code>IEventDispatcher</code> button.
	 */
	protected function addOrRemoveTitleBarHandlers(titleBar:IEventDispatcher,
												   add:Boolean):void
	{
		if (add)
		{
			titleBar.addEventListener(
				TitleBarEvent.BUTTON_CLICK, titleBar_buttonClickHandler);
		}
		else
		{
			titleBar.removeEventListener(
				TitleBarEvent.BUTTON_CLICK, titleBar_buttonClickHandler);
		}
	}
	
	/**
	 * @private
	 */
	protected function invalidateStatusBar():void
	{
		if (statusBarPropertiesChanged)
			return;
		
		statusBarPropertiesChanged = true;
		invalidateProperties();
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
			type, false, true, 
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
	
	//--------------------------------------------------------------------------
	//
	//  Private :: Methods
	//
	//--------------------------------------------------------------------------
	
	/**
	 * @private
	 * Returns the event type for the button's id.
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