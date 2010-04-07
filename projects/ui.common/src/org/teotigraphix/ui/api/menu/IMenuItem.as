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

import spark.components.IItemRenderer;

/**
 * The <code>IMenuItem</code> interface defines components that will 
 * render a Class icon and text label.
 * 
 * @author Michael Schmalle
 * @copyright Teoti Graphix, LLC
 * @productversion 1.0
 */
public interface IMenuItem extends IItemRenderer
{
	//--------------------------------------------------------------------------
	//
	//  Properties
	//
	//--------------------------------------------------------------------------
	
	//----------------------------------
	//  label
	//----------------------------------
	
    /**
     * The String to display in the item renderer. 
     */
    //function get label():String;
		
	/**
	 * @private
	 */
    //function set label(value:String):void;
	
	//----------------------------------
	//  icon
	//----------------------------------
	
	/**
	 * The iconic representation of the menu item.
	 */
	function get icon():Class;
	
	/**
	 * @private
	 */
	function set icon(value:Class):void;
	
	//----------------------------------
	//  labelField
	//----------------------------------
	
	/**
	 * The field on the dataProvider used to get the label.
	 */
	function get labelField():String;
		
	/**
	 * @private
	 */
	function set labelField(value:String):void;
		
	//----------------------------------
	//  iconField
	//----------------------------------
	
	/**
	 * The field on the dataProvider used to get the icon.
	 */
	function get iconField():String;
		
	/**
	 * @private
	 */
	function set iconField(value:String):void;
}
}