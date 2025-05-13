"
An object for Null Object Pattern implementation, it refers to a case of non affected tiles
"
Class {
	#name : 'NoEffect',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'positioning' }
NoEffect >> applyEffectOn: aPlayer [ 
	^aPlayer 
]

{ #category : 'testing' }
NoEffect >> isAffectedTiles: anInteger [ 
	^false
]
