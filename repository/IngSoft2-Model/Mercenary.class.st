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

	^ self new initializeWith: aShipMaster and: aShipSlave
]

{ #category : 'as yet unclassified' }
Mercenary >> applyBonusUsing: data [
"
	^ aTotalThrow + 1"
	self shouldBeImplemented 
]

{ #category : 'as yet unclassified' }
Mercenary >> equalsACard: aCard [

	aCard isMercenary ifTrue: [ ^ masterShip = aCard masterShip and: slaveShip = aCard slaveShip ].
	^ false
]

{ #category : 'initialization' }
Mercenary >> initializeWith: aShipMaster and: aShipSlave [

	masterShip := aShipMaster.
	slaveShip := aShipSlave
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
