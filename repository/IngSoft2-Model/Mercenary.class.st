Class {
	#name : 'Mercenary',
	#superclass : 'PermanentCard',
	#instVars : [
		'masterShip',
		'slaveShip'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'creation' }
Mercenary class >> createWith: aShipMaster and: aShipSlave [

	^ self new initializeWith: aShipMaster and: aShipSlave and: -1 "Reserved tag for non active"
]

{ #category : 'creation' }
Mercenary class >> createWith: aShipMaster and: aShipSlave and: anId [

	^ self new initializeWith: aShipMaster and: aShipSlave and: anId
]

{ #category : 'as yet unclassified' }
Mercenary >> applyBonusUsing: battleManager [

	^ battleManager findShipReference: slaveShip
]

{ #category : 'as yet unclassified' }
Mercenary >> equalsACard: aCard [

	aCard isMercenary ifTrue: [ ^ masterShip = aCard masterShip and: slaveShip = aCard slaveShip ].
	^ false
]

{ #category : 'testing' }
Mercenary >> hasSameSlave: anotherMercenaryCard [

	^ slaveShip = anotherMercenaryCard slaveShip
]

{ #category : 'initialization' }
Mercenary >> initializeWith: aShipMaster and: aShipSlave and: anId [

	masterShip := aShipMaster.
	slaveShip := aShipSlave.
	cardId := anId
]

{ #category : 'testing' }
Mercenary >> isMercenary [
	
	^ true
]

{ #category : 'accessing' }
Mercenary >> masterShip [

	^ masterShip
]

{ #category : 'as yet unclassified' }
Mercenary >> requestedBy: aPlayer [

^ masterShip equalsID: aPlayer
]

{ #category : 'as yet unclassified' }
Mercenary >> sameTypeOfCard: aCard [

	^ aCard isMercenary
]

{ #category : 'as yet unclassified' }
Mercenary >> setupWith: context [

	context asOrderedCollection size = 2 ifFalse: [
		Error signal: 'Wrong amount of parameters for this card' ].
	(context at: 1) isShip ifFalse: [ Error signal: 'Wrong type or order of parameters' ].
	(context at: 2) isShip ifFalse: [ Error signal: 'Wrong type or order of parameters' ].
	^ self class createWith: (context at: 1) and: (context at: 2)
]

{ #category : 'accessing' }
Mercenary >> slaveShip [

	^ slaveShip
]

{ #category : 'as yet unclassified' }
Mercenary >> tagPermanentCard: anId [

	^ self class createWith: masterShip and: slaveShip and: anId
]
