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
 * The <code>ITabNavigator</code> interface tags a container as having the 
 * ability to hold <code>INavigatorContent</code> and gives the ability 
 * to select it's content with a skin part <code>TabBar</code>.
 * 
 * <p>The <code>ITabNavigator</code> interface also allows the 
 * <code>TabBar</code>'s placement to be set at runtime by setting the 
 * <code>tabBarPlacement</code> property. Instead of replacing an entire
 * skin, the <code>TabBar</code> can be rearranged by the navigator's
 * default layout class.</p>
 * 
 * <p>Note: The default implementation of the <code>ITabNavigator</code> 
 * interface is the <code>TabNavigator</code>, this class when designed
 * had more of a developer in mind, so anything that designers want can
 * just be created in a new skin that implements the <code>ITabNavigator</code>'s
 * skin parts.</p>
 * 
 * @author Michael Schmalle
 * @copyright Teoti Graphix, LLC
 * @productversion 1.0
 */
public interface ITabNavigator
{
	//--------------------------------------------------------------------------
	//
	//  Properties
	//
	//--------------------------------------------------------------------------
	
	//----------------------------------
	//  tabBarPlacement
	//----------------------------------
	
	/**
	 * This property determines how the <code>tabBarDisplay</code> skin part is 
	 * layed out in the navigator.
	 * 
	 * <p>Possible values are <strong>top</strong>, <strong>right</strong>,
	 * <strong>bottom</strong> and <strong>left</strong>.</p>
	 * 
	 * @default top
	 * 
	 * @see org.teotigraphix.ui.core.TabBarPlacement
	 */
	function get tabBarPlacement():String;
	
	/**
	 * @private
	 */	
	function set tabBarPlacement(value:String):void;
	
	//----------------------------------
	//  tabBarRendererFunction
	//----------------------------------
	
	/**
	 * @private
	 */
	function get tabBarRendererFunction():Function;
	
	/**
	 * @private
	 */	
	function set tabBarRendererFunction(value:Function):void;
	
}
}