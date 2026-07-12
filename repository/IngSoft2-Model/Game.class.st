"
>>> Here I'll leave any notes or ideas for the future or for the structure, in other for other collaborators to read.

- In order to test a full round playing correctly, I must refactor the code to make game able to receive a list of players names. This refactor means the game is no longer played by 1 player.
>>> FIRST SPRINT ORDERED BY MY BROTHER IS FINISHED <<<
"
Class {
	#name : 'Game',
	#superclass : 'Object',
	#instVars : [
		'goalMark',
		'die',
		'ships',
		'nextShipIndex',
		'wormhole'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'deprecated' }
Game class >> createWith: aShipList and: aDie and: aGoalMark [

	| shipIndex |
	shipIndex := 0.
	self validate: aGoalMark.
	^ self new
		  initializeWith: aShipList asOrderedCollection deepCopy
		  and: aDie
		  and: aGoalMark
		  and: NoEffect new
]

{ #category : 'creation' }
Game class >> createWith: aShipList and: aDie and: aGoalMark and: aWormhole [

	| shipIndex |
	shipIndex := 0.
	self validate: aGoalMark.
	^ self new
		  initializeWith: aShipList asOrderedCollection deepCopy
		  and: aDie
		  and: aGoalMark
		  and: aWormhole
]

{ #category : 'validation' }
Game class >> validate: aGoalMark [

	aGoalMark < 4 ifTrue: [
		Error signal: 'The goal cant be nearer than 4 tiles.' ]
]

{ #category : 'initialization' }
Game >> initializeWith: aShipList and: aDie and: aGoalMark and: aWormhole [

	die := aDie.
	goalMark := aGoalMark.
	ships := aShipList.
	nextShipIndex := 0.
	wormhole := aWormhole
]

{ #category : 'testing' }
Game >> isWinner: aShip [

	| shipToVerify |
	shipToVerify := ships detect: [ :ship | ship equals: aShip ].
	^ (shipToVerify positionLowerThan: goalMark) not
]

{ #category : 'playing' }
Game >> nextPlayerPlays [

	| currentShip |
	self stillPlaying ifFalse: [  ].

	nextShipIndex := nextShipIndex \\ ships size + 1.
	currentShip := ships at: nextShipIndex.
	currentShip := currentShip moveForward: die throw.
	currentShip := wormhole applyEffectOn: currentShip.
	ships at: nextShipIndex put: currentShip
]

{ #category : 'showing' }
Game >> retrievePositions [

	^ ships collect: [ :ship | ship retrievePosition ].
]

{ #category : 'accessing' }
Game >> ship: aShip isIn: aPosition [

	| detectedShip errorMessage |
	errorMessage := '' join: {
			                'There is no ship with ID: '.
			                aShip id asString.
			                '.' }.
	detectedShip := ships
		                detect: [ :ship | ship equals: aShip ]
		                ifNone: [ Error signal: errorMessage ].
	^ detectedShip isIn: aPosition
]

{ #category : 'checking' }
Game >> stillPlaying [

	^ ships allSatisfy: [ :ship | ship positionLowerThan: goalMark ]
]
