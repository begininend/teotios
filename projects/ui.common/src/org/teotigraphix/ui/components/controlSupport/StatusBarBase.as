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

package org.teotigraphix.ui.components.controlSupport
{

import org.teotigraphix.ui.api.IStatusBar;

/**
 * The StatusBarBase class implements the <code>IStatusBar</code> 
 * interface.
 * 
 * @author Michael Schmalle
 * @copyright Teoti Graphix, LLC
 * @productversion 1.0
 * 
 * @mxml
 */
public class StatusBarBase extends MessageBarBase implements IStatusBar
{
	//--------------------------------------------------------------------------
	//
	//  IStatusBar API :: Properties
	//
	//--------------------------------------------------------------------------
	
	//----------------------------------
	//  statusIcon
	//----------------------------------
	
	/**
	 * @copy org.teotigraphix.ui.api.IStatusBar#statusIcon
	 * @mxml null
	 */
	public function get statusIcon():Class
	{
		return super.icon;
	}
	
	/**
	 * @private
	 */
	public function set statusIcon(value:Class):void
	{
		super.icon = value;
	}
	
	//----------------------------------
	//  status
	//----------------------------------
	
	/**
	 * @copy org.teotigraphix.ui.api.IStatusBar#status
	 * @mxml
	 */
	public function get status():String
	{
		return super.label;
	}
	
	/**
	 * @private
	 */
	public function set status(value:String):void
	{
		super.label = value;
	}
		
	//--------------------------------------------------------------------------
	//
	//  Constructor
	//
	//--------------------------------------------------------------------------
	
	/**
	 * Constructor.
	 */
	public function StatusBarBase()
	{
		super();
	}
}
}