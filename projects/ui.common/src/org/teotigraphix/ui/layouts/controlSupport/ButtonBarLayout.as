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

package org.teotigraphix.ui.layouts.controlSupport
{

import mx.core.ILayoutElement;

import org.teotigraphix.ui.layouts.ButtonBarDirection;

import spark.components.supportClasses.GroupBase;
import spark.layouts.supportClasses.LayoutBase;

/**
 * Adapted from the 
 * <code>spark.components.supportClasses.ButtonBarHorizontalLayout</code> class.
 * 
 * @author Michael Schmalle
 * @copyright Teoti Graphix, LLC
 * @productversion 1.0
 * 
 * @mxml
 */
public class ButtonBarLayout extends LayoutBase
{
	//--------------------------------------------------------------------------
	//
	//  Public :: Properties
	//
	//--------------------------------------------------------------------------
	
	//----------------------------------
	//  prefferedLength
	//----------------------------------
	
	/**
	 * @private
	 */
	private var _prefferedLength:Number;
	
	[Inspectable(category="General")]
	
	/**
	 * The preferred length of the button when laying out it's size.
	 * 
	 * <p>When the <code>direction</code> property is <strong>horizontal</strong>
	 * this applies to the button's <code>width</code>, when the <code>direction</code> 
	 * property is <strong>vertical</strong>, this applies to the button's
	 * <code>height</code>.</p>
	 * 
	 * <p>If this property remians NaN, the preferred width or height will be 
	 * used from the button.</p> 
	 * 
	 * @mxml NaN
	 * @default NaN
	 */
	public function get prefferedLength():Number
	{
		return _prefferedLength;
	}
	
	/**
	 * @private
	 */
	public function set prefferedLength(value:Number):void
	{
		if (_prefferedLength == value)
			return;
		
		_prefferedLength = value;
		
		var g:GroupBase = target;
		if (g)
		{
			g.invalidateSize();
			g.invalidateDisplayList();
		}
	}
	
	//----------------------------------
	//  gap
	//----------------------------------
	
	/**
	 * @private
	 */
	private var _gap:int = 0;
	
	[Inspectable(category="General")]
	
	/**
	 * The horizontal/vertical space between layout elements.
	 * 
	 * Note that the gap is only applied between layout elements, so if there's
	 * just one element, the gap has no effect on the layout.
	 * 
	 * @mxml 0
	 * @default 0
	 */
	public function get gap():int
	{
		return _gap;
	}
	
	/**
	 * @private
	 */
	public function set gap(value:int):void
	{
		if (_gap == value)
			return;
		
		_gap = value;
		
		var g:GroupBase = target;
		if (g)
		{
			g.invalidateSize();
			g.invalidateDisplayList();
		}
	}
	
	//----------------------------------
	//  direction
	//----------------------------------
	
	/**
	 * @private
	 */
	private var _direction:String = ButtonBarDirection.HORIZONTAL;
	
	[Inspectable(category="General")]
	
	/**
	 * The direction of the button bar's buttons.
	 * 
	 * @see org.teotigraphix.ui.layouts.ButtonBarDirection
	 * 
	 * @mxml horizontal|vertical
	 * @default horizontal
	 */
	public function get direction():String
	{
		return _direction;
	}
	
	/**
	 * @private
	 */
	public function set direction(value:String):void
	{
		if (_direction == value)
			return;
		
		_direction = value;
		
		var g:GroupBase = target;
		if (g)
		{
			g.invalidateSize();
			g.invalidateDisplayList();
		}
	}
	
	//--------------------------------------------------------------------------
	//
	//  Constructor
	//
	//--------------------------------------------------------------------------
	
	/**
	 * Constructor.
	 */
	public function ButtonBarLayout()
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
	override public function measure():void
	{
		var layoutTarget:GroupBase = target;
		if (!layoutTarget)
			return;
		
		var width:Number = 0;
		var height:Number = 0;
		
		var isVertical:Boolean = isVertical();
		
		var count:int = layoutTarget.numElements;
		for (var i:int = 0; i < count; i++)
		{
			var layoutElement:ILayoutElement = layoutTarget.getElementAt(i);
			if (!layoutElement || !layoutElement.includeInLayout)
				continue;
			
			var measured:Number;
			
			if (!isVertical)
			{
				width += getPrefferedLength(layoutElement);
				height = Math.max(height, layoutElement.getPreferredBoundsHeight());
			}
			else
			{
				width = Math.max(width, layoutElement.getPreferredBoundsWidth());
				height += getPrefferedLength(layoutElement);
			}
		}
		
		var gaps:int = (count - 1) * gap;
		if (count == 0)
			gaps = 0;
		
		if (isVertical)
			height += gaps;
		else
			width += gaps;
		
		layoutTarget.measuredWidth = width;
		layoutTarget.measuredHeight = height;
		//layoutTarget.measuredMinWidth = width;
		//layoutTarget.measuredMinHeight = height;
	}
	
	/**
	 * @private 
	 */
	public function _updateDisplayList(width:Number, height:Number):void
	{
		var gap:Number = this.gap;
		
		var layoutTarget:GroupBase = target;
		if (!layoutTarget)
			return;
		
		var isVertical:Boolean = isVertical();
		var i:int;
		var count:int = layoutTarget.numElements;
		var elementCount:int = count;
		
		var calcX:Number = 0;
		var calcY:Number = 0;
		
		// changed from NaN, this sets the default;
		// horizontal - stretches to measured height
		// vertical   - stretches to measured width
		var calcWidth:Number = width;
		var calcHeight:Number = height;	
		
		/*
		// fast track, we have a preffered length, use it
		if (!isNaN(_prefferedLength))
		{
			for (i = 0; i < count; i++)
			{
				layoutElement = layoutTarget.getElementAt(i);
				if (!layoutElement || !layoutElement.includeInLayout)
					continue;
				
				if (!isVertical)
				{
					calcWidth = _prefferedLength;
				}
				else
				{
					calcHeight = _prefferedLength;
				}
				
				layoutElement.setLayoutBoundsSize(calcWidth, calcHeight);
				layoutElement.setLayoutBoundsPosition(calcX, calcY);
				
				if (isVertical)
					calcY += gap + layoutElement.getLayoutBoundsHeight();
				else
					calcX += gap + layoutElement.getLayoutBoundsWidth();
			}
			
			return;
		}
		*/
		
		//----------------------------------------------------------------------
		// Pass one: calculate the excess space
		//----------------------------------------------------------------------
		
		var totalPreferred:Number = 0;
		var layoutElement:ILayoutElement;
		for (i = 0; i < count; i++)
		{
			layoutElement = layoutTarget.getElementAt(i);
			if (!layoutElement || !layoutElement.includeInLayout)
			{
				elementCount--;
				continue;
			}
			
			totalPreferred += getPrefferedLength(layoutElement);
		}
		
		// Special case for no elements
		if (elementCount == 0)
		{
			layoutTarget.setContentSize(0, 0);
			return;
		}
		
		// The content size is always the parent size
		layoutTarget.setContentSize(width, height);
		
		// Special case: if width/height is zero, make the gap zero as well
		if ((isVertical && height == 0) || (!isVertical && width == 0))
			gap = 0;
		
		var preferred:Number;
		var viewLength:Number = (isVertical) ? height : width;
		
		// excessSpace can be negative
		var excessSpace:Number = viewLength - totalPreferred - gap * (elementCount - 1);
		
		var toDistribute:Number = viewLength - gap * (elementCount - 1);
		
		// Special case: when we don't have enough space we need to count
		// the number of children smaller than the averager size.
		var average:Number;
		var largeChildrenCount:int = elementCount;
		if (excessSpace < 0)
		{
			average = viewLength / elementCount;
			for (i = 0; i < count; i++)
			{
				layoutElement = layoutTarget.getElementAt(i);
				if (!layoutElement || !layoutElement.includeInLayout)
					continue;
				
				preferred = getPrefferedLength(layoutElement);
				
				if (preferred <= average)
				{
					toDistribute -= preferred;
					largeChildrenCount--;
					continue;
				}
			}
			
			toDistribute = Math.max(0, toDistribute);		
		}
		
		//----------------------------------------------------------------------
		// Resize and position children
		//----------------------------------------------------------------------
		
		var preferredElementLength:Number;  // pwidth / pheight
		var elementLength:Number; // childWidth / childHeight
		
		var roundOff:Number = 0;
		for (i = 0; i < count; i++)
		{
			layoutElement = layoutTarget.getElementAt(i);
			if (!layoutElement || !layoutElement.includeInLayout)
				continue;
			
			preferredElementLength = getPrefferedLength(layoutElement);
			
			if (excessSpace > 0)
			{
				elementLength = toDistribute * preferredElementLength / totalPreferred;
			}
			
			if (excessSpace < 0)
			{
				elementLength = (average < preferredElementLength) ? 
					toDistribute / largeChildrenCount : NaN; 
			}
			
			if (!isNaN(preferredElementLength))
			{
				if (isVertical)
				{
					calcHeight = Math.round(elementLength + roundOff);
					if (isNaN(calcHeight) && !isNaN(_prefferedLength))
						calcHeight = _prefferedLength;
					roundOff += elementLength - calcHeight;
				}
				else
				{
					calcWidth = Math.round(elementLength + roundOff);
					if (isNaN(calcWidth) && !isNaN(_prefferedLength))
						calcWidth = _prefferedLength;
					roundOff += elementLength - calcWidth;
				}
			}
			
			layoutElement.setLayoutBoundsSize(calcWidth, calcHeight);
			layoutElement.setLayoutBoundsPosition(calcX, calcY);
			
			if (isVertical)
				calcY += gap + layoutElement.getLayoutBoundsHeight();
			else
				calcX += gap + layoutElement.getLayoutBoundsWidth();
		}
	}
	
	override public function updateDisplayList(width:Number, height:Number):void
	{
		super.updateDisplayList(width, height);
		
		if (_direction == ButtonBarDirection.VERTICAL)
		{
			updateVertical(width, height);
		}
		else
		{
			updateHorizontal(width, height);
		}
	}
	
	protected function updateHorizontal(width:Number, height:Number):void
	{
		var gap:Number = this.gap;
		super.updateDisplayList(width, height);
		
		var layoutTarget:GroupBase = target;
		if (!layoutTarget)
			return;
		
		// Pass one: calculate the excess space
		var totalPreferredWidth:Number = 0;            
		var count:int = layoutTarget.numElements;
		var elementCount:int = count;
		var layoutElement:ILayoutElement;
		for (var i:int = 0; i < count; i++)
		{
			layoutElement = layoutTarget.getElementAt(i);
			if (!layoutElement || !layoutElement.includeInLayout)
			{
				elementCount--;
				continue;
			}
			totalPreferredWidth += layoutElement.getPreferredBoundsWidth();
		}
		
		// Special case for no elements
		if (elementCount == 0)
		{
			layoutTarget.setContentSize(0, 0);
			return;
		}
		
		// The content size is always the parent size
		layoutTarget.setContentSize(width, height);
		
		// Special case: if width is zero, make the gap zero as well
		if (width == 0)
			gap = 0;
		
		// excessSpace can be negative
		var excessSpace:Number = width - totalPreferredWidth - gap * (elementCount - 1);
		var widthToDistribute:Number = width - gap * (elementCount - 1);
		
		// Special case: when we don't have enough space we need to count
		// the number of children smaller than the averager size.
		var averageWidth:Number;
		var largeChildrenCount:int = elementCount;
		if (excessSpace < 0)
		{
			averageWidth = width / elementCount;
			for (i = 0; i < count; i++)
			{
				layoutElement = layoutTarget.getElementAt(i);
				if (!layoutElement || !layoutElement.includeInLayout)
					continue;
				
				var preferredWidth:Number = layoutElement.getPreferredBoundsWidth();
				if (preferredWidth <= averageWidth)
				{
					widthToDistribute -= preferredWidth;
					largeChildrenCount--;
					continue;
				}
			}
			widthToDistribute = Math.max(0, widthToDistribute);
		}
		
		// Resize and position children
		var x:Number = 0;
		var childWidth:Number = NaN;
		var childWidthRounded:Number = NaN;
		var roundOff:Number = 0;
		for (i = 0; i < count; i++)
		{
			layoutElement = layoutTarget.getElementAt(i);
			if (!layoutElement || !layoutElement.includeInLayout)
				continue;
			
			if (excessSpace > 0)
			{
				childWidth = widthToDistribute * layoutElement.getPreferredBoundsWidth() / totalPreferredWidth;
			}
			else if (excessSpace < 0)
			{
				childWidth = (averageWidth < layoutElement.getPreferredBoundsWidth()) ? widthToDistribute / largeChildrenCount : NaN;  
			}
			
			if (!isNaN(childWidth))
			{
				// Round, we want integer values
				childWidthRounded = Math.round(childWidth + roundOff);
				roundOff += childWidth - childWidthRounded;
			}
			
			layoutElement.setLayoutBoundsSize(childWidthRounded, height);
			layoutElement.setLayoutBoundsPosition(x, 0);
			
			// No need to round, width should be an integer number
			x += gap + layoutElement.getLayoutBoundsWidth(); 
		}
	}
	
	protected function updateVertical(width:Number, height:Number):void
	{
		var gap:Number = this.gap;
		super.updateDisplayList(width, height);
		
		var layoutTarget:GroupBase = target;
		if (!layoutTarget)
			return;
		
		// Pass one: calculate the excess space
		var totalPreferredHeight:Number = 0;            
		var count:int = layoutTarget.numElements;
		var elementCount:int = count;
		var layoutElement:ILayoutElement;
		for (var i:int = 0; i < count; i++)
		{
			layoutElement = layoutTarget.getElementAt(i);
			if (!layoutElement || !layoutElement.includeInLayout)
			{
				elementCount--;
				continue;
			}
			totalPreferredHeight += layoutElement.getPreferredBoundsHeight();
		}
		
		// Special case for no elements
		if (elementCount == 0)
		{
			layoutTarget.setContentSize(0, 0);
			return;
		}
		
		// The content size is always the parent size
		layoutTarget.setContentSize(width, height);
		
		// Special case: if width is zero, make the gap zero as well
		if (width == 0)
			gap = 0;
		
		// excessSpace can be negative
		var excessSpace:Number = height - totalPreferredHeight - gap * (elementCount - 1);
		var heightToDistribute:Number = height - gap * (elementCount - 1);
		
		// Special case: when we don't have enough space we need to count
		// the number of children smaller than the averager size.
		var averageHeight:Number;
		var largeChildrenCount:int = elementCount;
		if (excessSpace < 0)
		{
			averageHeight = height / elementCount;
			for (i = 0; i < count; i++)
			{
				layoutElement = layoutTarget.getElementAt(i);
				if (!layoutElement || !layoutElement.includeInLayout)
					continue;
				
				var preferredHeight:Number = layoutElement.getPreferredBoundsHeight();
				if (preferredHeight <= averageHeight)
				{
					heightToDistribute -= preferredHeight;
					largeChildrenCount--;
					continue;
				}
			}
			heightToDistribute = Math.max(0, heightToDistribute);
		}
		
		// Resize and position children
		var y:Number = 0;
		var childHeight:Number = NaN;
		var childHeightRounded:Number = NaN;
		var roundOff:Number = 0;
		for (i = 0; i < count; i++)
		{
			layoutElement = layoutTarget.getElementAt(i);
			if (!layoutElement || !layoutElement.includeInLayout)
				continue;
			
			if (excessSpace > 0)
			{
				childHeight = heightToDistribute * layoutElement.getPreferredBoundsHeight() / totalPreferredHeight;
			}
			else if (excessSpace < 0)
			{
				childHeight = (averageHeight < layoutElement.getPreferredBoundsHeight()) ? heightToDistribute / largeChildrenCount : NaN;  
			}
			
			if (!isNaN(childHeight))
			{
				// Round, we want integer values
				childHeightRounded = Math.round(childHeight + roundOff);
				roundOff += childHeight - childHeightRounded;
			}
			
			layoutElement.setLayoutBoundsSize(width, childHeightRounded);
			layoutElement.setLayoutBoundsPosition(0, y);
			
			// No need to round, width should be an integer number
			y += gap + layoutElement.getLayoutBoundsHeight(); 
		}
	}
	
	//--------------------------------------------------------------------------
	//
	//  Protected :: Methods
	//
	//--------------------------------------------------------------------------
	
	/**
	 * Returns whether we are vertical <code>true</code> or horizontal 
	 * <code>false</code>.
	 */
	protected function isVertical():Boolean
	{
		return (_direction == ButtonBarDirection.VERTICAL);
	}
	
	/**
	 * Returns the preffered length of the layout element.
	 * 
	 * @param layoutElement The layout element.
	 * @return The preffered length of the layout element.
	 */
	protected function getPrefferedLength(layoutElement:ILayoutElement):Number
	{
		var result:Number;
		if (!isVertical())
		{
			result = (!isNaN(_prefferedLength))
			? _prefferedLength 
				: layoutElement.getPreferredBoundsWidth();
			//result = Math.max(result, layoutElement.getMinBoundsWidth());
			return result;
			//return layoutElement.getPreferredBoundsWidth();
		}
		else
		{
			return (!isNaN(_prefferedLength))
			? _prefferedLength 
				: layoutElement.getPreferredBoundsHeight();
			//result = Math.max(result, layoutElement.getMinBoundsHeight());
			return result;
			//return layoutElement.getPreferredBoundsHeight();
		}
		
		return NaN;
	}
}
}