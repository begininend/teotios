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

package org.teotigraphix.ui.core
{

/**
 * An enumerated class of bar placement values.
 * 
 * @author Michael Schmalle
 * @copyright Teoti Graphix, LLC
 * @productversion 1.0
 */
public final class BarPlacement
{
	//--------------------------------------------------------------------------
	//
	// Public :: Constants
	//
	//--------------------------------------------------------------------------
	
	/**
	 * Constant that identifies the <strong>top</strong> layout placement.
	 */
	public static const TOP:String = "top";
	
	/**
	 * Constant that identifies the <strong>right</strong> layout placement.
	 */
	public static const RIGHT:String = "right";
	
	/**
	 * Constant that identifies the <strong>bottom</strong> layout placement.
	 */
	public static const BOTTOM:String = "bottom";
	
	/**
	 * Constant that identifies the <strong>left</strong> layout placement.
	 */
	public static const LEFT:String = "left";
	
	//--------------------------------------------------------------------------
	//
	//  Public Class :: Methods
	//
	//--------------------------------------------------------------------------
	
	/**
	 * Returns whether the placement passed is a valid placement.
	 * 
	 * @param value A string indicating the placement to check for valid.
	 */
	public static function isValid(value:String):Boolean
	{
		switch(value)
		{
			case TOP:
			case RIGHT:
			case BOTTOM:
			case LEFT:
				return true;
			default:
				return false;
		}
	}
	
	/**
	 * Returns an enumerated Array.
	 * 
	 * @return An Array of placement values.
	 */
	public static function toArray():Array
	{
		return [TOP, RIGHT, BOTTOM, LEFT];
	}
}
}