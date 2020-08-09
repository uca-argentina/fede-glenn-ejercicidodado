Class {
	#name : #ProbabilityDistributorTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
ProbabilityDistributorTest >> testGetDistributedArrayOfObjects [
	| distributor |
	distributor := ProbabilityDistributor new
		getShuffledCollection:
			{(ProbabilityWrapper with: 'Fede' probability: 0.4).
			(ProbabilityWrapper with: 'Abril' probability: 0.6)}
		size: 100.
	self assert: distributor size equals: 100.
	self
		assert: ((distributor count: [ :name | 'Fede' == name ]) between: 20 and: 55).
	self
		assert: ((distributor count: [ :name | 'Abril' == name ]) between: 45 and: 75)
		
	

]

{ #category : #tests }
ProbabilityDistributorTest >> testGetDistributedArrayOfObjectsPadded [
	| result distributor |
	distributor := ProbabilityDistributor new
		getShuffledCollection:
			{(ProbabilityWrapper with: 'Fede' probability: 0.4).
			(ProbabilityWrapper with: 'Abril' probability: 0.4)}
		defaultElement: ''
		size: 100.
	self assert: distributor size equals: 100.
	self
		assert: ((distributor count: [ :name | 'Fede' == name ]) between: 25 and: 55).
	self
		assert: ((distributor count: [ :name | 'Abril' == name ]) between: 25 and: 55).
	self
		assert: ((distributor count: [ :name | '' == name ]) between: 5 and: 35). 
]
