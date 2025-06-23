Class {
	#name : 'HyperJump',
	#superclass : 'Effect',
	#instVars : [
		'buffList',
		'actualBuffIndex'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'creation' }
HyperJump class >> create [
	^self new initializeEffectWith: #(13 9 5)
]

{ #category : 'creation' }
HyperJump class >> createWith: aListOfParsecs [
	^self new initializeEffectWith: aListOfParsecs
]

{ #category : 'creation' }
HyperJump class >> effectProbability [

^0.08
]

{ #category : 'positioning' }
HyperJump >> applyEffectOn: aPlayer using: positionManager and: battleManager and: turnManager [

	positionManager move: aPlayer forwardWith: (buffList at: actualBuffIndex) .

		self nextBuff.

]

{ #category : 'initialization' }
HyperJump >> initializeEffectWith: aListOfParsecs [

	buffList := aListOfParsecs.
	actualBuffIndex := 1
]

{ #category : 'testing' }
HyperJump >> isHyperJump [

	^ true
]

{ #category : 'positioning' }
HyperJump >> nextBuff [

	actualBuffIndex := actualBuffIndex \\ buffList size + 1
]
