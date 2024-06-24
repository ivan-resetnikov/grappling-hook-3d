To quickly check out the capability of this addon, please check out the example scene
located at res://addons/grappling_hook_3d/example/main.tscn


(*) How to get started:

1. Have your player scene
2. Add a new node "HookController", anywhere you want in the player scene
3. In the inspector, open the "Required settings" tab and fill it out accordingly:
	- Hook Raycast (Raycast3D), a raycast that's a child of player's camera
	
	- Player Body (CharactedBody3D), a player body.
		(Usually is a root of the player's scene)
	
	- Launch Action Name (String), name of the action to launch a hook.
		(in the Project > Project Settings > Input Map)
	
	- Retract Action Name (String), name of the action to retract a hook.
		(Can be the same as launch action)


(*) Customisation

Every availible customisation setting is located at "Optional settings" tab in
the inspector of "HookController" node.

- Pull Speed (float) - Force at whitch hook pulls you towards the target

- Hook source (Node3D) - Node from which visual instance of the rope start from
	(Only affects visuals)


(*) Advanced

Every availible advanced customisation setting is located at "Advanced settings" tab in
the inspector of "HookController" node.

- Hook scene (PackedScene) - A scene that contains a hook scene, try cloning the
	default scene and snoop around it. It should be easy to make something yourself.
