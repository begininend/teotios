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

package org.teotigraphix.ui.skins.containerSupport
{

import org.teotigraphix.ui.core.BarPlacement;
import org.teotigraphix.ui.skins.TitleContainerSkin;

import spark.components.supportClasses.GroupBase;
import spark.layouts.supportClasses.LayoutBase;

/**
 * @author Michael Schmalle
 * @copyright Teoti Graphix, LLC
 * @productversion 1.0
 */
public class TitleContainerSkinLayout extends LayoutBase
{
	//--------------------------------------------------------------------------
	//
	//  Private :: Variables
	//
	//--------------------------------------------------------------------------
	
	/**
	 * @private
	 */
	protected var contentWidth:Number;
	
	/**
	 * @private
	 */
	protected var contentHeight:Number;	
	
	/**
	 * @private
	 */
	protected var cornerRadius:Number;
	
	/**
	 * @private
	 */
	protected var borderVisible:Boolean;
	
	/**
	 * @private
	 */
	protected var borderWeight:Number;
	
	/**
	 * @private
	 */
	protected var titleBarWidth:Number;
	
	/**
	 * @private
	 */
	protected var titleBarHeight:Number;
	
	
	protected var offsetTitleBar:Boolean = false;
	
	
	
	
	public function TitleContainerSkinLayout()
	{
		super();
	}
	
	
	public override function measure():void
	{
		var layoutTarget:GroupBase = target;
		if (!target)
			return;
		
		var skin:TitleContainerSkin = layoutTarget as TitleContainerSkin;
		
		var mWidth:Number = 0;
		var mHeight:Number = 0;		
		
		mWidth += Math.max(
			skin.contentGroup.getMinBoundsWidth(),
			skin.contentGroup.getPreferredBoundsWidth());
		
		mHeight += Math.max(
			skin.contentGroup.getMinBoundsHeight(),
			skin.contentGroup.getPreferredBoundsHeight());
		
		// don't measure padding, contentGroup layout calcs that
		
		offsetTitleBar = skin.getStyle("offsetTitleBar");
		
		// add border width
		borderVisible = skin.getStyle("borderVisible");
		borderWeight = skin.getStyle("borderWeight");
		if (!borderVisible)
			borderWeight = 0;
		
		if (skin.titleBarDisplay)
		{
			if (skin.hostComponent.titleBarPlacement == "left" ||
				skin.hostComponent.titleBarPlacement == "right")
			{
				mHeight = Math.max(mHeight, skin.titleBarDisplay.getPreferredBoundsHeight());
				mWidth += skin.titleBarDisplay.getPreferredBoundsWidth();
				
				// add the offsets to the measurements if we are offsetting the titleBar
				mHeight += (offsetTitleBar) ? borderWeight * 2 : 0;
				mWidth += (offsetTitleBar) ? borderWeight * 2 : borderWeight;				
			}
			else
			{
				mWidth = Math.max(mWidth, skin.titleBarDisplay.getPreferredBoundsWidth());
				mHeight += skin.titleBarDisplay.getPreferredBoundsHeight();
				
				// add the offsets to the measurements if we are offsetting the titleBar
				mWidth += (offsetTitleBar) ? borderWeight * 2 : 0;
				mHeight += (offsetTitleBar) ? borderWeight * 2 : borderWeight;
			}
		}
		
		layoutTarget.measuredWidth = mWidth;
		layoutTarget.measuredHeight = mHeight;
		layoutTarget.measuredMinWidth = mWidth;
		layoutTarget.measuredMinHeight = mHeight;		
	}
	

	public override function updateDisplayList(width:Number, height:Number):void
	{
		var layoutTarget:GroupBase = target;
		if (!target)
			return;
		
		var skin:TitleContainerSkin = layoutTarget as TitleContainerSkin;
		
		offsetTitleBar = skin.getStyle("offsetTitleBar");
		
		borderVisible = skin.getStyle("borderVisible");
		borderWeight = skin.getStyle("borderWeight");
		if (!borderVisible)
			borderWeight = 0;
		
		titleBarWidth = skin.titleBarDisplay.getPreferredBoundsWidth();
		titleBarHeight = skin.titleBarDisplay.getPreferredBoundsHeight();	
		
		skin.borderDisplay.visible = borderVisible;
		
		switch(skin.hostComponent.titleBarPlacement)
		{
			case BarPlacement.TOP:
				
				updateHorizontal(width, height);
				layoutTop(width, height);
				
				break;
			
			case BarPlacement.BOTTOM:
				
				updateHorizontal(width, height);
				layoutBottom(width, height);
				
				break;
			
			case BarPlacement.LEFT:
				
				updateVertical(width, height);
				layoutLeft(width, height);
				
				break;
			
			case BarPlacement.RIGHT:
				
				updateVertical(width, height);
				layoutRight(width, height);
				
				break;
		}		
	}
	
	/**
	 * Updates the layout with cached values for <strong>horizontal</strong>
	 * positioning.
	 * 
	 * @param width The layout width.
	 * @param height The layout height.
	 */
	protected function updateHorizontal(width:Number, height:Number):void
	{
		contentWidth = width - (borderWeight * 2);
		contentHeight = height - titleBarHeight - borderWeight;
	}
	
	/**
	 * Updates the layout with cached values for <strong>vertical</strong>
	 * positioning.
	 * 
	 * @param width The layout width.
	 * @param height The layout height.
	 */
	protected function updateVertical(width:Number, height:Number):void
	{
		contentHeight = height - (borderWeight * 2);
		contentWidth = width - titleBarWidth - borderWeight;
	}
	
	/**
	 * Subclasses override to implement layout <strong>top</strong>
	 * features.
	 * 
	 * <p>Called from <code>#updateDisplayList()</code>.</p>
	 * 
	 * @param width The layout width.
	 * @param height The layout height.
	 */
	protected function layoutTop(width:Number, height:Number):void
	{
		var layoutTarget:GroupBase = target;
		var skin:TitleContainerSkin = layoutTarget as TitleContainerSkin;
		
		if (borderVisible)
		{
			// layout border
			skin.borderDisplay.setLayoutBoundsPosition(0, 0);
			skin.borderDisplay.setLayoutBoundsSize(width, height);
		}
		
		if (skin.titleBarDisplay)
		{
			var tx:Number = (offsetTitleBar) ? borderWeight : 0;
			var ty:Number = (offsetTitleBar) ? borderWeight : 0;
			var tw:Number = (offsetTitleBar) ? width - (borderWeight * 2) : width;
			
			// layout titleBar
			skin.titleBarDisplay.setLayoutBoundsSize(tw, titleBarHeight);
			skin.titleBarDisplay.setLayoutBoundsPosition(tx, ty);
		}
		
		// layout contentGroup
		skin.contentGroup.setLayoutBoundsSize(contentWidth, contentHeight);
		skin.contentGroup.setLayoutBoundsPosition(borderWeight, titleBarHeight);
	}
	
	/**
	 * Subclasses override to implement layout <strong>bottom</strong>
	 * features.
	 * 
	 * <p>Called from <code>#updateDisplayList()</code>.</p>
	 * 
	 * @param width The layout width.
	 * @param height The layout height.
	 */
	protected function layoutBottom(width:Number, height:Number):void
	{
		var layoutTarget:GroupBase = target;
		var skin:TitleContainerSkin = layoutTarget as TitleContainerSkin;
		
		if (borderVisible)
		{
			// layout border
			skin.borderDisplay.setLayoutBoundsPosition(0, 0);
			skin.borderDisplay.setLayoutBoundsSize(width, height);
		}
		
		if (skin.titleBarDisplay)
		{
			var tx:Number = (offsetTitleBar) ? borderWeight : 0;
			var ty:Number = (offsetTitleBar) ? borderWeight : 0;
			var tw:Number = (offsetTitleBar) ? width - (borderWeight * 2) : width;
			ty = height - titleBarHeight - ty;
			
			// layout titleBar
			skin.titleBarDisplay.setLayoutBoundsSize(tw, titleBarHeight);
			skin.titleBarDisplay.setLayoutBoundsPosition(tx, ty);
		}
		
		// layout contentGroup
		skin.contentGroup.setLayoutBoundsSize(contentWidth, contentHeight);
		skin.contentGroup.setLayoutBoundsPosition(borderWeight, borderWeight);		
	}
	
	/**
	 * Subclasses override to implement layout <strong>left</strong>
	 * features.
	 * 
	 * <p>Called from <code>#updateDisplayList()</code>.</p>
	 * 
	 * @param width The layout width.
	 * @param height The layout height.
	 */
	protected function layoutLeft(width:Number, height:Number):void
	{
		var layoutTarget:GroupBase = target;
		var skin:TitleContainerSkin = layoutTarget as TitleContainerSkin;
		
		if (borderVisible)
		{
			// layout border
			skin.borderDisplay.setLayoutBoundsPosition(0, 0);
			skin.borderDisplay.setLayoutBoundsSize(width, height);
		}
		
		if (skin.titleBarDisplay)
		{
			var tx:Number = (offsetTitleBar) ? borderWeight : 0;
			var ty:Number = (offsetTitleBar) ? borderWeight : 0;
			var th:Number = (offsetTitleBar) ? height - (borderWeight * 2) : height;
			
			// layout titleBar
			skin.titleBarDisplay.setLayoutBoundsSize(titleBarWidth, th);
			skin.titleBarDisplay.setLayoutBoundsPosition(tx, ty);
		}
		
		// layout contentGroup
		skin.contentGroup.setLayoutBoundsSize(contentWidth, contentHeight);
		skin.contentGroup.setLayoutBoundsPosition(titleBarWidth, borderWeight);			
	}
	
	/**
	 * Subclasses override to implement layout <strong>right</strong>
	 * features.
	 * 
	 * <p>Called from <code>#updateDisplayList()</code>.</p>
	 * 
	 * @param width The layout width.
	 * @param height The layout height.
	 */
	protected function layoutRight(width:Number, height:Number):void
	{
		var layoutTarget:GroupBase = target;
		var skin:TitleContainerSkin = layoutTarget as TitleContainerSkin;
		
		if (borderVisible)
		{
			// layout border
			skin.borderDisplay.setLayoutBoundsPosition(0, 0);
			skin.borderDisplay.setLayoutBoundsSize(width, height);
		}
		
		if (skin.titleBarDisplay)
		{
			var tx:Number = (offsetTitleBar) ? borderWeight : 0;
			var ty:Number = (offsetTitleBar) ? borderWeight : 0;
			var th:Number = (offsetTitleBar) ? height - (borderWeight * 2) : height;
			tx = width - titleBarWidth - tx;
			
			// layout titleBar
			skin.titleBarDisplay.setLayoutBoundsSize(titleBarWidth, th);
			skin.titleBarDisplay.setLayoutBoundsPosition(tx, ty);
		}
		
		// layout contentGroup
		skin.contentGroup.setLayoutBoundsSize(contentWidth, contentHeight);
		skin.contentGroup.setLayoutBoundsPosition(borderWeight, borderWeight);
	}
}
}