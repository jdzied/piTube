# piTube
Shellscript: RaspberryPi Youtube Playlist Sync

# Requirements
<pre><code>sudo apt install youtube-dl
sudo apt install mplayer
</code></pre>

# Usage:
Edit piTube.sh:
<pre><code>nano piTube.sh
</code></pre>
Parameters to set:
* fullscreen=true/false
* youtube_url="URL of playlist"

Save file and exit.

<pre><code>chmod +x piTube.sh
./piTube.sh
</code></pre>

The script will create a new folder in your HOME-Directory and store the videos locally. (In case of temp. loss of Internet connection)


