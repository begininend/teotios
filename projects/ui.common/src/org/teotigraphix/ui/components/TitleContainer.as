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
import org.teotigraphix.ui.components.containerSupport.TitleContainerBase;
import org.teotigraphix.ui.skins.TitleContainerSkin;
import org.teotigraphix.ui.utils.StyleUtil;

/**
 * The TitleContainer class is a style-skin implementation fo the 
 * <code>TitleContainerBase</code> class.
 * 
 * @author Michael Schmalle
 * @copyright Teoti Graphix, LLC
 * @productversion 1.0
 * @mxml
 */
public class TitleContainer extends TitleContainerBase
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
	 * Initializes the TypeSelector for the 
	 * <code>org.teotigraphix.ui.components.TitleBar</code>.
	 */
	public static function initializeClass():void
	{
		if (stylesInitialized)
			return;
		
		StyleUtil.create(
			"org.teotigraphix.ui.components.TitleContainer",
			function ():void {
				
				this.skinClass = TitleContainerSkin;
				
				/*
				this.borderColor = 0xFFFFFF;
				this.borderAlpha = 1;
				
				this.backgroundColor = 0xFFFFFF;
				this.backgroundAlpha = 1;
				
				this.headerColors = undefined;
				this.headerAlphas = undefined;
				
				this.gap = 2;
				
				this.paddingTop = 2;
				this.paddingRight = 2;
				this.paddingBottom = 2;
				this.paddingLeft = 2;
				
				this.cornerRadius = 0;
				
				this.topLeftRadius = 0;
				this.topRightRadius = 0;
				this.bottomRightRadius = 0;
				this.bottomLeftRadius = 0;
				*/
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
	public function TitleContainer()
	{
		super();
		
		initializeClass();
	}
}
}