Class {
	#name : #BaselineOfDrTestsMutation,
	#superclass : #BaselineOf,
	#category : #BaselineOfDrTestsMutation
}

{ #category : #baselines }
BaselineOfDrTestsMutation >> baseline: spec [
	<baseline>
	"subclasses should redefine me"
	
	"Here is a typical package and its tests "
	spec for: #'common' do: [
		spec 
			package: #'DrTests-TestMutation' .
	spec
	baseline: 'MuTalk'
	with: [ spec repository: 'github://pharo-contributions/mutalk/src' ]
]
	
]

{ #category : #accessing }
BaselineOfDrTestsMutation >> projectClass [
    ^ MetacelloCypressBaselineProject
]
