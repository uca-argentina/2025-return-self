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

	^ self createWith: 5
]

{ #category : 'creation' }
MoonWalk class >> createEspeciallyWith: aSpecificDebuff [

	^ self new initializeEffectWith: aSpecificDebuff
]

{ #category : 'creation' }
MoonWalk class >> createWith: aMaxDebuff [

	^ self createEspeciallyWith: (1 to: aMaxDebuff) atRandom
]

{ #category : 'creation' }
MoonWalk class >> effectProbability [

	^ 0.08
]

{ #category : 'positioning' }
MoonWalk >> applyEffectOn: aPlayer and: aGame [

	aGame move: aPlayer backward: debuff
]

{ #category : 'initialization' }
MoonWalk >> initializeEffectWith: aDebuff [

	debuff := aDebuff
]

{ #category : 'testing' }
MoonWalk >> isMoonWalk [

	^ true
]

{ #category : 'accessing' }
MoonWalk >> target [

	^ EveryOtherShip create
]
