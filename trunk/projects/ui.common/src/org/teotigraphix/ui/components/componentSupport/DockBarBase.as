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

import flash.display.DisplayObject;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.Point;
import flash.geom.Rectangle;

import mx.core.IFactory;
import mx.core.IVisualElement;
import mx.core.IVisualElementContainer;
import mx.core.UIComponent;
import mx.effects.IEffect;
import mx.events.EffectEvent;
import mx.events.FlexEvent;
import mx.managers.ISystemManager;

import org.teotigraphix.ui.api.IDockBar;
import org.teotigraphix.ui.components.componentSupport.DockBarButton;
import org.teotigraphix.ui.core.DockBarPlacement;
import org.teotigraphix.ui.layouts.ButtonBarDirection;
import org.teotigraphix.ui.layouts.controlSupport.ButtonBarLayout;

import spark.components.supportClasses.ButtonBarBase;

//--------------------------------------
//  Styles
//--------------------------------------

/**
 * Determines the amount of space calculated for the hit area when
 * the <code>autoHide</code> property is <code>true</code>.
 * 
 * @default 20
 */
[Style(name="autoHideThickness",type="Number",inherit="no")]

//--------------------------------------
//  Class
//--------------------------------------

/**
 * An abstract implementation of the IDockBar interface.
 * 
 * <p>The DockBar is a component that get's placed in the systemManager of
 * the root application. The bar can be auto hidden and placed on either four
 * sides of the application centered.</p>
 * 
 * <p>The DockBar acts much like a ButtonBar except that the DockBar can 
 * easily display an icon and toolTip along with the standard label.</p>
 * 
 * <p>When <code>autoHide</code> is true, the component uses a Rectangle to
 * calculate visibility, not mouseOver events that can mess with the underlying
 * components in the application.</p>
 * 
 * @author Michael Schmalle
 * @copyright Teoti Graphix, LLC
 * @productversion 1.0
 */
public class DockBarBase extends ButtonBarBase implements IDockBar
{
	//--------------------------------------------------------------------------
	//
	//  Public SkinPart :: Variables
	//
	//--------------------------------------------------------------------------
	
	//----------------------------------
	//  dockButton
	//----------------------------------
	
	[SkinPart(required="false")]
	
	/**
	 * The button skin part renderer.
	 */
	public var dockButton:IFactory;
	
	//--------------------------------------------------------------------------
	//
	//  Private :: Variables
	//
	//--------------------------------------------------------------------------
	
	/**
	 * @private
	 */
	private var hidden:Boolean = false;
	
	//--------------------------------------------------------------------------
	//
	//  IDockBar API :: Properties
	//
	//--------------------------------------------------------------------------	
	
	//----------------------------------
	//  autoHide
	//----------------------------------
	
	/**
	 * @private
	 */
	private var _autoHide:Boolean = false;
	
	/**
	 * @private
	 */
	private var autoHideChanged:Boolean = false;
	
	/**
	 * @copy org.teotigraphix.ui.api.IDockBar#autoHide
	 * 
	 * @default false
	 */
	public function get autoHide():Boolean
	{
		return _autoHide;
	}
	
	/**
	 * @private
	 */	
	public function set autoHide(value:Boolean):void
	{
		if (_autoHide == value)
			return;
		
		_autoHide = value;
		
		autoHideChanged = true;
		invalidateProperties();
	}
	
	//----------------------------------
	//  placement
	//----------------------------------
	
	/**
	 * @private
	 */
	private var _placement:String = DockBarPlacement.TOP;
	
	/**
	 * @private
	 */
	private var placementChanged:Boolean = false;
	
	/**
	 * @copy org.teotigraphix.ui.api.IDockBar#placement
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
		
		// if the dataGroup has a ButtonBarLayout as it's layout
		// we will set the layout's direction to match whether we are
		// vertical or horizontal based on the placement value
		// NOTE :: This logic needs to happen in this setter because when
		// updatePlacement() is called, an invalidation cycle has already
		// passed, this will not allow the new dataGroup measurements to
		// be correctly applied to the layout calcs of this dock bar
		updateButtonBarLayout();	
		
		placementChanged = true;
		invalidateDisplayList();
	}
	
	//----------------------------------
	//  dataProvider
	//----------------------------------
	
	// function get dataProvider():IList;
	// function set dataProvider(value:IList):void;
	
	//----------------------------------
	//  toolTipField
	//----------------------------------
	
	/**
	 * @private
	 */
	private var _toolTipField:String = "toolTip";
	
	/**
	 * @copy org.teotigraphix.ui.api.IDockBar#toolTipField
	 * 
	 * @default toolTip
	 * @mxml
	 */
	public function get toolTipField():String
	{
		return _toolTipField;
	}
	
	/**
	 * @private
	 */	
	public function set toolTipField(value:String):void
	{
		if (_toolTipField == value)
			return;
		
		_toolTipField = value;
	}
	
	//----------------------------------
	//  toolTipFunction
	//----------------------------------
	
	/**
	 * @private
	 */
	private var _toolTipFunction:Function = null;
	
	/**
	 * @copy org.teotigraphix.ui.api.IDockBar#toolTipFunction
	 * 
	 * @default null
	 * @mxml
	 */
	public function get toolTipFunction():Function
	{
		return _toolTipFunction;
	}
	
	/**
	 * @private
	 */	
	public function set toolTipFunction(value:Function):void
	{
		if (_toolTipFunction == value)
			return;
		
		_toolTipFunction = value;
	}
	
	//----------------------------------
	//  iconField
	//----------------------------------
	
	/**
	 * @private
	 */
	private var _iconField:String = "icon";
	
	/**
	 * @copy org.teotigraphix.ui.api.IDockBar#iconField
	 * 
	 * @default icon
	 * @mxml
	 */
	public function get iconField():String
	{
		return _iconField;
	}
	
	/**
	 * @private
	 */	
	public function set iconField(value:String):void
	{
		if (_iconField == value)
			return;
		
		_iconField = value;
	}
	
	//----------------------------------
	//  iconFunction
	//----------------------------------
	
	/**
	 * @private
	 */
	private var _iconFunction:Function = null;
	
	/**
	 * @copy org.teotigraphix.ui.api.IDockBar#iconFunction
	 * 
	 * @default null
	 * @mxml
	 */
	public function get iconFunction():Function
	{
		return _iconFunction;
	}
	
	/**
	 * @private
	 */	
	public function set iconFunction(value:Function):void
	{
		if (_iconFunction == value)
			return;
		
		_iconFunction = value;
	}
	
	//----------------------------------
	//  labelField
	//----------------------------------
	
	// function get labelField():String
	// function set labelField(value:String):void
	
	//----------------------------------
	//  labelFunction
	//----------------------------------
	
	// function get labelFunction():Function
	// function set labelFunction(value:Function):void
	
	//--------------------------------------------------------------------------
	//
	//  Constructor
	//
	//--------------------------------------------------------------------------
	
	/**
	 * Constructor.
	 */
	public function DockBarBase()
	{
		super();
		
		itemRendererFunction = defaultItemRendererFunction;
	}
	
	//--------------------------------------------------------------------------
	//
	//  Overridden Public :: Methods
	//
	//--------------------------------------------------------------------------
	
	/**
	 * @private
	 */
	public override function updateRenderer(renderer:IVisualElement, 
											itemIndex:int, 
											data:Object):void
	{
		super.updateRenderer(renderer, itemIndex, data);
		
		// if the renderer is a DockBarButton, set the toolTip and icon
		var button:DockBarButton = renderer as DockBarButton;
		if (button)
		{
			button.toolTip = itemToToolTip(data);
			button.icon = itemToIcon(data);
		}
	}
	
	//--------------------------------------------------------------------------
	//
	//  Overridden Protected :: Methods
	//
	//--------------------------------------------------------------------------
	
	/**
	 * @private
	 */
	protected override function initializationComplete():void
	{
		super.initializationComplete();
		
		if (parent)
		{
			parent.addEventListener(
				FlexEvent.CREATION_COMPLETE, parent_creationCompleteHandler);
		}
		
		// set the initial visible value after all creation happens
		//visible = !_autoHide;
	}
	
	/**
	 * @private
	 */
	override protected function commitProperties():void
	{
		super.commitProperties();
		
		if (autoHideChanged)
		{
			commitAutoHide();
			autoHideChanged = false;
		}
	}
	
	/**
	 * @private
	 */
	override protected function updateDisplayList(unscaledWidth:Number, 
												  unscaledHeight:Number):void
	{
		super.updateDisplayList(unscaledWidth, unscaledHeight);
		
		if (placementChanged)
		{
			updatePlacement();
			placementChanged = false;
		}
	}
	
	//--------------------------------------------------------------------------
	//
	//  Protected :: Methods
	//
	//--------------------------------------------------------------------------
	
	/**
	 * Commits the <code>placement</code> property.
	 * 
	 * @see #layoutBar()
	 */
	protected function updatePlacement():void
	{
		layoutBar();
	}
	
	/**
	 * Commits the <code>autoHide</code> property.
	 */
	protected function commitAutoHide():void
	{
		// when autoHide is true, the systemManager's MOUSE_MOVE event
		// is listened to. A calculation is used to find if the mouse is
		// within a certain bounding box based off of the current dock
		// bar placement
		
		// add the systemManager MOUSE_MOVE handler
		var sm:DisplayObject = systemManager.getSandboxRoot();
		
		if (_autoHide)
		{
			sm.addEventListener(
				MouseEvent.MOUSE_MOVE, systemManager_mouseMoveHandler);
		}
		else
		{
			sm.removeEventListener(
				MouseEvent.MOUSE_MOVE, systemManager_mouseMoveHandler);
		}
		
		// since this property will only be commited once on a valid cycle
		// it's ok to set visible, this will also take care of the event
		// dispatch to trigger any effects associated with show or hide
		visible = !_autoHide;
	}
	
	/**
	 * Lays out the dock bar as a child of the system manager.
	 * 
	 * <p>Uses the <code>placement</code> property to determine the layout 
	 * position.</p>
	 */
	protected function layoutBar():void
	{
		var calcX:Number = 0;
		var calcY:Number = 0;
		
		if (!stage)
			return;
		
		// use the stage's metrics
		var width:Number = stage.stageWidth;
		var height:Number = stage.stageHeight;		
		
		// calculate the x, y based on the placement
		switch (_placement)
		{
			case DockBarPlacement.TOP:
				calcX = (width - getLayoutBoundsWidth()) / 2;
				break;
			
			case DockBarPlacement.BOTTOM:
				calcX = (width - getLayoutBoundsWidth()) / 2;
				calcY = height - getLayoutBoundsHeight();
				break;
			
			case DockBarPlacement.LEFT:
				calcY = (height - getLayoutBoundsHeight()) / 2;
				break;
			
			case DockBarPlacement.RIGHT:
				calcY = (height - getLayoutBoundsHeight()) / 2;
				calcX = width - getLayoutBoundsWidth();
				break;			
		}
		
		// set our layout position
		setLayoutBoundsPosition(calcX, calcY);
	}	
	
	/**
	 * Adds the dock bar as a child of the systemManager.
	 */
	protected function addAsPopup():void
	{
		var container:IVisualElementContainer = parent as IVisualElementContainer;
		if (container)
		{
			// remove us from our parent
			container.removeElement(this);
			
			// add us to the systemManager as a popUp
			//PopUpManager.addPopUp(this, container as DisplayObject);
			var sb:ISystemManager = systemManager.getSandboxRoot() as ISystemManager;
			sb.popUpChildren.addChild(this);
			
			// add a RESIZE handler listening on the stage
			stage.addEventListener(Event.RESIZE, stage_resizeHandler);
			
			// now that the bar is added, make sure the layout is correct
			// for bar layout in the next udl() pass
			updateButtonBarLayout();
			
			// schedual a layout
			placementChanged = true;
			invalidateDisplayList();
		}
	}
	
	/**
	 * Updates the visibility of the dock bar when <code>autoHide</code>
	 * is <code>true</code>.
	 */
	protected function updateVisibility(mousePoint:Point):void
	{
		// get the hit rectangle for the placement
		var bounds:Rectangle = getHitRectangle();
		// whether the point is inside the hit rect
		var inArea:Boolean = bounds.containsPoint(mousePoint);
		// whether the mouse is over the dock bar
		var overUs:Boolean = false;
		
		var effect:IEffect = null;
		
		if (!inArea)
		{
			// check to see if the mouse is over the dock bar
			bounds = getRect(parent);
			overUs = bounds.containsPoint(mousePoint);
		}
		
		if (inArea && !hidden)
		{
			// if there is a showEffect, listen for it
			// else just show without event
			effect = getStyle("showEffect");
			if (effect)
				effect.addEventListener(EffectEvent.EFFECT_END, effectEndHandler);
			else
				setVisible(true, true);
			
			hidden = true;
			dispatchEvent(new FlexEvent("show"));
		}
		else if (!inArea && hidden)
		{
			// if there is a hideEffect, listen for it
			// else just hide without event			
			effect = getStyle("hideEffect");
			if (effect)
				effect.addEventListener(EffectEvent.EFFECT_END, effectEndHandler);			
			else
				setVisible(false, true);
			
			// if the mouse is not over this dock bar, hide it
			if (!overUs)
			{
				hidden = false;
				dispatchEvent(new FlexEvent("hide"));
			}
		}
	}
	
	/**
	 * Returns a String toolTip based on the item data.
	 * 
	 * @param The data item.
	 * @return A String toolTip.
	 */
	protected function itemToToolTip(item:Object):String
	{
		var tip:String;
		
		if (_toolTipFunction is Function)
			tip = _toolTipFunction(item);
		
		if (tip == null && _toolTipField != null)
			tip = item[_toolTipField];
		
		return tip;
	}
	
	/**
	 * Returns a Class icon based on the item data.
	 * 
	 * @param The data item.
	 * @return A Class icon.
	 */
	protected function itemToIcon(item:Object):Class
	{
		var icon:Class;
		
		if (_iconFunction is Function)
			icon = _iconFunction(item);
		
		if (icon == null && _iconField != null)
			icon = item[_iconField];
		
		return icon;
	}
	
	//--------------------------------------------------------------------------
	//
	//  Private :: Handlers
	//
	//--------------------------------------------------------------------------
	
	/**
	 * @private
	 */
	private function parent_creationCompleteHandler(event:FlexEvent):void
	{
		event.target.removeEventListener(
			FlexEvent.CREATION_COMPLETE, parent_creationCompleteHandler);
		
		// if the parent is not the systemManager, reparent
		if (!(parent is ISystemManager))
			addAsPopup();		
	}
	
	/**
	 * @private
	 */
	private function stage_resizeHandler(event:Event):void
	{
		layoutBar();
	}
	
	/**
	 * @private
	 */
	private function systemManager_mouseMoveHandler(event:MouseEvent):void
	{
		// the mouse point in stage coords
		var point:Point = new Point(event.stageX, event.stageY);
		
		// update the dock bar's visible state
		updateVisibility(point);
	}
	
	/**
	 * @private
	 */
	private function effectEndHandler(event:EffectEvent):void
	{
		// remove the listener
		event.target.removeEventListener(
			EffectEvent.EFFECT_END, effectEndHandler);
		
		// set the correct visibility based on whether the dock bar is hidden
		// do not dispatch an event since we are finished with the operation
		setVisible(hidden, true);
	}
	
	//--------------------------------------------------------------------------
	//
	//  Private :: Methods
	//
	//--------------------------------------------------------------------------
	
	/**
	 * @private
	 */
	private function defaultItemRendererFunction(item:Object):IFactory
	{
		return dockButton;
	}
	
	/**
	 * @private
	 */
	private function getHitRectangle():Rectangle
	{
		// the number of pixels the calculation uses to register a hit
		var autoHideThickness:Number = getStyle("autoHideThickness");		
		
		var rectangle:Rectangle = new Rectangle();
		
		switch (_placement)
		{
			case DockBarPlacement.TOP:
				rectangle.x = 0;
				rectangle.y = 0;
				rectangle.height = autoHideThickness;
				rectangle.width = stage.stageWidth;
				break;
			
			case DockBarPlacement.BOTTOM:
				rectangle.x = 0;
				rectangle.y = stage.stageHeight - autoHideThickness;
				rectangle.height = autoHideThickness;
				rectangle.width = stage.stageWidth;
				break;
			
			case DockBarPlacement.LEFT:
				rectangle.x = 0;
				rectangle.y = 0;
				rectangle.height = stage.stageHeight;
				rectangle.width = autoHideThickness;
				break;
			
			case DockBarPlacement.RIGHT:
				rectangle.x = stage.stageWidth - autoHideThickness;
				rectangle.y = 0;
				rectangle.height = stage.stageHeight;
				rectangle.width = autoHideThickness;
				break;			
		}
		
		return rectangle;
	}
	
	/**
	 * @private
	 */	
	private function updateButtonBarLayout():void
	{
		if (dataGroup && (dataGroup.layout is ButtonBarLayout))
		{
			ButtonBarLayout(dataGroup.layout).direction = 
				(DockBarPlacement.isVertical(_placement)) ? 
				ButtonBarDirection.VERTICAL : 
				ButtonBarDirection.HORIZONTAL;
			
			// invalidate size since the change in direction will invalidate
			// the dock bar's measurements
			invalidateSize();
		}
	}	
}
}