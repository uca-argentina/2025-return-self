Class {
	#name : 'InstantCard',
	#superclass : 'Card',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'playing' }
InstantCard >> applyIn: aGame [

	self subclassResponsibility
]

{ #category : 'playing' }
InstantCard >> playedBy: aShip in: aGame [

	self applyIn: aGame.
	^ self
]
