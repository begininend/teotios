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

import org.teotigraphix.ui.components.controlSupport.DataControlBase;
import org.teotigraphix.ui.skins.DataControlSkin;
import org.teotigraphix.ui.utils.StyleUtil;

/**
 * The DataControl is the default icon and label renderer.
 * 
 * <p>The default skin is the <code>DataControlSkin</code>.</p>
 * 
 * @author Michael Schmalle
 * @copyright Teoti Graphix, LLC
 * @productversion 1.0
 * 
 * @see org.teotigraphix.ui.skins.DataControlSkin
 */
public class DataControl extends DataControlBase
{
	//--------------------------------------------------------------------------
	//
	//  Class :: Initialization
	//
	//--------------------------------------------------------------------------
	
	/**
	 * @private
	 */
	private static var stylesInitialized:Boolean = false;
	
	/**
	 * @private
	 */
	private static function initializeStyles():void
	{
		if (stylesInitialized)
			return;
		
		StyleUtil.create(
			"org.teotigraphix.ui.components.DataControl",
			function ():void {
				this.skinClass = DataControlSkin;
			});
		
		stylesInitialized = true;
	}
	
	//--------------------------------------------------------------------------
	//
	//  Constructor
	//
	//--------------------------------------------------------------------------
	
	/**
	 * Constructor.
	 */
	public function DataControl()
	{
		super();
		
		initializeStyles();
	}
}
}