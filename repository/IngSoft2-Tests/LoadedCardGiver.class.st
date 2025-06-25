"
A mock object to test the Effect application of the CardGiver
"
Class {
	#name : 'LoadedCardGiver',
	#superclass : 'Object',
	#instVars : [
		'cardOrderedLooping',
		'actualCardIndex'
	],
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'creation' }
LoadedCardGiver class >> createWith: aListOfCards [

	^ self new initializeEffectWith: aListOfCards
]

{ #category : 'positioning' }
LoadedCardGiver >> applyEffectOn: aPlayer using: positionManager and: battleManager and: cardManager [

	cardManager add: (cardOrderedLooping at: actualCardIndex) to: aPlayer.

	self nextCard "HASTA ACA, EL RESTO ES MAS ADELANTE"
]

{ #category : 'initialization' }
LoadedCardGiver >> initializeEffectWith: aListOfCards [

	cardOrderedLooping := aListOfCards asOrderedCollection.
	actualCardIndex := 1
]

{ #category : 'testing' }
LoadedCardGiver >> isCardGiver [

	^ true
]

{ #category : 'interaction loop' }
LoadedCardGiver >> nextCard [

	actualCardIndex := actualCardIndex \\ cardOrderedLooping size + 1
]
