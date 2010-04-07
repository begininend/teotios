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

import mx.core.EdgeMetrics;
import mx.core.UIComponent;
import mx.styles.CSSCondition;
import mx.styles.CSSSelector;
import mx.styles.CSSStyleDeclaration;
import mx.styles.ISimpleStyleClient;
import mx.styles.IStyleClient;
import mx.styles.StyleManager;

import spark.skins.spark.CheckBoxSkin;

/**
 * @private
 * 
 * A general style utility class for various style algorithms
 * used in the toolkit.
 * 
 * @author Michael Schmalle
 * @copyright Teoti Graphix, LLC
 * @productversion 1.0
 */
public class StyleUtil
{
	public static var createRuntimeSelectors:Boolean = true;
	
	//--------------------------------------------------------------------------
	//
	//  Private Class :: Properties
	//
	//--------------------------------------------------------------------------
	
	/**
	 * An internal map of selectors created by this class.
	 */
	private static var selectorMap:Object = new Object();
	
	//--------------------------------------------------------------------------
	//
	//  Class :: Methods
	//
	//--------------------------------------------------------------------------
	
	/**
	 * Creates a type selector if undefined otherwise returns the
	 * selector's CSSStyleDeclaration instance.
	 * 
	 * @param name A string indicating which type selector 
	 * to create or query.
	 * 
	 * @return A CSSStyleDeclaration instance already registered with
	 * the StyleManager.
	 */
	public static function createSelector(name:String):CSSStyleDeclaration
	{
		var selector:CSSStyleDeclaration =
			StyleManager.getStyleManager(null).getStyleDeclaration(name) as CSSStyleDeclaration;
		
		if (!selector)
		{
			selector = new CSSStyleDeclaration();
			StyleManager.getStyleManager(null).setStyleDeclaration(name, selector, false);
		}
		
		selectorMap[name] = true;
		
		return selector;
	}
	
	/**
	 * Creates a style selector and sets the selector's defaultFactory.
	 * 
	 * @param name A string indicating which type selector to create.
	 * @param factory A factory function that will be used as the selector's
	 * defaultFactory.
	 */
	public static function create(name:String, 
								  factory:Function):CSSStyleDeclaration
	{
		var selector:CSSSelector = new CSSSelector(name, null, null);
		var style:CSSStyleDeclaration = StyleManager.getStyleManager(null).getStyleDeclaration(name);
		
		if (!style)
		{
			style = new CSSStyleDeclaration(selector);
		}
		
		if (style.defaultFactory == null)
			style.defaultFactory = factory;
		
		return style;
	}
	
	public static function factory(type:String, 
								   part:String,
								   factory:Function):CSSStyleDeclaration
	{
		var conditions:Array = [];
		
		var typeSelector:CSSSelector = new CSSSelector(type);
		
		var condition:CSSCondition = new CSSCondition("id", part);
		conditions.push(condition); 
		
		var idSelector:CSSSelector = new CSSSelector("", conditions, typeSelector);
		
		var style:CSSStyleDeclaration = StyleManager.
			getStyleManager(null).getStyleDeclaration(type + " #" + part);
		
		if (!style)
		{
			style = new CSSStyleDeclaration(idSelector);
		}
		
		//if (style.factory == null)
		//{
		//	style.factory = factory
		//}
		
		if (style.defaultFactory == null)
		{
			style.defaultFactory = factory
		}		
		
		return null;
	}
	
	
	public static function setSkinClass(client:IStyleClient, 
										target:IStyleClient):void
	{
		if (!client || !target)
			return;
		
		var partName:String = UIComponent(target).id;
		if (partName.indexOf("Display") == -1)
			return;
		
		partName = partName.replace("Display", "");
		
		var cls:Class = client.getStyle(partName + "SkinClass") as Class;
		if (cls != null)
		{
			target.setStyle("skinClass", cls);
		}
	}
	
	/**
	 * Resolves the styleName property using the style name passed.
	 * 
	 * @param source The style client to retrive the styleName from.
	 * @param target The style client to apply the new styleName value to.
	 * @param styleName A string indicating the style to query for the new
	 * styleName assignment.
	 */
	public static function resolveStyleName(source:IStyleClient, 
											target:ISimpleStyleClient, 
											styleName:String):void
	{
		if (target is ISimpleStyleClient)
		{
			var style:String = source.getStyle(styleName);
			if (style)
				target.styleName = style;
		}
	}	
	
	/**
	 * Returns an EdgeMetrics instance based on margin styles.
	 * 
	 * @param client An IStyleClient to query styles on.
	 */
	public static function getMarginMetrics(client:IStyleClient):EdgeMetrics
	{
		var top:Number = client.getStyle("marginTop");
		var right:Number = client.getStyle("marginRight");
		var bottom:Number = client.getStyle("marginBottom");
		var left:Number = client.getStyle("marginLeft");
		
		return new EdgeMetrics(left, top, right, bottom);
	}
	
	/**
	 * Returns an EdgeMetrics instance based on padding styles.
	 * 
	 * @param client An IStyleClient to query styles on.
	 */
	public static function getPaddingMetrics(client:IStyleClient):EdgeMetrics
	{
		var top:Number = client.getStyle("paddingTop");
		var right:Number = client.getStyle("paddingRight");
		var bottom:Number = client.getStyle("paddingBottom");
		var left:Number = client.getStyle("paddingLeft");
		
		return new EdgeMetrics(left, top, right, bottom);
	}	
}
}