Class {
	#name : 'GameFeatureManager',
	#superclass : 'Object',
	#instVars : [
		'playersFeature'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'accessing' }
GameFeatureManager >> findShipReference: aSpaceShipComponent [

	| shipIndex |
	shipIndex := playersFeature findFirst: [ :each |
		             each equalsID: aSpaceShipComponent ].
	^ playersFeature at: shipIndex
]

{ #category : 'updating' }
GameFeatureManager >> updateShipReference: selfSpaceShipComponent [

	| shipIndex |
	shipIndex := playersFeature findFirst: [ :each |
		             each equalsID: selfSpaceShipComponent ].
	playersFeature at: shipIndex put: selfSpaceShipComponent
]
