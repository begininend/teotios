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

import spark.components.supportClasses.SkinnableComponent;

/**
 * The ComponentBorder allows for a border placeholder in a component's skin.
 * 
 * <p>For more complex composite skins, this simplifies the border graphic 
 * code.</p>
 * 
 * <p>The class also synchronizes the <code>currentState</code> of the class
 * to it's skin. This is handy if a skin needs to know the current state of
 * it's host and render based on that state.</p>
 * 
 * @author Michael Schmalle
 * @copyright Teoti Graphix, LLC
 * @productversion 1.0
 */
public class ComponentBorder extends SkinnableComponent
{
	//--------------------------------------------------------------------------
	//
	//  Overridden Public :: Properties
	//
	//--------------------------------------------------------------------------
	
	//----------------------------------
	//  currentState
	//----------------------------------
	
	/**
	 * @private
	 */
	private var currentStateChanged:Boolean = false;
	
	/**
	 * @private
	 */
	private var _currentState:String;
	
	/**
	 * @private
	 */
	public override function set currentState(value:String):void
	{
		_currentState = value;
		currentStateChanged = true;
		invalidateProperties();
	}
	
	//--------------------------------------------------------------------------
	//
	//  Constructor
	//
	//--------------------------------------------------------------------------
	
	/**
	 * Constructor.
	 */
	public function ComponentBorder()
	{
		super();
	}
	
	//--------------------------------------------------------------------------
	//
	//  Overridden Protected :: Methods
	//
	//--------------------------------------------------------------------------
	
	/**
	 * @private
	 */
	protected override function commitProperties():void
	{
		super.commitProperties();
		
		if (currentStateChanged)
		{
			if (skin)
			{
				skin.currentState = _currentState;
			}
			
			currentStateChanged = false;
		}
	}
}
}