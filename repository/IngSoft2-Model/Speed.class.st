Class {
	#name : 'Speed',
	#superclass : 'Card',
	#instVars : [
		'shipId'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
Speed class >> createWithAnId: anId [ 
	^self new initializeWith: anId 
]

{ #category : 'as yet unclassified' }
Speed >> applyBounsUsing: aThrow [ 
	^ aThrow + 1.
]

{ #category : 'initialization' }
Speed >> initializeWith: anId [
	shipId := anId.
]
