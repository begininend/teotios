package org.teotigraphix.ui.api
{
import mx.collections.IList;

/*

DockBar

The DockBar component;

- allows a ButtonBar to be docked at the top, right, bottom or 
left of the application. 
- [N/A] allows for a heirachle Tree dataProvider
- allows for auto hide where the mouse enters a certain area of the screeen
and the bar becomes visible
- has a border
- [N/A] has a separator data item
- has an ITEM_CLICK event
- [N/A] uses an itemRenderer based on the type [separator|leaf|branch]
- uses an icon field or function to get icon image from dataProvider
- uses a toolTip field or function to get a toolTip from dataProvider

- [N/A] figure out keyboard interaction

Properties

Layout

- placement (top|right|bottom|left)
- autoHide (true|false)

Data

- dataProvider:Object
- toolTipField:String
- toolTipFunction:Function
- iconField:String
- iconFunction:Function

Styles

- 

Effects

- mouseOver [scale|swing]

*/
/**
 * The IDockBar interface creates a contract that allows a component to be
 * populated with data items, auto hidden and placed somwhere within it's
 * parent's bounding box.
 * 
 * @author Michael Schmalle
 * @copyright Teoti Graphix, LLC
 * @productversion 1.0
 */
public interface IDockBar
{
	//--------------------------------------------------------------------------
	//
	//  Public Layout :: Properties
	//
	//--------------------------------------------------------------------------
	
	//----------------------------------
	//  autoHide
	//----------------------------------
	
	/**
	 * Whether to auto hide the dock bar when mousing out of the dock hit area.
	 * 
	 * @default false
	 */
	function get autoHide():Boolean;
	
	/**
	 * @private
	 */
	function set autoHide(value:Boolean):void;
	
	//----------------------------------
	//  placement
	//----------------------------------
	
	/**
	 * The placement of the dock bar in the application's screen rectangle.
	 * 
	 * @default top
	 */
	function get placement():String;
	
	/**
	 * @private
	 */
	function set placement(value:String):void;
	
	//--------------------------------------------------------------------------
	//
	//  Public Data :: Properties
	//
	//--------------------------------------------------------------------------
	
	//----------------------------------
	//  dataProvider
	//----------------------------------
	
	/**
	 * The data that creates the bar's item renderers.
	 * 
	 * @internal Not implemented yet
	 * 
	 * <p>If the item has children, the type will be a branch, if no children are 
	 * specified the item's type is a leaf. The other item type is 
	 * <code>separator</code>. In the item object, the <code>type</code> property 
	 * must be set to <code>separator</code>.</p>
	 * 
	 * <p>If the item is a branch, the correct item renderer will be created and 
	 * act as a drop down menu. If the item has no chilren, the item renderer will
	 * be rendered as a button.</p>
	 * 
	 * <p>The dataProvider can be XML or an object struct with the property of 
	 * <code>children</code> to create a drop down.</p>
	 */
	function get dataProvider():IList;
	
	/**
	 * @private
	 */
	function set dataProvider(value:IList):void;
	
	//----------------------------------
	//  toolTipField
	//----------------------------------
	
	/**
	 * The dataProvider's field that is used to retieve the item's toolTip
	 * text.
	 */
	function get toolTipField():String;
	
	/**
	 * @private
	 */
	function set toolTipField(value:String):void;
	
	//----------------------------------
	//  toolTipFunction
	//----------------------------------
	
	/**
	 * The dataProvider's field that is used to retieve the item's toolTip
	 * text using a query function.
	 */
	function get toolTipFunction():Function;
	
	/**
	 * @private
	 */
	function set toolTipFunction(value:Function):void;
	
	//----------------------------------
	//  iconField
	//----------------------------------
	
	/**
	 * The dataProvider's field that is used to retieve the item's icon
	 * image.
	 */
	function get iconField():String;
	
	/**
	 * @private
	 */
	function set iconField(value:String):void;
	
	//----------------------------------
	//  iconFunction
	//----------------------------------
	
	/**
	 * The dataProvider's field that is used to retieve the item's icon
	 * image using a query function.
	 */
	function get iconFunction():Function;
	
	/**
	 * @private
	 */
	function set iconFunction(value:Function):void;
	
	//----------------------------------
	//  labelField
	//----------------------------------
	
	/**
	 * The dataProvider's field that is used to retieve the item's label
	 * text.
	 */
	function get labelField():String;
	
	/**
	 * @private
	 */
	function set labelField(value:String):void;
	
	//----------------------------------
	//  labelFunction
	//----------------------------------
	
	/**
	 * The dataProvider's field that is used to retieve the item's label
	 * text using a query function.
	 */
	function get labelFunction():Function;
	
	/**
	 * @private
	 */
	function set labelFunction(value:Function):void;
}
}