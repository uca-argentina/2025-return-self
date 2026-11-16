Class {
	#name : 'Effect',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'creation' }
Effect class >> create [

	^ self new
]

{ #category : 'creation' }
Effect class >> effectProbability [

	self subclassResponsibility
]

{ #category : 'testing' }
Effect >> allowsBattleOnItsTile [

	^ false
]

{ #category : 'positioning' }
Effect >> applyEffectOn: aPlayer among: everyPlayer and: aGame [

	self
		applyEffectOnEvery: (self target shipsAffectedWhen: aPlayer landsAmong: everyPlayer)
		and: aGame
]

{ #category : 'positioning' }
Effect >> applyEffectOn: aPlayer and: aGame [

	self subclassResponsibility
]

{ #category : 'positioning' }
Effect >> applyEffectOnEvery: aGroupOfPlayers and: aGame [

	aGroupOfPlayers do: [ :player | self applyEffectOn: player and: aGame ]
]

{ #category : 'testing' }
Effect >> isAtomikBomb [

	^ false
]

{ #category : 'testing' }
Effect >> isBlackHole [

	^ false
]

{ #category : 'testing' }
Effect >> isCardGiver [

	^ false
]

{ #category : 'testing' }
Effect >> isHyperJump [

	^ false
]

{ #category : 'testing' }
Effect >> isHyperSpaceJump [

	^ false
]

{ #category : 'testing' }
Effect >> isMoonWalk [

	^ false
]

{ #category : 'testing' }
Effect >> isNoEffect [

	^ false
]

{ #category : 'testing' }
Effect >> isWormhole [

	^ false
]

{ #category : 'accessing' }
Effect >> target [

	^ LandingShip create
]
