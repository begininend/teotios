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

package org.teotigraphix.ui.skins.controlSupport
{

import mx.core.EdgeMetrics;

import org.teotigraphix.ui.skins.ButtonSkin;
import org.teotigraphix.ui.utils.StyleUtil;

import spark.components.supportClasses.GroupBase;
import spark.layouts.VerticalLayout;
import spark.layouts.supportClasses.LayoutBase;

/**
 * @author Michael Schmalle
 * @copyright Teoti Graphix, LLC
 * @productversion 1.0
 */
public class ButtonLayout extends LayoutBase
{
	//--------------------------------------------------------------------------
	//
	//  Constructor
	//
	//--------------------------------------------------------------------------
	
	/**
	 * Constructor.
	 */
	public function ButtonLayout()
	{
		super();
	}
	
	//--------------------------------------------------------------------------
	//
	//  Overridden Public :: Methods
	//
	//--------------------------------------------------------------------------
	
	/**
	 * @private
	 */
	public override function measure():void
	{
		var layoutTarget:GroupBase = target;
		if (!layoutTarget)
			return;
		
		var skin:ButtonSkin = layoutTarget.owner as ButtonSkin;
		
		var metrics:EdgeMetrics = StyleUtil.getPaddingMetrics(skin);
		
		var placement:String = skin.hostComponent.labelPlacement;
		
		var mWidth:Number = 0;
		var mHeight:Number = 0;
		
		if (skin.iconDisplay)
		{
			mWidth += skin.iconDisplay.getPreferredBoundsWidth();
			mHeight = Math.max(mHeight, skin.iconDisplay.getPreferredBoundsHeight());
		}
		
		if (skin.labelDisplay)
		{
			mWidth += skin.getStyle("gap");
			
			mWidth += skin.labelDisplay.getPreferredBoundsWidth();
			mHeight = Math.max(mHeight, skin.labelDisplay.getPreferredBoundsHeight());
		}
		
		mWidth += metrics.left + metrics.right;
		mHeight += metrics.top + metrics.bottom;
		
		layoutTarget.measuredWidth = mWidth;
		layoutTarget.measuredHeight = mHeight;
		layoutTarget.measuredMinWidth = mWidth;
		layoutTarget.measuredMinHeight = mHeight;		
	}
	
	// XXX (mschmalle) implement Button.labelPlacement
	
	/**
	 * @private
	 */
	public override function updateDisplayList(width:Number, 
											   height:Number):void
	{
		var layoutTarget:GroupBase = target;
		if (!layoutTarget)
			return;
		
		var skin:ButtonSkin = layoutTarget.owner as ButtonSkin;
		
		var placement:String = skin.hostComponent.labelPlacement;
		
		var metrics:EdgeMetrics = StyleUtil.getPaddingMetrics(skin);
		
		var top:Number;
		var left:Number = metrics.left;
		
		if (skin.iconDisplay)
		{
			skin.iconDisplay.setLayoutBoundsSize(
				skin.iconDisplay.getPreferredBoundsWidth(),
				skin.iconDisplay.getPreferredBoundsHeight());
			skin.iconDisplay.setLayoutBoundsPosition(left, 
				Math.floor((height - skin.iconDisplay.getPreferredBoundsHeight()) / 2));
			
			left += skin.iconDisplay.getPreferredBoundsWidth();
		}
		
		if (skin.labelDisplay)
		{
			left += skin.getStyle("gap");
			
			skin.labelDisplay.setLayoutBoundsSize(
				skin.labelDisplay.getPreferredBoundsWidth(),
				skin.labelDisplay.getPreferredBoundsHeight());
			skin.labelDisplay.setLayoutBoundsPosition(left, 
				Math.floor((height - skin.labelDisplay.getPreferredBoundsHeight()) / 2) + 1);
		}		
	}
}
}