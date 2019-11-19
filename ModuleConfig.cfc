/**
* This module wraps the OpenCage Geocoder API: https://opencagedata.com/
**/
component {

	// Module Properties
    this.modelNamespace			= 'opencage';
    this.cfmapping				= 'opencage';
    this.parseParentSettings 	= true;

	/**
	 * Configure
	 */
	function configure(){
		
		// Skip information vars if the box.json file has been removed
		if( fileExists( modulePath & '/box.json' ) ){
			// Read in our box.json file for so we don't duplicate the information above
			var moduleInfo = deserializeJSON( fileRead( modulePath & '/box.json' ) );

			this.title 				= moduleInfo.name;
			this.author 			= moduleInfo.author;
			this.webURL 			= moduleInfo.homepage;
			this.description 		= moduleInfo.shortDescription;
			this.version			= moduleInfo.version;
			
		}

		// Settings
		settings = {
				'apiKey' : ''
		};
	}

	function onLoad(){
		binder.map( "opencage@opencage" )
		.to( "#moduleMapping#.models.opencage" )
		.asSingleton()
		.initWith(
			apiKey = settings.apiKey
		);
	}

}