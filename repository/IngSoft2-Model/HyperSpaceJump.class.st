Class {
	#name : 'HyperSpaceJump',
	#superclass : 'Effect',
	#instVars : [
		'buff',
		'shieldDebuff'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'creation' }
HyperSpaceJump class >> create [

	^ self createWith: 4 and: 1
]

{ #category : 'creation' }
HyperSpaceJump class >> createWith: aBoost and: aShieldDebuff [

	^ self new initializeEffectWith: aBoost and: aShieldDebuff
]

{ #category : 'creation' }
HyperSpaceJump class >> effectProbability [

	^ 0.18
]

{ #category : 'positioning' }
HyperSpaceJump >> applyEffectOn: aPlayer and: aGame [

	aGame move: aPlayer forward: buff.
	aGame takeShields: shieldDebuff from: aPlayer
]

{ #category : 'initialization' }
HyperSpaceJump >> initializeEffectWith: aBoost and: aShieldDebuff [

	buff := aBoost.
	shieldDebuff := aShieldDebuff
]
