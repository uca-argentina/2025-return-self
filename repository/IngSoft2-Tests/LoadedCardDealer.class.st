Class {
	#name : 'LoadedCardDealer',
	#superclass : 'Object',
	#instVars : [
		'cardKinds',
		'nextCardIndex'
	],
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'creation' }
LoadedCardDealer class >> dealing: aSequenceOfCardKinds [

	^ self new initializeDealing: aSequenceOfCardKinds
]

{ #category : 'dealing' }
LoadedCardDealer >> dealCard [

	| aCard |
	aCard := (cardKinds at: nextCardIndex) create.
	nextCardIndex := nextCardIndex \\ cardKinds size + 1.
	^ aCard
]

{ #category : 'initialization' }
LoadedCardDealer >> initializeDealing: aSequenceOfCardKinds [

	cardKinds := aSequenceOfCardKinds.
	nextCardIndex := 1
]
