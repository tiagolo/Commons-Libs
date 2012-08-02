
/*


	ORIGINAL FILE BY Rich Tretola
	
	http://blog.everythingflex.com/

*/



package com.dehats.air.managers{    import flash.desktop.NativeApplication;    import flash.events.Event;    import flash.filesystem.File;    import flash.filesystem.FileMode;    import flash.filesystem.FileStream;    import flash.net.URLRequest;    import flash.net.URLStream;
    import flash.desktop.Updater;    import flash.utils.ByteArray;        import mx.controls.Alert;    import mx.events.CloseEvent;    import mx.rpc.events.FaultEvent;    import mx.rpc.events.ResultEvent;    import mx.rpc.http.HTTPService;       public class UpdateManager    {        public var versionURL:String;        private var appXml:XML = NativeApplication.nativeApplication.applicationDescriptor;        private var currentVersion:String = appXml.children()[3];// Unable to get it through appXml.version        private var version:XML;        private var urlStream:URLStream = new URLStream();        private var fileData:ByteArray = new ByteArray();                private var fileName:String ;
               public function UpdateManager(versionURL:String, pFileName:String):void{            this.versionURL = versionURL;            loadRemoteFile();
            fileName = pFileName;
                    }                    // load the remote version.xml file        private function loadRemoteFile():void{            var http:HTTPService = new HTTPService();            http.url = this.versionURL;            http.useProxy=false;            http.method = "GET";            http.resultFormat="xml";            http.send();            http.addEventListener(ResultEvent.RESULT,testVersion);
            http.addEventListener(FaultEvent.FAULT,onLoadingFailure);
            
        }       
       private function onLoadingFailure(pEvt:FaultEvent):void
       {
			//Alert.show(pEvt.fault.faultString, "Update Manager Error")   ;   	
       }
       
               /*        test the currentVersion against the remote version file and either alert the user of        an update available or force the update        */        public function testVersion(event:ResultEvent):void{
          version = XML(event.result);
          trace(currentVersion+"vs"+ version.@version)          if((currentVersion != version.@version) && version.@forceUpdate == true){              getUpdate();          }else if(currentVersion != version.@version){                Alert.show("An update for this application is available,\nwould you like to get it now? \n\nDetails:\n" + version.@message, "New Version available", 3, null, alertClickHandler);          }        }                  /*        test the currentVersion against the remote version file and either alert the user of        an update available or force the update, if no update available, alert user        */        public function checkForUpdate(pShowNoUpdateMsg:Boolean=false):Boolean{          if(version  ==  null){            this.loadRemoteFile();            return true;          }          if((currentVersion != version.@version) && version.@forceUpdate == true){              getUpdate();          }else if(currentVersion != version.@version){                Alert.show("An update for this application is available,\nwould you like to get it now? \n\nDetails:\n" + version.@message, "New Version available", 3, null, alertClickHandler);          }else if(pShowNoUpdateMsg){              Alert.show("No update available", "NOTICE");          }          return true;        }               // handle the Alert window decission        private function alertClickHandler(event:CloseEvent):void {            if (event.detail==Alert.YES){                getUpdate();            }        }               // get the new version from the remote server        private function getUpdate():void{            var urlReq:URLRequest = new URLRequest(version.@downloadLocation);            urlStream.addEventListener(Event.COMPLETE, loaded);            urlStream.load(urlReq);        }                // read in the new AIR package        private function loaded(event:Event):void {            urlStream.readBytes(fileData, 0, urlStream.bytesAvailable);            writeAirFile();        }               // write the newly downloaded AIR package to the application storage directory        private function writeAirFile():void {            var file:File = File.applicationStorageDirectory.resolvePath(fileName);            var fileStream:FileStream = new FileStream();            fileStream.addEventListener(Event.CLOSE, fileClosed);            fileStream.openAsync(file, FileMode.WRITE);            fileStream.writeBytes(fileData, 0, fileData.length);            fileStream.close();        }                // after the write is complete, call the update method on the Updater class        private function fileClosed(event:Event):void {            var updater:Updater = new Updater();          var airFile:File = File.applicationStorageDirectory.resolvePath(fileName);          updater.update(airFile,version.@version);        }           }}