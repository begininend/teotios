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

import mx.core.INavigatorContent;
import mx.core.IUIComponent;
import mx.core.IVisualElement;

/**
 * The <code>INavigator</code> interface tags a container as having the 
 * ability to hold <code>INavigatorContent</code> and gives the ability 
 * to select it's content with the <code>selectedIndex</code> property
 * and the <code>selectedChild</code> property.
 * 
 * @author Michael Schmalle
 * @copyright Teoti Graphix, LLC
 * @productversion 1.0
 */
public interface INavigator extends IUIComponent, IVisualElement
{
	//--------------------------------------------------------------------------
	//
	//  Properties
	//
	//--------------------------------------------------------------------------
	
	//----------------------------------
	//  selectedIndex
	//----------------------------------

	/**
	 * The zero-based index of the currently visible visual element.
	 */
	function get selectedIndex():int;
	
	/**
	 * @private
	 */	
	function set selectedIndex(value:int):void;
	
	//----------------------------------
	//  selectedChild
	//----------------------------------
	
	/**
	 * The selected navigator content child.
	 * 
	 * <p>Usually a container will also implement the <code>ISelectableList</code>
	 * interface which gives the <code>selectedIndex</code> property in parallel
	 * with this property.</p>
	 */
	function get selectedChild():INavigatorContent;
	
	/**
	 * @private
	 */
	function set selectedChild(value:INavigatorContent):void;
		
	//----------------------------------
	//  resizeToContent
	//----------------------------------
	
	/**
	 * 
	 */
	function get resizeToContent():Boolean;
	
	/**
	 * @private
	 */
	function set resizeToContent(value:Boolean):void;
}
}