sap.ui.define(["sap/base/util/ObjectPath","sap/ushell/services/Container"],function(e){"use strict";e.set(["sap-ushell-config"],{defaultRenderer:"fiori2",bootstrapPlugins:{RuntimeAuthoringPlugin:{component:"sap.ushell.plugins.rta",config:{validateAppVers+
ion:false}},PersonalizePlugin:{component:"sap.ushell.plugins.rta-personalize",config:{validateAppVersion:false}}},renderers:{fiori2:{componentData:{config:{enableSearch:false,rootIntent:"Shell-home"}}}},services:{LaunchPage:{adapter:{config:{groups:[{til+
es:[{tileType:"sap.ushell.ui.tile.StaticTile",properties:{title:"fiori 연동",targetURL:"#synczca20demo2-display"}}]}]}}},ClientSideTargetResolution:{adapter:{config:{inbounds:{"synczca20demo2-display":{semanticObject:"synczca20demo2",action:"display",descr+
iption:"fiori 연동",title:"fiori 연동",signature:{parameters:{}},resolutionResult:{applicationType:"SAPUI5",additionalInformation:"SAPUI5.Component=sync.zca20demo2",url:sap.ui.require.toUrl("sync/zca20demo2")}}}}}},NavTargetResolution:{config:{enableClientSi+
deTargetResolution:true}}}});var i={init:function(){if(!this._oBootstrapFinished){this._oBootstrapFinished=sap.ushell.bootstrap("local");this._oBootstrapFinished.then(function(){sap.ushell.Container.createRenderer().placeAt("content")})}return this._oBoo+
tstrapFinished}};return i});                                                                                                                                                                                                                                   