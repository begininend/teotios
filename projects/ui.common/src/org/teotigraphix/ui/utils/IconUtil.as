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

package org.teotigraphix.ui.utils
{

import mx.core.IVisualElement;

/**
 * @private
 * 
 * @author Michael Schmalle
 * @copyright Teoti Graphix, LLC
 * @productversion 1.0
 */
public class IconUtil
{
	/**
	 * @private
	 */
	public static function itemToIcon(item:Object, 
									  iconField:String = null, 
									  iconFunction:Function = null):Object
	{
		if (iconFunction != null)
			return iconFunction(item);
		
		if (item is Class)
			return Class(item);
		
		if (item is XML)
		{
			try
			{
				if (item[iconField].length() != 0)
					return item[iconField]; // String
			}
			catch(e:Error)
			{
			}
		}
		else if (item is Object)
		{
			try
			{
				if (item[iconField] != null)
					item = item[iconField];
			}
			catch(e:Error)
			{
			}
		}
		
		return item;
	}
	
	/**
	 * @private
	 */
	public static function setSource(element:IVisualElement, 
									 icon:Class,
									 setVisible:Boolean = false):void
	{
		if (!element)
			return;
		
		if ("source" in element)
			Object(element).source = icon;
		
		if (setVisible)
			element.visible = element.includeInLayout = (icon != null);
	}
}
}