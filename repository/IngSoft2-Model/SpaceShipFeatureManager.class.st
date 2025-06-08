Class {
	#name : 'SpaceShipFeatureManager',
	#superclass : 'Object',
	#instVars : [
		'playersFeature'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'accessing' }
SpaceShipFeatureManager >> findPlayerIndex: aPlayer [

	^ playersFeature findFirst: [ :each | each equals: aPlayer ]
]
