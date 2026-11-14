Class {
	#name : 'AtomikBomb',
	#superclass : 'Effect',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'creation' }
AtomikBomb class >> effectProbability [

	^ 0.02
]

{ #category : 'positioning' }
AtomikBomb >> applyEffectOn: aPlayer and: aGame [

	aGame moveEveryoneToTheFirstTile.
	aGame takeAShieldFromEveryone
]

{ #category : 'testing' }
AtomikBomb >> isAtomikBomb [

	^ true
]
