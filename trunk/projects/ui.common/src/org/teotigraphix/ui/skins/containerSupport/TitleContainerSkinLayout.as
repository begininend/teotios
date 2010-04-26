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

import mx.core.IVisualElement;

import org.teotigraphix.ui.components.containerSupport.TitleContainerBase;
import org.teotigraphix.ui.core.BarPlacement;
import org.teotigraphix.ui.skins.TitleContainerSkin;

import spark.components.Group;
import spark.components.supportClasses.GroupBase;
import spark.layouts.supportClasses.LayoutBase;

/**
 * A default custom layout for the TitleContainerSkin.
 * 
 * <p>The layout allows for top, right, bottom and left titleBar placements.
 * The statusBar if visible will always be layed out on the bottom of the
 * container. If the titleBarPlacement value is bottom and the statusBar
 * is visible, the statusBar will be placed above the titleBar with the
 * content above it.</p>
 * 
 * <p>A possible subclass could allow the status bar to be layed out next
 * to the title bar at all times.</p>
 * 
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
	
	/**
	 * @private
	 */
	protected var statusBarWidth:Number;
	
	/**
	 * @private
	 */
	protected var statusBarHeight:Number;
	
	/**
	 * @private
	 */
	protected var insetTitleBar:Boolean = false;
	
	/**
	 * @private
	 */
	protected var container:TitleContainerBase;
	
	//--------------------------------------------------------------------------
	//
	//  Constructor
	//
	//--------------------------------------------------------------------------
	
	/**
	 * Constructor.
	 */
	public function TitleContainerSkinLayout()
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
		if (!target)
			return;
		
		var skin:TitleContainerSkin = layoutTarget as TitleContainerSkin;
		container = skin.hostComponent;
		
		var placement:String = container.titleBarPlacement;
		
		var titleBar:IVisualElement = container.titleBarDisplay;
		var contentGroup:Group = container.contentGroup;
		var statusBar:IVisualElement = container.statusBarDisplay;
		
		var mWidth:Number = 0;
		var mHeight:Number = 0;
		
		insetTitleBar = container.getStyle("insetTitleBar");
		
		// add border width
		borderVisible = container.getStyle("borderVisible");
		borderWeight = container.getStyle("borderWeight");
		if (!borderVisible)
			borderWeight = 0;
		
		// measure contentGroup's min & max
		mWidth += Math.max(
			contentGroup.getMinBoundsWidth(),
			contentGroup.getPreferredBoundsWidth());
		
		mHeight += Math.max(
			contentGroup.getMinBoundsHeight(),
			contentGroup.getPreferredBoundsHeight());
		
		// measure the titleBar
		if (titleBar && container.showTitleBar)
		{
			if (placement == "left" || placement == "right")
			{
				mHeight = Math.max(mHeight, titleBar.getPreferredBoundsHeight());
				mWidth += titleBar.getPreferredBoundsWidth();
				
				// add the offsets to the measurements if we are offsetting the titleBar
				mHeight += (insetTitleBar) ? borderWeight * 2 : 0;
				mWidth += (insetTitleBar) ? borderWeight * 2 : borderWeight;				
			}
			else
			{
				mWidth = Math.max(mWidth, titleBar.getPreferredBoundsWidth());
				mHeight += titleBar.getPreferredBoundsHeight();
				
				// add the offsets to the measurements if we are offsetting the titleBar
				mWidth += (insetTitleBar) ? borderWeight * 2 : 0;
				mHeight += (insetTitleBar) ? borderWeight * 2 : borderWeight;
			}
		}
		
		// measure the statusBar
		if (statusBar && container.showStatusBar)
		{
			mWidth = Math.max(mWidth, statusBar.getPreferredBoundsWidth());
			mHeight += statusBar.getPreferredBoundsHeight();
		}
		
		layoutTarget.measuredWidth = mWidth;
		layoutTarget.measuredHeight = mHeight;
		layoutTarget.measuredMinWidth = mWidth;
		layoutTarget.measuredMinHeight = mHeight;		
	}
	
	/**
	 * @private
	 */
	public override function updateDisplayList(width:Number, height:Number):void
	{
		var layoutTarget:GroupBase = target;
		if (!target)
			return;
		
		var skin:TitleContainerSkin = layoutTarget as TitleContainerSkin;
		container = skin.hostComponent;
		
		var titleBar:IVisualElement = container.titleBarDisplay;
		var contentGroup:Group = container.contentGroup;
		var statusBar:IVisualElement = container.statusBarDisplay;
		
		insetTitleBar = container.getStyle("insetTitleBar");
		
		borderVisible = container.getStyle("borderVisible");
		var borderWeight:Number = container.getStyle("borderWeight");
		if (!borderVisible)
			borderWeight = 0;
		
		titleBarWidth = titleBar.getPreferredBoundsWidth();
		titleBarHeight = titleBar.getPreferredBoundsHeight();
		
		statusBarWidth = statusBar.getPreferredBoundsWidth();
		statusBarHeight = statusBar.getPreferredBoundsHeight();		
		
		if (container.borderDisplay)
		{
			container.borderDisplay.visible = borderVisible;
			container.borderDisplay.includeInLayout = borderVisible;
		}
		
		switch(container.titleBarPlacement)
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
		// if the titleBar is offset into the container, only count one borderWeight
		var weight:Number = (insetTitleBar) ? borderWeight * 2 : borderWeight;
		contentHeight = height - titleBarHeight - statusBarHeight - weight;
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
		contentHeight = height - (borderWeight * 2) - statusBarHeight;
		// if the titleBar is offset into the container, only count one borderWeight
		var weight:Number = (insetTitleBar) ? borderWeight * 2 : borderWeight;
		contentWidth = width - titleBarWidth - weight;
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
		if (container.borderDisplay && borderVisible)
		{
			// layout border
			container.borderDisplay.setLayoutBoundsPosition(0, 0);
			container.borderDisplay.setLayoutBoundsSize(width, height);
		}
		
		if (container.titleBarDisplay && container.showTitleBar)
		{
			var tx:Number = (insetTitleBar) ? borderWeight : 0;
			var ty:Number = (insetTitleBar) ? borderWeight : 0;
			var tw:Number = (insetTitleBar) ? width - (borderWeight * 2) : width;
			
			// layout titleBar
			container.titleBarDisplay.setLayoutBoundsSize(tw, titleBarHeight);
			container.titleBarDisplay.setLayoutBoundsPosition(tx, ty);
		}
		
		// layout contentGroup
		container.contentGroup.setLayoutBoundsSize(
			contentWidth, contentHeight);
		container.contentGroup.setLayoutBoundsPosition(
			borderWeight, ty + titleBarHeight);
		
		// layout statusBar
		if (container.statusBarDisplay && container.showStatusBar)
		{
			container.statusBarDisplay.setLayoutBoundsSize(
				contentWidth, statusBarHeight);
			container.statusBarDisplay.setLayoutBoundsPosition(
				borderWeight, height - statusBarHeight - borderWeight);
		}
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
		if (container.borderDisplay && borderVisible)
		{
			// layout border
			container.borderDisplay.setLayoutBoundsPosition(0, 0);
			container.borderDisplay.setLayoutBoundsSize(width, height);
		}
		
		if (container.titleBarDisplay && container.showTitleBar)
		{
			var tx:Number = (insetTitleBar) ? borderWeight : 0;
			var ty:Number = (insetTitleBar) ? borderWeight : 0;
			ty = height - titleBarHeight - ty;
			
			var tw:Number = (insetTitleBar) ? width - (borderWeight * 2) : width;
			
			// layout titleBar
			container.titleBarDisplay.setLayoutBoundsSize(tw, titleBarHeight);
			container.titleBarDisplay.setLayoutBoundsPosition(tx, ty);
		}
		
		// layout contentGroup
		container.contentGroup.setLayoutBoundsSize(contentWidth, contentHeight);
		container.contentGroup.setLayoutBoundsPosition(borderWeight, borderWeight);
		
		// layout statusBar
		if (container.statusBarDisplay && container.showStatusBar)
		{
			container.statusBarDisplay.setLayoutBoundsSize(
				contentWidth, statusBarHeight);
			container.statusBarDisplay.setLayoutBoundsPosition(
				borderWeight, height - statusBarHeight - titleBarHeight - borderWeight);
		}
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
		if (container.borderDisplay && borderVisible)
		{
			// layout border
			container.borderDisplay.setLayoutBoundsPosition(0, 0);
			container.borderDisplay.setLayoutBoundsSize(width, height);
		}
		
		var tx:Number = (insetTitleBar) ? borderWeight : 0;
		var ty:Number = (insetTitleBar) ? borderWeight : 0;
		var th:Number = (insetTitleBar) ? height - (borderWeight * 2) : height;
		
		if (container.titleBarDisplay && container.showTitleBar)
		{
			// layout titleBar
			container.titleBarDisplay.setLayoutBoundsSize(titleBarWidth, th);
			container.titleBarDisplay.setLayoutBoundsPosition(tx, ty);
		}
		
		// layout contentGroup
		container.contentGroup.setLayoutBoundsSize(contentWidth, contentHeight);
		container.contentGroup.setLayoutBoundsPosition(tx + titleBarWidth, borderWeight);
		
		// layout statusBar
		if (container.statusBarDisplay && container.showStatusBar)
		{
			container.statusBarDisplay.setLayoutBoundsSize(
				contentWidth, statusBarHeight);
			container.statusBarDisplay.setLayoutBoundsPosition(
				tx + titleBarWidth, height - statusBarHeight - borderWeight);
		}
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
		if (container.borderDisplay && borderVisible)
		{
			// layout border
			container.borderDisplay.setLayoutBoundsPosition(0, 0);
			container.borderDisplay.setLayoutBoundsSize(width, height);
		}
		
		var tx:Number = (insetTitleBar) ? borderWeight : 0;
		var ty:Number = (insetTitleBar) ? borderWeight : 0;
		var th:Number = (insetTitleBar) ? height - (borderWeight * 2) : height;
		
		if (container.titleBarDisplay && container.showTitleBar)
		{
			tx = width - titleBarWidth - tx;
			
			// layout titleBar
			container.titleBarDisplay.setLayoutBoundsSize(titleBarWidth, th);
			container.titleBarDisplay.setLayoutBoundsPosition(tx, ty);
		}
		
		// layout contentGroup
		container.contentGroup.setLayoutBoundsSize(contentWidth, contentHeight);
		container.contentGroup.setLayoutBoundsPosition(borderWeight, borderWeight);
		
		// layout statusBar
		if (container.statusBarDisplay && container.showStatusBar)
		{
			container.statusBarDisplay.setLayoutBoundsSize(
				contentWidth, statusBarHeight);
			container.statusBarDisplay.setLayoutBoundsPosition(
				borderWeight, height - statusBarHeight - borderWeight);
		}
	}
}
}