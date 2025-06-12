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
GameFeatureManager >> findPlayerIndex: aPlayer [

	^ playersFeature findFirst: [ :each | each equalsID: aPlayer ]
]
