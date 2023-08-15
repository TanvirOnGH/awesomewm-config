-----------------------------------------------------------------------------------------------------------------------
--                                        Third-party applications keys sheet                                        --
-----------------------------------------------------------------------------------------------------------------------
-- This file provides table to build hotkeys helpers for third-party applications.
-- The key lists here are purely descriptive, have nothing to do with real application configs.


local appkeys = {}

appkeys["mpv"] = {
	style = { column = 3, geometry = { width = 1600, height = 720 } },
	pack = {
		{
			{}, "f", nil,
			{ description = "Toggle fullscreen", group = "General" }
		},
		{
			{}, "s", nil,
			{ description = "Take a screenshot", group = "General" }
		},
		{
			{ "Shift" }, "s", nil,
			{ description = "Take a screenshot without subtitles", group = "General" }
		},
		{
			{}, "q", nil,
			{ description = "Quit", group = "General" }
		},
		{
			{ "Shift" }, "q", nil,
			{ description = "Quit saving current position", group = "General" }
		},
		{
			{}, "o", nil,
			{ description = "Show progress", group = "General" }
		},
		{
			{ "Shift" }, "o", nil,
			{ description = "Toggle show progress", group = "General" }
		},
		{
			{}, "F9", nil,
			{ description = "Show the list of audio and subtitle", group = "General" }
		},
		{
			{ "Shift" }, "a", nil,
			{ description = "Cycle aspect ratio", group = "General" }
		},

		{
			{}, "F8", nil,
			{ description = "Show the playlist", group = "Playlist" }
		},
		{
			{ "Shift" }, ",", nil,
			{ description = "Forward in playlist", group = "Playlist" }
		},
		{
			{ "Shift" }, ".", nil,
			{ description = "Backward in playlist", group = "Playlist" }
		},

		{
			{}, "Space", nil,
			{ description = "Play/pause", group = "Playback" }
		},
		{
			{}, "[", nil,
			{ description = "Decrease speed", group = "Playback" }
		},
		{
			{}, "]", nil,
			{ description = "Increase speed", group = "Playback" }
		},
		{
			{}, "{", nil,
			{ description = "Halve current speed", group = "Playback" }
		},
		{
			{}, "}", nil,
			{ description = "Double current speed", group = "Playback" }
		},
		{
			{}, "l", nil,
			{ description = "Set/clear A-B loop points", group = "Playback" }
		},
		{
			{ "Shift" }, "l", nil,
			{ description = "Toggle infinite looping", group = "Playback" }
		},
		{
			{}, "Backspace", nil,
			{ description = "Reset speed to normal", group = "Playback" }
		},

		{
			{}, "m", nil,
			{ description = "Mute/unmute", group = "Audio" }
		},
		{
			{}, "9", nil,
			{ description = "Decrease volume", group = "Audio" }
		},
		{
			{}, "0", nil,
			{ description = "Increase volume", group = "Audio" }
		},
		{
			{ "Control" }, "-", nil,
			{ description = "Decrease audio delay", group = "Audio" }
		},
		{
			{ "Control" }, "+", nil,
			{ description = "Increase audio delay", group = "Audio" }
		},
		{
			{}, "#", nil,
			{ description = "Cycle through audio tracks", group = "Audio" }
		},

		{
			{}, "PageUp", nil,
			{ description = "Next chapter", group = "Navigation" }
		},
		{
			{}, "PageDn", nil,
			{ description = "Previous chapter", group = "Navigation" }
		},
		{
			{}, ",", nil,
			{ description = "Previous frame", group = "Navigation" }
		},
		{
			{}, ".", nil,
			{ description = "Next frame", group = "Navigation" }
		},
		{
			{}, "Right", nil,
			{ description = "Forward 5 seconds", group = "Navigation" }
		},
		{
			{}, "Left", nil,
			{ description = "Backward 5 seconds", group = "Navigation" }
		},
		{
			{}, "Up", nil,
			{ description = "Forward 60 seconds", group = "Navigation" }
		},
		{
			{}, "Down", nil,
			{ description = "Backward 60 seconds", group = "Navigation" }
		},
		{
			{ "Control" }, "Left", nil,
			{ description = "Seek to the previous subtitle", group = "Navigation" }
		},
		{
			{ "Control" }, "Right", nil,
			{ description = "Seek to the next subtitle", group = "Navigation" }
		},
		{
			{ "Shift" }, "Backspace", nil,
			{ description = "Undo  the  last  seek", group = "Navigation" }
		},
		{
			{ "Control",                                 "Shift" }, "Backspace", nil,
			{ description = "Mark the current position", group = "Navigation" }
		},

		{
			{}, "v", nil,
			{ description = "Show/hide subtitles", group = "Subtitles" }
		},
		{
			{}, "j", nil,
			{ description = "Next subtitle", group = "Subtitles" }
		},
		{
			{ "Shift" }, "j", nil,
			{ description = "Previous subtitle", group = "Subtitles" }
		},
		{
			{}, "z", nil,
			{ description = "Increase subtitle delay", group = "Subtitles" }
		},
		{
			{}, "x", nil,
			{ description = "Decrease subtitle delay", group = "Subtitles" }
		},
		{
			{}, "r", nil,
			{ description = "Move subtitles up", group = "Subtitles" }
		},
		{
			{}, "t", nil,
			{ description = "Move subtitles down", group = "Subtitles" }
		},
		{
			{}, "u", nil,
			{ description = "Style overrides on/off", group = "Subtitles" }
		},


		{
			{}, "1", nil,
			{ description = "Decrease contrast", group = "Video" }
		},
		{
			{}, "2", nil,
			{ description = "Increase contrast", group = "Video" }
		},
		{
			{}, "5", nil,
			{ description = "Decrease gamma", group = "Video" }
		},
		{
			{}, "6", nil,
			{ description = "Increase gamma", group = "Video" }
		},
		{
			{}, "7", nil,
			{ description = "Decrease saturation", group = "Video" }
		},
		{
			{}, "8", nil,
			{ description = "Increase saturation", group = "Video" }
		},

		{
			{}, "w", nil,
			{ description = "Decrease pan-and-scan range", group = "Zoom" }
		},
		{
			{}, "e", nil,
			{ description = "Increase pan-and-scan range", group = "Zoom" }
		},
		{
			{ "Alt" }, "-", nil,
			{ description = "Decrease zoom", group = "Zoom" }
		},
		{
			{ "Alt" }, "+", nil,
			{ description = "Increase zoom", group = "Zoom" }
		},
		{
			{ "Alt" }, "Backspace", nil,
			{ description = "Reset zoom", group = "Zoom" }
		},
		{
			{ "Alt" }, "Arrow", nil,
			{ description = "Move the video rectangle", group = "Zoom" }
		},
	}
}

return appkeys
