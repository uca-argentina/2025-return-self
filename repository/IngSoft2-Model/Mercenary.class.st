Class {
	#name : 'Mercenary',
	#superclass : 'PermanentCard',
	#instVars : [
		'masterShip',
		'mercenaryShip'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'creation' }
Mercenary class >> createWith: aMercenaryShip [

	^ self new initializeWith: aMercenaryShip
]

{ #category : 'creation' }
Mercenary class >> createWith: aMercenaryShip hiredBy: aMasterShip [

	self ship: aMasterShip cantHireItself: aMercenaryShip.
	^ self new initializeWith: aMercenaryShip hiredBy: aMasterShip
]

{ #category : 'testing' }
Mercenary class >> ship: aMasterShip cantHireItself: aMercenaryShip [

	(aMasterShip equalsID: aMercenaryShip) ifTrue: [
		Error signal: 'A ship cannot hire itself as a mercenary.' ]
]

{ #category : 'mercenaries' }
Mercenary >> addMercenariesOf: aShip to: aTeam [

	(masterShip equalsID: aShip) ifTrue: [ aTeam add: mercenaryShip ]
]

{ #category : 'testing' }
Mercenary >> assertCanBeActivatedWith: activeCards [

	activeCards do: [ :card | card assertDoesNotHire: mercenaryShip ]
]

{ #category : 'testing' }
Mercenary >> assertDoesNotHire: aShip [

	(self hires: aShip) ifTrue: [
		Error signal: 'Cant have the same mercenary as other.' ]
]

{ #category : 'testing' }
Mercenary >> hires: aShip [

	^ mercenaryShip equalsID: aShip
]

{ #category : 'initialization' }
Mercenary >> initializeWith: aMercenaryShip [

	mercenaryShip := aMercenaryShip
]

{ #category : 'initialization' }
Mercenary >> initializeWith: aMercenaryShip hiredBy: aMasterShip [

	mercenaryShip := aMercenaryShip.
	masterShip := aMasterShip
]

{ #category : 'playing' }
Mercenary >> playedBy: aShip in: aGame [

	| hiredMercenary |
	self assertHasTarget: mercenaryShip.
	aGame assertIsPlaying: mercenaryShip.
	hiredMercenary := self class createWith: mercenaryShip hiredBy: aShip.
	aGame player: aShip activates: hiredMercenary.
	^ hiredMercenary
]

{ #category : 'setup' }
Mercenary >> setupWith: aTarget [

	^ self class createWith: aTarget
]
