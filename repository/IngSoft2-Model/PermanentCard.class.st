Class {
	#name : 'PermanentCard',
	#superclass : 'Card',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'bonus' }
PermanentCard >> boost: aThrow of: aShip [

	^ aThrow
]

{ #category : 'playing' }
PermanentCard >> playedBy: aShip in: aGame [

	aGame player: aShip activates: self.
	^ self
]
