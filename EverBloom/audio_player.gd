extends AudioStreamPlayer

#this helps create a audio script that scales with
# how audio files are played.

const level_music = preload("res://Music/track_1.mp3")

# this function converts volume to a mesure closer to how
#  sound files are normally scaled.
func _play_music (music: AudioStream, volume = 0.0):
	if stream == music:
		return
	stream = music
	volume_db = volume
	play()
	
func play_music_level():
	_play_music (level_music)
