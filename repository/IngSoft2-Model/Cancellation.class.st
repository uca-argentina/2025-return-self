Class {
	#name : 'Cancellation',
	#superclass : 'InstantCard',
	#instVars : [
		'targetCard'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'creation' }
Cancellation class >> createWith: aCardToCancel [

	^ self new initializeWith: aCardToCancel
]

{ #category : 'playing' }
Cancellation >> applyIn: aGame [

	self assertHasTarget: targetCard.
	aGame cancelActiveCard: targetCard
]

{ #category : 'initialization' }
Cancellation >> initializeWith: aCardToCancel [

	targetCard := aCardToCancel
]

{ #category : 'setup' }
Cancellation >> setupWith: aTarget [

	^ self class createWith: aTarget
]
