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

import mx.styles.IStyleClient;

import org.teotigraphix.ui.components.containerSupport.TitleContainerBase;
import org.teotigraphix.ui.skins.TitleContainerSkin;
import org.teotigraphix.ui.utils.StyleUtil;

//--------------------------------------
//  Styles
//--------------------------------------

/**
 * The alternate <code>skinClass</code> for the <code>borderDisplay</code>.
 * 
 * @mxml Class
 * @default undefined
 */
[Style(name="borderSkinClass",type="Class")]

/**
 * The alternate <code>skinClass</code> for the <code>titleBarDisplay</code>.
 * 
 * @mxml Class
 * @default undefined
 */
[Style(name="titleBarSkinClass",type="Class")]

[Style(name="offsetTitleBar",type="Boolean")]

//--------------------------------------
//  Styles
//--------------------------------------

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
	 * <code>com.teotigraphix.ui.components.TitleBar</code>.
	 */
	public static function initializeClass():void
	{
		if (stylesInitialized)
			return;
		else
			stylesInitialized = true;
		
		StyleUtil.create(
			"org.teotigraphix.ui.components.TitleContainer",
			function ():void {
				this.skinClass = TitleContainerSkin;
				
				this.borderVisible = true;
				this.borderAlpha = 0.5;
				this.borderColor = 0x000000;
				this.cornerRadius = 0;
				this.dropShadowVisible = true;
				
				this.offsetTitleBar = true;
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
	public function TitleContainer()
	{
		super();
		
		initializeClass();
	}
	
	//--------------------------------------------------------------------------
	//
	//  Overridden Protected :: Methods
	//
	//--------------------------------------------------------------------------
	
	/**
	 * @private
	 */
	override protected function partAdded(partName:String, instance:Object):void
	{
		super.partAdded(partName, instance);
		
		if (instance == borderDisplay)
		{
			StyleUtil.setSkinClass(this, borderDisplay as IStyleClient);
		}
		
		if (instance == titleBarDisplay)
		{
			StyleUtil.setSkinClass(this, titleBarDisplay);
		}
	}
	
	//--------------------------------------------------------------------------
	//
	//  Overridden Public :: Methods
	//
	//--------------------------------------------------------------------------
	
	/**
	 * @private
	 */
	public override function styleChanged(styleProp:String):void
	{
		super.styleChanged(styleProp);
		
		var allStyles:Boolean = styleProp == null || styleProp == "styleName";
		
		if (allStyles || styleProp == "borderSkinClass")
		{
			StyleUtil.setSkinClass(this, borderDisplay as IStyleClient);
		}		
		
		if (allStyles || styleProp == "titleBarSkinClass")
		{
			StyleUtil.setSkinClass(this, titleBarDisplay);
		}
	}
}
}