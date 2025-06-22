Class {
	#name : 'Tile',
	#superclass : 'Object',
	#instVars : [
		'effect'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
Tile class >> createWithEffect: anEffect [ 

	^self new initializeTileWithEffect: anEffect.
]

{ #category : 'as yet unclassified' }
Tile >> applyEffectOn: aPlayer using: aSetOfManagers [

effect applyEffectOn: aPlayer using: aSetOfManagers
]

{ #category : 'accessing' }
Tile >> effect [

^effect 
]

{ #category : 'initialization' }
Tile >> initializeTileWithEffect: anEffect [

effect := anEffect .
]
