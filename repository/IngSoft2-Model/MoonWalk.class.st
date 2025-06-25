Class {
	#name : 'MoonWalk',
	#superclass : 'Effect',
	#instVars : [
		'debuff'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'creation' }
MoonWalk class >> create [
	^self new initializeEffectWith: (1 to: 5) atRandom
]

{ #category : 'creation' }
MoonWalk class >> createEspeciallyWith: aSpecificDebuff [

	^ self new initializeEffectWith: aSpecificDebuff
]

{ #category : 'creation' }
MoonWalk class >> createWith: aMaxDebuff [

	^ self new initializeEffectWith: (1 to: aMaxDebuff) atRandom
]

{ #category : 'creation' }
MoonWalk class >> effectProbability [

^0.10
]

{ #category : 'positioning' }
MoonWalk >> applyEffectOn: aPlayer and: aGame [

	| positionManager |
	positionManager := aGame requestPositionManager: self.

	positionManager moveEveryoneExcept: aPlayer backwardsWith: debuff
]

{ #category : 'initialization' }
MoonWalk >> initializeEffectWith: aDebuff [

	debuff := aDebuff
]

{ #category : 'testing' }
MoonWalk >> isMoonWalk [

	^ true
]
