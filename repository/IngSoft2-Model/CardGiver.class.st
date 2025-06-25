Class {
	#name : 'CardGiver',
	#superclass : 'Effect',
	#instVars : [
		'cardClasses'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'creation' }
CardGiver class >> create [

	^ self new initializeEffect
]

{ #category : 'creation' }
CardGiver class >> effectProbability [

0.1
]

{ #category : 'positioning' }
CardGiver >> applyEffectOn: aPlayer using: positionManager and: battleManager and: turnManager and: cardManager [

	| aRandomIndex aRandomCard |
	aRandomIndex := (1 to: cardClasses size) atRandom.
	aRandomCard := (cardClasses at: aRandomIndex) new.
	cardManager add: aRandomCard to: aPlayer "HASTA ACA, EL RESTO ES MAS ADELANTE"
]

{ #category : 'initialization' }
CardGiver >> initializeEffect [

	cardClasses := {
		               Acceleration.
		               Cancellation.
		               Mercenary.
		               Redo.
		               Repeat.
		               Speed }
]

{ #category : 'testing' }
CardGiver >> isCardGiver [

	^ true
]
