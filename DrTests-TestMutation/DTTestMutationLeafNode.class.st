Class {
	#name : #DTTestMutationLeafNode,
	#superclass : #DTTreeLeafNode,
	#category : #'DrTests-TestMutation'
}

{ #category : #accessing }
DTTestMutationLeafNode >> drTestsName [

	| originalString |
	originalString := self content asString.
	^ originalString copyWithoutAll: '#'
]
