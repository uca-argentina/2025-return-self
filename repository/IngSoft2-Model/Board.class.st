Class {
	#name : 'Board',
	#superclass : 'Object',
	#instVars : [
		'tiles',
		'parsecsPerTile'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'testing' }
Board class >> boardLengthMustBeGreaterThanThree: aLength [

	aLength > 3 ifFalse: [
		Error signal: 'The board length must be greater than three.' ]
]

{ #category : 'creation' }
Board class >> createWithTiles: aNumberOfTiles [
	| rng cumulativeProbs effectClasses aSetOfTiles|
	self boardLengthMustBeGreaterThanThree: aNumberOfTiles.
	rng := Random new.
	effectClasses := {
		                 AtomikBomb.
		                 BlackHole.
		                 HyperJump.
		                 HyperSpaceJump.
		                 MoonWalk.
		                 NoEffect }.

	cumulativeProbs := Array new: effectClasses size.
	effectClasses withIndexDo: [ :cls :i |
		| acum |
		acum := (i = 1
			         ifTrue: [ 0 ]
			         ifFalse: [ cumulativeProbs at: i - 1 ])
		        + cls effectProbability.
		cumulativeProbs at: i put: acum ].

	"2. Para cada casilla, sortear un efecto con peso:"
	aSetOfTiles := (1 to: aNumberOfTiles) collect: [ :idx |
		         | r chosenClass |
		         r := rng next. "Número real [0,1)"
		         chosenClass := effectClasses
			                        detect: [ :cls |
			                        r
			                        <=
			                        (cumulativeProbs at:
				                         (effectClasses indexOf: cls)) ]
			                        ifNone: [ effectClasses last ]. "por redondeo"
		         chosenClass createOnTile: idx "instancia de efecto" ].
	^ self new initializeWithTiles: aSetOfTiles
]

{ #category : 'creation' }
Board class >> createWithTiles: aNumberOfTiles andParsecs: aNumberOfParsecs [
	| rng cumulativeProbs effectClasses aSetOfTiles|
	self boardLengthMustBeGreaterThanThree: aNumberOfTiles.
	rng := Random new.
	effectClasses := {
		                 AtomikBomb.
		                 BlackHole.
		                 HyperJump.
		                 HyperSpaceJump.
		                 MoonWalk.
		                 NoEffect }.

	cumulativeProbs := Array new: effectClasses size.
	effectClasses withIndexDo: [ :cls :i |
		| acum |
		acum := (i = 1
			         ifTrue: [ 0 ]
			         ifFalse: [ cumulativeProbs at: i - 1 ])
		        + cls effectProbability.
		cumulativeProbs at: i put: acum ].

	"2. Para cada casilla, sortear un efecto con peso:"
	aSetOfTiles := (1 to: aNumberOfTiles) collect: [ :idx |
		         | r chosenClass |
		         r := rng next. "Número real [0,1)"
		         chosenClass := effectClasses
			                        detect: [ :cls |
			                        r
			                        <=
			                        (cumulativeProbs at:
				                         (effectClasses indexOf: cls)) ]
			                        ifNone: [ effectClasses last ]. "por redondeo"
		         chosenClass createOnTile: idx "instancia de efecto" ].
	^ self new initializeWithTiles: aSetOfTiles andParsecs: aNumberOfParsecs
]

{ #category : 'positioning' }
Board >> applyEffectTriggeredBy: aPlayer [ 

	| detectedTile |
	
	detectedTile := tiles at: aPlayer position.
^ detectedTile effect.
]

{ #category : 'initialization' }
Board >> initializeWithTiles: aSetOfTiles [

    tiles := aSetOfTiles.


]

{ #category : 'initialization' }
Board >> initializeWithTiles: aSetOfTiles andParsecs: aNumberOfParsecs [

    tiles := aSetOfTiles.
	 parsecsPerTile := aNumberOfParsecs//(aSetOfTiles size).

]

{ #category : 'accessing' }
Board >> tiles [ 
^tiles
]

{ #category : 'accessing' }
Board >> totalTiles [
	^ tiles size.
]
