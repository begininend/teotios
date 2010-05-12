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
 * An enumerated class of <code>DockBar</code> placement values.
 * 
 * @author Michael Schmalle
 * @copyright Teoti Graphix, LLC
 * @productversion 1.0
 * 
 * @see org.teotigraphix.ui.api.IDockBar#placement
 */
public final class DockBarPlacement
{
	//--------------------------------------------------------------------------
	//
	// Public :: Constants
	//
	//--------------------------------------------------------------------------
	
	/**
	 * Constant that identifies the <strong>top</strong> placement.
	 */
	public static const TOP:String = "top";
	
	/**
	 * Constant that identifies the <strong>right</strong> placement.
	 */
	public static const RIGHT:String = "right";
	
	/**
	 * Constant that identifies the <strong>bottom</strong> placement.
	 */
	public static const BOTTOM:String = "bottom";
	
	/**
	 * Constant that identifies the <strong>left</strong> placement.
	 */
	public static const LEFT:String = "left";
	
	//--------------------------------------------------------------------------
	//
	// Public :: Methods
	//
	//--------------------------------------------------------------------------
	
	/**
	 * Returns whether the placement is in a vertical state.
	 * 
	 * @param placement A String indicating the placement value to test.
	 * @return A Boolean indicating whether the placement is vertical (true) or
	 * horizontal (false).
	 */
	public static function isVertical(placement:String):Boolean
	{
		return (placement == LEFT || placement == RIGHT);
	}
}
}