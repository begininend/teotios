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

package org.teotigraphix.ui.api
{

/**
 * The ITitleContainer interface marks a component as having the 
 * ability to represent title information of a client context within a 
 * container holding a content group of children.
 * 
 * <p>This interface assumes there will be a titleBar, contentGroup and
 * statusBar composite existing within the container.</p>
 * 
 * @author Michael Schmalle
 * @copyright Teoti Graphix, LLC
 * @productversion 1.0
 */
public interface ITitleContainer
{
	//--------------------------------------------------------------------------
	//
	//  Properties
	//
	//--------------------------------------------------------------------------
	
	//----------------------------------
	//  titleBar
	//----------------------------------
	
	/**
	 * Returns the <code>titleBarDisplay</code> instance.
	 * 
	 * <p>In the default implementation of the <code>TitleContainerBase</code>,
	 * this property will return it's <code>titleBarDisplay</code> skin
	 * part.</p>
	 */
	function get titleBar():ITitleBar;
	
	//----------------------------------
	//  statusBar
	//----------------------------------
	
	/**
	 * Returns the <code>statusBarDisplay</code> instance.
	 * 
	 * <p>In the default implementation of the <code>TitleContainerBase</code>,
	 * this property will return it's <code>statusBarDisplay</code> skin
	 * part.</p>
	 */
	function get statusBar():IStatusBar;

	//----------------------------------
	//  showTitleBar
	//----------------------------------
	
	/**
	 * Wether the <code>titleBar</code> is visible or invisible.
	 * 
	 * <p>When setting this property, if the container has an explicitHeight,
	 * the content will expand to fill the area where the titleBar was located.
	 * If an explicitHeight has not been set, the container will shrink and
	 * the content area will remain the same size.</p>
	 */
	function get showTitleBar():Boolean;
	
	/**
	 * @private
	 */
	function set showTitleBar(value:Boolean):void;
	
	//----------------------------------
	//  showStatusBar
	//----------------------------------
	
	/**
	 * Wether the <code>statusBar</code> is visible or invisible.
	 * 
	 * <p>When setting this property, if the container has an explicitHeight,
	 * the content will expand to fill the area where the <code>statusBar</code>
	 *  was located. If an explicitHeight has not been set, the 
	 * container will shrink and the content area will remain the 
	 * same size.</p>
	 */
	function get showStatusBar():Boolean;
	
	/**
	 * @private
	 */
	function set showStatusBar(value:Boolean):void;
	
	//----------------------------------
	//  showContentGroup
	//----------------------------------
	
	/**
	 * Wether the <code>contentGroup</code> or <code>scroller</code> 
	 * is visible or invisible.
	 */
	function get showContentGroup():Boolean;
	
	/**
	 * @private
	 */
	function set showContentGroup(value:Boolean):void;
	
	//----------------------------------
	//  titleBarPlacement
	//---------------------------------- 
	
	/**
	 * The placement of the title bar within it's container.
	 * 
	 * <p>Use the ControlBarPlacement class to specify the correct
	 * position for the title bar.</p>
	 * 
	 * <p>The four placements are;
	 * <ul>
	 * <li><code>org.teotigraphix.ui.core.BarPlacement#TOP</code></li>
	 * <li><code>org.teotigraphix.ui.core.BarPlacement#RIGHT</code></li>
	 * <li><code>org.teotigraphix.ui.core.BarPlacement#BOTTOM</code></li>
	 * <li><code>org.teotigraphix.ui.core.BarPlacement#LEFT</code></li>
	 * </ul>
	 * </p>
	 */
	function get titleBarPlacement():String;
	
	/**
	 * @private
	 */
	function set titleBarPlacement(value:String):void;
	
	//--------------------------------------------------------------------------
	//
	//  ITitleBar API :: Properties
	//
	//--------------------------------------------------------------------------
	
	//----------------------------------
	//  titleIcon
	//----------------------------------
	
	/**
	 * The graphical representation of the client context.
	 * 
	 * @productversion 1.0
	 */
	function get titleIcon():Class;
	
	/**
	 * @private
	 */
	function set titleIcon(value:Class):void;
	
	//----------------------------------
	//  title
	//----------------------------------
	
	/**
	 * The textual representation of the client context.
	 * 
	 * @productversion 1.0
	 */
	function get title():String;
	
	/**
	 * @private
	 */
	function set title(value:String):void;
	
	//----------------------------------
	//  showMinimizeButton
	//----------------------------------
	
	/**
	 * Whether to show the <code>minimizeButtonDisplay</code> of the title bar.
	 * 
	 * @productversion 1.0
	 */
	function get showMinimizeButton():Boolean;
	
	/**
	 * @private
	 */
	function set showMinimizeButton(value:Boolean):void;
	
	//----------------------------------
	//  showMaximizeButton
	//----------------------------------
	
	/**
	 * Whether to show the <code>maximizeButtonDisplay</code> of the title bar.
	 * 
	 * @productversion 1.0
	 */
	function get showMaximizeButton():Boolean;
	
	/**
	 * @private
	 */
	function set showMaximizeButton(value:Boolean):void;
	
	//----------------------------------
	//  showCloseButton
	//----------------------------------
	
	/**
	 * Whether to show the <code>closeButtonDisplay</code> of the title bar.
	 * 
	 * @productversion 1.0
	 */
	function get showCloseButton():Boolean;
	
	/**
	 * @private
	 */
	function set showCloseButton(value:Boolean):void;
	
	//--------------------------------------------------------------------------
	//
	//  IStatusBar API :: Properties
	//
	//--------------------------------------------------------------------------
	
	//----------------------------------
	//  statusIcon
	//----------------------------------
	
	/**
	 * The graphical representation of the client context.
	 * 
	 * @productversion 1.0
	 */
	function get statusIcon():Class;
	
	/**
	 * @private
	 */
	function set statusIcon(value:Class):void;
	
	//----------------------------------
	//  status
	//----------------------------------
	
	/**
	 * The textual representation of the client context.
	 * 
	 * @productversion 1.0
	 */
	function get status():String;
	
	/**
	 * @private
	 */
	function set status(value:String):void;
	
	//--------------------------------------------------------------------------
	//
	//  Methods
	//
	//--------------------------------------------------------------------------
}
}