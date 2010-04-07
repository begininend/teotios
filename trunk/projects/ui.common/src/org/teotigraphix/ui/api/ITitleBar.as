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
 * The ITitleBar interface marks a component as having the ability to
 * represent title information of a client context.
 * 
 * @author Michael Schmalle
 * @copyright Teoti Graphix, LLC
 * @productversion 1.0
 */
public interface ITitleBar
{
	//--------------------------------------------------------------------------
	//
	//  Properties
	//
	//--------------------------------------------------------------------------
	
	//----------------------------------
	//  titleIcon
	//----------------------------------
	
	/**
	 * The iconic representation of the client context.
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
	 */
	function get showCloseButton():Boolean;
	
	/**
	 * @private
	 */
	function set showCloseButton(value:Boolean):void;
}
}