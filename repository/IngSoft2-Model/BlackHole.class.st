Class {
	#name : 'BlackHole',
	#superclass : 'Effect',
	#instVars : [
		'debuff'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'creation' }
BlackHole class >> create [

	^ self createWith: 4
]

{ #category : 'creation' }
BlackHole class >> createWith: aDebuff [

	^ self new initializeEffectWith: aDebuff
]

{ #category : 'creation' }
BlackHole class >> effectProbability [

	^ 0.18
]

{ #category : 'positioning' }
BlackHole >> applyEffectOn: aPlayer and: aGame [

	aGame move: aPlayer backward: debuff
]

{ #category : 'initialization' }
BlackHole >> initializeEffectWith: aDebuff [

	debuff := aDebuff
]
