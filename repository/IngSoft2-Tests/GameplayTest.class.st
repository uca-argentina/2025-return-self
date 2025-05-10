Class {
	#name : 'GameplayTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
GameplayTest >> testWhenAGameIsPlayedThenAWinnerIsAnnounced [

| aGame aSetOfPlayers aBoard aDice firstPlayer secondPlayer|
firstPlayer := Player named: 'Juan'.
secondPlayer := Player named: 'Tomi'.
aSetOfPlayers := { firstPlayer . secondPlayer}.
aGame := Game playedBy: aSetOfPlayers onBoard: aBoard withDie: aDice.
]
