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

import org.teotigraphix.ui.components.controlSupport.StatusBarBase;
import org.teotigraphix.ui.skins.StatusBarSkin;
import org.teotigraphix.ui.skins.controlSupport.BarBorderSkin;
import org.teotigraphix.ui.utils.StyleUtil;

/**
 * The StatusBar class is a style-skin implementation for the 
 * <code>StatusBarBase</code> class.
 * 
 * @author Michael Schmalle
 * @copyright Teoti Graphix, LLC
 * @productversion 1.0
 * 
 * @mxml
 */
public class StatusBar extends StatusBarBase
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
		else
			stylesInitialized = true;
		
		StyleUtil.create(
			"org.teotigraphix.ui.components.StatusBar",
			function ():void {
				this.skinClass = StatusBarSkin;
				
				// ComponentBase
				this.borderColor = 0xFFFFFF;
				this.borderAlpha = 1;
				
				this.backgroundColor = 0xFFFFFF;
				this.backgroundAlpha = 1;
				
				this.paddingTop = 2;
				this.paddingRight = 2;
				this.paddingBottom = 2;
				this.paddingLeft = 2;
				
				this.cornerRadius = 0;
				
				this.topLeftRadius = 0;
				this.topRightRadius = 0;
				this.bottomRightRadius = 0;
				this.bottomLeftRadius = 0;
				
				// BarBase
				this.barColors = [0xE2E2E2, 0xD9D9D9];
				this.barAlphas = [1, 1];
				this.barDividerColor = 0x242424;//0xC0C0C0;
				this.barHighlightColors = [0xFFFFFF, 0xCCCCCC];
				this.barHighlightAlphas = [1, 1];
				
				this.gap = 5;
				this.verticalAlign = "bottom";
				this.horizontalAlign = "left";
			});
	}
	
	//--------------------------------------------------------------------------
	//
	//  Constructor
	//
	//--------------------------------------------------------------------------
	
	/**
	 * Constructor.
	 */
	public function StatusBar()
	{
		super();
		
		initializeStyles();
	}
}
}