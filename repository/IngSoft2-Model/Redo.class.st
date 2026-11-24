Class {
	#name : 'Redo',
	#superclass : 'Card',
	#instVars : [
		'target'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'creation' }
Redo class >> createWith: aTarget [

	^ self new initializeWith: aTarget
]

{ #category : 'initialization' }
Redo >> initializeWith: aTarget [

	target := aTarget
]

{ #category : 'playing' }
Redo >> playedBy: aShip in: aGame [

	^ (aGame lastPlayedCard setupWith: target) playedBy: aShip in: aGame
]

{ #category : 'setup' }
Redo >> setupWith: aTarget [

	^ self class createWith: aTarget
]
