/*
 * LIGHTSTREAMER - www.lightstreamer.com
 * Lightstreamer Flash Client - lsjavascriptbridge.as
 * Version 1.2 Build 46 Revision: 33986 $
 *
 * Copyright 2013 Weswit Srl
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *    http://www.apache.org/licenses/LICENSE-2.0

 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
var bindedBridge=null;
function JavaScriptBridge(objName){
this.bridgeName=objName;
this.tables={};
this.ready=false;
this.bind=function(){
bindedBridge=this;
ExternalInterface.call("Lightstreamer.FlashBridge.flashIsReady",this.bridgeName);
}
this.addTable=function(table,tableSubId){
this.tables[tableSubId]=table;
this.subscribeTable(table,tableSubId);
}
this.removeTable=function(tableSubId){
if(this.ready){
ExternalInterface.call("Lightstreamer.FlashBridge.bridges['"+this.bridgeName+"'].unsubscribeTable",tableSubId);
}
this.tables[tableSubId]=null;
}
this.subscribeTable=function(table,tableSubId){
if(!this.ready){
return;
}
table.commit();
ExternalInterface.call("Lightstreamer.FlashBridge.bridges['"+this.bridgeName+"'].subscribeTable",table.id,tableSubId);
}
this.onReady=function(){
return;
};
this.onReadyCall=function(){
this.ready=true;
for(var tableSubId in this.tables){
this.subscribeTable(this.tables[tableSubId],tableSubId);
}
if(this.onReady!=null){
this.onReady();
}
}
ExternalInterface.addCallback("onReady",this,this.onReadyCall);
this.onStatusChange=function(newStatus){
return;
};
this.onStatusChangeCall=function(newStatus){
if(this.onStatusChange!=null){
this.onStatusChange(newStatus);
}
}
ExternalInterface.addCallback("onStatusChange",this,this.onStatusChangeCall);
this.onLostUpdates=function(tableId,itemPos,lostUpdates,itemName){
if(this.tables[tableId]&&this.tables[tableId].onLostUpdates!=null){
this.tables[tableId].onLostUpdates(itemPos,lostUpdates,itemName);
}
}
ExternalInterface.addCallback("onLostUpdates",this,this.onLostUpdates);
this.onEndOfSnapshot=function(tableId,itemPos,itemName){
if(this.tables[tableId]&&this.tables[tableId].onEndOfSnapshot!=null){
this.tables[tableId].onEndOfSnapshot(itemPos,itemName);
}
}
ExternalInterface.addCallback("onEndOfSnapshot",this,this.onEndOfSnapshot);
this.onItemUpdate=function(tableId,itemPos,itemObj,itemName){
if(this.tables[tableId]&&this.tables[tableId].onItemUpdate!=null){
fuii=new FlashUpdateItemInfo();
fuii.obj=itemObj;
this.tables[tableId].onItemUpdate(itemPos,fuii,itemName);
}
}
ExternalInterface.addCallback("onItemUpdate",this,this.onItemUpdate);
this.onStart=function(tableId){
if(this.tables[tableId]&&this.tables[tableId].onStart!=null){
this.tables[tableId].onStart();
}
}
ExternalInterface.addCallback("onStart",this,this.onStart);
}
function FlashUpdateItemInfo(){
this.obj=null;
this.isValueChanged=function(fieldId){
pos=this.obj[fieldId+"_pos"];
if(pos){
fieldId=pos;
}
return!(this.obj[fieldId].length==-1);
}
this.getNewValue=function(fieldId){
pos=this.obj[fieldId+"_pos"];
if(pos){
fieldId=pos;
}
return this.isValueChanged(fieldId)?this.obj[fieldId]:this.getOldValue(fieldId);
}
this.getOldValue=function(fieldId){
pos=this.obj[fieldId+"_pos"];
if(pos){
fieldId=pos;
}
return this.obj[fieldId+"_old"];
}
this.getNumFields=function(){
return this.obj.length;
}
}
function FlashTable(_group,_schema,_mode){
FlashTable.counter++;
this.id=FlashTable.counter;
this._group=_group;
this._schema=_schema;
this._mode=_mode;
this.setSnapshotRequired=function(required){
this.snapRequired=required;
}
this.setItemsRange=function(_start,_end){
this.itemRangeStart=_start;
this.itemRangeEnd=_end;
}
this.setRequestedMaxFrequency=function(maxFreq){
this.maxFreq=maxFreq;
}
this.setRequestedBufferSize=function(buffSize){
this.buffSize=buffSize;
}
this.setSelector=function(selector){
this.selector=selector;
}
this.setDataAdapter=function(adapter){
this.adapter=adapter;
}
this.commit=function(){
if(bindedBridge){
jsObj="Lightstreamer.FlashBridge.bridges['"+bindedBridge.bridgeName+"']";
ExternalInterface.call(jsObj+".createTable",this._group,this._schema,this._mode,this.id);
if(this.snapRequired){
ExternalInterface.call(jsObj+".setSnapshotRequired",this.id,this.snapRequired);
}
if(this.itemRangeStart||this.itemRangeEnd){
ExternalInterface.call(jsObj+".setItemsRange",this.id,this.itemRangeStart,this.itemRangeEnd);
}
if(this.maxFreq){
ExternalInterface.call(jsObj+".setRequestedMaxFrequency",this.id,this.maxFreq);
}
if(this.buffSize){
ExternalInterface.call(jsObj+".setRequestedBufferSize",this.id,this.buffSize);
}
if(this.selector){
ExternalInterface.call(jsObj+".setSelector",this.id,this.selector);
}
if(this.adapter){
ExternalInterface.call(jsObj+".setDataAdapter",this.id,this.adapter);
}
}
}
this.onLostUpdates=function(itemPos,lostUpdates,itemName){
return;
};
this.onEndOfSnapshot=function(itemPos,itemName){
return;
};
this.onStart=function(){
return;
};
this.onItemUpdate=function(itemPos,updateInfo,itemName){
return;
};
}
FlashTable.counter=0;
