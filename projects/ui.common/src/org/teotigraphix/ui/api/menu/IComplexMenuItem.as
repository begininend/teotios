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

package org.teotigraphix.ui.api.menu
{

import mx.collections.IList;

/**
 * The <code>IComplexMenuItem</code> interface defines components that will 
 * render a list of data, hold selection state and render a main icon 
 * and label.
 * 
 * <p>The additional responsibilities include maintaining a data provider
 * provided by the <code>data</code> property and rendering <strong>open</strong> 
 * and <strong>closed</strong> user interface states.</p>
 * 
 * @author Michael Schmalle
 * @copyright Teoti Graphix, LLC
 * @productversion 1.0
 */
public interface IComplexMenuItem extends IMenuItem
{
	//--------------------------------------------------------------------------
	//
	//  Properties
	//
	//--------------------------------------------------------------------------
	
	//----------------------------------
	//  dataProvider
	//----------------------------------
	
	/**
	 * Returns the <code>IList</code> dataProvider for this list item.
	 */
	function get dataProvider():IList;
	
	//----------------------------------
	//  selectedIndex
	//----------------------------------
	
	/**
	 * The selected index of the menu item dataProvider.
	 */
	function get selectedIndex():int;
	
	/**
	 * @private
	 */
	function set selectedIndex(value:int):void;
	
	//----------------------------------
	//  open
	//----------------------------------
	
	/**
	 * Whether the list item is open <code>true</code> or closed 
	 * <code>false</code>.
	 */
	function get opened():Boolean;
	
	/**
	 * @private
	 */	
	function set opened(value:Boolean):void;
}
}