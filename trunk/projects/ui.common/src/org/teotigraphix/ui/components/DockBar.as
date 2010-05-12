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

package org.teotigraphix.ui.components
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

import org.teotigraphix.ui.components.componentSupport.DockBarBase;
import org.teotigraphix.ui.components.componentSupport.DockBarButton;
import org.teotigraphix.ui.core.DockBarPlacement;
import org.teotigraphix.ui.layouts.ButtonBarDirection;
import org.teotigraphix.ui.layouts.controlSupport.ButtonBarLayout;

//--------------------------------------
//  Class
//--------------------------------------

/**
 * A concrete implementation of the <code>IDockBar</code> interface.
 * 
 * <p>Adds rollOut and rollOver actions to the dock bar buttons.</p>
 * 
 * @author Michael Schmalle
 * @copyright Teoti Graphix, LLC
 * @productversion 1.0
 */
public class DockBar extends DockBarBase
{
	//--------------------------------------------------------------------------
	//
	//  Public SkinPart :: Variables
	//
	//--------------------------------------------------------------------------
	
	//----------------------------------
	//  rollOverAction
	//----------------------------------
	
	[SkinPart(required="false")]
	
	/**
	 * The rollOver effect factory that gets assigned to each renderer's
	 * <code>rollOverEffect</code> style.
	 */
	public var rollOverAction:IFactory;
	
	//----------------------------------
	//  rollOutAction
	//----------------------------------
	
	[SkinPart(required="false")]
	
	/**
	 * The rollOut effect factory that gets assigned to each renderer's
	 * <code>rollOutEffect</code> style.
	 */
	public var rollOutAction:IFactory;
	
	//--------------------------------------------------------------------------
	//
	//  Constructor
	//
	//--------------------------------------------------------------------------
	
	/**
	 * Constructor.
	 */
	public function DockBar()
	{
		super();
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
		
		// check to see if we add a rollOverEffect
		if (rollOverAction)
		{
			var ev:IEffect = rollOverAction.newInstance();
			UIComponent(renderer).setStyle("rollOverEffect", ev);
		}
		
		// check to see if we add a rollOutEffect
		if (rollOutAction)
		{
			var eo:IEffect = rollOutAction.newInstance();
			UIComponent(renderer).setStyle("rollOutEffect", eo);
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
	override protected function commitProperties():void
	{
		super.commitProperties();
	}
	
	/**
	 * @private
	 */
	override protected function updateDisplayList(unscaledWidth:Number, 
												  unscaledHeight:Number):void
	{
		super.updateDisplayList(unscaledWidth, unscaledHeight);
	}
}
}