Class {
	#name : 'PermanentCard',
	#superclass : 'Card',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'mercenaries' }
PermanentCard >> addMercenariesOf: aShip to: aTeam [

]

{ #category : 'testing' }
PermanentCard >> assertCanBeActivatedWith: activeCards [

]

{ #category : 'testing' }
PermanentCard >> assertDoesNotHire: aShip [

]

{ #category : 'bonus' }
PermanentCard >> boost: aThrow of: aShip [

	^ aThrow
]

{ #category : 'polarity' }
PermanentCard >> effect: anEffect atTile: aTileNumber [

	^ anEffect
]

{ #category : 'comparing' }
PermanentCard >> equalsACard: aCard [

	self subclassResponsibility
]

{ #category : 'playing' }
PermanentCard >> playedBy: aShip in: aGame [

	aGame player: aShip activates: self.
	^ self
]
